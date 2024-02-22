//
//  Bank.swift
//  Sampler
//
//  Created by Henri Bredt on 21.02.24.
//

import Foundation

enum Bank {
    case bank1, bank2, bank3, bank4, bank5, bank6, bank7, bank8, bank9
    
    func getString() -> String {
        switch self {
        case .bank1:
            "1"
        case .bank2:
            "2"
        case .bank3:
            "3"
        case .bank4:
            "4"
        case .bank5:
            "5"
        case .bank6:
            "6"
        case .bank7:
            "7"
        case .bank8:
            "8"
        case .bank9:
            "9"
        }
    }
    
    func getFileName() -> String {
        "bank_\(self.getString())_base_sample"
    }
}

struct BankManager {
    static func toggle(base: Bank, current: Bank?) -> Bank? {
        if current == nil {
            return base
        } else {
            return nil
        }
    }
}
