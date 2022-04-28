//
//  MainViewController.swift
//  ToDoApp
//
//  Created by Алилуя БК on 28.04.2022.
//

import RealmSwift
import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var chooseDate: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        textField.delegate = self
        
        chooseDate.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(TapSaveButton))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func TapSaveButton() {
        if let text =  textField.text, !text.isEmpty {
            let date = chooseDate.date
            realm.beginWrite()
            
            let newItem = Items()
            newItem.date = date
            newItem.item = text
            realm.add(newItem)
            
            try! realm.commitWrite()
            completionHandler?()
        } else {
            print("add more")
        }
    }

}
