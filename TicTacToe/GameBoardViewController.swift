//
//  GameBoardViewController.swift
//  TicTacToe
//
//  Created by Aries Lam on 4/27/22.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    var player1 = ""
    var player2 = ""
    var size = 0.0
    var xMove = 1
    var playerMove = Array<Array<String>>()
    var mappingTagToCoordinate = [Int: (Int, Int)]()
    @IBOutlet weak var gameBoardView: UIView!
    @IBOutlet weak var anounceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anounceLabel.text = "\(player1)'s turn!"
        gameBoardView.backgroundColor = .white
        view.addSubview(gameBoardView)
        createUI()

    }
    
    
    func createUI() {
        let buffer = 3.0
        let totalW = gameBoardView.frame.width - (buffer * (size - 1))
        let btnSide = totalW / size
        var tag = 0
        for col in 0..<Int(size) {
            let c = Double(col)
            let y = (btnSide * c) + (buffer * c)
            var tempArray = Array<String>()
            for r in 0..<Int(size) {
                let j = Double(r)
                let x = (btnSide * j) + (buffer * j)
                let btn = makeBtn(x: x, y: y, side: btnSide)
                btn.tag = tag
                mappingTagToCoordinate[tag] = (r, col)
                tag += 1
                btn.setTitle("", for: .normal)
                tempArray.append("nil")
            }
            playerMove.append(tempArray)
        }
    }
    
    func makeRow(y : CGFloat) -> [UIButton] {
        return [UIButton]()
    }
    
    func makeBtn(x : CGFloat, y: CGFloat, side: CGFloat) -> UIButton {
        let r = CGRect(x: x, y: y, width: side, height: side)
        let btn = UIButton(type: .system)
        btn.frame = r
        btn.backgroundColor = .black
        
        gameBoardView.addSubview(btn)
        
//        
//        btn.addTarget(self,
////                      action: #selector(doGameBtn),
//                      for: .touchUpInside)
        return btn
    }
    
//    @objc func doGameBtn(sender : UIButton) {
//        sender.isEnabled = false
//        let coor = (mappingTagToCoordinate[sender.tag][0], mappingTagToCoordinate[sender.tag][1])
//        if xMove > 0 {
//            sender.setTitle("X", for: .normal)
//            sender.setTitleColor(.blue, for: .normal)
//            sender.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//            anounceLabel.text = "\(player2) turn!"
//            playerMove[coor[0], coor[1]] = "X"
//        } else {
//            sender.setTitle("O", for: .normal)
//            sender.setTitleColor(.red, for: .normal)
//            sender.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//            anounceLabel.text = "\(player1) turn!"
//            playerMove[coor[0], coor[1]] = "X"
//        }
//        xMove *= -1
//    }

}
