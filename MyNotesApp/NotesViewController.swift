//
//  NotesViewController.swift
//  MyNotesApp
//
//  Created by Barooah, Brandon N on 1/5/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notesTableView: UITableView!
    
    var notesList = [MyNotes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notesTableView.delegate = self
        notesTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNotes()
    }

    func loadNotes(){
        let fetchRequest : NSFetchRequest<MyNotes> = MyNotes.fetchRequest()
        do {
            notesList = try context.fetch(fetchRequest)
            notesTableView.reloadData()
        } catch {
            print("Can't load messages")
        }
    }
    
    @objc func deletePressed(_ sender:UIButton){
        context.delete(notesList[sender.tag])
        loadNotes()
    }
    
    @objc func editPressed(_ sender:UIButton){
        performSegue(withIdentifier: "addNotesSegue", sender: notesList[sender.tag])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNotesSegue" {
            if let editPage = segue.destination as? ViewController {
                if let note = sender as? MyNotes {
                    editPage.editNote = note
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 261
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! notesTableViewCell
        cell.setNotes(note: notesList[indexPath.row])
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deletePressed(_ :)), for: .touchUpInside)
        
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editPressed(_ :)), for: .touchUpInside)
        return cell
    }
    

}
