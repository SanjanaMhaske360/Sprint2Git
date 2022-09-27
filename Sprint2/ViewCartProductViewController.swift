//
//  ViewCartProductViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/26/22.
//

import UIKit
import Alamofire
import AlamofireImage


// MARK: productArray structure
struct ProductsArray : Codable {
    var products = [ProductInfo]()
}


//MARK: ProductInfo structure
struct ProductInfo : Codable{
    var id: Int
    var title: String
    var description : String
    var thumbnail: String
    var price: Int
}

// MARK: ViewCartCell class
class ViewCartCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
   @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    
}

// MARK: UIImageView extension
extension UIImageView {
    // MARK: getImageFromurl function
    
    func getImageFromurl(urlImageAddress: String) {
        // getting Image from urlAdress
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

var category = [ProductInfo]()
// var items = [String]()

// MARK: ViewCartProductViewController class
class ViewCartProductViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // connection for tableView
    @IBOutlet weak var tableView: UITableView!
    
    var category = [ProductInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // calling a function thirdPartyIntegration
        thirdPartyIntegration()
    }

  // MARK: thirdPartyIntegration function
  func thirdPartyIntegration() {
      
    // Alamofire request for getting data from url
    Alamofire.request ("https://dummyjson.com/products/category/smartphones", method: .get, encoding: URLEncoding.default, headers: nil)
        .responseData(completionHandler:{
            
            // response will be success of fail
            (response) in
            switch response.result
            {
            case .success(_):
                if let dict = response.value
                {
                    print(dict)
                    // parse a data
                    self.parse (productdata:dict)
                }
                break
                
            case .failure(let error):
                //print Error
                print (error)
            }
        })
   
  }
    
    // MARK: parsing function
   func parse(productdata: Data) {
    
    // using JSONDecoder decode a data
    let decoder = JSONDecoder()
    if let jsondata = try? decoder.decode(ProductsArray.self, from: productdata) {
        
        category = jsondata.products
        
        // reload data in tabelView
        tableView.reloadData()
        
        // print count and data
        print(jsondata.products.count)
        for i in 0...jsondata.products.count-1 {
            print(jsondata.products[i].title)
            print(jsondata.products[i].description)
        }
    }
  }

    // MARK: tableView Data Source
    //MARK: heightForRowAt function of tableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // row height
        return 178.0
    }
    
    //MARK: numberOfRowsInSection function of tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print("count is \(category.count)")
       // number of rows equal to category array count
       return category.count
   
   }
    
    //MARK: cellForRowAt function of tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddedCartIdenrtifier", for: indexPath) as! ViewCartCell
        let product = category[indexPath.row]
        
        // print title And description in labels
        cell.productTitle?.text = product.title
        cell.productDescription?.text = product.description
        //cell.productImage.getImageFromurl(urlImageAddress: product.thumbnail)
        return cell
   }

    // MARK: didSelectRowAt function for tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell : UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        // color of selected cell will change to green
        selectedCell.contentView.backgroundColor = UIColor.green
         myIdex = indexPath.row
        
         tableView.deselectRow(at: indexPath, animated: true)
        
        // navigate to next view controller using CartToMapSegue Identifier
         performSegue(withIdentifier: "CartToMapSegue", sender: self)
    }
 
    // MARK: didDeSelectRowAt function for tableView
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell : UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.white
    }
    
    
}























/*
import UIKit
import Alamofire
import AlamofireImage


//HomeProduct
struct ProductsArray : Codable {
    var products = [ProductInfo]()
}
//Details
struct ProductInfo : Codable{
    var id: Int
    var title: String
    var description : String
    var thumbnail: String
    var price: Int
}


var category = [ProductInfo]()

class ViewCartProductViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    
var category = [ProductInfo]()
override func viewDidLoad() {
    super.viewDidLoad()
    thirdPartyIntegration()
    
}

func thirdPartyIntegration() {
    Alamofire.request ("https://dummyjson.com/products/category/smartphones", method: .get, encoding: URLEncoding.default, headers: nil)
        .responseData(completionHandler:{
            
            (response) in
            switch response.result
            {
            case .success(_):
                if let dict = response.value
                {
                    print(dict)
                    self.parse (productdata:dict)
                }
                break
            case .failure(let error):
                print (error)
            }
        })
   
}
func parse(productdata: Data) {
    let decoder = JSONDecoder()
    if let jsondata = try? decoder.decode(ProductsArray.self, from: productdata) {
        category = jsondata.products
        tableView.reloadData()
        print(jsondata.products.count)
        for i in 0...jsondata.products.count-1 {
            print(jsondata.products[i].title)
            print(jsondata.products[i].description)
        }
    }
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   print("count is \(category.count)")
   return category.count
   
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "AddedCartIdenrtifier", for: indexPath)
   
   let product = category[indexPath.row]
   cell.textLabel?.text = product.title
   cell.detailTextLabel?.text = product.description
   return cell
}
    
    // MARK: didSelectRowAt function for tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         myIdex = indexPath.row
         tableView.deselectRow(at: indexPath, animated: true)
         performSegue(withIdentifier: "CartToMapSegue", sender: self)
    }
}
}
 */
