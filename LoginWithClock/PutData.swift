//
//  DataSeeder.swift
//  LoginWithClock
//
//  Created by Amith on 22/01/25.
//

import Foundation
import CoreData
import UIKit

class PutData{
    static func PutUsers(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let count = try context.count(for: fetchRequest)
            if count == 0{
                let user = User(context: context)
                user.username = "admin"
                user.password = "123"
                let amith = User(context: context)
                amith.username="amith"
                amith.password="1234"
                
                
                try context.save()
                
            }
        }catch{
            print("Failed to save data in database.")
        }
    }
}


