//
//  ViewController.swift
//  Journal
//
//  Created by Gregor Kramer on 11.03.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }


    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        // Customize cell

        let titleLabel = cell.viewWithTag(1) as? UILabel
        
        let bodyLabel = cell.viewWithTag(2) as? UILabel
        
        return cell
    }
    
    
}
