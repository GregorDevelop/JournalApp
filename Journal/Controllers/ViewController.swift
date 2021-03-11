//
//  ViewController.swift
//  Journal
//
//  Created by Gregor Kramer on 11.03.2021.
//

import UIKit

class ViewController: UIViewController {

    var notesModel = NotesModel()
    var notes = [Note]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate and datasource for the table
        tableView.dataSource = self
        tableView.delegate = self
        
        notesModel.getNotes()
        
        // Set self as the delegate for the notes model
        notesModel.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let noteVC = segue.destination as! NoteViewController
        
        // If the user has selected a row, transition to note vc
        if tableView.indexPathForSelectedRow != nil {
           
            // Set the note of the note vc
            noteVC.selectedNote = notes[tableView.indexPathForSelectedRow!.row]
            
            // Deselect the selected row so that it doesn't interfere with new note creation
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
        
        noteVC.notesModel = notesModel
    }

    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        // Customize cell

        let titleLabel = cell.viewWithTag(1) as? UILabel
        titleLabel?.text = notes[indexPath.row].title
        
        let bodyLabel = cell.viewWithTag(2) as? UILabel
        bodyLabel?.text = notes[indexPath.row].body
        
        return cell
    }
        
}


extension ViewController: NotesModelProtocol {
    func notesRetrieved(notes: [Note]) {
        self.notes = notes
        tableView.reloadData()
    }
    
    
}
