//
//  ShopCellViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.05.2024.
//

import Foundation

// MARK: - ShopCellViewModelProtocol

protocol ShopCellViewModelProtocol: ViewModelType where Input == Item {
    
    var output: CellViewModelOutput? { get set }
    
}

// MARK: - ShopCellViewModel

final class ShopCellViewModel: ShopCellViewModelProtocol {

    // MARK: - Types
 
    
    // MARK: - Private properties
    
    private var displayedItem: Item
    
    // MARK: - Public properties
    
    var output: CellViewModelOutput?
    
    // MARK: - Initializers
    init(item: Item) {
        displayedItem = item
    }
    
    // MARK: - Public methods
    
    func transform(input: Item) {
//        output.mainText = displayedItem.description
//        output.secondaryText =  " \(displayedItem.price.formatted())"
//        return output
//        //Constants.priceTag +
        
    }
    
    // MARK: - Private methods
    
    private func getCellText(item: Item) -> String {
        item.description
    }
    
    private func getSecondaryText(item: Item) -> String {
        //Constants.priceTag +
        " \(item.price.formatted())"
    }
}
