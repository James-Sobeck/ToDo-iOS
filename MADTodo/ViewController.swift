//
//  ViewController.swift
//  MADTodo
//
//  Created by James Sobeck on 4/21/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var items: [String] = []
    let cellReuseIdentifier = "cell"
    let defaults = UserDefaults(suiteName: "com.MADTodo")
    var myarry: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = defaults?.value(forKey: "array") as? [String] else {
            tableView.delegate = self
            tableView.dataSource = self
            return
        }
        items.append(contentsOf: data)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as! TodoCell
        cell.cellText.text = items[indexPath.row].description
        //user defaults
        defaults!.setValue(items[indexPath.row].description, forKey: "items")
        let myarray = defaults!.stringArray(forKey: "SavedStringArray") ?? [String]()
        myarry.append(contentsOf: myarray)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let finish = UIContextualAction(style: .normal, title: "Complete!") {_,_,_ in
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
                    }
        let swipeAction = UISwipeActionsConfiguration(actions: [finish])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pos = indexPath.row
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let alert = sb.instantiateViewController(identifier: "EditItemViewController") as! EditItemViewController
        alert.parentVC = self
        alert.item = self.items[pos]
        alert.pos = pos
        alert.modalPresentationStyle = .overCurrentContext
        self.present(alert, animated: true, completion: nil)
           
    }
    
    
    @IBAction func saveItem(_ sender: Any) {
        items.append(contentsOf: myarry)
        defaults?.setValue(items, forKey: "array")
        print("Saved")
    }
    
    @IBAction func newItem(_ sender: Any) {
        items.append("New Item")
        tableView.reloadData()
    }
}
