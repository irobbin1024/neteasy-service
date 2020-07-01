//
//  File 2.swift
//  
//
//  Created by robbin on 2020/7/1.
//

import Foundation
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
            let request = try? URLRequest(url: URL(string: url)!, method: .get)
            let task = session.dataTask(with: request!) { (data, response, error) in
                do {
                    let json = try? JSONSerialization.jsonObject(with: data!,
                                                                options:.allowFragments) as! [String: Any]
                    result = json!
                 } catch {
                   print(error)
                }
                signal.signal()
            }
            
            task.resume()
        }
        
        signal.wait()
        return result
    }
}
