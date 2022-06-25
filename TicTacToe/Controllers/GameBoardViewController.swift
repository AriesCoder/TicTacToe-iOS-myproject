//
//  GameBoardViewController.swift
//  TicTacToe
//
//  Created by Aries Lam on 4/27/22.
//

import UIKit
import RealmSwift

class GameBoardViewController: UIViewController {
    
    var realm = try! Realm()
    var players : Results<Player>?
    var player1 = Player()
    var player2 = Player()
    var size = 3.0
    var xMove = 1
    var gameLogic = GameLogic()
    var win = false
    @IBOutlet weak var gameBoardView: UIView!
    @IBOutlet weak var anounceLabel: UILabel!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(gameBoardView)
        createGameBoardUI()
        buttonUI()
        loadData()
        saveData(player: player1)
        saveData(player: player2)
        navigationController?.navigationBar.tintColor = .white
    }
    //MARK: - UI setting
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
        gameLogic.setGameBoard(boardGameSize: Int(size))
        
        anounceLabel.text = "\(player1.name)'s turn!"
        
        let buffer = 3.0
        print("gameboardSize", gameBoardView.frame.width)
        let totalW = gameBoardView.frame.width - (buffer * (size - 1))
        print("totalW", totalW)
        let btnSide = totalW / size
        var tag = 0
        for col in 0..<Int(size) {
            let c = Double(col)
            let y = (btnSide * c) + (buffer * c)
            for r in 0..<Int(size) {
                let j = Double(r)
                let x = (btnSide * j) + (buffer * j)
                print("size X", x)
                print("btnSize", btnSide)
                let btn = makeBtn(x: x, y: y, side: btnSide)
                btn.tag = tag
                gameLogic.setMappingTagToCoordinate(tag: tag, coor: [col, r])
                tag += 1
                btn.setTitle("", for: .normal)
            }
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
    
    //MARK: - game moves
    @objc func doGameBtn(sender : UIButton) {
        print("sender move: " + String(sender.tag))
        if win{
            return
        }
        else{
            if xMove > 0 {
                sender.setTitle("X", for: .normal)
                sender.setTitleColor(.blue, for: .normal)
                sender.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .bold)
                anounceLabel.text = "\(player2.name)'s turn!"
                if gameLogic.playerMove(player: "X", tag: sender.tag) {
                    anounceLabel.text = "\(player1.name) win"
                    win = true
//                    for player in players!{
//                        if player.name == player1.name{
//                            updateScore(player: player)
//                        }
//                    }
                    if let player = players?[1]{
                            updateScore(player: player)
                        }
                }
            } else {
                sender.setTitle("O", for: .normal)
                sender.setTitleColor(.red, for: .normal)
                sender.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .bold)
                anounceLabel.text = "\(player1.name)'s turn!"
                if gameLogic.playerMove(player: "O", tag: sender.tag) {
                    anounceLabel.text = "\(player2.name) win"
                    win = true
                    if let player = players?.first{
                        updateScore(player: player)
                    }
                }
            }
        }
        
        sender.isEnabled = false
        
        xMove *= -1
    }
    
    //MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            if let result = segue.destination as? ResultTableViewController{
                result.players = players
                
            }
        }
    }
    //MARK: - save, load and update data
    func updateScore(player: Player){
        do{
            try realm.write({
                player.score += 1
                
            })
        }catch{
            print("Error saving player's data \(error)")
        }
    }
    
    func saveData(player: Player){
        do{
            try! realm.write({
                realm.add(player)
            })
        }
    }
    
    func loadData(){
        players = realm.objects(Player.self).sorted(byKeyPath: "dateCreated", ascending: false)
    }

     
    //MARK: - restarting game

    @IBAction func restartBtnPressed(_ sender: Any) {
        gameLogic.reset()
        createGameBoardUI()
        xMove = 1
        win = false
    }
    
}
