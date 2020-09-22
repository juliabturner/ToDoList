//
//  ViewViewController.swift
//  ToDoList
//
//  Created by Julia Turner on 2020-09-21.
//  Copyright © 2020 Julia Turner. All rights reserved.
//
import RealmSwift
import UIKit

class ViewViewController: UIViewController {

    public var item: ToDoListItem?
    
    public var deletionHandler: (()-> Void)?
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }
        
        realm.beginWrite()
        
        realm.delete(myItem)
        
        try! realm.commitWrite()
        
        deletionHandler?()
        
        navigationController?.popToRootViewController(animated: true)
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
