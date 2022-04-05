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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        let textFieldCell = UINib(nibName: "ItemTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "itemCell")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
    }
    func bind() {
        viewModel.refreshData = { [weak self] in ()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return viewModel.itemsList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        let item = viewModel.itemsList[indexPath.row]
        cell.nameLabel.text = item.body.title
        cell.priceLabel.text = "$ \(item.body.price)"
        let url = URL(string: item.body.pictures[0].secureURL)!
        if let data = try? Data(contentsOf: url) {
            cell.img.image = UIImage(data: data)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        let item = viewModel.itemsList[indexPath.row]
        vc.titleText = item.body.title
        let url = URL(string: item.body.pictures[0].secureURL)!
        if let data = try? Data(contentsOf: url) {
            vc.img.image = UIImage(data: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.getSearchText(searchText: searchTexField.text ?? "")
        return true
    }
}

