//
//  DetailTableViewController.swift
//  Ue05-Vorgabe
//
//  Created by Marjana Karzek on 04/01/17.
//  Copyright © 2017 Klaus Jung. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var addressCard: AddressCard? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    var addressBook: AddressBook?
    
    func configureView() {
        // Update the user interface for the detail item.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.isEditing = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if (addressCard?.friends.count != 0 || addressCard?.hobbies.count != 0){
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch(section){
            case 0: return 4
            case 1: if(addressCard?.friends.count == 0){
                        return 2
                    }
                    else{
                        return (addressCard?.friends.count ?? 1)+1
                    }
            case 2: if(addressCard?.hobbies.count == 0){
                        return 2
                    }
                    else{
                        return (addressCard?.hobbies.count ?? 1)+1
                    }
            default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
            case 0: return "Details"
            case 1: return "Friends"
            case 2: return "Hobbies"
            default: return "Error"
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! EditableCell
        // Configure the cell...
        if let card = addressCard{
            cell.card = card
            if let book = addressBook{
                cell.book = book
            }
            cell.section = indexPath.section
            cell.row = indexPath.row
            cell.table = self
            switch(indexPath.section){
                case 0: switch(indexPath.row){
                    case 0: cell.editableText.text = card.firstname
                    case 1: cell.editableText.text = card.lastname
                    case 2: cell.editableText.text = "\(card.street) \(card.nr)"
                    case 3: cell.editableText.text = "\(card.postcode) \(card.city)"
                    default: break
                }
                case 1: switch(indexPath.row){
                    case (card.friends.count): cell.editableText.text = "<add friend by lastname>"
                    case (card.friends.count + 1): cell.editableText.text = "no friends added"
                    default: cell.editableText.text = "\(card.friends[indexPath.row].lastname), \(card.friends[indexPath.row].firstname)"
                }
                case 2: switch(indexPath.row){
                    case (card.hobbies.count ): cell.editableText.text = "<add hobby>"
                    case (card.hobbies.count + 1): cell.editableText.text = "no hobbies added"
                    default: cell.editableText.text = "\(card.hobbies[indexPath.row])"
                }
                default: break
            }
        }
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if let card = addressCard{
            switch (indexPath.section){
                case 0: return false
                case 1: if(indexPath.row != card.friends.count && indexPath.row != (card.friends.count + 1)){
                    return true
                        }else{
                        return false
                    }
                case 2: if(indexPath.row != card.hobbies.count && indexPath.row != (card.hobbies.count + 1)){
                    return true
                }else{
                    return false
                }
                default: return false
            }
        }
        else{
            return false
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let card = addressCard{
            if(indexPath.section == 1){
                if editingStyle == .delete{
                    // Delete the row from the data source
                    card.remove(friend: card.friends[indexPath.row])
                    if(card.friends.count != 0){
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                    else{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! EditableCell
                        cell.editableText.text = "no friends added"
                        self.tableView.reloadData()
                        self.navigationItem.rightBarButtonItem = .none
                    }
                } else if editingStyle == .insert {
                    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
                }
            }
            else if(indexPath.section == 2){
                if editingStyle == .delete{
                    // Delete the row from the data source
                    card.remove(hobby: card.hobbies[indexPath.row])
                    if(card.hobbies.count != 0){
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                    else{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! EditableCell
                        cell.editableText.text = "no hobbies added"
                        self.tableView.reloadData()
                        self.navigationItem.rightBarButtonItem = .none
                    }
                } else if editingStyle == .insert {
                    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
                }
            }
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if let card = addressCard{
            if(fromIndexPath.section == 1 && to.section == 1 && to.row != card.friends.count && to.row != (card.friends.count + 1)){
                let movedFriend = card.friends[fromIndexPath.row]
                card.friends.remove(at: fromIndexPath.row)
                card.friends.insert(movedFriend, at: to.row)
            }
            else if(fromIndexPath.section == 2 && to.section == 2 && to.row != card.hobbies.count && to.row != (card.hobbies.count + 1)){
                let movedHobby = card.hobbies[fromIndexPath.row]
                card.hobbies.remove(at: fromIndexPath.row)
                card.hobbies.insert(movedHobby, at: to.row)
            }
            self.tableView.reloadData()
        }
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
