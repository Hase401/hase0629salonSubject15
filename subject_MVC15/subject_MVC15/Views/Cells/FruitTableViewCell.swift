//
//  FruitTableViewCell.swift
//  subject_MVC15
//
//  Created by 長谷川孝太 on 2021/07/02.
//

import UIKit

class FruitTableViewCell: UITableViewCell {

    @IBOutlet private weak var checkmarkImageView: UIImageView!
    @IBOutlet private weak var fruitNameLabel: UILabel!

    static let identifier = "FruitTableViewCell"

    static func nib() -> UINib {
        UINib(nibName: "FruitTableViewCell", bundle: nil)
    }

    func configure(fruit: Fruit) {
        fruitNameLabel.text = fruit.name
        checkmarkImageView.image = fruit.isChecked ? UIImage(systemName: "checkmark") : nil
    }

}
