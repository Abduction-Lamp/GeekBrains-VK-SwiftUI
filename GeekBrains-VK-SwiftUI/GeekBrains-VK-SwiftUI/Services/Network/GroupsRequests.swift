//
//  GroupsRequests.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 17.10.2021.
//

import Foundation


final class GroupsRequests {
    
    private var session: URLSession
    private let version = "5.130"
    
    
    init(session: URLSession) {
        self.session = session
    }
    
    
    //  MARK:   - Load Gpoups
    //
    public func get(completed: @escaping ([Group]?) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: version)
        ]
        guard let url = urlComponents.url else {
            completed(nil)
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completed(nil)
                return
            }
//            guard let response = response as? HTTPURLResponse,
//                  response.statusCode == 200 else {
//
//                completed(nil)
//                return
//            }
            guard let data = data else {
                completed(nil)
                return
            }

            //  FIXME: - Нужно ли эту часть кода оборачивать в DispatchQueue.global().async ?
            //
            do {
                let groupsResponse = try JSONDecoder().decode(GroupService.self, from: data)
                completed(groupsResponse.response.items)
            } catch {
                print(error.localizedDescription)
                completed(nil)
            }
        }.resume()
    }
    
    
    //  MARK:   - Search Gpoups
    //
    public func search(query: String, offset: Int, completed: @escaping ([Group]?) -> Void) -> Int {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: version)
        ]
        guard let url = urlComponents.url else {
            completed(nil)
            return 0
        }
        
        var count = 0
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completed(nil)
                return
            }
//            guard let response = response as? HTTPURLResponse,
//                  response.statusCode == 200 else {
//
//                completed(nil)
//                return
//            }
            guard let data = data else {
                completed(nil)
                return
            }

            //  FIXME: - Нужно ли эту часть кода оборачивать в DispatchQueue.global().async ?
            //
            do {
                let groupsResponse = try JSONDecoder().decode(GroupService.self, from: data)
                completed(groupsResponse.response.items)
                count = groupsResponse.response.items.count
            } catch {
                print(error.localizedDescription)
                completed(nil)
            }
        }.resume()
        
        return count
    }
    
    
    //  MARK:   - Join Gpoups
    //
    public func join(id: Int) -> Void {
        requestToJoinOrLeave(id: id, path: "/method/groups.join")
    }
    
    
    //  MARK:   - Leave Gpoups
    //
    public func leave(id: Int) -> Void {
        requestToJoinOrLeave(id: id, path: "/method/groups.leave")
    }
    
    
    //  MARK:   - General part for requests to join or leave the group
    //
    private func requestToJoinOrLeave(id: Int, path: String) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "group_id", value: "\(id)"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: version)
        ]
        guard let url = urlComponents.url else {
            return
        }

        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
//            guard let response = response as? HTTPURLResponse,
//                  response.statusCode == 200 else {
//                return
//            }
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                if let response = json as? [String: Int] {
                    if response["response"] != 1 {
                        print("The request has not been fulfilled")
                    }
                }
            } catch {
                print("Data parsing error")
            }
        }
        .resume()
    }
}
