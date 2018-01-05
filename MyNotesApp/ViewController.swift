//
//  ViewController.swift
//  MyNotesApp
//
//  Created by Barooah, Brandon N on 1/5/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    
    var editNote : MyNotes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        descTextView.delegate = self
        titleTextField.delegate = self
        
        if let note = editNote {
            self.titleTextField.text = note.title
            self.descTextView.text = note.details
        }
    }
    

  
    
    @IBAction func savePressed(_ sender: Any) {
        var newNote:MyNotes
        if let note = editNote {
            newNote = note
        } else {
            newNote = MyNotes(context: context)
        }
        newNote.title = titleTextField.text
        newNote.details = descTextView.text
        newNote.date_saved = NSDate() as Date
        
        do {
            ad.saveContext()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Error saving note")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descTextView.becomeFirstResponder()
        return false
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

