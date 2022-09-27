//
//  DatabaseHelper.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/21/22.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    // create instance of DatabseHelper
    static var shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    

    //MARK: Save Data in Coredata function
    func save(object:[String:String]) {
        let customer = NSEntityDescription.insertNewObject(forEntityName: "Customer", into: context!) as! Customer
        
        // get a Array Data
        customer.name = object["name"]
        customer.email = object["email"]
        customer.mobile = object["mobile"]
        customer.password = object["password"]
        
        //save a data with try and catch exception Handling
        do{
            try context?.save()
        } catch{
            print("data in not save")
        }
    }
    
    //MARK: fetch data to coredata function
    func getCustomerData() -> [Customer] {
        var customer = [Customer]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Customer")   //fetch Request for Data
         
        //fetch data with try and catch exception Handling
        do{
            customer = try context?.fetch(fetchRequest) as! [Customer]
        }catch{
            print("can't get data")
        }
      return customer
    }
    
    //MARK: Delete Data From coredata function
    func deleteData(index:Int) -> [Customer] {
        var customer = getCustomerData()
        context?.delete(customer[index])
        customer.remove(at: index)
        do{
            try context?.save()
        } catch{
            print("can't  delete Data")
        }
        return customer
    }
}
