//
//  MagicMoveExt.swift
//  MagicMove
//
//  Created by Patrick Reynolds on 1/24/16.
//  Copyright © 2016 Patrick Reynolds. All rights reserved.
//

import Foundation

enum Storyboards {
    case Main
    
    var storyboard: String {
        switch self {
        case .Main: return "Main"
        }
    }
}

enum MagicMoveSelectors: String {
    case ButtonTapped
    
    func selector() -> Selector {
        return Selector(self.rawValue)
    }
}
