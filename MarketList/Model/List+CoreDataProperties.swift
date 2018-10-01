//
//  List+CoreDataProperties.swift
//  MarketList
//
//  Created by Phan Nhat Dang on 9/30/18.
//  Copyright © 2018 Le Thi Hoa. All rights reserved.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var dateOfListSub: String?
    @NSManaged public var nameOfList: String?
    @NSManaged public var planingMoney: Double
    @NSManaged public var surplusMoney: Double
    @NSManaged public var usedMoney: Double

}
