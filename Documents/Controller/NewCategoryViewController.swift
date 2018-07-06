//
//  NewCategoryViewController.swift
//  Documents
//
//  Created by Dominic Pilla on 7/6/18.
//  Copyright © 2018 Dominic Pilla. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {

    @IBOutlet weak var categoryTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTitleTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        categoryTitleTextField.resignFirstResponder()
    }
    
    @IBAction func saveCategory(_ sender: Any) {
        guard let categoryTitle = categoryTitleTextField.text else {
            print("No category title set")
            return
        }
        
        let category = Category(title: categoryTitle)
        
        do {
            try category?.managedObjectContext?.save()
            
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Could not save category")
        }
    }
}
    
extension NewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
