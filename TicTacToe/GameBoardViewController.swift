//
//  GameBoardViewController.swift
//  TicTacToe
//
//  Created by Aries Lam on 4/27/22.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    var player1 = "Player 1"
    var player2 = "Player 2"
    var size = 3.0
    var xMove = 1
    var playerMove = Array<Array<String>>()
    var mappingTagToCoordinate = [Int: (Int, Int)]()
    @IBOutlet weak var gameBoardView: UIView!
    @IBOutlet weak var anounceLabel: UILabel!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anounceLabel.text = "\(player1)'s turn!"
        view.addSubview(gameBoardView)
        createGameBoardUI()
        buttonUI()
    }
    
    func buttonUI(){
        restartBtn.layer.cornerRadius = 10
        restartBtn.layer.borderColor = UIColor.white.cgColor
        restartBtn.layer.borderWidth = 3.0
        
        resultBtn.layer.cornerRadius = 10
        resultBtn.layer.borderColor = UIColor.white.cgColor
        resultBtn.layer.borderWidth = 3.0
    }
    
    func createGameBoardUI() {
        //glowing gameboardView
        gameBoardView.layer.shadowColor = UIColor.white.cgColor
        gameBoardView.layer.shadowOffset = .zero
        gameBoardView.layer.shadowRadius = 20.0
        gameBoardView.layer.shadowOpacity = 1.0
        gameBoardView.layer.masksToBounds = false
        gameBoardView.layer.shouldRasterize = true

        
        let buffer = 3.0
        print("gameboardSize", gameBoardView.frame.width)
        let totalW = gameBoardView.frame.width - (buffer * (size - 1))
        print("totalW", totalW)
        let btnSide = totalW / size
        var tag = 0
        for col in 0..<Int(size) {
            let c = Double(col)
            let y = (btnSide * c) + (buffer * c)
            var tempArray = Array<String>()
            for r in 0..<Int(size) {
                let j = Double(r)
                let x = (btnSide * j) + (buffer * j)
                print("size X", x)
                print("btnSize", btnSide)
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
        btn.addTarget(self, action: #selector(doGameBtn(sender:)), for: .touchUpInside)
        return btn
    }
    
    @objc func doGameBtn(sender : UIButton) {
        sender.isEnabled = false
//        let coor = (mappingTagToCoordinate[sender.tag][0], mappingTagToCoordinate[sender.tag][1])
        if xMove > 0 {
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.blue, for: .normal)
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .bold)
            anounceLabel.text = "\(player2)'s turn!"
//            playerMove[coor[0], coor[1]] = "X"
        } else {
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.red, for: .normal)
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .bold)
            anounceLabel.text = "\(player1)'s turn!"
//            playerMove[coor[0], coor[1]] = "X"
        }
        xMove *= -1
    }

}
