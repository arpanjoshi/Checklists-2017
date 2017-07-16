//
//  Checklistitem.swift
//  Checklists 2017
//
//  Created by RashuArpan on 7/6/17.
//  Copyright © 2017 Avin Technologies. All rights reserved.
//

import Foundation
import UserNotifications


class CheckListItem:NSObject, NSCoding {


    var text = ""
    var isChecked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(isChecked, forKey: "Checked")
        aCoder.encode(dueDate, forKey: "DueDate")
        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
        aCoder.encode(itemID, forKey: "ItemID")

    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        isChecked = aDecoder.decodeBool(forKey: "Checked")
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        itemID = aDecoder.decodeInteger(forKey: "ItemID")
        
        super.init()
    }
    


    override init() {
        
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    func toggleChecked() {
    
        isChecked = !isChecked
    
    }
    
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            // 1
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default()
            // 2
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(
                [.month, .day, .hour, .minute], from: dueDate)
            // 3
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components, repeats: false)
            // 4
            let request = UNNotificationRequest(
                identifier: "\(itemID)", content: content, trigger: trigger)
            // 5
            let center = UNUserNotificationCenter.current()
            center.add(request)
            print("Scheduled notification \(request) for itemID \(itemID)")
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(
            withIdentifiers: ["\(itemID)"])
    }
    
    deinit {
        removeNotification()
    }
}
