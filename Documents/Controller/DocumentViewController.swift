//
//  DocumentViewController.swift
//  Documents
//
//  Created by Dominic Pilla on 6/14/18.
//  Copyright © 2018 Dominic Pilla. All rights reserved.
//

import UIKit
import CoreData

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var documentTitle: UITextField!
    @IBOutlet weak var documentContents: UITextView!
    
    var exisitingDocument: Document?
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentTitle.text = exisitingDocument?.title
        documentContents.text = exisitingDocument?.contents
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        // Check if the textboxes are empty.  If so, do not save the document
        if let title = documentTitle.text, let contents = documentContents.text, !title.isEmpty, !contents.isEmpty {
            let size = Double(contents.count) // Size calculated on amount of characters in contents
            let currentDate = Date() // Date for last modified
            
            var document: Document?
            
            if let existingDocument = exisitingDocument {
                exisitingDocument?.title = title
                exisitingDocument?.contents = contents
                existingDocument.lastModified = currentDate
                existingDocument.size = size
                
                document = exisitingDocument
            } else {
                if let document = Document(title: title, contents: contents, lastModified: currentDate, size: size) {
                    category?.addToRawDocuments(document)
                    
                    do {
                        try document.managedObjectContext?.save()
                        
                        self.navigationController?.popViewController(animated: true)
                    } catch {
                        print("Document could not be created")
                    }
                }
            }
            
            if let document = document {
                category?.replaceRawDocuments(at: 0, with: document)
                do {
                    try document.managedObjectContext?.save()
                    
                    self.navigationController?.popViewController(animated: true)
                } catch {
                    print("Document could not be saved.")
                }
            }
        }
    }
    
    @IBAction func textFieldEdited(_ sender: Any) {
        self.title = documentTitle.text
    }
}
