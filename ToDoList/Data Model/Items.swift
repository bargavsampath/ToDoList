//
//  Checkmark.swift
//  ToDoList
//
//  Created by BARGAV MUNUSAMY SAMPATH  on 6/24/18.
//  Copyright © 2018 BARGAV MUNUSAMY SAMPATH . All rights reserved.
//

import Foundation

//Making this class adopt Encodable protocol so that all of its properties can be encoded inorder to save it in plist
//Making this class also adopt Decodable protocol so that saved data in plist can be retrieved back and updated in the UI when the app is terminated and re-launched again.
class Items:Encodable, Decodable {
   
    var title = ""
    var isChecked = false
}
