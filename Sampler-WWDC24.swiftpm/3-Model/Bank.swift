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
    
    func playerIndex() -> Int {
        switch self {
        case .bank1:
            0
        case .bank2:
            1
        case .bank3:
            2
        case .bank4:
            3
        case .bank5:
            4
        case .bank6:
            5
        case .bank7:
            6
        case .bank8:
            7
        case .bank9:
            8
        }
    }
    
    static func from(playerIndex: Int) -> Bank? {
        switch playerIndex {
        case 0:
            Bank.bank1
        case 1:
            Bank.bank2
        case 2:
            Bank.bank3
        case 3:
            Bank.bank4
        case 4:
            Bank.bank5
        case 5:
            Bank.bank6
        case 7:
            Bank.bank8
        case 8:
            Bank.bank9
        default:
            nil
        }
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
