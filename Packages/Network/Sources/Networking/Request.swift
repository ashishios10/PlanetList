//
//  Request.swift
//
//
//  Created by Ashish Patel on 2024/10/11.
//

import UIKit
import Utilities

public enum RequestConfig {
    case fetchPlanets(pageNo: Int)
    
    public var value: Request? {
        switch self {
        case .fetchPlanets(let pageNo):
            let urlString = String(format: APIURL.getPlanets.getURL(), pageNo)
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}

enum RequestMethod: String {
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
    var value: String {
        return self.rawValue
    }
}

/**
 ## Request
 
 This class provides URLRequest.
 
 */
final public class Request: NSMutableURLRequest {
    
    convenience init?(requestMethod: RequestMethod,
                      urlString: String,
                      bodyParams: [String: Any]? = nil) {
        guard let url =  URL.init(string: urlString) else {
            return nil
        }
        self.init(url: url)
        if let bodyParams = bodyParams {
            let data = try? JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
            self.httpBody = data
        }
        self.httpMethod = requestMethod.value
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
