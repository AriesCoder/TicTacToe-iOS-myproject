//
//  CoorLogic.swift
//  TicTacToe
//
//  Created by Aries Lam on 5/9/22.
//

import Foundation

class GameLogic {
    
    var gameBoard = [[String]]()
    var mappingTagToCoordinate = [Int: [Int]]()
    var size = 3
    
    func setGameBoard(boardGameSize: Int) {
        size = boardGameSize
        for _ in 0..<size {
            var temp = Array<String>()
            for _ in 0..<size {
                temp.append("nil")
            }
            gameBoard.append(temp)
        }
        print(gameBoard)
    }
    
    func reset() {
        gameBoard = [[String]]()
        mappingTagToCoordinate = [Int: [Int]]()
    }
    
    func setMappingTagToCoordinate(tag: Int, coor: [Int]) {
        mappingTagToCoordinate[tag] = coor
    }
    
    func playerMove(player: String, tag: Int) -> Bool {
        print("player" + ": move")
        guard let coor = mappingTagToCoordinate[tag] else {return false}
        gameBoard[coor[0]][coor[1]] = player
        if checkWin(player: player, coor: coor) {
            return true
        }
        return false
    }
    
    func checkWin(player: String, coor: [Int]) -> Bool {
        if horizontalCheck(player: player, coor: coor) {
            return true
        }
        if verticalCheck(player: player, coor: coor) {
            return true
        }
        if diagnoleCheck(player: player, coor: coor) {
            return true
        }
        return false
    }
    
    func horizontalCheck(player: String, coor: [Int]) -> Bool {
        let column = coor[0]
        var row = coor[1]
        var found = 0
        while row >= 0 && gameBoard[column][row] == player {
            found += 1
            if found == size {
                return true
            }
            row -= 1
        }
        row = coor[1]
        if found > 0 {
            found -= 1
        }
        while row < size && gameBoard[column][row] == player {
            found += 1
            if found == size {
                return true
            }
            row += 1
        }
        return false
    }
    
    func verticalCheck(player: String, coor: [Int]) -> Bool {
        var column = coor[0]
        let row = coor[1]
        var found = 0
        while column >= 0 && gameBoard[column][row] == player {
            found += 1
            if found == size {
                return true
            }
            column -= 1
        }
        if found > 0 {
            found -= 1
        }
        column = coor[0]
        while column < size && gameBoard[column][row] == player {
            found += 1
            if found == size {
                return true
            }
            column += 1
        }
        return false
    }
    
    func diagnoleCheck(player: String, coor: [Int]) -> Bool {
        var diaC = coor[0]
        var diaR = coor[1]
        var found = 0
        while diaC >= 0 && diaR >= 0  && gameBoard[diaC][diaC] == player {
            found += 1
            if found == size {
                return true
            }
            diaC -= 1
            diaR -= 1
        }
        if found > 0 {
            found -= 1
        }
        diaC = coor[0]
        diaR = coor[1]
        while diaC < size && diaR < size  && gameBoard[diaC][diaC] == player {
            found += 1
            if found == size {
                return true
            }
            diaC += 1
            diaR += 1
        }
        
        // check diagnol up
        diaC = coor[0]
        diaR = coor[1]
        found = 0
        while diaC >= 0 && diaR < size  && gameBoard[diaC][diaR] == player {
            found += 1
            if found == size {
                return true
            }
            diaC -= 1
            diaR += 1
        }
        diaC = coor[0]
        diaR = coor[1]
        if found > 0 {
            found -= 1
        }
        while diaC < size && diaR >= 0  && gameBoard[diaC][diaR] == player {
            found += 1
            if found == size {
                return true
            }
            diaC += 1
            diaR -= 1
        }
        
        return false
    }
    
    
    
}
