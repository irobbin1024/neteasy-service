//
//  File.swift
//  
//
//  Created by robbin on 2020/6/30.
//

import Foundation

class UserController {
    static func loginWithPhone(_ phone: String, password : String, complete: @escaping (_ success: Bool) -> Void ) {
        let json = Network.GET("http://irobbin.com:3000/login/cellphone", parameter: ["phone" : "17681821076", "password" : "19920613"])
        let code = json["code"] as? Int
        complete(code == 200)
    }
}
