//
//  String-CapitalizeFirst.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 7/27/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
