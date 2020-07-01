//
//  File 2.swift
//  
//
//  Created by robbin on 2020/7/1.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct Network {
    static func GET(_ url:String, parameter: [String: Any]) -> [String: Any] {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let signal = DispatchSemaphore(value: 0)
        var result: [String: Any] = [:]
        DispatchQueue.global(qos: .default).async {
            var urlComponents = URLComponents(string: url)!
            var queryItemList = [URLQueryItem]()
            for (key, value) in parameter {
                let item = URLQueryItem(name: key, value: "\(value)")
                queryItemList.append(item)
            }
            urlComponents.queryItems = queryItemList
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request) { (data, response, error) in
                let json = try? JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String: Any]
                result = json!
                signal.signal()
            }
            
            task.resume()
        }
        
        signal.wait()
        return result
    }
}
