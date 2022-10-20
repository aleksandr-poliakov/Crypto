//
//  UIApplication+Extensions.swift
//  CryptoWallet
//
//  Created by Aleksandr on 20.10.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
