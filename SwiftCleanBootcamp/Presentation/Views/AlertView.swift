//
//  AlertView.swift
//  Presentation
//
//  Created by Willian Guedes on 28/10/22.
//

import Foundation

protocol AlertView {
    func showMessage(viewmodel: AlertViewModel)
}

struct AlertViewModel: Equatable {
    var title: String
    var message: String
}
