//
//  SaveMethods.swift
//  Checklists 2017
//
//  Created by RashuArpan on 7/11/17.
//  Copyright © 2017 Avin Technologies. All rights reserved.
//



import Foundation



func getDocumentsDirectory() -> URL{
    
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    return paths[0]
    
}

func dataFilePath() -> URL{
    
    return getDocumentsDirectory().appendingPathComponent("CheckLists.plist")
    
}

func saveChecklistItems() {
    
    
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: data)
    
  //  archiver.encode(checklist.items, forKey: "ChecklistItems")
    
    archiver.finishEncoding()
    
    data.write(to: dataFilePath(), atomically: true)
    
}
func loadChecklistItems() {
    
    let path = dataFilePath()
    // 2
    if let data = try? Data(contentsOf: path) {
        // 3
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
   //     checklist.items = unarchiver.decodeObject(forKey: "ChecklistItems")
            as! [CheckListItem]
     //   unarchiver.finishDecoding()
    }
    
    
    
    
}


