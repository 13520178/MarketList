//
//  ViewController.swift
//  MarketList
//
//  Created by Apple on 9/24/18.
//  Copyright © 2018 Le Thi Hoa. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var lists = [List]()
    var thingsInList = [ThingInList]()
    var persistenceManager = PersistenceManager()
    
    var exchangeListName = UITextField()
    var exchangeLTotalMoney = UITextField()
    
    
    var usedMoneyDouble = Double() {
        didSet {
            usedMoneyLabel.text = String(usedMoneyDouble)
            leftMoneyDouble = totalMoneyDouble - usedMoneyDouble
        }
    }
    var totalMoneyDouble = Double(){
        didSet {
            totalMoneyLabel.text = String(totalMoneyDouble)
            leftMoneyDouble = totalMoneyDouble - usedMoneyDouble
        }
    }
    
    var leftMoneyDouble = Double(){
        didSet {
            leftMoneyLabel.text = String(leftMoneyDouble)
        }
    }
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var qtyTextfield: UITextField!
    @IBOutlet weak var saleTextfield: UITextField!
    var thingInSaveCase = ThingInList()
    var isSave = false
    var numOfSavingItem = -1
    
    
    var listName = String()
    
    @IBOutlet weak var leftMoneyLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var usedMoneyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewThingTextfield: UITextField!
    @IBOutlet weak var listNameButton: UIButton!

    func showNumOfListVsThing() {
        print(lists.count)
        print(thingsInList.count)
    }
    
    override func viewDidLoad() {
        //Test case
       
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        lists = List.getList(persistenceManager: persistenceManager)
        if lists.count == 0,let buttonTitle = listNameButton.currentTitle {
            lists = List.createList(persistenceManager: persistenceManager, date: "0", nameOfList:buttonTitle, planingMoney: 0, usedMoney: 0)
        }else {
            listNameButton.setTitle(lists[0].nameOfList!, for: .normal)
        }
        
        thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
        
        usedMoneyDouble = lists[0].usedMoney
        
        totalMoneyDouble = lists[0].planingMoney
        
        leftMoneyDouble = lists[0].surplusMoney
        
        showNumOfListVsThing()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func changeListTitle(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Change title", message: "Enter the list title", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: exchangeListName)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.okHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
        
    }
    
    func exchangeListName(textField:UITextField!) {
        exchangeListName = textField
        exchangeListName.placeholder = "Ex. Birthday List"
        
    }
    
    func okHandler(alert: UIAlertAction!) {
        if let exchangeListName = exchangeListName.text {
            listNameButton.setTitle(exchangeListName, for: .normal)
            listName = exchangeListName
            lists = List.updateList(persistenceManager: persistenceManager, lists: lists, numOfList: 0, nameOfList: exchangeListName, planingMoney: 0, usedMoney: 0)
            print(lists[0].nameOfList!)
        }
        showNumOfListVsThing()
    }
    
    @IBAction func addNewThingButton(_ sender: UIButton) {
        if isSave == false , numOfSavingItem == -1 {
            if let newThingName = addNewThingTextfield.text, addNewThingTextfield.text?.replacingOccurrences(of: " ", with: "") != ""{
                thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
                let numOfThingString = String(thingsInList.count)
                
                ThingInList.createThingInList(persistenceManager: persistenceManager, date: "0", thingInListId: Helper.dateToString(date: Date()) + numOfThingString, nameOfThing: newThingName, thingAfterCountPrice: 0, thingInitialPrice: 0, thingIsComplete: false, thingNumberOfThing: 1, thingSalePrice: 0)
            }
            
            thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
            addNewThingTextfield.text = ""
            
            tableView.reloadData()
            
            for til in thingsInList {
                print(til.thingInListName!)
                print(til.thingInListID!)
                print(til.thingIsComplete)
                print(til.dateOfList!)
            }
        }else {
            let thing = thingsInList[numOfSavingItem]
            if let priceString = priceTextfield.text {
                let priceDouble:Double? = Double(priceString)
                
                if let priceDouble = priceDouble {
                    ThingInList.updateList(persistenceManager: persistenceManager, thingsInList: thingsInList, numOfList: numOfSavingItem, nameOfThing: thing.thingInListName!, thingAfterCountPrice: thing.thingAfterCountPrice, thingInitialPrice: priceDouble, thingIsComplete: thing.thingIsComplete, thingNumberOfThing: Int(thing.thingNumberOfThing), thingSalePrice: thing.thingSalePrice)
                    thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
                }
            }else {
                let priceDouble = 0
                ThingInList.updateList(persistenceManager: persistenceManager, thingsInList: thingsInList, numOfList: numOfSavingItem, nameOfThing: thing.thingInListName!, thingAfterCountPrice: thing.thingAfterCountPrice, thingInitialPrice: Double(priceDouble), thingIsComplete: thing.thingIsComplete, thingNumberOfThing: Int(thing.thingNumberOfThing), thingSalePrice: thing.thingSalePrice)
                thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
            }
            
            if let qtyString = qtyTextfield.text {
                let qtyInt:Int? = Int(qtyString)
                
                if let qtyInt = qtyInt {
                    ThingInList.updateList(persistenceManager: persistenceManager, thingsInList: thingsInList, numOfList: numOfSavingItem, nameOfThing: thing.thingInListName!, thingAfterCountPrice: thing.thingAfterCountPrice, thingInitialPrice: thing.thingInitialPrice, thingIsComplete: thing.thingIsComplete, thingNumberOfThing: Int(qtyInt), thingSalePrice: thing.thingSalePrice)
                    thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
                }
            }else {
                let qtyInt = 0
                ThingInList.updateList(persistenceManager: persistenceManager, thingsInList: thingsInList, numOfList: numOfSavingItem, nameOfThing: thing.thingInListName!, thingAfterCountPrice: thing.thingAfterCountPrice, thingInitialPrice: thing.thingInitialPrice, thingIsComplete: thing.thingIsComplete, thingNumberOfThing: Int(qtyInt), thingSalePrice: thing.thingSalePrice)
                thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
            }
            
            if let saleString = saleTextfield.text {
                let saleDouble:Double? = Double(saleString)
                
                if let saleDouble = saleDouble {
                    ThingInList.updateList(persistenceManager: persistenceManager, thingsInList: thingsInList, numOfList: numOfSavingItem, nameOfThing: thing.thingInListName!, thingAfterCountPrice: thing.thingAfterCountPrice, thingInitialPrice: thing.thingInitialPrice, thingIsComplete: thing.thingIsComplete, thingNumberOfThing: Int(thing.thingNumberOfThing), thingSalePrice: saleDouble)
                    thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
                }
            }else {
                let saleDouble = 0
                ThingInList.updateList(persistenceManager: persistenceManager, thingsInList: thingsInList, numOfList: numOfSavingItem, nameOfThing: thing.thingInListName!, thingAfterCountPrice: thing.thingAfterCountPrice, thingInitialPrice: thing.thingInitialPrice, thingIsComplete: thing.thingIsComplete, thingNumberOfThing: Int(thing.thingNumberOfThing), thingSalePrice: Double(saleDouble))
                thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
            }
            let finalThing = thingsInList[numOfSavingItem]
            finalThing.thingAfterCountPrice = finalThing.thingInitialPrice * Double(finalThing.thingNumberOfThing) * ((100-finalThing.thingSalePrice)/100)
            ThingInList.updateList(persistenceManager: persistenceManager, thingsInList: thingsInList, numOfList: numOfSavingItem, nameOfThing: finalThing.thingInListName!, thingAfterCountPrice: finalThing.thingAfterCountPrice, thingInitialPrice: finalThing.thingInitialPrice, thingIsComplete: finalThing.thingIsComplete, thingNumberOfThing: Int(finalThing.thingNumberOfThing), thingSalePrice: finalThing.thingSalePrice)
            thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
            
            usedMoneyDouble = 0
            for thingInList in thingsInList {
                usedMoneyDouble += thingInList.thingAfterCountPrice
            }
            lists = List.updateList(persistenceManager: persistenceManager, lists: lists, numOfList: 0, nameOfList: listNameButton.currentTitle!, planingMoney: lists[0].planingMoney, usedMoney: usedMoneyDouble)
            
            isSave = false
            numOfSavingItem = -1
            tableView.reloadData()
        }
    }
    
   
    @IBAction func addTotalMoney(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Adding money !", message: "You can put like that : 20 000 ", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: exchangeLTotalMoney)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.okTotalMoneyHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func exchangeLTotalMoney(textField:UITextField!) {
        exchangeLTotalMoney = textField
        exchangeLTotalMoney.placeholder = "Ex. 20 000"
        
    }
    
    func okTotalMoneyHandler(alert: UIAlertAction!) {
        if var exchangeTotalMoneyString = exchangeLTotalMoney.text {
            exchangeTotalMoneyString = exchangeTotalMoneyString.replacingOccurrences(of: " ", with: "")
            let exchangeTotalMoneyDouble:Double? = Double(exchangeTotalMoneyString)
            if let exchangeTotalMoneyDouble = exchangeTotalMoneyDouble {
                totalMoneyDouble = exchangeTotalMoneyDouble
                lists = List.updateList(persistenceManager: persistenceManager, lists: lists, numOfList: 0, nameOfList: listName, planingMoney: totalMoneyDouble, usedMoney: 0)
                
            }else {
                AlertController.showAlert(inController: self, tilte: "Something wrong", message: "You put the wrong type of total money")
            }
        }
    }
    

    @IBAction func reset(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Reset Cart", message: "Do you want to reset your cart ?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.okToResetHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func okToResetHandler(alert: UIAlertAction!) {
        lists = List.updateList(persistenceManager: persistenceManager, lists: lists, numOfList: 0, nameOfList: "List name (Touch to edit)", planingMoney: 0, usedMoney: 0)
        
        totalMoneyDouble = lists[0].planingMoney
        
        usedMoneyDouble = lists[0].usedMoney
    
        
        listNameButton.setTitle(lists[0].nameOfList, for: .normal)
        lists = List.getList(persistenceManager: persistenceManager)
        
        thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
        if thingsInList.count > 0 {
            for i in 0...(thingsInList.count - 1) {
                ThingInList.deleteList(persistenceManager: persistenceManager, thingsInList: thingsInList, numOfList: i)
            }
        }
        thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thingsInList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if thingsInList.count != 0 {
            let thingInList = thingsInList[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
            cell?.setThingInList(thingIL: thingInList)
            if thingsInList[indexPath.row].thingIsComplete {
                cell?.completedButton.setTitle("✓", for: .normal)
            }else {
                cell?.completedButton.setTitle("", for: .normal)
            }
            cell?.delegate = self
            return cell!
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
            usedMoneyDouble = usedMoneyDouble - thingsInList[indexPath.row].thingAfterCountPrice
            
            lists = List.updateList(persistenceManager: persistenceManager, lists: lists, numOfList: 0, nameOfList: lists[0].nameOfList!, planingMoney: lists[0].planingMoney, usedMoney: usedMoneyDouble)
            
            ThingInList.deleteList(persistenceManager: persistenceManager, thingsInList: thingsInList, numOfList: indexPath.row)
            thingsInList = ThingInList.getList(persistenceManager: persistenceManager, filter: "0")
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        thingInSaveCase = thingsInList[indexPath.row]
        priceTextfield.text = String(thingInSaveCase.thingInitialPrice)
        qtyTextfield.text = String(thingInSaveCase.thingNumberOfThing)
        saleTextfield.text = String(thingInSaveCase.thingSalePrice)
        numOfSavingItem = indexPath.row
        isSave = true
    }

}

extension CartViewController: ThingInListDelegate {
    
    func didTabInSwitch(didChange: Bool,  idChange: String) {
        for thingInList in thingsInList {
            if thingInList.thingInListID == idChange {
                thingInList.thingIsComplete = !thingInList.thingIsComplete
            }
        }
        persistenceManager.save()
        tableView.reloadData()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

