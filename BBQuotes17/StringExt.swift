//
//  StringExt.swift
//  BBQuotes17
//
//  Created by Luca Borda on 02/08/2024.
//

import Foundation

extension String {
    func removeSpaces()-> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpaces()-> String {
        self.removeSpaces().lowercased()
    }
}
