//
//  NoteViewController.swift
//  Journal
//
//  Created by Gregor Kramer on 11.03.2021.
//

import UIKit

class NoteViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var selectedNote: Note?
    var notesModel: NotesModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedNote != nil {
            titleTextField.text = selectedNote!.title
            bodyTextView.text = selectedNote!.body
        }
        else {
            
            let newNote = Note(docId: UUID().uuidString, title: titleTextField.text ?? "", body: bodyTextView.text, isStarred: false, createdAt: Date(), lastUpdateAt: Date())
            selectedNote =  newNote
        }
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        selectedNote = nil
        titleTextField.text = ""
        bodyTextView.text = ""
    }

    @IBAction func deleteTapped(_ sender: Any) {
        
        if selectedNote != nil {
            notesModel?.deleteNote(selectedNote!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        if selectedNote != nil {
            
            selectedNote?.title = titleTextField.text ?? ""
            selectedNote?.body = bodyTextView.text
            
            notesModel?.saveNote(selectedNote!)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
