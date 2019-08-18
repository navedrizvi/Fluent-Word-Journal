//
//  User.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/18/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

class User {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }

}
