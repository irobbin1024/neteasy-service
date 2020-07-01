//
//  File.swift
//  
//
//  Created by robbin on 2020/6/30.
//

import Foundation

class SongController {
    static func getSongNameWithID(_ id: Int, complete: @escaping (_ list: String) -> Void ) {
        let json = Network.GET("http://irobbin.com:3000/song/detail", parameter: ["ids" : id])
        
        let songs = json["songs"] as? [Any]
        let song = songs!.first! as! [String: Any]
        let ar = song["ar"] as? [Any]
        let arName = (ar?.first! as? [String: Any])?["name"]
        let name = song["name"] as! String
        complete("\(name) \(arName!)")
    }
}
