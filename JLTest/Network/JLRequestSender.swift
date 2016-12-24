//
//  JLRequestSender.swift
//  JLTest
//
//  Created by Fabio on 23/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import UIKit

class JLRequestSender: NSObject, URLSessionTaskDelegate, URLSessionDataDelegate {
    
    var tasksBeingExecuted = Dictionary<String, Data>()
    
    var session: URLSession!
    var requestFactory: JLRequestFactory!
    
    weak var delegate: JLNetworkDelegate?
    
    // Show the spinner while a request is in progress
    var active: Bool = false {
        didSet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = active
        }
    }
    
    //MARK: Initialiser
    
    init(requestFactory: JLRequestFactory, urlSession: URLSession? = nil, delegate: JLNetworkDelegate?) {
        
        super.init()
        
        self.requestFactory = requestFactory
        self.delegate = delegate
        
        if let session = urlSession {
            self.session = session
        } else {
            self.session = initializeSession()
        }

    }

    /**
     Create and initializes NSURL session.
     */
    private func initializeSession() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpMaximumConnectionsPerHost = 20
        sessionConfiguration.timeoutIntervalForRequest = 10
        sessionConfiguration.timeoutIntervalForResource = 10
        return URLSession(configuration: sessionConfiguration, delegate:self, delegateQueue:nil)
    }
    
    /**
     Create and sends data request. If request result is cached, function will not send request.
     
     - parameter method:             HTTP method string, either "GET", "PUT", "POST" or "DELETE"
     - parameter endpoint:           Relative path to API endpoint.
     - parameter type:               Type of the request. See JLRequestType enumeration for possible values.
     */
    
    func sendDataRequest(method: String, endpoint: String, type: JLRequestType) {
        
        let request = requestFactory.dataRequestWithMethod(method: method, endpoint: endpoint)
        
        let taskId = "\(type.rawValue)"
        
        //check if the task is in execution
        if (request != nil && self.tasksBeingExecuted[taskId] == nil) {
            
            self.tasksBeingExecuted[taskId] = Data()
            
            let task = self.session.dataTask(with: request! as URLRequest)
            
            task.taskDescription = taskId
            task.resume()
            
            JLLogger.networkRequestLog(request: request!, type: type)
        }
        
        self.active = self.tasksBeingExecuted.count > 0
    }
    
    /**
     Callback function which is called when data request is completed.
     
     - parameter task:               The instance of URLSessionDataTask for data request.
     - parameter responseUrl:        Absolute response url.
     - parameter httpCode:           HTTP response code.
     */
    func dataTaskCompleted(task: URLSessionDataTask, responseUrl: String, requestType: JLRequestType, httpCode: Int) {
        
        if let taskDescription = task.taskDescription,
            let data = self.tasksBeingExecuted[taskDescription] {
            
            var json: Dictionary<String,AnyObject>!
            
            let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            log.debug(datastring as? String)
            
            do {
                json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Dictionary<String,AnyObject>
                
                self.notifyDelegateRequestProcessed(requestType: requestType, data: json)
                
            } catch {
                log.error("JSONSerialization failure!")
                self.notifyDelegateRequestFailed(requestType: requestType, httpCode: httpCode)
            }

        }
    }
    
    /**
     Notifies observers if request is completed successfully.
     
     - parameter requestType: Type of the request. See JLRequestType enumeration for possible values.
     - parameter data: Data returned from the api.
     */
    func notifyDelegateRequestProcessed(requestType: JLRequestType, data: Dictionary<String, AnyObject>) {
        
         DispatchQueue.main.async {
            
            if let delegate = self.delegate as JLNetworkDelegate? {
                delegate.requestProcessed(type: requestType, data: data)
            }
            
        }
    }
    
    /**
     Notifies observers if request is completed with error.
     
     - parameter requestType:       Type of the request. See JLRequestType enumeration for possible values.
     - parameter httpCode:          HTTP response code.
     */
    func notifyDelegateRequestFailed(requestType: JLRequestType, httpCode: Int?) {
        
         DispatchQueue.main.async {
            
            if let delegate = self.delegate as JLNetworkDelegate? {
                delegate.requestFailed(type: requestType, httpCode: httpCode)
            }
        }
    }
    
    //MARK: URLSessionTaskDelegate
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        var requestType: JLRequestType = .Unknown
        var taskDescription = "\(requestType.rawValue)"
        var type: Int = Int(taskDescription)!
        
        if let tskDesc = task.taskDescription {
            taskDescription = tskDesc
            type = Int(taskDescription)!
            requestType = JLRequestType(rawValue: type)!
        }
        
        if let httpResponse = task.response as? HTTPURLResponse,
            let responseUrl = httpResponse.url?.absoluteString {
            
            if let nonoptionalError = error {
                log.error("FRAMEWORK ERRROR <-  \(responseUrl) message=\(nonoptionalError.localizedDescription)")
                
                self.notifyDelegateRequestFailed(requestType: requestType, httpCode: nil)
            }
            else {
                
                if (task is URLSessionDataTask) {
                    self.dataTaskCompleted(task: task as! URLSessionDataTask, responseUrl: responseUrl, requestType: requestType, httpCode: httpResponse.statusCode)
                }
            }
            
        } else {
            self.notifyDelegateRequestFailed(requestType: .Unknown, httpCode: nil)
        }
        
        //remove task from dictionary
        self.tasksBeingExecuted.removeValue(forKey: taskDescription)
        self.active = self.tasksBeingExecuted.count > 0
        
    }
    
    //MARK: URLSessionDataDelegate
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        if let taskDescription = dataTask.taskDescription {
            let rawData = NSMutableData(data: self.tasksBeingExecuted[taskDescription]!)
            rawData.append(data)
            self.tasksBeingExecuted[taskDescription] = rawData as Data
        }
    }
    
}
