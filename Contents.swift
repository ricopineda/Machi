//: Playground - noun: a place where people can play

import UIKit

import UIKit



struct Card {
    var Color: String
    var Roll: Int
}

class Deck {
    var cards: [Card] = []
    
    init() {
        for _ in 1...10{
            cards.append(Card(Color: "Blue", Roll: Int(arc4random_uniform(2)+1)))
            cards.append(Card(Color: "Red", Roll: Int(arc4random_uniform(2)+3)))
            cards.append(Card(Color: "Green", Roll: Int(arc4random_uniform(3)+4)))
        }
    }
    
    func deal() -> Card {
        return cards.remove(at: 0)
    }
    
    func isEmpty() -> Bool {
        //        if cards.count == 0{
        //            return true
        //        }
        //        else{
        //            return false
        //}
        // another way to write the above code
        return cards.count == 0
        
    }
    
    func shuffle() {
        for _ in  0...30{
            let random1: Int = Int(arc4random_uniform(UInt32(cards.count)))
            let random2: Int = Int(arc4random_uniform(UInt32(cards.count)))
            let temp: Card = cards[random1]
            cards[random1] = cards[random2]
            cards[random2] = temp
        }
        
    }
}

class Player: Deck {
    var name: String
    var hand: [Card] = []
    var coin: Int = 0
    
    init(name: String){
        self.name = name
    }
    func draw(deck: Deck) -> Card {
        let playerCard = deck.deal()
        hand.append(playerCard)
        return playerCard
    }
    func rollDice() -> Int{
        return Int(arc4random_uniform((6)) + 1)
    }
    func matchingCards(color: String, roll: Int) ->Int{
        var count = 0
        for card in hand{
            if color == card.Color && roll == card.Roll{
                count += 1
              
                
            }
        }
        return count
    }
}

class Game {
    var players: [Player] = []
    var deck: Deck = Deck()
    var turnIdx: Int = 0
    
    init(){
        players.append(Player(name: "Mike"))
        players.append(Player(name: "Sydney"))
        players.append(Player(name: "Blake"))
        players.append(Player(name: "Tiffany"))
        deck = Deck()
        deck.shuffle()
    }
    func playGame() {
        while !deck.isEmpty(){
            takeTurn(player: &players[turnIdx])
            turnIdx += 1
            if players.count == turnIdx{
                turnIdx = 0
            }
        }
        announceWinner()
    }
    func takeTurn(player: inout Player){
        let roll: Int = player.rollDice()
        var count: Int = player.matchingCards(color: "Green", roll: roll)
        player.coin += count * 2
        for p in players{
            count = p.matchingCards(color: "Blue", roll: roll)
            p.coin += count
        }
        for r in players{
            count = r.matchingCards(color: "Red", roll: roll)
            while count != 0 {
                if player.coin != 0 {
                    player.coin -= count
                    r.coin += count
                    count -= 1
                    
                }
                else{
                    break
                }
            }
        }
//        print (player.name, player.coin)
        player.draw(deck:deck)
    }
    func announceWinner(){
        var winner: Player = players[0]
        for i in 1..<players.count{
            if winner.coin < players[i].coin{
                winner = players[i]
            
            }
            
        }
        print(winner.name)
    }
}



var newGame: Game = Game()
newGame.playGame()


























