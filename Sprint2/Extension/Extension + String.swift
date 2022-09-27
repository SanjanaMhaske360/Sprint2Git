//
//  Extension + String.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/21/22.
//

import Foundation
import CoreData

extension String{
     
    // MARK: validation of PhoneNumber function
    func validatePhoneNumber() -> Bool {
        
        // Regex For PhoneNumber (phoneNumber Contain 10 digits only)
        let phoneNumberRegEx = "^[0-9]{10}$"
        return applyPredicateOnRegex(regexStr: phoneNumberRegEx)
    }
    
    
    
    // MARK: validation of EmailId function
    func validateEmailId() -> Bool {
        
        // Regex For EmailID
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }
    
    
    
    // MARK: Validation of Password function
    func validatePassword(mini: Int = 6, max: Int = 15) -> Bool {
        
        //Password Shold be Minimum 6 characters at least 1 Alphabet, 1 Number and 1 Special Character :
        var passRegEx = ""
        if mini >= max{
            passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{\(mini),}"
            
        }else{
            passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{\(mini),\(max)}"
        }
        return applyPredicateOnRegex(regexStr: passRegEx)
    }

    
    
    
    // MARK: ValidationPassword
    func validateName() -> Bool {
        
        // Employee name should contain atleast  4 character 
        let nameRegEx = "[A-Za-z]{4,25}"
        return applyPredicateOnRegex(regexStr: nameRegEx)
    }
    
    
    
    
    //MARK: self Matching String function
    func applyPredicateOnRegex(regexStr: String) -> Bool{
        
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}


