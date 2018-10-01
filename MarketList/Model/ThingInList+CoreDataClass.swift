//
//  ThingInList+CoreDataClass.swift
//  MarketList
//
//  Created by Phan Nhat Dang on 9/30/18.
//  Copyright © 2018 Le Thi Hoa. All rights reserved.
//
//

import Foundation
import CoreData


public class ThingInList: NSManagedObject {
    static func createThingInList(persistenceManager:PersistenceManager,date:String,thingInListId:String,nameOfThing:String,thingAfterCountPrice:Double,thingInitialPrice:Double,thingIsComplete:Bool,thingNumberOfThing:Int,thingSalePrice:Double ){
        
        let thingInList = ThingInList(context: persistenceManager.context)
        
        thingInList.dateOfList = date
        thingInList.thingInListName = nameOfThing
        thingInList.thingInListID = thingInListId
        thingInList.thingAfterCountPrice = thingAfterCountPrice
        thingInList.thingInitialPrice = thingInitialPrice
        thingInList.thingIsComplete = thingIsComplete
        thingInList.thingNumberOfThing = Int16(thingNumberOfThing)
        thingInList.thingSalePrice = thingSalePrice
        
        persistenceManager.save()
        
        
    }
    
    static func createThingsInList(persistenceManager:PersistenceManager,thingsInList:[ThingInList] ) {
        
        for thingInList in thingsInList {
            let thingInListData = ThingInList(context: persistenceManager.context)
            thingInListData.dateOfList = thingInList.dateOfList
            thingInListData.thingInListName = thingInList.thingInListName
            thingInListData.thingInListID = thingInList.thingInListID
            thingInListData.thingAfterCountPrice = thingInList.thingAfterCountPrice
            thingInListData.thingInitialPrice = thingInList.thingInitialPrice
            thingInListData.thingIsComplete = thingInList.thingIsComplete
            thingInListData.thingNumberOfThing = Int16(thingInList.thingNumberOfThing)
            thingInListData.thingSalePrice = thingInList.thingSalePrice
            persistenceManager.save()
        }
    }
    
    
    
    static func getList(persistenceManager:PersistenceManager, filter: String)->[ThingInList] {
        let thingsInList = persistenceManager.fetch(ThingInList.self).filter {$0.dateOfList == filter}
        return thingsInList
        
    }
    
    static func updateList (persistenceManager:PersistenceManager, thingsInList: [ThingInList], numOfList: Int,nameOfThing:String,thingAfterCountPrice:Double,thingInitialPrice:Double,thingIsComplete:Bool,thingNumberOfThing:Int,thingSalePrice:Double ) {
        
        let thingInList = thingsInList[numOfList]
        
        thingInList.thingInListName = nameOfThing
        thingInList.thingAfterCountPrice = thingAfterCountPrice
        thingInList.thingInitialPrice = thingInitialPrice
        thingInList.thingIsComplete = thingIsComplete
        thingInList.thingNumberOfThing = Int16(thingNumberOfThing)
        thingInList.thingSalePrice = thingSalePrice
        
        persistenceManager.save()
    }
    
    static func deleteList(persistenceManager:PersistenceManager,thingsInList: [ThingInList],numOfList: Int) {
        let thingInList = thingsInList[numOfList]
        persistenceManager.delete(thingInList)
    }
    
}
