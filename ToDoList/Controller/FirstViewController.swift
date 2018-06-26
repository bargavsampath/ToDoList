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
      // Attempt to set a non-property-list object
     //  Cannot use instance member 'dataFilePath' within property initializer; property initializers run before 'self' is available
    
    //creating an empty array of Items of type "Data Model"
    var itemsArray = [Items]()
    
    //creating a variable to store the textField captured inside UIAlertaddtextField closure.
    var itemAdded:UITextField!
    
    //Dubugging variables
    var count = 0
    var count1 = 0
    
    //Creating UserDefaults for persistent local data storage
    let userDefault = UserDefaults.standard
    
    //creating a global variable to store the FilePath
    
    var globalFilePath:URL!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        //Creating a FilePath to our directory using FileManager and also creating our own plist and placing that plist inside the FilePath
        PlistURL()
        
        print(globalFilePath,"zzz")
        

        
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
          
            //Saving our NewItem to plist
            self.SaveData()
            
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
    
    
    //**********    Saving Our Data to custom plist  ***************
    
    
    func SaveData() {
    //creating an encoder to encode our newItem to plist
    let encoder = PropertyListEncoder()
    //encoding our newItem
    do {
    let data = try encoder.encode(itemsArray)
    //writing the encoded data to our custom plist
    try data.write(to: globalFilePath)
    } catch let error {
        print(error)
    }
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
        
        //setting title for each cell based on rowNumber
        ConfigureTitleForCell(cell:cell, rowNumber:rowNumber)
        
        //configuring the checkMark based on "isChecked" property value
        configureCheckMark(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    //function to configure label
    func ConfigureTitleForCell(cell:UITableViewCell, rowNumber:Int) {
        //assigning text for cell at this rowNumber
        cell.textLabel!.text = itemsArray[rowNumber].title
    }
    
    //function to configure checkMark
    func configureCheckMark(cell:UITableViewCell, indexPath:IndexPath) {
        
        //Ternary operator
        // value = (Condition) ? (value-if-True) : (value-if-False)
        cell.accessoryType = (itemsArray[indexPath.row].isChecked) ? (.checkmark) : (.none)
        
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
        
      //updating the checkMark status to our custom plist
         SaveData()

        
        //highlighting the selected row just for few seconds
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Creating a FilePath to our directory using FileManager and also creating our own plist and placing that plist inside the FilePath
         PlistURL()
        
        //Decodable protocol is used to load the data that we have stored in plist after our app has been terminated and re-launched
          LoadData()
        
        
        print("ViewDidLoad")
        print("Items.plist")
        
//        //creating an instance of the dataModel
//        let item = Items()
//        item.title = "Messi"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        let item = Items()
//        item.title = "Ronaldo"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        let item = Items()
//        item.title = "Dhoni"
//        item.isChecked = false
//        itemsArray.append(item)
//
//        let item = Items()
//        item.title = "Sachin"
//        item.isChecked = false
//        itemsArray.append(item)
        
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
    
    func PlistURL() {
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let finalFilePath = filePath.first?.appendingPathComponent("Items.plist")
        globalFilePath = finalFilePath
    }
    
    func LoadData() {
        //Retrieving the Data present in plist in-order to decode it
        guard let data = try? Data.init(contentsOf: globalFilePath) else {
                return
        }
        print("Inside Load data")
            //creating an instance of decoder
            let decoder = PropertyListDecoder()
            //decoding the data present in plist
            do {
            let decodedValue = try? decoder.decode([Items].self, from: data)
                print(decodedValue)
            itemsArray = decodedValue!
            } catch let error {
                print(error)
            }
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

