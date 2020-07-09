//
//  File.swift
//  
//
//  Created by robbin on 2020/6/30.
//

import Foundation
import GBig

class PlaylistController {
    static func getPlaylistWithID(_ id: String, complete: @escaping (_ list: [[String: String]], _ playlistName: String) -> Void ) {
        let json = Network.GET("http://irobbin.com:3000/playlist/detail", parameter: ["id" : id.isEmpty ? "504334809" : id])

        let playlist = json["playlist"] as? [String: Any]
        let playListName = playlist?["name"] as? String
        let trackIds = playlist?["trackIds"] as? [Any]
        var ids:[[String: String]] = []
        
        let idList = trackIds!.map { (item) -> String in
            let itemDic = item as! [String: Any]
            let idStr = itemDic["id"]
            let id = idStr as! Int
            return id > 0 ? "\(id)" : ""
        }

        SongController.getSongListWithIDList(idList) { (songs) in
            for song in songs {
                ids.append(["name" : song.0, "songName" : song.1, "singer" : song.2, "prefix" : song.3])
                print("当前歌曲 : \(song.0)")
            }
        }
        complete(ids, playListName ?? "")

    }
    
    static func top50ForSingerWithID(_ id: String, singer: String, complete: @escaping (_ list: [[String: String]], _ playlistName: String) -> Void ) {
        let json = Network.GET("http://irobbin.com:3000/artist/top/song", parameter: ["id" : id.isEmpty ? "74625" : id])

        let playlist = json["songs"] as? [[String: Any]]
        var ids:[[String: String]] = []
        
        if let _playList = playlist {
            for song in _playList {
                let songName = song["name"] as? String ?? ""
                let singerName = (song["ar"] as! [[String: Any]]).first?["name"] as? String ?? ""
                let name = "\(songName) \(singerName)"
                var prefix = ""
                if songName.count > 2 {
                    prefix = String(name.prefix(2))
                } else {
                    prefix = songName
                }
                
                ids.append(["name" : name, "songName" : songName, "singer" : singerName, "fSinger" : singerName.big5, "prefix" : prefix])
            }
        }
        
        complete(ids, "\(singer)的热门top50")

    }
}
