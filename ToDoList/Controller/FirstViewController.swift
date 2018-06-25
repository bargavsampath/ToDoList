//
//  ViewController.swift
//  ToDoList
//
//  Created by BARGAV MUNUSAMY SAMPATH  on 6/24/18.
//  Copyright © 2018 BARGAV MUNUSAMY SAMPATH . All rights reserved.
//

/*
 Note:
 Updating the checkmark based on cellAccessory status will create problems when that cell is being reused.
 Hence update the checkmark based on "label" for each cell.
 
 Outlets cannot be connected to repeating content.
 */


import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Note:Text Fields can only be added to an alert controller of style .alert
      //   Attempt to set a non-property-list object
    
    //creating an empty array of Items of type "Data Model"
    var itemsArray = [Items]()
    
   
    //creating a variable to store the textField captured inside UIAlertaddtextField closure.
    var itemAdded:UITextField!
    
    //Dubugging variables
    var count = 0
    var count1 = 0
    
    //Creating UserDefaults for persistent local data storage
    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var myTableView: UITableView!
    
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
            
            let item = Items()
            
            item.title = newItem
            item.isChecked = false
            
            self.itemsArray.append(item)
            
            //self.userDefault.set(self.itemsArray, forKey: "Item-Added")
            
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
        return itemsArray.count
    }
    
   //TODO - creating cell using datasource method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    /**  This function is called when we
         1. call tableView.reloaddata()
         2. when we scroll the tableView
         3. set the dataSource initially at ViewDidLoad
     **/
         //Creating cell for each row
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        print("Inside reusable cell")
        
        //getting the rowNumber of the created cell
        let rowNumber = indexPath.row
        //assigning text for cell at this rowNumber
        cell.textLabel!.text = itemsArray[rowNumber].title
        
        return cell
    }
    
  
    
    
//MARK - TableView Delegate Methods
    
    //returns the indexPath of the row we selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Retrieving the cell of selected row
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        //retrieving the rowNumber of the selected Row
        let rowNumber = indexPath.row
        
      //Inverting the ischecked property
       itemsArray[rowNumber].isChecked = !(itemsArray[rowNumber].isChecked)
        
     //configuring the checkMark based on "isChecked" property value
        configureCheckMark(cell: cell, indexPath: indexPath)

        
        //highlighting the selected row just for few seconds
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    //function to configure checkMark
    func configureCheckMark(cell:UITableViewCell, indexPath:IndexPath) {
        
        //Ternary operator
        // value = (Condition) ? (value-if-True) : (value-if-False)
        cell.accessoryType = (itemsArray[indexPath.row].isChecked) ? (.checkmark) : (.none)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad")
        
        //creating an instance of the dataModel
        let item = Items()
        
        item.title = "Messi"
        item.isChecked = false
        itemsArray.append(item)
        
        item.title = "Ronaldo"
        item.isChecked = false
        itemsArray.append(item)
        
        item.title = "Dhoni"
        item.isChecked = false
        itemsArray.append(item)
        
        item.title = "Sachin"
        item.isChecked = false
        itemsArray.append(item)
        
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
        
        
        //userDefault.array(forKey: "Item-Added")
        
        //setting up the tableView DataSource and Delegate
        myTableView.dataSource = self
        myTableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

