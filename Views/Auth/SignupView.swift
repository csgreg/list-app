//
//  SignupView.swift
//  lify
//
//  Created by Gergo Csizmadia on 2023. 03. 12..
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @Binding var currentShowingView: String
    @AppStorage("uid") var userID: String = ""
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var signUpFail = false
    @State private var failTitle = ""
    @State private var loading: Bool = false
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text("Create an account!")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                //email input
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                    
                    Spacer()
                    
                    if(email.count != 0){
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
     
                    }
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                
                //password
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                    
                    Spacer()
                    
                    if(password.count != 0){
                        Image(systemName: password.isValidPassword() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(password.isValidPassword() ? .green : .red)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                
                //sign in button
                Button(action: {
                    withAnimation{
                        self.currentShowingView = "login"
                    }
                }){
                    Text("Already have an account?")
                        .foregroundColor(.white.opacity(0.9))
                }
                
                
                Spacer()
                Spacer()
                
                //sign in button
                Button(action: {
                    loading = true
                    if(!email.isValidEmail()){
                        signUpFail = true
                        failTitle = "Please type a correct email address!"
                        loading = false
                        return
                    }
                    if(!password.isValidPassword()){
                        signUpFail = true
                        failTitle = "Please type a correct password!"
                        loading = false
                        return
                    }
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if error != nil {
                            signUpFail = true
                            failTitle = "Please try again later or check your internet connection!"
                            loading = false
                            return
                        }
                        
                        if let authResult = authResult{
                            withAnimation{
                                userID = authResult.user.uid
                            }
                        }
                        loading = false
                    }
                }){
                    Text("Create New Account")
                        .foregroundColor(.black)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                        )
                        .padding(.horizontal)
                }
                .disabled(loading)
                .alert(isPresented: $signUpFail) {
                    Alert(
                        title: Text("Failed to sign up"),
                        message: Text(failTitle)
                    )
                }
            }
        }
    }
}
