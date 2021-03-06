//
//  File.swift
//  
//
//  Created by robbin on 2020/6/30.
//

import Foundation
import PerfectHTTP
import PerfectHTTPServer

class Application: NSObject {
    public func startServer() {

        // 注册您自己的路由和请求／响应句柄
        var routes = Routes()
        routes.add(method: .get, uri: "/index") {
            request, response in

            var content: String = ""
            
            UserController.loginWithPhone("17681821076", password: "19920613") { (success) in
                if success {
                    print("登录成功")
                    var playlistID: String = ""
                    for param in request.queryParams {
                        if param.0 == "id" {
                            playlistID = param.1
                        }
                    }
                    PlaylistController.getPlaylistWithID(playlistID) { (list, playlistName) in
                        let json: [String: Any] = ["name" : playlistName, "list" : list]
                        let jsonData = try! JSONSerialization.data(withJSONObject: json)
                        content = String(data: jsonData, encoding: .utf8) ?? ""
                    }
                }
            }

            response.setHeader(.contentType, value: "application/json; charset=utf-8")
            response.appendBody(string: "\(content)")
                .completed()
        }
        
        routes.add(method: .get, uri: "/singertop50") {
            request, response in

            var content: String = ""
            var singer: String = ""
            for param in request.queryParams {
                if param.0 == "singer" {
                    singer = param.1
                }
            }
            
            SingerController.searchWithKeyword(singer) { (singerModel) in
                PlaylistController.top50ForSingerWithID(singerModel.id, singer: singerModel.name) { (list, playListName) in
                    let json: [String: Any] = ["name" : playListName, "list" : list]
                    let jsonData = try! JSONSerialization.data(withJSONObject: json)
                    content = String(data: jsonData, encoding: .utf8) ?? ""
                }
            }

            response.setHeader(.contentType, value: "application/json; charset=utf-8")
            response.appendBody(string: "\(content)")
                .completed()
        }

        do {
            // 启动HTTP服务器
            try HTTPServer.launch(
                .server(name: "localhost", port: 8181, routes: routes))
        } catch {
            fatalError("\(error)") // fatal error launching one of the servers
        }
        
        
            
    }
}
