//
//  CategoryViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/22/22.
//

import UIKit
import Alamofire

// Display Array in Tabel View Using Alamofire API

var myIdex = 0

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UITabelView variable
    @IBOutlet weak var myTable: UITableView!
    
    // create a Array
    var categoryArray = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call a function getJSONData
        getJSONData()
    }
    
    
    // MARK: GetJSONData function
    
    func getJSONData() {
        
        // create a urlFile for url link
       let urlFile = "https://dummyjson.com/products/categories"
        
        // request to Json for url using Alamofire
       Alamofire.request(urlFile).responseJSON { (response) in
           
          //  response can be a Succesful Of Fail
          switch response.result
          {
            // if Response is succesful store them in Array of String
            case .success(_):
                  let jsondata = response.result.value as! [String]?
                  self.categoryArray = jsondata!
                  // reload a data in myTabel
                  self.myTable.reloadData()
        
             // if Response if fail then print error
            case .failure(let error):
                  print("Error Occured \(error.localizedDescription)")
       }
    }
  }
    
    
    // MARK: NumberOfRowsInSection function for tabelView
    //  Return a row count as category array count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return categoryArray.count
        
    }


    // MARK: cellForRowAt function for tableView
    // pass a Array data to the label
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         cell.textLabel?.text = categoryArray[indexPath.row]
         return cell
    }

    // MARK: didSelectRowAt function for tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         myIdex = indexPath.row
         myTable.deselectRow(at: indexPath, animated: true)
         performSegue(withIdentifier: "category", sender: self)
 }
}
