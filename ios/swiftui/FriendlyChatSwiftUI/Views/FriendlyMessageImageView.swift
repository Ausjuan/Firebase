//
//  FriendlyMessageImageView.swift
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
import FirebaseStorage

struct FriendlyMessageImageView: View {
  let fullPath: String
  let storage = Storage.storage()
  @State private var image = UIImage(systemName: "photo")

  func downloadImage() {
    let storageRef = storage.reference(withPath: fullPath)
    storageRef.getData(maxSize: 1 * 2048 * 2048) { data, error in
      if let error = error {
        print("Error downloading image: \(error)")
      } else {
        self.image = UIImage(data: data!)
      }
    }
  }

  var body: some View {
    Image(uiImage: self.image!)
        .resizable()
        .scaledToFill()
    .frame(maxWidth: 150, alignment: .leading)
    .onAppear(perform: downloadImage)
  }
}
