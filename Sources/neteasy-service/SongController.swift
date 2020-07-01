//
//  File.swift
//  
//
//  Created by robbin on 2020/6/30.
//

import Foundation
import Alamofire

class SongController {
    static func getSongNameWithID(_ id: Int, complete: @escaping (_ list: String) -> Void ) {
        let result = Network.GET("http://irobbin.com:3000/song/detail?ids=\(id)", parameter: ["ids" : id])
        print(result)
        
        AF.request("http://irobbin.com:3000/song/detail", method: .get, parameters: ["ids" : id]).responseJSON(queue: DispatchQueue.global(qos: .default), completionHandler: { response in
            let json = response.value as? [String: Any]
            let songs = json?["songs"] as? [Any]
            let song = songs!.first! as! [String: Any]
            let name = song["name"] as! String
            complete(name)
        })
    }
}
