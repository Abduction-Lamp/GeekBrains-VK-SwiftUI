//
//  SignIn.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI
import Combine

struct SignIn: View {
    
    private let style = ConstUIStyle.instances
    
    @State private var login = ""
    @State private var password = ""
    @State private var isWrongPasswordMpdalShown = false
    
    @Binding var isUserAuthorization: Bool
    
    
    private let keyboardStatePublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification).map { _ in true },
        NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification).map { _ in false }
    )
    
    
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
                        Button(action: {
                            let result = verifyLoginData()
                            isWrongPasswordMpdalShown = !result
                            isUserAuthorization = result
                        }) {
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
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .onReceive(keyboardStatePublisher) { _ in }
            .alert(isPresented: $isWrongPasswordMpdalShown) {
                Alert(title: Text("Ощибка"),
                      message: Text("Неверный логин или пароль"),
                      dismissButton: .default(Text("Ок"), action: {
                        password = ""
                      }))
            }
        }
    }
    
    
    private func verifyLoginData() -> Bool {
        return (login == "1" && password == "1")
    }
}


extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
