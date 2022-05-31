//
//  ResponsePosts.swift
//  LearnCollectionVCWithAsyncImages
//
//  Created by Steven Hertz on 5/31/22.
//

import Foundation

struct PostUserProfileImage: Codable {
  let medium: String
}

struct PostUser: Codable {
  let profile_image: PostUserProfileImage
}

struct PostUrls: Codable {
  let regular: String
}

struct Post: Codable {
  let id: String
  let description: String?
  let user: PostUser
  let urls: PostUrls
}

 struct APIResponse: Codable {
     var results: [Post] = []
}
