//
//  User.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 19.08.2023.
//

class User {
    var name = ""
    var wallet = 0
    
    static let shared = User()
    
    private init() {}
}
