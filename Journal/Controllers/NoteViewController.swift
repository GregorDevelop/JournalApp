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
    
    @IBOutlet weak var starButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedNote != nil {
            
            // User is viewing an existing note, so populate the fields
            titleTextField.text = selectedNote!.title
            bodyTextView.text = selectedNote!.body
            
            // Set the status of the star button
            setStarState()
        }
        else {
            // Note property is nil, so create a new note
            
            // Create the note
            let newNote = Note(docId: UUID().uuidString, title: titleTextField.text ?? "", body: bodyTextView.text, isStarred: false, createdAt: Date(), lastUpdateAt: Date())
            selectedNote =  newNote
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        // Clear the fields
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
        
        // This is an update to the existing note
        selectedNote?.title = titleTextField.text ?? ""
        selectedNote?.body = bodyTextView.text
        
        // Send it to the notes model
        notesModel?.saveNote(selectedNote!)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func setStarState() {
        let imageName = selectedNote!.isStarred ? "star.fill" : "star"
        starButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func starButtonTapped(_ sender: Any) {
        
        // Change the property in the note
        selectedNote?.isStarred.toggle()
        
        // Update the database
        notesModel?.updateFaveState(selectedNote!)
        
        // Update the button
        setStarState()
    }
    
    
}
