//
//  List+CoreDataClass.swift
//  MarketList
//
//  Created by Phan Nhat Dang on 9/30/18.
//  Copyright © 2018 Le Thi Hoa. All rights reserved.
//
//

import Foundation
import CoreData


public class List: NSManagedObject {
    static func createList(persistenceManager:PersistenceManager,date:String,nameOfList:String,planingMoney: Double,usedMoney:Double) -> [List]{
        
        let list = List(context: persistenceManager.context)
        
        list.dateOfListSub = date
        list.nameOfList = nameOfList
        list.planingMoney = planingMoney
        list.usedMoney = usedMoney
        list.surplusMoney = list.planingMoney - list.usedMoney
        
        persistenceManager.save()
        
        let lists = persistenceManager.fetch(List.self)
        return lists
    }
    
    static func getList(persistenceManager:PersistenceManager)->[List] {
        let lists = persistenceManager.fetch(List.self)
        return lists
        
    }
    
    static func updateList (persistenceManager:PersistenceManager, lists: [List], numOfList: Int,nameOfList:String,planingMoney: Double,usedMoney:Double) -> [List] {
        let list = lists[numOfList]
        list.nameOfList = nameOfList
        list.planingMoney = planingMoney
        list.usedMoney = usedMoney
        list.surplusMoney = list.planingMoney - list.usedMoney
        
        persistenceManager.save()
        
        let lists = persistenceManager.fetch(List.self)
        return lists
    }
    
    static func deleteList(persistenceManager:PersistenceManager,lists: [List],numOfList: Int)->[List] {
        let list = lists[numOfList]
        persistenceManager.delete(list)
        
        let lists = persistenceManager.fetch(List.self)
        return lists
    }

}
