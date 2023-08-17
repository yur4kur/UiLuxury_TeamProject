//
//  DataAboutCharacter.swift
//  UiLuxury_TeamProject
//
//  Created by Акира on 17.08.2023.
//

import Foundation

struct DataAboutCharacter {
    
    static var shared = DataAboutCharacter()
    
    private init() {}
    
    var userName = ""
    var userWallet = 0
}
