import Foundation

struct PlayingCardDeck
{
    var cards = [PlayingCard]()
   
    init()
    {
        for suit in PlayingCard.Suit.all
        {
            for rank in PlayingCard.Rank.all
            {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
        cards.shuffle()
        cards.shuffle()
    }
    
    //player 1 initial deck of cards
      var deck1: [PlayingCard]
    {
        get
        {
            var deck = [PlayingCard]()
            for index in 0..<cards.count/2
            {
                deck.append(cards[index])
            }
            return deck
        }
        set{}
    }
    

    
    //player 2 initial deck of cards
     var deck2: [PlayingCard]
    {
        get
        {
            var deck = [PlayingCard]()
            for index in cards.count/2..<cards.count
            {
                deck.append(cards[index])
            }
            return deck
        }
        set
        {
            
        }
    }
    
    //mutating function to draw 1 card randomly from a deck of card
    mutating func draw(_ deck: inout [PlayingCard])-> PlayingCard?
    {
        if deck.count > 0
        {
           return deck.remove(at: deck.count.arc4random)
        }
        else
        {
            return nil
        }
    }
}

extension Int
{
    var arc4random: Int
    {
        if self>0
        {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self<0
        {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else
        {
            return 0
        }
    }
}
