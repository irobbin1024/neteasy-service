//
//  File.swift
//  
//
//  Created by robbin on 2020/6/30.
//

import Foundation
import Alamofire

class PlaylistController {
    static func getPlaylistWithID(_ id: String, complete: @escaping (_ list: [String], _ playlistName: String) -> Void ) {
        AF.request("http://irobbin.com:3000/playlist/detail", method: .get, parameters: ["id" : id]).responseJSON(queue: DispatchQueue.global(qos: .default), completionHandler: { response in
            let json = response.value as? [String: Any]
            let playlist = json?["playlist"] as? [String: Any]
            let playListName = playlist?["name"] as? String
            let trackIds = playlist?["trackIds"] as? [Any]
            var ids:[String] = []
            
            let group = DispatchGroup()
            
            for track in trackIds! {
                let trackDictionary = track as? [String: Any]
                if let realTrackDictionary = trackDictionary {
                    let result = realTrackDictionary["id"] as! Int
                    
                    group.enter()
                    SongController.getSongNameWithID(result) { (songName) in
                        ids.append(songName)
                        print("当前歌曲 : \(songName)")
                        group.leave()
                    }
    
                }
            }
            
            group.notify(queue: DispatchQueue.global(qos: .default)) {
                complete(ids, playListName ?? "")
            }
        })
    }
}
