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
    @IBOutlet weak var gameBoardView: UIView!
    @IBOutlet weak var anounceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anounceLabel.text = "\(player1) turn!"
        gameBoardView.backgroundColor = .black
        view.addSubview(gameBoardView)
        createUI()

    }
    
    
    func createUI() {
        let buffer = 3.0
        let totalW = gameBoardView.frame.width - (buffer * (size - 1))
        let btnW = totalW / size
        var tag = 0
        for col in 0..<Int(size) {
            let c = Double(col)
            let b = (btnW * c) + (buffer * c)
            for r in 0..<Int(size) {
                let j = Double(r)
                let x = (btnW * j) + (buffer * j)
                let btn = makeBtn(x: x, buffer: b, btnW: btnW)
                btn.tag = tag
                tag += 1
                btn.setTitle("", for: .normal)
            }
        }
    }
    
    func makeRow(y : CGFloat) -> [UIButton] {
        return [UIButton]()
    }
    
    func makeBtn(x : CGFloat, buffer: CGFloat, btnW: CGFloat) -> UIButton {
        let r = CGRect(x: x, y: buffer, width: btnW, height: btnW)
        let btn = UIButton(type: .system)
        btn.frame = r
        btn.backgroundColor = .white
        
        gameBoardView.addSubview(btn)
        
        
        btn.addTarget(self,
                      action: #selector(doGameBtn),
                      for: .touchUpInside)
        print("btn")
        return btn
    }
    @objc func doGameBtn(sender : UIButton) {
//        let btnTag = sender.tag
        sender.isEnabled = false
        if xMove > 0 {
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.blue, for: .normal)
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            anounceLabel.text = "\(player2) turn!"
        } else {
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.red, for: .normal)
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            anounceLabel.text = "\(player1) turn!"
        }
        xMove *= -1
    }

}
