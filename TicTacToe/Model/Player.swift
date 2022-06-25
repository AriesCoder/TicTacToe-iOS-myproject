//
//  Player.swift
//  TicTacToe
//
//  Created by Aries Lam on 6/15/22.
//

import Foundation
import RealmSwift

class Player: Object{
    
    @Persisted var name: String = ""
    @Persisted var score: Int = 0
    @Persisted var dateCreated = Date()
}
