//
//  LoginViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/21/22.
//

import UIKit
import CoreData
import LocalAuthentication
import FirebaseAuth

class LoginViewController: UIViewController {

    // outlet for All Text Fields Labels and images
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a image round shape
        imageView.layer.cornerRadius = imageView.layer.bounds.height/2
        imageView.clipsToBounds = true
        
        //radius of login and signup Button
        loginButton.layer.cornerRadius = 25.0
        loginButton.layer.masksToBounds = true
        signUpButton.layer.cornerRadius = 25.0
        signUpButton.layer.masksToBounds = true
        
        
        // callig a function FaceNotification for getting a Permission from customer When App Start
        FaceIdNotification()
    }
    
    
    //MARK: faceIdNotification function for Authentication of Customer By Face
    
    func FaceIdNotification() {
        
       let context = LAContext()
        var error: NSError? = nil
        
        // When Face Id Authentication Disable For App
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error) {
            
            let reason = "Please authorize with touch Id"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success,error == nil else {
                        
                        //Alert When Customer Face Not Matched
                        let alert = UIAlertController(title: "Failed To Authenticate", message: "Please Try Again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert,animated: true)
                        return
                }
                    
                    // Alert When Customer Face matched
                    let alert = UIAlertController(title: "Face Authentication Succesful!!!", message: "",preferredStyle: .alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self?.present(alert, animated: true, completion: nil)
                    print("Face ID Authentication Succced")
                }
            }
        }
        
        // When Face Id Authentication Disable For App
        else {
           let alert = UIAlertController(title: "Unavailable FaceId", message: "Please Enable Face Id", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
    }
    
    
    
    //MARK: function for Checking EmailId And Password in Coredata Exist Or Not
    
    func CheckForUserNameAndPasswordMatch(email: String, password: String) -> Bool {
        
        //
        var customer = [Customer]()
        let app = (UIApplication.shared.delegate)  as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSManagedObject>(entityName: "Customer")
        
        //checking With formate Email And Password In Coredata
        fetchrequest.predicate = NSPredicate(format: "email = %@ and password = %@", email,password)
        
        do{
            customer = try context.fetch(fetchrequest) as! [Customer]
          //  if data Present in coredata then count will be 1
            if(customer.count == 1){
                return true
            }
        }
        catch {
            print("error")
        }
        return false
     }
    
    
    
    // loginButton Action
    @IBAction func loginButton(_ sender: UIButton) {
        
        if let email = userName.text, let password = userPassword.text   {

            // Alert Popup When Email or Password Text Empty
            if (email == "" || password == ""){
             openAlert(title: "Alert", message: "Please Enter All Details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
             print("Enter All Login Email And Password!")}])
            }
            
            //Alert If EmailId Is not Valid
            else if  !email.validateEmailId(){
                openAlert(title: "Alert", message: "Email address is invalid", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in print("Enter Valid Email!")}])
            }
            
            //Alert If Password Not Valid
            else if !password.validatePassword(){
                //Alert msg If Password Not Valid
                openAlert(title: "Alert", message: "Password is invalid", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in print("Enter Valid Password!")}])
            }

            else  {
                
                // if  Email Exist
                if(CheckForUserNameAndPasswordMatch(email: userName.text!, password: userPassword.text!)){

                    // code for firebase Authentication
                    
                    Auth.auth().signIn(withEmail: userName.text!, password: userPassword.text!) { [weak self] authResult, err in
                        guard let strongSelf = self else {return}
                        
                        if let err = err {
                            print(err.localizedDescription)
                            self?.openAlert(title: "Alert", message: "User Not found", alertStyle: .alert, actionTitles: ["Please SignUp"], actionStyles: [.default], actions: [{ _ in print(" Authentication Failed!")}])                         }
                        
                        // User Should Present In FireBase
                        if Auth.auth().currentUser != nil {
                            print(Auth.auth().currentUser?.uid)
                            
                            //Navigate To MainTabBarController
                            let employeesVC = self?.storyboard?.instantiateViewController(withIdentifier:"MainTabBarController") as! MainTabBarController
                            self?.navigationController?.pushViewController(employeesVC, animated: true)
                        }
                    }
                }
 
                
                else {
                    //if user Not Exist in coredata
                    openAlert(title: "Alert", message: "User Not found", alertStyle: .alert, actionTitles: ["Please SignUp"], actionStyles: [.default], actions: [{ _ in print("Login Failed!")}])                }
            }
       }
 
 
 
        else{
            openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")}])
            }
    
 
   }
    
    

}
