//
//  Err.swift
//  WRLDS
//
//  Created by Garrett Jester on 9/5/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import Foundation

public class Err: NSObject {
    var code: Int // Internal error code
    var message: String!
    
    init(code: Int = 0000, message: String? = "Unknown error.") {
        self.message = message
        self.code = code
    }
    
    @nonobjc class var internalServerError: Err {
        return Err(code: 500, message: "Internal server error.")
    }
    
    @nonobjc class var phoneNumberInUse: Err {
        return Err(code: 4091, message: "That phone number is already in use.")
    }
    
    @nonobjc class var emailInUse: Err {
        return Err(code: 4092, message: "That email is already in use.")
    }
    
    @nonobjc class var usernameInUse: Err {
        return Err(code: 4093, message: "Oops! That username's taken.")
    }
    
    @nonobjc class var invalidConfirmCode: Err {
        return Err(code: 4221, message: "The code you entered was invalid.")
    }
    
    @nonobjc class var resendLimitReached: Err {
        return Err(code: 4221, message: "You've reached the code resend limit. Try again later.")
    }
    
    @nonobjc class var graphQlError: Err {
        return Err(code: 4042, message: "No graphql object found.")
    }
    
    @nonobjc class var noContactsPermission: Err {
        return Err(code: 4011, message: "Contacts access must be enabled to access this feature.")
    }
    
    @nonobjc class var facebookSignIn: Err {
        return Err(code: 6001, message: "An error occured with Facebook.")
    }
}

