//
//  Memory+CoreDataProperties.swift
//  testingStoria 1.0
//
//  Created by Rahmannur Rizki Syahputra on 04/05/21.
//
//

import Foundation
import CoreData


extension Memory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memory> {
        return NSFetchRequest<Memory>(entityName: "Memory")
    }

    @NSManaged public var dateMemory: Date?
    @NSManaged public var detail: String?
    @NSManaged public var image: Data?
    @NSManaged public var location: String?
    @NSManaged public var oneWord: String?
    @NSManaged public var title: String?
    @NSManaged public var coordinateLat: Double
    @NSManaged public var coordinateLon: Double

}

extension Memory : Identifiable {

}
