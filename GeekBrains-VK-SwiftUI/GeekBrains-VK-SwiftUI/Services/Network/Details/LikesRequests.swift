//
//  LikesRequests.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 02.11.2021.
//
import Foundation

final class LikesRequests {
    
    private var session: URLSession
    private let version = "5.130"
    
    
    init(session: URLSession) {
        self.session = session
    }
    
    
    //  MARK:   - Like Add
    //
    public func add(ownerId: Int, itemId: Int, type: String, completed: @escaping (Int?) -> ()) -> Void {
        like(path: "/method/likes.add", ownerId: ownerId, itemId: itemId, type: type, completed: completed)
    }
    
    
    //  MARK:   - Like Delete
    //
    public func delete(ownerId: Int, itemId: Int, type: String, completed: @escaping (Int?) -> ()) -> Void {
        like(path: "/method/likes.delete", ownerId: ownerId, itemId: itemId, type: type, completed: completed)
    }
    
    
    //  MARK:   - Сommon for Add and Delete methods
    //
    private func like(path: String, ownerId: Int, itemId: Int, type: String, completed: @escaping (Int?) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "owner_id", value: "\(ownerId)"),
            URLQueryItem(name: "item_id", value: "\(itemId)"),
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
            guard let data = data else {
                completed(nil)
                return
            }


            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                print("URLSession: Serializing data error")
                return
            }
            guard let responseObj = json as? [String : [String : Int]] else {
                print("Request failed: Couldn't parse JSON")
                return
            }
            
            completed(responseObj["response"]?["likes"])
        }.resume()
    }
}
