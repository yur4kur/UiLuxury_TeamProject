//
//  ShopCell.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.05.2024.
//

import UIKit

// MARK: - CellViewModelOutput
struct CellViewModelOutput {
    var mainText: String
    var secondaryText: String
}

// MARK: - ShopCell

final class ShopCell: UITableViewCell {
    
    var viewModel: (any ShopCellViewModelProtocol)? {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel?.output?.mainText
            content.textProperties.lineBreakMode = .byTruncatingHead
            content.secondaryText = viewModel?.output?.secondaryText
            content.secondaryTextProperties.font = .boldSystemFont(ofSize: 17)
        }
    }
}
