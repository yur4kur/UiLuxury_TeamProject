//
//  DataAboutCharacter.swift
//  UiLuxury_TeamProject
//
//  Created by Акира on 17.08.2023.
//

import Foundation

struct Character {
    
    static var shared = Character()
    
    private init() {}
    
    var userName = ""
    var userWallet = 0
}
