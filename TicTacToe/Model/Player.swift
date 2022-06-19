//
//  Player.swift
//  TicTacToe
//
//  Created by Aries Lam on 6/15/22.
//

import Foundation
import RealmSwift

class Player: Object {
    
    @Persisted var name: String = ""
    @Persisted var totalScore: Int = 0
}
