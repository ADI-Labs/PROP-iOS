//
//  UserProfileManager.swift
//  GalloPrototype
//
//  Created by Conder Shou on 3/31/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import FirebaseDatabase
import FirebaseAuth

class UserProfileManager {
    
    static let shared = UserProfileManager()
    
    func update(for user:FIRUser, firstName:String, lastName: String) {
        
        let reference = FIRDatabase.database().reference()
        
        let userId = user.uid
        
        let post = ["uid": userId,
                    "firstName": firstName,
                    "lastName": lastName,
                    "email": user.email ?? ""
            ] as [String : Any]
        let childUpdates = ["/profile/\(user.uid)": post]
        reference.updateChildValues(childUpdates)
    }
    
    func userName(for user: FIRUser, completion: @escaping ((String?, String?, Error?) -> Void)) {
        
        let reference = FIRDatabase.database().reference()
        
        reference.child("profile").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            guard let userItem = snapshot.value as? NSDictionary else {
                // TODO: handle error
                return
            }
            
            let firstName = userItem["firstName"] as? String
            let lastName = userItem["lastName"] as? String
            
            completion(firstName, lastName, nil)
        }) { (error) in
            completion(nil, nil, error)
        }
    }
}
