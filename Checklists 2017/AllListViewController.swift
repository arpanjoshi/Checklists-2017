//
//  AllListViewController.swift
//  Checklists 2017
//
//  Created by RashuArpan on 7/10/17.
//  Copyright © 2017 Avin Technologies. All rights reserved.
//

import Foundation
import UIKit


class AllListViewController:UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate{
    
    
    //Instance Variables
    
    var dataModel:DataModel!
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataModel.checklists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = makeCell(for: tableView)
        cell.textLabel!.text = "List \(indexPath.row)"
        
        let checklist = dataModel.checklists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        let count = checklist.countUncheckedItems()
        if count == 0 {
        
            cell.detailTextLabel!.text = "All Done"
            
        
        }
        
        else {
        
        
            cell.detailTextLabel!.text = "\(checklist.countUncheckedItems()) Remaining"
        
        }
        cell.imageView!.image = UIImage(named: checklist.iconName)
        return cell
    
    }
    
    func makeCell(for tableView: UITableView) -> UITableViewCell {
    
        let cellidentifier = "Cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier) {
        
            return cell
        
        
        }
            
            else {
            
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellidentifier)
                
                
        }
            }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // add this line:
        dataModel.indexOfSelectedChecklist = indexPath.row
        let checklist = dataModel.checklists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist"{
        
                        let controller = segue.destination as! CheckListViewController
                        controller.checklist = sender as! Checklist
            
        }
        
        else if segue.identifier == "Addchecklist" {
        
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            
            controller.delegate  = self
            controller.checkListToEdit = nil
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem checklist: Checklist) {
        
        if let index = dataModel.checklists.index(of: checklist){
        
        
            let indexPath = IndexPath(row: index, section:0)
            
            if let cell = tableView.cellForRow(at: indexPath){
            
            
                cell.textLabel!.text = checklist.name
            
            }
            dismiss(animated: true, completion: nil)
        
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.checklists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        dataModel.checklists.append(checklist)
        dataModel.sortChecklists()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    

    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
    dataModel.sortChecklists()
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
    
    }


    override func tableView(_ tableView: UITableView,
                            accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let navigationController = storyboard!.instantiateViewController(
            withIdentifier: "ListDetailNavigationController")
            as! UINavigationController
        let controller = navigationController.topViewController
            as! ListDetailViewController
        controller.delegate = self
        let checklist = dataModel.checklists[indexPath.row]
        controller.checkListToEdit = checklist
        present(navigationController, animated: true, completion: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.checklists.count {
            let checklist = dataModel.checklists[index]
            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    



        }

    
