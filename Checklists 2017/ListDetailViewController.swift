//
//  ListDetailViewController.swift
//  Checklists 2017
//
//  Created by RashuArpan on 7/10/17.
//  Copyright © 2017 Avin Technologies. All rights reserved.
//

import UIKit


protocol ListDetailViewControllerDelegate: class{


    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem checklist:Checklist)
    
    

}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDetailViewControllerDelegate?
    
    var checkListToEdit: Checklist?
    var iconName = "Folder"


    
    @IBAction func done(){
    
    
        if let checklist = checkListToEdit {
            
            checklist.name = textField.text!
        
            checklist.iconName = iconName
            delegate?.listDetailViewController(self, didFinishEditingItem: checklist)
            
        }
        
        else {
        
            let checklist = Checklist(name: textField.text!, iconName: iconName)
            checklist.iconName = iconName
            delegate?.listDetailViewController(self, didFinishAdding: checklist)
        
        
        }
    
    }
    
    @IBAction func cancel(){
    
        delegate?.listDetailViewControllerDidCancel(self)
    
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneBarButton.isEnabled = (newText.length > 0)
        return true
        
    }

    
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
   
        
        textField.becomeFirstResponder()
        
        
    }
    
    
    
    override func viewDidLoad() {
        if let checklist = checkListToEdit {
        
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
            iconName = checklist.iconName
            iconImageView.image = UIImage(named: iconName)
        
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickIcon" {
            let controller = segue.destination as! IconPickerViewController
            controller.delegate = self
        }
    }
    
    func iconPicker(_ picker: IconPickerViewController,
                    didPick iconName: String) {
        self.iconName = iconName
        iconImageView.image = UIImage(named: iconName)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    }

