//
//  ViewCartProductViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/26/22.
//

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


class ViewCartCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
   @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    
    
}






extension UIImageView {
    // MARK:
    func getImageFromurl(urlImageAddress: String) {
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178.0
    }
    
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   print("count is \(category.count)")
   return category.count
   
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "AddedCartIdenrtifier", for: indexPath) as! ViewCartCell
   
   let product = category[indexPath.row]
    cell.productTitle?.text = product.title
    cell.productDescription?.text = product.description
    cell.productImage.getImageFromurl(urlImageAddress: product.thumbnail)
   return cell
}

    // MARK: didSelectRowAt function for tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell : UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.green
         myIdex = indexPath.row
         tableView.deselectRow(at: indexPath, animated: true)
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
