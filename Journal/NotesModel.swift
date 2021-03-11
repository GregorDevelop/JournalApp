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
    
    var delegate: NotesModelProtocol?
    
    func getNotes() {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Get all the notes
        db.collection("notes").getDocuments { (snapshot, error) in
            
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
    
}
