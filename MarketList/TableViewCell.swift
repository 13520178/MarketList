//
//  TableViewCell.swift
//  MarketListModelDatabase
//
//  Created by Phan Nhat Dang on 9/24/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import UIKit

protocol ThingInListDelegate {
    func didTabInSwitch(didChange: Bool, idChange: String)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfThingLabel: UILabel!
    @IBOutlet weak var initalMoneyLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    

    
    var thingInList = ThingInList()    
    var delegate: ThingInListDelegate?
    
    func setThingInList(thingIL:ThingInList) {
        thingInList = thingIL
        nameOfThingLabel.text = thingIL.thingInListName
        initalMoneyLabel.text = String(thingIL.thingInitialPrice)
        qtyLabel.text = "x\(thingIL.thingNumberOfThing)"
        saleLabel.text = String(thingIL.thingSalePrice)
        totalLabel.text = String(thingIL.thingAfterCountPrice)
    }
    @IBAction func didSwitch(_ sender: UIButton) {
        delegate?.didTabInSwitch(didChange: thingInList.thingIsComplete, idChange: thingInList.thingInListID!)
        if sender.currentTitle == "" {
            sender.setTitle("✓", for: .normal)
        }else {
            sender.setTitle("", for: .normal)
        }
    }
}
