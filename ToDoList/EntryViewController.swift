//
//  EntryViewController.swift
//  ToDoList
//
//  Created by Julia Turner on 2020-09-21.
//  Copyright © 2020 Julia Turner. All rights reserved.
//
import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.becomeFirstResponder()
        textField.delegate = self
        
        datePicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
   @objc func didTapSaveButton() {
    if let text = textField.text, !text.isEmpty {
        let date = datePicker.date
        
        realm.beginWrite()
        
        let newItem = ToDoListItem()
        newItem.date = date
        newItem.item = text
        realm.add(newItem)
        
        try! realm.commitWrite()
        
        completionHandler?()
        navigationController?.popToRootViewController(animated: true)
    } else {
        print("Type something")
    }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
