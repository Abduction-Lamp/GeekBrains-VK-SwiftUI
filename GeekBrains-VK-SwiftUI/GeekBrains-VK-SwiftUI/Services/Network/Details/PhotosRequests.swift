//
//  PhotosRequests.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 18.10.2021.
//

import Foundation

final class PhotosRequests {
    
    private var session: URLSession
    private let version = "5.130"
    
    init(session: URLSession) {
        self.session = session
    }
    
    public func get(ownerId: Int, completed: @escaping ([Photo]?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(ownerId)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "photo_sizes", value: "1"),
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
                let photosResponse = try JSONDecoder().decode(PhotoService.self, from: data)
                completed(photosResponse.response.items)
                print("URLSession: Photos list is loaded")
            } catch {
                print(error.localizedDescription)
                completed(nil)
            }
        }
        .resume()
    }
}
