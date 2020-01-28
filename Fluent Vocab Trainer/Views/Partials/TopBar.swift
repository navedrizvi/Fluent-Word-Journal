//
//  TopBar.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/7/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI

struct TopBar : View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.purple)
            .edgesIgnoringSafeArea(.top)
            .frame(maxHeight: 60)
    }
}
