//
//  File.swift
//  
//
//  Created by robbin on 2020/6/30.
//

import Foundation
import Alamofire

class UserController {
    static func loginWithPhone(_ phone: String, password : String, complete: @escaping (_ success: Bool) -> Void ) {
        AF.request("http://irobbin.com:3000/login/cellphone", method: .get, parameters: ["phone" : "17681821076", "password" : "19920613"]).responseJSON(queue: DispatchQueue.global(qos: .default), completionHandler: { response in
            let json = response.value as? [String: Any]
            let code = json?["code"] as? Int
            complete(code == 200)
        })
    }
}
