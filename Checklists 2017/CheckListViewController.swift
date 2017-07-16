//
//  ViewController.swift
//  Checklists 2017
//
//  Created by RashuArpan on 7/5/17.
//  Copyright © 2017 Avin Technologies. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, AddItemViewControllerDelegate {
    
    

        var checklist:Checklist!
    
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        checklist.items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return checklist.items.count
    
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Checklistitem", for: indexPath)
        
        let item = checklist.items[indexPath.row]
        
        configureTextForCell(for: cell, with: item)
        configureCheckmarkForCell(for: cell, with: item)
        
        
        
        return cell
    }
    
    
    func configureTextForCell (for cell: UITableViewCell, with item: CheckListItem){
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = item.text
        
    }
    
    func configureCheckmarkForCell(for cell:UITableViewCell, with item:CheckListItem){
        
        
    
            let label = cell.viewWithTag(1001) as! UILabel
            
        if item.isChecked {
            
            label.text = "✅"
        }
        
        else {
        
        label.text = ""
        }
        


    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
        let item = checklist.items[indexPath.row]
            
            item.toggleChecked()
            
            configureCheckmarkForCell(for: cell, with: item)
        
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem) {
        
        let rowIndex = checklist.items.count
        
        checklist.items.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)

        dismiss(animated: true, completion: nil)
        
    }
    
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: CheckListItem) {
        
        if let index = checklist.items.index(of: item){
        
            let indexPath = IndexPath(row: index, section: 0)
            
            if let cell = tableView.cellForRow(at: indexPath){
            
                configureTextForCell(for: cell, with: item)
            
            
            }
        
        dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
        
        
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! AddItemViewController
            
            controller.delegate = self
        
        }
        
        
        else if segue.identifier == "EditItem"{
        
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            
            {
            
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        
        }
        
    }
    
    }



