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
    
    private var tasks = [Tasks]()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        
    }
    
    // MARK: - IBActions
    
    @IBAction private func addTaskAction(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Новая задача", message: "Введите текст", preferredStyle: .alert)
        
        ac.addTextField()
        
        let addTask = UIAlertAction(title: "Сохранить", style: .default) { action in
            let text = ac.textFields?.first
            
            if let newTask = text?.text {
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        
        ac.addAction(addTask)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true)
    }
    
    @IBAction private func removeTasksAction(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Private Methods
    
    private func saveTask() {
        
    }
    
    private func removeAllTasks() {
        
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
