//
//  AdressCard.swift
//  Ue3-Karzek
//
//  Created by Marjana Karzek on 23/11/16.
//  Copyright © 2016 Marjana Karzek. All rights reserved.
//

import Foundation

class AddressCard: NSObject, NSCoding {
    var firstname = ""
    var lastname = ""
    var street = ""
    var nr = 0
    var postcode = 0
    var city = ""
    var hobbies = [String]()
    var friends = [AddressCard]()
    
    override init(){
        super.init()
    }
    
    /*init(lastname: String){
        self.lastname = lastname
    }*/
    
    init(firstname: String, lastname: String, street: String, nr: Int, postcode: Int, city: String){
        self.firstname = firstname
        self.lastname = lastname
        self.street = street
        self.nr = nr
        self.postcode = postcode
        self.city = city
    }
    
    func add(hobby: String){
        hobbies.append(hobby)
    }
    
    func add(friend: AddressCard){
        friends.append(friend)
    }
    
    func remove(hobby: String){
        if let index = hobbies.index(of: hobby){
            hobbies.remove(at: index)
        }
    }
    
    func remove(friend: AddressCard){
        if let index = friends.index(of: friend){
            friends.remove(at: index)
        }
    }
    
    required init?(coder:NSCoder){
        super.init()
        if let cFirstname = coder.decodeObject(forKey: "firstname") as? String { firstname = cFirstname }
        if let cLastname = coder.decodeObject(forKey: "lastname") as? String { lastname = cLastname }
        if let cStreet = coder.decodeObject(forKey: "street") as? String { street = cStreet }
        nr = coder.decodeInteger(forKey: "nr") as NSInteger
        postcode = coder.decodeInteger(forKey: "postcode") as NSInteger
        if let cCity = coder.decodeObject(forKey: "city") as? String { city = cCity}
        if let cHobbies = coder.decodeObject(forKey: "hobbies") as? [String] { hobbies = cHobbies }
        if let cFriends = coder.decodeObject(forKey: "friends") as? [AddressCard] { friends = cFriends }
    }
    
    func encode(with coder: NSCoder){
        coder.encode(firstname, forKey: "firstname")
        coder.encode(lastname, forKey: "lastname")
        coder.encode(street, forKey: "street")
        coder.encode(nr, forKey: "nr")
        coder.encode(postcode, forKey: "postcode")
        coder.encode(city, forKey: "city")
        coder.encode(hobbies, forKey: "hobbies")
        coder.encode(friends, forKey: "friends")
    }
    
    //Eine der Klassen erbt von Equatable --> nicht nochmal einbinden
    static func == (left: AddressCard, right: AddressCard) -> Bool {
        return left.lastname == right.lastname
    }
}
