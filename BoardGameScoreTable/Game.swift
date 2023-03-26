import Foundation

struct Game {

    var playDate: Date
    var playersCount: Int
    var totalScores: [Int]
    var playersScore: [[Int]]

    init(
        playDate: Date,
        playersCount: Int,
        totalScores: [Int],
        playersScore: [[Int]]
    ) {
        self.playDate = playDate
        self.playersCount = playersCount
        self.totalScores = totalScores
        self.playersScore = playersScore
    }
}
