//
//  EditItemViewController.swift
//  MADTodo
//
//  Created by Jeffrey Hutto on 4/21/21.
//

import UIKit

class EditItemViewController: UIViewController {

    @IBOutlet weak var txt: UITextField!
    var parentVC: ViewController?
    var item: String?
    var pos: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt.text = parentVC?.items[pos].description
    }
    
    @IBAction func okButton(_ sender: Any) {
        parentVC?.items[pos] = txt.text ?? ""
        parentVC?.tableView.reloadData()
        self.dismiss(animated: true, completion: {})
    }

}
