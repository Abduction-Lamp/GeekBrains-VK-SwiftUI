//
//  FriendsRequests.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 17.10.2021.
//

import Foundation

final class FriendsRequests {
    
    private var session: URLSession
    private let version = "5.130"
    
    init(session: URLSession) {
        self.session = session
    }
    
    public func get(completed: @escaping ([User]?) -> Void) {
    
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "fields", value: "bdate, nickname, domain, photo_50, online, sex, last_seen, city, country"),
            URLQueryItem(name: "order", value: "name"),
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
                let frendsResponse = try JSONDecoder().decode(UserService.self, from: data)
                completed(frendsResponse.response.items)
            } catch {
                print(error.localizedDescription)
                completed(nil)
            }
        }
        .resume()
    }
}
