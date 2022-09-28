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
    
    // outlet for All Text Fiels Labels and images
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
                if (Auth.auth().currentUser == nil){
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
                
                    // Save Data in FireBase
                    Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { (authResult,error) in
                        guard let users = authResult?.user,error == nil else {
                            print("Error \(error?.localizedDescription)")
                            return
                        }
                    }
                
                // PopUp When Data Saven in Firebase
                let alert = UIAlertController(title: "Data Save Successfully", message:"SignUp Completed" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print(" Data Save Succesfully")
                
                }
            }
        }
                
    }
            
    else {
             openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in print("Okay clicked!")}])
    }
  }
}
