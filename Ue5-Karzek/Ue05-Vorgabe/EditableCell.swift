//
//  EditableCell.swift
//  Ue05-Vorgabe
//
//  Created by Marjana Karzek on 11/01/17.
//  Copyright © 2017 Klaus Jung. All rights reserved.
//

import UIKit

class EditableCell: UITableViewCell {

    @IBOutlet weak var editableText: UITextField!
    
    var card = AddressCard()
    var book = AddressBook()
    var row = 0
    var section = 0
    var table = UITableViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editingDidEnd(_ sender: Any) {
        if let text = editableText.text{
            switch(section){
            case 0: switch(row){
                case 0: card.firstname = text
                case 1: card.lastname = text
                case 2: let values = text.components(separatedBy: " ")
                        card.street = values.first ?? card.street
                        card.nr = Int(values.last ?? "") ?? card.nr
                        table.tableView.reloadData()
                case 3: let values = text.components(separatedBy: " ")
                        card.postcode = Int(values.first ?? "") ?? card.postcode
                        card.city = values.last ?? card.city
                        table.tableView.reloadData()
                default: break
            }
            case 1: switch(row){
                case (card.friends.count): let index = book.search(lastname: text)
                    if(index != -1){
                        card.add(friend: book.list[index])
                    }
                    table.tableView.reloadData()
                case (card.friends.count + 1): editableText.text = "no friends added"
                default: let index = book.search(lastname: text)
                    if(index != -1){
                        card.friends[row] = book.list[index]
                    }
                    table.tableView.reloadData()
                }
            case 2: switch(row){
                case (card.hobbies.count): if(text != "<add hobby>" && text != ""){
                    card.add(hobby: text)
                    }
                    table.tableView.reloadData()
                case (card.hobbies.count + 1): editableText.text = "no hobbies added"
                default: if(text != "<add hobby>" && text != ""){
                        card.hobbies[row] = text
                    }
                    table.tableView.reloadData()
            }
            default: break
            }
        }
    }
}
