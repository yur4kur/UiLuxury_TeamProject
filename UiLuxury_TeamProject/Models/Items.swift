//
//  Items.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.07.2023.
//

struct Items {
    
    let nameItem: String
    
    let priceItem:  Int
    
    let descriptionItem: String
    
}

func getItemsList() -> [Items] {
    
    [
        Items(nameItem: "Homeless hat",
              priceItem: 15,
              descriptionItem: "Plus one point to any tap"),
        
        Items(nameItem: "Lost talent",
              priceItem: 40,
              descriptionItem: "Multiplies the number of points per touch by 2"),
        
        Items(nameItem: "Back to ex-girlfriend",
              priceItem: 80,
              descriptionItem: "Plus random point per one tap. There is a chance to lose 50 points at once "),
        
        Items(nameItem: "New haircut",
              priceItem: 80,
              descriptionItem: "Plus three points to any tap"),
        
        Items(nameItem: "Red-Bull",
              priceItem: 140,
              descriptionItem: "Multiple point from one tap by 3"),
        
        Items(nameItem: "Lotery ticket",
              priceItem: 140,
              descriptionItem: "Delete all your items and take random item from shop"),
        
        Items(nameItem: "Illegal business",
              priceItem: 140,
              descriptionItem: "Take 500 points, but locked one item slot "),
        
        Items(nameItem: "Mortgage",
              priceItem: 200,
              descriptionItem: "Multiple your score wallet and lock one item slot"),
        
        Items(nameItem: "Good job",
              priceItem: 200,
              descriptionItem: "Plus 7 point per one tap"),
        
        Items(nameItem: "Psychologist",
              priceItem: 250,
              descriptionItem: "Multiplies the number of points per touch by 4"),
        
        Items(nameItem: "New Love",
              priceItem: 250,
              descriptionItem: "Random points per one tap. There is a chance lost 100 points per tap"),
        
        Items(nameItem: "Release a rock album",
              priceItem: 500,
              descriptionItem: "Take a random huge point, or lose all. If you sell, get -200 points"),
        
        Items(nameItem: "Defeat Mom's Friend's Son",
              priceItem: 1000,
              descriptionItem: "Take a god state and plus 20 points to any tap. "),
        
        Items(nameItem: "Win this game and take credits",
              priceItem: 6000,
              descriptionItem: "Good Job")
                
    ]
}
