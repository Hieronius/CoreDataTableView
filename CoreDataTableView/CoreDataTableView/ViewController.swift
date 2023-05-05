//
//  ViewController.swift
//  CoreDataTableView
//
//  Created by Арсентий Халимовский on 05.05.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private Properties
    
    var tasks = [Tasks]()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    
    @IBAction private func addTaskAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction private func removeTasksAction(_ sender: UIBarButtonItem) {
    }
    

}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].title
        
        return cell
    }
}
