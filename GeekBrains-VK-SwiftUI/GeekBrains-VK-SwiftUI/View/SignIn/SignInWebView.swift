//
//  SignInWebView.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 16.10.2021.
//

import SwiftUI
import WebKit

struct SignInWebView: UIViewRepresentable {
    
    fileprivate var navigationDelegate: NSObject & WKNavigationDelegate
    
    init(isUserAuthorization: Binding<Bool>) {
        navigationDelegate = WebViewNavigationDelegate(isUserAuthorization: isUserAuthorization)
    }
    
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = navigationDelegate
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let request = VKAuth.instance.buildAuthRequest() {
            uiView.load(request)
        }
    }
}


class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    
    @Binding private var isUserAuthorization: Bool
    
    init(isUserAuthorization: Binding<Bool>) {
        _isUserAuthorization = isUserAuthorization
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let user = Int(userIdString)
        else {
            decisionHandler(.allow)
            return
        }
        
        
        Session.instance.token = token
        Session.instance.user = user
        Session.instance.date = Date().timeIntervalSince1970
        
        print("TOKEN:\n\(token)")
        print("USER:\n\(user)")
        
        decisionHandler(.cancel)
        isUserAuthorization = true
    }
}
