//
//  ApiService.swift
//  MarvelTest
//
//  Created by Vlad on 27/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import UIKit

class APIService {
    
    public func requestGetApi(url: String, params: Dictionary<String, String>?, headers: Dictionary<String, String>?, completionHandler: @escaping (_ data: NSData?, _ response: URLResponse?, _ error: NSError?) -> ()) {
        
        // Indicate download
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var stringUrl = url
        
        // add parameters (if any) to the url
        if let params = params {
            stringUrl.append("?")
            var it = 0
            for (key, value) in params {
                if (it>0) {stringUrl.append("&")}
                stringUrl.append("\(key)=\(value)")
                it+=1
            }
        }
        
        let urlRequest = NSURL(string: stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        let request = NSMutableURLRequest(url: urlRequest as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        
        // add headers (if any) to the request
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            
        }
        
        // get the data
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            completionHandler(data as NSData?, response, error as NSError?)
            
            // Stop download indication
              DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        
        task.resume()
    }
    
}
