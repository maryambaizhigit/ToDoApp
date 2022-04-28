//
//  ViewController.swift
//  ToDoApp
//
//  Created by Алилуя БК on 28.04.2022.
//

import UIKit
import RealmSwift

class Items: Object {
    @objc dynamic var item : String = ""
    @objc dynamic var date : Date = Date()
}

class ViewController: UITableViewController {
   
    private let realm = try! Realm()
    private var data = [Items]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("it works")
        data = realm.objects(Items.self).map( { $0 })

    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "enter") as? MainViewController else {
            return
        }
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        
    }
    
    func refresh() {
        data = realm.objects(Items.self).map( { $0 })
        tableView.reloadData()
    }
}
