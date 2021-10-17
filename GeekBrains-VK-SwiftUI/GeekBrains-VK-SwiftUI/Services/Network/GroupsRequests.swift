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
    
    
    public func getGroups(completed: @escaping ([Group]?) -> Void) {
    
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

            do {
                let groupsResponse = try JSONDecoder().decode(GroupService.self, from: data)
                completed(groupsResponse.response.items)
            } catch {
                print(error.localizedDescription)
                completed(nil)
            }
        }.resume()
    }
}
