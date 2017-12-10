//
//  AuthService.swift
//  KChat
//
//  Created by Kel Robertson on 7/01/2017.
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
    
    func login(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                    self.handleFirebaseErrors(error: error as! NSError, onComplete: onComplete!)
            } else {
                if let user = user {
                    KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                    onComplete?(true,nil,nil)
                }
            }
  
        })
    }
    
    func completeSignIn(id: String, userData: Dictionary<String,String>) {
        let _ = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        DataService.instance.saveUser(uid: id, userData: userData)

    }
    
    func createUser(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.handleFirebaseErrors(error: error! as NSError, onComplete: onComplete!)
            } else {
                if user?.uid != nil {
                    
                    let userData = ["provider": user?.providerID, "username": email]
                    
                    self.completeSignIn(id: (user?.uid)!, userData: userData as! Dictionary<String, String>)
                    onComplete!(true,nil,nil)
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
}
