//
//  NotesModel.swift
//  Journal
//
//  Created by Gregor Kramer on 11.03.2021.
//

import Foundation
import Firebase

protocol NotesModelProtocol {
    func notesRetrieved(notes: [Note])
}

class NotesModel {
    
    var listener: ListenerRegistration?
    
    deinit {
        
        // Unregister database listener
        listener?.remove()
    }
    
    var delegate: NotesModelProtocol?
    
    func getNotes() {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Get all the notes
        listener = db.collection("notes").order(by: "lastUpdateAt").addSnapshotListener { (snapshot, error) in
            
            if error == nil && snapshot != nil {
                
                var  notes = [Note]()
                
                // Parse documents into notes
                for doc in snapshot!.documents {
                    
                    let createdAtDate = Timestamp.dateValue(doc["createdAt"] as! Timestamp)()
                    
                    let lastUpdateAtDate = Timestamp.dateValue(doc["lastUpdateAt"] as! Timestamp)()
                    
                    let n = Note(docId: doc["docId"] as! String, title: doc["title"] as! String, body: doc["body"] as! String, isStarred: doc["isStarred"] as! Bool, createdAt: createdAtDate, lastUpdateAt: lastUpdateAtDate)
                    
                    notes.append(n)
                }
                
                // Call the delegate and pass back the notes in the main thread
                DispatchQueue.main.async {
                    self.delegate?.notesRetrieved(notes: notes)
                }
            }
        }
        
    }
    
    func deleteNote(_ selectedNote: Note) {
        let db = Firestore.firestore()
        
        db.collection("notes").document(selectedNote.docId).delete()
    }
    
    
    func saveNote(_ selectedNote: Note) {
        
        let db = Firestore.firestore()
        
        db.collection("notes").document(selectedNote.docId).setData(noteToDict(selectedNote))
    }
    
    func noteToDict(_ selectedNote: Note) -> [String: Any] {
        
        var dict = [String: Any]()
        
        dict["docId"] = selectedNote.docId
        dict["title"] = selectedNote.title
        dict["body"] = selectedNote.body
        dict["isStarred"] = selectedNote.isStarred
        dict["createdAt"] = selectedNote.createdAt
        dict["lastUpdateAt"] = selectedNote.lastUpdateAt
        
        return dict
    }
    
}
