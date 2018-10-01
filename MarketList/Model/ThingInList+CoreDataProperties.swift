//
//  ThingInList+CoreDataProperties.swift
//  MarketList
//
//  Created by Phan Nhat Dang on 9/30/18.
//  Copyright © 2018 Le Thi Hoa. All rights reserved.
//
//

import Foundation
import CoreData


extension ThingInList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThingInList> {
        return NSFetchRequest<ThingInList>(entityName: "ThingInList")
    }

    @NSManaged public var dateOfList: String?
    @NSManaged public var thingAfterCountPrice: Double
    @NSManaged public var thingInitialPrice: Double
    @NSManaged public var thingInListID: String?
    @NSManaged public var thingInListName: String?
    @NSManaged public var thingIsComplete: Bool
    @NSManaged public var thingNumberOfThing: Int16
    @NSManaged public var thingSalePrice: Double

}
