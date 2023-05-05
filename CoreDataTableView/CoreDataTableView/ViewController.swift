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
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
                print(error.localizedDescription)
            }
    }
    
    // MARK: - IBActions
    
    @IBAction private func addTaskAction(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Новая задача", message: "Введите текст", preferredStyle: .alert)
        
        ac.addTextField()
        
        let addTask = UIAlertAction(title: "Сохранить", style: .default) { action in
            let text = ac.textFields?.first
            
            if let newTask = text?.text {
                self.saveTask(withTitle: newTask)
                 // self.tableView.reloadData()
                let indexPath = IndexPath(row: self.tasks.count - 1, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        let refreshAction = UIAlertAction(title: "Обновить", style: .default) { action in
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        ac.addAction(addTask)
        ac.addAction(cancelAction)
        ac.addAction(refreshAction)
        
        self.present(ac, animated: true)
    }
    
    @IBAction private func removeTasksAction(_ sender: UIBarButtonItem) {
        removeAllTasks()
    }
    
    // MARK: - Private Methods
    
    private func saveTask(withTitle title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else { return }
        
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            tasks.append(taskObject)
//            let indexPath = IndexPath(row: self.tasks.count - 1, section: 0)
//            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func removeAllTasks() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        if let tasks = try? context.fetch(fetchRequest) {
            for task in tasks {
                context.delete(task)
                
                if let index = self.tasks.firstIndex(of: task) {
                    self.tasks.remove(at: index)
                }
            }
        }
        do {
            try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        self.tableView.reloadData()
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
        print(indexPath.row)
        
        return cell
    }
}
