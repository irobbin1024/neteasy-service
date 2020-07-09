//
//  File.swift
//  
//
//  Created by irobbin on 2020/7/5.
//

import Foundation

struct SingerModel {
    let name: String
    let id: String
}

class SingerController {
    static func searchWithKeyword(_ keyword: String, complete: @escaping (_ singerModel: SingerModel) -> Void ) {
        let json = Network.GET("http://irobbin.com:3000/search", parameter: ["keywords" : keyword, "type" : "100"])
        let id = ((json["result"] as? [String: Any])?["artists"] as? [[String: Any]])?.first?["id"] as? Int ?? 0
        let singerModel = SingerModel(name: keyword, id: "\(id)")
        complete(singerModel)
    }
}
