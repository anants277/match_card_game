import Foundation

struct PlayingCard
{
    var suit: Suit
    var rank: Rank
    
    enum Suit: String
    {
        var description: String
        {
            return rawValue
        }
        
        case spades = "S"
        case diamonds = "D"
        case hearts = "H"
        case clubs = "C"
        static var all = [Suit.spades, Suit.diamonds, Suit.hearts, Suit.clubs]
    }
    
    enum Rank: String , CaseIterable
    {
        case one = "A"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5" 
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case jack = "J"
        case queen = "Q"
        case king = "K"
        
    static var all: [Rank]
    {
        var allRank: [Rank] = []
        for rank in self.allCases
        {
            allRank.append(rank)
        }
        return allRank
    }

    }
}
