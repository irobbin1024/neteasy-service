//
//  File.swift
//  
//
//  Created by robbin on 2020/6/30.
//

import Foundation

class PlaylistController {
    static func getPlaylistWithID(_ id: String, complete: @escaping (_ list: [String], _ playlistName: String) -> Void ) {
        let json = Network.GET("http://irobbin.com:3000/playlist/detail", parameter: ["id" : id])

        let playlist = json["playlist"] as? [String: Any]
        let playListName = playlist?["name"] as? String
        let trackIds = playlist?["trackIds"] as? [Any]
        var ids:[String] = []
        
        for track in trackIds! {
            let trackDictionary = track as? [String: Any]
            if let realTrackDictionary = trackDictionary {
                let result = realTrackDictionary["id"] as! Int
                
                SongController.getSongNameWithID(result) { (songName) in
                    ids.append(songName)
                    print("当前歌曲 : \(songName)")
                }

            }
        }
        complete(ids, playListName ?? "")

    }
}
