//
//  SearchViewController.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 29/3/22.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTexField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ItemsViewModel()
    var resultItems: [Top20Element] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textFieldCell = UINib(nibName: "ItemTableViewCell", bundle: nil)
        viewModel.itemsList = resultItems
        tableView.reloadData()
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "itemCell")
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return resultItems.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        let item = resultItems[indexPath.row]
        cell.nameLabel.text = item.body.title
        cell.priceLabel.text = "\(item.body.price)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        print("que pasa aca")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

