import UIKit

enum Player: Int {
    case player1 = 0
    case player2
    case player3
    case player4
    case player5
    case player6

    var image: String {
        switch self {
        case .player1: return "PlayerRed"
        case .player2: return "PlayerBlue"
        case .player3: return "PlayerGreen"
        case .player4: return "PlayerYellow"
        case .player5: return "PlayerOrange"
        case .player6: return "PlayerPurple"
        }
    }

    var darkColor: UIColor {
        switch self {
        case .player1: return UIColor(red: 0.75, green: 0.24, blue: 0.25, alpha: 1.0)
        case .player2:
            return UIColor(red: 0.54, green: 0.65, blue: 0.8, alpha: 1.0)
        case .player3:
            return UIColor(red: 0.43, green: 0.81, blue: 0.32, alpha: 1.0)
        case .player4:
            return UIColor(red: 0.81, green: 0.8, blue: 0.33, alpha: 1.0)
        case .player5:
            return UIColor(red: 0.77, green: 0.52, blue: 0.28, alpha: 1.0)
        case .player6:
            return UIColor(red: 0.60, green: 0.25, blue: 0.79, alpha: 1.0)
        }
    }

    var paleColor: UIColor {
        switch self {
        case .player1: return UIColor(red: 0.75, green: 0.24, blue: 0.25, alpha: 0.7)
        case .player2:
            return UIColor(red: 0.54, green: 0.65, blue: 0.8, alpha: 0.7)
        case .player3:
            return UIColor(red: 0.43, green: 0.81, blue: 0.32, alpha: 0.7)
        case .player4:
            return UIColor(red: 0.81, green: 0.8, blue: 0.33, alpha: 0.7)
        case .player5:
            return UIColor(red: 0.77, green: 0.52, blue: 0.28, alpha: 0.7)
        case .player6:
            return UIColor(red: 0.60, green: 0.25, blue: 0.79, alpha: 0.7)
        }
    }
}
