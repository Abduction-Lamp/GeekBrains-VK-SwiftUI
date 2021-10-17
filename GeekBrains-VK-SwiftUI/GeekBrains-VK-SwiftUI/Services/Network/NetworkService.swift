//
//  NetworkService.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 16.10.2021.
//

import Foundation

final class NetworkService {
    
    static var instance = NetworkService()
    private init() {}

    
    
    private let version = "5.130"
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        return URLSession(configuration: config)
    }()
    
    
    
    //  MARK:   - FRIENDS
    //
    public func getFriends(completed: @escaping ([User]?) -> Void) {
        
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

            do {
                let frendsResponse = try JSONDecoder().decode(UserService.self, from: data)
                completed(frendsResponse.response.items)
            } catch {
                print(error.localizedDescription)
                completed(nil)
            }
        }.resume()
    }
}
