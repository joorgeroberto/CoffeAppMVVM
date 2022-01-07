//
//  OrdersTableViewController.swift
//  CoffeAppMVVM
//
//  Created by Jorge de Carvalho on 30/12/21.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    private func populateOrders() {
        Webservice().load(resource: Order.all) {[weak self] result in
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
              let addCoffeeOrderViewController = navigationController.viewControllers.first as? AddOrderViewController else {
                  fatalError("Error performing segue!")
              }
        
        addCoffeeOrderViewController.delegate = self
    }
}

extension OrdersTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.orderListViewModel.orderViewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.type
        cell.detailTextLabel?.text = viewModel.size

        return cell
    }
}

extension OrdersTableViewController {
    // Delegate functions of AddCoffeeOrderDelegate protocol
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController!) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController!) {
        let orderViewModel = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderViewModel)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
        
        controller.dismiss(animated: true, completion: nil)
    }
}
