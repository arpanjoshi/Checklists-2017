//
//  Checklist.swift
//  Checklists 2017
//
//  Created by RashuArpan on 7/10/17.
//  Copyright © 2017 Avin Technologies. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    
    
    
    var name=""
    var iconName : String
    
    var items = [CheckListItem]()
    
    
    convenience init(name: String) {
        self.init(name: name, iconName: "No Icon")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [CheckListItem]
        iconName = aDecoder.decodeObject(forKey: "IconName") as! String
        super.init()
    }
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(iconName, forKey: "IconName")
    }
    
    func countUncheckedItems() -> Int {
    
        var count = 0
        for item in items where !item.isChecked {
        
        
            count += 1
            
        }
        
        return count
    
    }
    
    

}
