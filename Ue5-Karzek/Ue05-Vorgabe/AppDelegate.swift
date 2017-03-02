//
//  AppDelegate.swift
//  Ue05-Vorgabe
//
//  Created by Klaus Jung on 03.12.16.
//  Copyright © 2016 Klaus Jung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var addressbook = AddressBook()
    var filename = String()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url =  urls.first
        if let path = url?.path{
            filename = (path as NSString).appendingPathComponent("book.archive")
        }
        
        addressbook = AddressBook.addressBook(fromFile: filename) ?? AddressBook()
        
        if (addressbook.list.count == 0){
            let card1 = AddressCard(firstname: "Peter",lastname: "Müller",street: "Feldweg",nr: 1,postcode: 10374,city: "Berlin")
            addressbook.add(card: card1)
            let card2 = AddressCard(firstname: "Hans",lastname: "Albrecht",street: "Marktstraße",nr: 23,postcode: 38495,city: "Osnabrück")
            addressbook.add(card: card2)
            addressbook.list[0].add(friend: addressbook.list[1])
            addressbook.list[0].add(hobby: "Tanzen")
            addressbook.list[0].add(hobby: "Malen")
            addressbook.list[0].add(hobby: "Spazieren gehen")
            addressbook.list[1].add(hobby: "Fußball spielen")
            addressbook.list[1].add(hobby: "Billard spielen")
            
            addressbook.sort()
            
            print("Daten eingetragen")
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        addressbook.save(toFile: filename)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        addressbook.save(toFile: filename)
    }

}

