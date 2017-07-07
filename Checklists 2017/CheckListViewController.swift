//
//  ViewController.swift
//  Checklists 2017
//
//  Created by RashuArpan on 7/5/17.
//  Copyright © 2017 Avin Technologies. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    
    }
    
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Checklistitem", for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        
        
        
        if indexPath.row==0 {
        
            label.text = "1st Row"
        }
        
        else if indexPath.row==1 {
            
            label.text = "2nd Row"
        }
        
        else if indexPath.row==2 {
            
            label.text = "3rd Row"
        }
        
        else if indexPath.row==4 {
            
            label.text = "4th Row"
        }
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
        
            if cell.accessoryType == .none{
            
                cell.accessoryType = .checkmark
                
                
            }
            else if cell.accessoryType == .checkmark{
            
                cell.accessoryType = .none
            
            }

        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

}

