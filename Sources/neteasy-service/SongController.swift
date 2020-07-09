//
//  File.swift
//  
//
//  Created by robbin on 2020/6/30.
//

import Foundation

class SongController {
    static func getSongNameWithID(_ id: Int, complete: @escaping (_ list: (String, String, String)) -> Void ) {
        let json = Network.GET("http://irobbin.com:3000/song/detail", parameter: ["ids" : id])
        
        let songs = json["songs"] as? [Any]
        let song = songs!.first! as! [String: Any]
        let ar = song["ar"] as? [Any]
        let arName = (ar?.first! as? [String: Any])?["name"]
        let name = song["name"] as! String
        let singer = (((song["ar"] as? [Any])?.first as? [String: Any])?["name"]) as! String
        complete(("\(name) \(arName!)", name, singer))
    }
    
    static func getSongListWithIDList(_ id: [String], complete: @escaping (_ list: [(String, String, String, String)]) -> Void ) {
        let result = id.joined(separator: ",")
        let json = Network.GET("http://irobbin.com:3000/song/detail", parameter: ["ids" : result])
        let songs = json["songs"] as? [Any]
        var list = [(String, String, String, String)]()
        for song in songs! {
            let s = song as? [String: Any]
            let name = s!["name"] as! String
            var prefix: String = ""
            if name.count > 3 {
                prefix = String(name.prefix(3))
            } else {
                prefix = name
            }
            let arName = (((s!["ar"] as? [Any])?.first as? [String: Any])?["name"]) as! String
            list.append(("\(name) \(arName)", name, arName, prefix))
        }
        complete(list)
    }
}
