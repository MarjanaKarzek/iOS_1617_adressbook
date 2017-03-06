//
//  AdressBook.swift
//  Ue3-Karzek
//
//  Created by Marjana Karzek on 23/11/16.
//  Copyright © 2016 Marjana Karzek. All rights reserved.
//

import Foundation

class AddressBook: NSObject, NSCoding{
    var list = [AddressCard]()
    
    override init(){
        super.init()
    }
    
    func add(card: AddressCard){
        list.append(card)
    }
    
    func remove(card: AddressCard){
        if let index = list.index(of: card){
            //delete all friends
            for element in list {
                if (element.friends.index(of: card) != nil){
                    element.remove(friend: card)
                }
            }
            //delete from AddressBook
            list.remove(at: index)
        }
    }
    
    func sort(){
        list.sort{$0.lastname < $1.lastname}
    }
    
    func search(lastname: String) -> Int{
        var index = -1
        for card in list {
            if(card.lastname == lastname){
                index = list.index(of: card) ?? -1
                break
            }
        }
        return index
    }
    
    required init?(coder:NSCoder){
        super.init()
        if let cList = coder.decodeObject(forKey: "list") as? [AddressCard] { list = cList }
    }
    
    func encode(with coder: NSCoder){
        coder.encode(list, forKey: "list")
    }
    
    func save(toFile path: String){
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
    }
    
    class func addressBook(fromFile path: String) -> AddressBook?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as? AddressBook
    }
}
