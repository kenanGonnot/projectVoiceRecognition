//
//  File.swift
//  projectVoiceRecognition
//
//  Created by Kenan on 30/05/2021.
//

import Foundation


struct Utilisateurs {

  var username: String
  var email: String
  var password: String
  var userID: String
  
  var dictionary: [String: Any] {
    return [
      "username": username,
      "email": email,
      "password": password,
      "userID": userID,
    ]
  }
}
