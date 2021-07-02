//
//  ViewController.swift
//  subject_MVC15
//
//  Created by 長谷川孝太 on 2021/07/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var fruitsArray: [Fruit] = []
    private static let initialFruitsArray = [
        Fruit(isChecked: false, name: "りんご"),
        Fruit(isChecked: true, name: "みかん"),
        Fruit(isChecked: false, name: "バナナ"),
        Fruit(isChecked: true, name: "パイナップル")
    ]
    private let fruitsArrayRepository = FruitsArrayRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FruitTableViewCell.nib(), forCellReuseIdentifier: FruitTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        /// UserDefaultsを停止
//        fruitsArray = self.fruitsArrayRepository.load() ?? Self.initialFruitsArray
        fruitsArray = Self.initialFruitsArray
    }

    @IBAction func addCellDidTapped(_ sender: UIBarButtonItem) {
        let inputFruitViewController = InputFruitViewController.instantiate(
            didSaveFruits: { [weak self] text in
                /// guard let 文でself?を書かないで済むようにアンラップ
                guard let strongSelf = self else { return }
                let newFruit = Fruit(isChecked: false, name: text)
                strongSelf.fruitsArray.append(newFruit)
                /// UserDefaultsを停止
//                _ = strongSelf.fruitsArrayRepository.save(newFruitsArray: strongSelf.fruitsArray)
                strongSelf.tableView.reloadData()
                strongSelf.dismiss(animated: true, completion: nil)

            },
            didCancel: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
        )
        let navigationController = UINavigationController(
            rootViewController: inputFruitViewController
        )
        present(navigationController, animated: true)
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fruitsArray[indexPath.row].isChecked.toggle()
        // 【課題】今知っているやりたいことのパターンは
        // ①fruitCellのconfigureメソッドを呼びたい ←今回はここをやってみた
        // ②クロージャで渡してやる
        // ③自作delegateを使う
        // 【課題】もっとゆっくりチェックマークとつけたりはずす、アニメーションがほしい
        let cell = tableView.cellForRow(at: indexPath) as! FruitTableViewCell
        cell.configure(fruit: fruitsArray[indexPath.row])
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fruitsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(
                            // swiftlint:disable:next force_cast
                            withIdentifier: FruitTableViewCell.identifier, for: indexPath) as! FruitTableViewCell
        customCell.configure(fruit: fruitsArray[indexPath.row])
        return customCell
    }
}
