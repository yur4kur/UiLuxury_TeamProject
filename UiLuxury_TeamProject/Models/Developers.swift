//
//  Developers.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.07.2023.
//

struct Developers {
    
    let name: String
    let clan: String
    var fullname: String {
        "\(name) + \(clan)"
    }
    
    let jobInfo: String
    let reactionToApp: String
    
}
