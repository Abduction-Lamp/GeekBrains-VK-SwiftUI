//
//  NewsfeedRequests.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 17.10.2021.
//

import Foundation

final class NewsfeedRequests {
    
    private var session: URLSession
    private let version = "5.130"
    
    
    init(session: URLSession) {
        self.session = session
    }
    
    
    public func get(filters: String,
                    count: Int = 20,
                    startTime: TimeInterval? = nil,
                    nextFrom: String = "",
                    completed: @escaping (NewsfeedService?) -> Void) -> Void {
    
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "filters", value: filters),
            URLQueryItem(name: "count", value: "\(count)"),
            URLQueryItem(name: "start_from", value: nextFrom),
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
                let newsfeedLisn = try JSONDecoder().decode(NewsfeedService.self, from: data)
                completed(newsfeedLisn)
                print("URLSession: Newsfeed is loaded")
            } catch {
                print(error.localizedDescription)
                completed(nil)
            }
        }
        .resume()
    }
}
