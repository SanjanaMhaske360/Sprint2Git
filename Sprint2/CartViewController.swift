//
//  CartViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/26/22.
//


import UIKit
import Alamofire
import AlamofireImage


//HomeProduct
struct EProductsArray : Codable {
    var products = [EProductInfo]()
}
//Details
struct EProductInfo : Codable{
    var id: Int
    var title: String
    var description : String
    var thumbnail: String
    var price: Int
}


var Ecategory = [ProductInfo]()

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
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
       let cell = tableView.dequeueReusableCell(withIdentifier: "CartListIdentifier", for: indexPath)
       
       let product = category[indexPath.row]
       cell.textLabel?.text = product.title
       cell.detailTextLabel?.text = product.description
       return cell
   }
  
        
  }

