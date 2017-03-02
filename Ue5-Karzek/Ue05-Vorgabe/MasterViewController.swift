//
//  MasterViewController.swift
//  Ue05-Vorgabe
//
//  Created by Klaus Jung on 03.12.16.
//  Copyright © 2016 Klaus Jung. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var addressBook = AddressBook()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        //get addressbook
        if let del = UIApplication.shared.delegate as? AppDelegate {
            addressBook = del.addressbook
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        //objects.insert(NSDate(), at: 0)
        let newCard = AddressCard(firstname: "<firstname>", lastname: "<lastname>", street: "<street>", nr: 0, postcode: 0, city: "<city>")
        addressBook.add(card: newCard)
        addressBook.sort()
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let currentAddressCard = addressBook.list[indexPath.row]
                let controller = segue.destination as! DetailTableViewController
                controller.addressCard = currentAddressCard
                controller.addressBook = addressBook
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressBook.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let addressCard = addressBook.list[indexPath.row] as AddressCard
        cell.textLabel?.text = "\(addressCard.lastname), \(addressCard.firstname)"
        cell.detailTextLabel?.text = "\(addressCard.postcode) \(addressCard.city), \(addressCard.street) \(addressCard.nr)"
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            addressBook.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

}

