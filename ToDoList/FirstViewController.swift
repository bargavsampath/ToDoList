//
//  ViewController.swift
//  ToDoList
//
//  Created by BARGAV MUNUSAMY SAMPATH  on 6/24/18.
//  Copyright © 2018 BARGAV MUNUSAMY SAMPATH . All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Note:Text Fields can only be added to an alert controller of style .alert
    
    //Creating an array of items
    var items = ["Messi","Ronaldo","Dhoni"]
    var itemAdded:UITextField!
    var count = 0
    var count1 = 0
    
    //creating an empty array which keeps track of the checkmark status for each row
    var checkMarkItems = [Checkmark]()
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
      //creating an UIALertController
        let alertController = UIAlertController.init(title: "AlertController-Activated", message:"Add an Item to ToDoList", preferredStyle: .alert)
        
        //creating an UIAlert Action
        let action = UIAlertAction.init(title: "Add Item", style: .destructive) { (action) in
         //Below lines inside this closure are executed only once, after pressing the AddItem icon
            self.count1 += 1
            print("Add Item is pressed")
            print(self.itemAdded.text!)
            print(self.count1,"Action")
          
          //Adding the newItem to the array only if there is a valid text in the UIAlert textfield
            guard let newItem = (self.itemAdded.text)  else {
                return
            }
            if newItem.isEmpty {
                return
            }
            self.items.append(newItem)
           //Calling the tableView DataSource methods to update the tableView
             self.myTableView.reloadData()
        }
        
    //adding the UIAlertAction to AlertController.
        alertController.addAction(action)
        
    //adding textField to UIAlertController
        alertController.addTextField { (textField) in
          //All the below statements inside this closure are executed only once
            self.count += 1
            textField.placeholder = "Create a New Item"
            self.itemAdded = textField
            print(textField.text!,self.count,"TextField")
        }
     
    //Presenting the UIAlertcontroller to UIViewController
     present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK - Tableview DataSource Methods
    
    //TODO - no.of rows in each column
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
   //TODO - creating cell using datasource method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         //Creating cell for each row
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        let checkmark = Checkmark()
        checkmark.status = false
        checkMarkItems.append(checkmark)
        
        //assigning text to each cell in each row
        cell.textLabel!.text = items[indexPath.row]
        
        return cell
    }
    
//MARK - TableView Delegate Methods
    
    //returns the indexPath of the row we selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print(items[indexPath.row])
        
        //Retrieving the cell of selected row
        let cell = tableView.cellForRow(at: indexPath)
        
//print(cell?.accessoryType)
       
      //retrieving the checkmark status of the selected row
       let checkedStatus = checkMarkItems[indexPath.row].status
        //let checkedStatus = cell?.accessoryType
        
        //Adding checkmark to the selected cell if the checkmark doesn't exist
        if checkedStatus {
            print("none")
            cell?.accessoryType = .none
          }
        else {
            print("checkmark")
            cell?.accessoryType = .checkmark
        }
        
        let checkmark = Checkmark()
        checkMarkItems[indexPath.row].status = checkmark.toggle(val: checkMarkItems[indexPath.row].status)
        
        //highlighting the selected row just for few seconds
        myTableView.deselectRow(at: indexPath, animated: true)

        
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting up the tableView DataSource and Delegate
        myTableView.dataSource = self
        myTableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

