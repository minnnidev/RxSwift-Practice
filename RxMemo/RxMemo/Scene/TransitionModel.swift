//
//  TransitionModel.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
