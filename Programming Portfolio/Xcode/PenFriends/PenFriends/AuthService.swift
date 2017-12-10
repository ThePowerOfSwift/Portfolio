//
//  AuthService.swift
//  PenFriends
//
//  Created by Kel Robertson on 5/02/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ suc: Bool?, _ em: String?, _ d: AnyObject?) -> Void

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instance: AuthService{
        return _instance
    }
    
    
    func login(username: String, email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
//                self.handleFirebaseErrors(error: error as! NSError, onComplete: onComplete!)
                self.createUser(username: username, email: email, password: password, onComplete: { (success, msg, data) in
                    if success == true {
                        onComplete!(true,nil,nil)
                    }
                })
            } else {
                if let user = user {
                    if !user.isEmailVerified{
                        onComplete?(false,nil,nil)
                    } else {
                        KeychainWrapper.standard.set(user.uid, forKey: "uid")
                        onComplete?(true,nil,nil)
                    }
                }
            }
            
        })
    }

    func createUser(username:String, email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.handleFirebaseErrors(error: error! as NSError, onComplete: onComplete!)
            } else {
                if user?.uid != nil {
                    user?.sendEmailVerification(completion: { (_) in
                    })
                    let userData = ["provider": user?.providerID, "emailAddress": email, "username": username]
                    
                    DataService.instance.saveUser(uid: (user?.uid)!, userData: userData as! Dictionary<String, String>)
                    onComplete!(true,nil, nil)
                    
                    
                } else {
                    onComplete!(false,nil,nil)
                }
            }
        })
    }
    
    func handleFirebaseErrors(error: NSError, onComplete: Completion) {
        print(error.debugDescription)
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch (errorCode) {
            case .errorCodeUserNotFound:
                onComplete(false,"The user does not exist, please register before logging in.", nil)
                break
            case .errorCodeInvalidEmail:
                onComplete(false,"Invalid Email Address", nil)
                break
            case .errorCodeWrongPassword:
                onComplete(false,"Invalid Password", nil)
                break
            case .errorCodeEmailAlreadyInUse , .errorCodeAccountExistsWithDifferentCredential:
                onComplete(false,"Could not create account, Email already in use",nil)
                break
            default:
                onComplete(false,"There was a problem authenticating Try Again", nil)
            }
        }
    }
    
    func currentUsername(email:String) -> [String] {
        
        let delimiter = "@"
        let newstr = email
        let username = newstr.components(separatedBy: delimiter)
        
        return username
    }
    
}
