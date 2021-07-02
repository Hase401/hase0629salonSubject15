//
//  InputFruitViewController.swift
//  subject_MVC15
//
//  Created by 長谷川孝太 on 2021/07/02.
//

import UIKit

class InputFruitViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!

    static func instantiate(didSaveFruits: @escaping (String) -> Void,
                            didCancel: @escaping () -> Void ) -> InputFruitViewController {

        let modalVC = UIStoryboard(name: "Main", bundle: nil)

                        .instantiateViewController(identifier: "InputFruitViewController") as! InputFruitViewController
        modalVC.didSaveFruitsHandler = didSaveFruits
        modalVC.didCancelHandler = didCancel
        return modalVC
    }

    private var didSaveFruitsHandler: (String) -> Void = { _ in }
    private var didCancelHandler: () -> Void = {}

    @IBAction func cancelDidTapped(_ sender: UIBarButtonItem) {
        didCancelHandler()
    }
    @IBAction func saveCellDataDidTapped(_ sender: UIBarButtonItem) {
        let text = nameTextField.text ?? ""
        didSaveFruitsHandler(text)
    }

}
