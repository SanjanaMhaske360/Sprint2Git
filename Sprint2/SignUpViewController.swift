//
//  SignUpViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/21/22.
//

import UIKit
import CoreData
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userMobile: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userConfirmPassword: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var result = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create Image Round Shape
        imageView.layer.cornerRadius = imageView.layer.bounds.height/2
        imageView.clipsToBounds = true
        
        //Corner Radius For SignUp Button
        signUpBtn.layer.cornerRadius = 25.0
        signUpBtn.layer.masksToBounds = true
        
    }
    
    
    //MARK: Check Email And Password Exist in Coredata or not
    func CheckForUserNameAndPasswordMatch(email: String) -> Bool {
    var customer = [Customer]()
    let app = (UIApplication.shared.delegate)  as! AppDelegate
    let context = app.persistentContainer.viewContext
    let fetchrequest = NSFetchRequest<NSManagedObject>(entityName: "Customer")
    
    //checking With formate Email And Password In Coredata
    fetchrequest.predicate = NSPredicate(format: "email = %@", email )
    do{
        customer = try context.fetch(fetchrequest) as! [Customer]
        //  if data Present in coredata then count will be 1
        if(customer.count == 1){
            return true
        }
    } catch {
        print("error")
    }
    return false
  }
    
    
    //SignUp Button Action
    @IBAction func signUpButton(_ sender: Any) {

        if let name = userName.text, let email = userEmail.text, let phoneNumber = userMobile.text, let password = userPassword.text , let confirmPassword = userConfirmPassword.text {
        
        // Alert If Name or Password or Email Or Phone Number Text Fields Empty
        if (name == "" || password == "" || email == "" ||  phoneNumber == "" || confirmPassword == "") {
            openAlert(title: "Alert", message: "Enter All Details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Enter All Details")}])
        }
        
        else {
            // Alert if Name is invaild
            if !name.validateName() {
                openAlert(title: "Alert", message: "Invalid Name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Invalid Name!")}])
            }
            
            // Alert if Email is Invalid
            else if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Invalid Email Address", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Invalid Email!")}])
            }
            
            else{
                
                //Alert If Email Already Exist in CoreData
                if(CheckForUserNameAndPasswordMatch(email: userEmail.text!)){
                openAlert(title: "Alert", message: "Email Already Exist", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Email Exist!")}])
            }
            
                
                // Alert If phoneNumver Invalid
                else if !phoneNumber.validatePhoneNumber() {
                openAlert(title: "Alert", message: "Invalid phoneNumber", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Invalid PhoneNumber!")}])
            }
                
                //Alert If Password is not Valid
                else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Inavlid Password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Inavlid Password!")}])
            }
            
                //Alert if Confirm Password not Matched with Password
                else if (password != confirmPassword) {
                openAlert(title: "Alert", message: "Password Not Matched", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Password Not Matched")}])
            }
    
                
                
            else {
                    // Save All Input Data In  CoreData Dictionary
                    let dict = ["name":userName.text ,"email":userEmail.text, "mobile":userMobile.text ,"password":userPassword.text]
                    DatabaseHelper.shareInstance.save(object: dict as! [String : String])
                    
                    // PopUp When Data Saven in Coredata
                    let alert = UIAlertController(title: "Data Save Successfully", message:"SignUp Completed" , preferredStyle: .alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    print(" Data Save Succesfully")
                
                
                    // Save Data in FireBase
                    Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { (authResult,error) in
                        guard let users = authResult?.user,error == nil else {
                            print("Error \(error?.localizedDescription)")
                            return
                        }
                    }
                }
            }
        }
                
    }
            
    else {
             openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in print("Okay clicked!")}])
    }
  }
}


    



