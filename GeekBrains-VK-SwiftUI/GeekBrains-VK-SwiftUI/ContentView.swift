//
//  ContentView.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 11.09.2021.
//

import SwiftUI
import Combine


struct ContentView: View {
    
    private let style = ConstUIStyle.instances
    
    @State private var login = ""
    @State private var password = ""
    @State private var keyboardHeight: CGFloat = 0
    
    
    private let keyboardAppearedPablisher = NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)
    private let keyboardDisappearedPablisher = NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image("VKLogoAndName")
                        .padding(.top, 50)
                    
                    VStack {
                        HStack {
                            Text("Логин")
                            Spacer()
                            TextField("", text: $login)
                                .frame(maxWidth: 200)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack {
                            Text("Пароль")
                            Spacer()
                            SecureField("", text: $password)
                                .frame(maxWidth: 200)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        Button(action: { print("Hello") }) {
                            Text("Войти")
                                .bold()
                                .frame(width: 80, height: 37, alignment: .center)
                                .foregroundColor(.white)
                                .background(style.vkBrandColor)
                        }
                        .frame(width: 80, height: 37, alignment: .center)
                        .cornerRadius(10.0)
                        .padding(.top, 25)
                        .disabled(login.isEmpty || password.isEmpty)
                    }
                    .frame(maxWidth: 280)
                    .padding(.top, 70)
                }
                .frame(minWidth: geometry.size.width, idealWidth: geometry.size.width, maxWidth: geometry.size.width)
            }
            .onReceive(keyboardAppearedPablisher) { notificationEvent in
                guard let keyboardBouns = notificationEvent.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
                    return
                }
                keyboardHeight = keyboardBouns.size.height
            }
            .onReceive(keyboardAppearedPablisher) { _ in
                keyboardHeight = 0
            }
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
