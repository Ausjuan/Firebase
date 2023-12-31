//
//  SignUpView.swift
//  FriendlyChatSwiftUI
//
//  Copyright (c) 2022 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import SwiftUI

struct SignUpView: View {
  @ObservedObject var user: UserViewModel
  @Binding var isPresented: Bool
  var screenHeight = UIScreen.main.bounds.size.height
  var screenWidth = UIScreen.main.bounds.size.width

  var body: some View {
    VStack {
      // Sign up title
      Text("Sign up".uppercased())
        .font(.title)

      Spacer()
        .frame(idealHeight: 0.1 * screenHeight)
        .fixedSize()

      // Email textfield
      HStack {
        Image("user-icon")
          .resizable()
          .scaledToFit()
          .frame(width: 30.0, height: 30.0)
          .opacity(0.5)
        TextField("Email", text: $user.email)
          .keyboardType(.emailAddress)
          .autocapitalization(UITextAutocapitalizationType.none)
      }
      .padding(0.02 * screenHeight)
      .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray5)))
      .frame(width: screenWidth * 0.8)

      // Password textfield
      HStack {
        Image("lock-icon")
          .resizable()
          .scaledToFit()
          .frame(width: 30.0, height: 30.0)
          .opacity(0.5)
        SecureField("Password", text: $user.password)
      }
      .padding(0.02 * screenHeight)
      .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray5)))
      .frame(width: screenWidth * 0.8)

      Spacer()
        .frame(idealHeight: 0.05 * screenHeight)
        .fixedSize()

      // Sign up button
      Button(action: user.signUp) {
        Text("Sign up".uppercased())
          .foregroundColor(.white)
          .font(.title2)
          .bold()
      }
      .padding(0.025 * screenHeight)
      .background(Capsule().fill(Color("FirebaseOrange")))
      .buttonStyle(BorderlessButtonStyle())

      Spacer()
        .frame(idealHeight: 0.05 * screenHeight)
        .fixedSize()

      // Navigation text
      HStack {
        Text("Already have an account?")
        Button(action: {
          isPresented = false
        }) {
          Text("Login".uppercased())
            .bold()
        }
        .buttonStyle(BorderlessButtonStyle())
      }
    }
    .alert(isPresented: $user.alert, content: {
      Alert(
        title: Text("Message"),
        message: Text(user.alertMessage),
        dismissButton: .destructive(Text("Ok"))
      )
    })
  }
}
