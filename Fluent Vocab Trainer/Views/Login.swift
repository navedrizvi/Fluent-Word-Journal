//
//  Login.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/6/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI

struct Login : View {
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                
        }
    }
}

#if DEBUG
struct Login_Previews : PreviewProvider {
    static var previews: some View {
        Login()
    }
}
#endif
