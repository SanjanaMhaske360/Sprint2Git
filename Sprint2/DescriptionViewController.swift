//
//  DescriptionViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/25/22.
//

import UIKit
import Alamofire
import AlamofireImage


// MARK: AllProductArray function
// Dictionary of Array of AllProduct
struct AllProductArray : Codable {
    var products = [AllProduct]()
}

// MARK: AllProduct function
// Dictionary of Product Info
struct AllProduct : Codable{
    var id: Int
    var title: String
    var description : String
    var thumbnail: String
    var price: Int
}

//MARK: DescrptionTableViewCell class
class DescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!

}

// UIImageView extension
extension UIImageView {
    // MARK: getImageFromURL function
    func getImageFromURL(urlImageAddress: String) {
        guard let url = URL(string: urlImageAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let dataOfImage = try? Data(contentsOf: url) {
                if let showImage = UIImage(data: dataOfImage) {
                    self?.image = showImage
                }
            }
        }
    }
}


var allProducts = [AllProduct]()
var items = [String]()

// MARK: DescriptionViewController class
class DescriptionViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
 {
    
    

    // connection of table View
    @IBOutlet weak var tableView: UITableView!
    
   
    var allProducts = [AllProduct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call a function thirdPartyIntegration
        thirdPartyIntegration()
        
    }
    
    
    // MARK: thirdPartyIntegration function
    
    func thirdPartyIntegration() {
        
        // Alamofire request for getting a data from web server
        Alamofire.request ("https://dummyjson.com/products/category/smartphones", method: .get, encoding: URLEncoding.default, headers: nil)
        
             // response from server
            .responseData(completionHandler:{
                
                (response) in
                switch response.result
                {
                    
                //if response from server is Succesful
                case .success(_):
                    if let dict = response.value
                    {
                        print(dict)
                        //parse a data function
                        self.parse (productdata:dict)
                    }
                    break
                    
                // if response from server in unsuccesful
                case .failure(let error):
                    // print error
                    print (error)
                }
            })
       
    }
    
    
    // MARK: parse(productdata: Data) function
    func parse(productdata: Data) {
        
        // use JSON Decoder
        let decoder = JSONDecoder()
        if let jsondata = try? decoder.decode(ProductsArray.self, from: productdata) {
            
            // fetch data to the category variable
            category = jsondata.products
            
            // reload data to the table View
            tableView.reloadData()
            
            //print data in console
            print(jsondata.products.count)
            for i in 0...jsondata.products.count-1 {
                print(jsondata.products[i].title)
                print(jsondata.products[i].description)
            }
        }
    }
   
    // MARK: - Table view data source
    
    //MARK: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178.0
    }
    
    
    //MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print("count is \(category.count)")
        
       //row count equal to category items count
       return category.count
       
   }
    
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cell identifier to print Values in table View
       let cell = tableView.dequeueReusableCell(withIdentifier: "myCategoryIdentifier", for: indexPath) as! DescriptionTableViewCell
       
       let product = category[indexPath.row]
       
       // print title of product in label
        cell.productTitle?.text = product.title
        
       // print description of product in label
        cell.productDescription?.text = product.description
        
        
        // print thumbnail of product in label
        cell.productImage.getImageFromURL(urlImageAddress: product.thumbnail)
        
        
       return cell
   }
  
    //MARK: didSelectRowAt function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell : UITableViewCell = tableView.cellForRow(at: indexPath)!
        //cell color become green when user select cell
        selectedCell.contentView.backgroundColor = UIColor.green
        
    }
    //MARK: didDeselectRowAt function
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell : UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.white
    }
    
    
    @IBAction func addToCartBtn(_ sender: Any) {
        
        if let selectRows = tableView.indexPathsForSelectedRows
        {
            for indexpath in selectRows
            {
                let product = category[indexpath.row]
                items.append(product.title)
              //  items.append(product.description)
                
                
            }
            
            print("---you have selected items---")
            for item in items {
                print(item)
            }
        }
    }
  }
