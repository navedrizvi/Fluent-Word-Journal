//
//  Account.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/7/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI

struct Profile : View {
    var body: some View {
        VStack {
            TopBar()
            Spacer()
        }
    }
}

#if DEBUG
struct Account_Previews : PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
#endif
