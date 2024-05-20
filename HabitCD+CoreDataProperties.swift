//
//  HabitCD+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Weda on 2024-05-19.
//
//

import Foundation
import CoreData


extension HabitCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitCD> {
        return NSFetchRequest<HabitCD>(entityName: "HabitCD")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var plannedDays: NSObject?
    @NSManaged public var completedDays: NSObject?
    @NSManaged public var currentStreak: Int16

}

extension HabitCD : Identifiable {

}
