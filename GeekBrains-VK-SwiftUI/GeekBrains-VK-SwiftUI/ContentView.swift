//
//  ContentView.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 11.09.2021.
//

import SwiftUI
import Combine


struct ContentView: View {
    
    @State private var login = ""
    @State private var password = ""
    @State private var keyboardHeight: CGFloat = 0
    
    
    private let keyboardHeightPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                .compactMap { $0.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect }
                .map { $0.size.height },
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ -> CGFloat in 0 })
        .removeDuplicates()
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
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
                                .background(Color.init(red: 33/255, green: 111/255, blue: 243/255))
                        }
                        .frame(width: 80, height: 37, alignment: .center)
                        .border(Color.init(red: 33/255, green: 111/255, blue: 243/255), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10.0)
                        .padding(.top, 25)
                        .disabled(login.isEmpty || password.isEmpty)
                    }
                    .frame(maxWidth: 280)
                    .padding(.top, 70)
                }
                .frame(minWidth: geometry.size.width, idealWidth: geometry.size.width, maxWidth: geometry.size.width)
            }
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardHeightPublisher) { height in
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    self.keyboardHeight = height - 20
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
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
