//
//  Device+CoreDataProperties.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var content: String?

}

extension Device : Identifiable {

}
