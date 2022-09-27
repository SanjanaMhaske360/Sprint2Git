//
//  Customer+CoreDataProperties.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/21/22.
//
//

import Foundation
import CoreData


extension Customer {

    // create NSFetchRequest for Entity Customer
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    //declaration of Attributes of Entity Customer as NSManaged
    @NSManaged public var password: String?
    @NSManaged public var mobile: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?

}

extension Customer : Identifiable {

}
