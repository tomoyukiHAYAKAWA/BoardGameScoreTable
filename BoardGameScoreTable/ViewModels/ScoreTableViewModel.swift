import Foundation
import Combine

// アイディアメモ
// ・プレイ日や遊んだゲームを入力して保存する
//      - プレイヤー名の入力
// ・得点が高い人から金、銀、銅の枠で囲むとかする

final class ScoreTableViewModel: ObservableObject {

    @Published var totalScores: [Int] = []
    private(set) var scores:[Int] = []
    private(set) var playerNumber: Int
    private(set) var tableViewRows: Int = 0

    private let showInputErrorMessageSubject = PassthroughSubject<Void, Never>()
    var showInputErrorMessage: AnyPublisher<Void, Never> {
        showInputErrorMessageSubject.eraseToAnyPublisher()
    }

    init(
        playerNumber: Int
    ) {
        self.playerNumber = playerNumber
        self.tableViewRows = playerNumber

        addScores()
        initTotalScores()

    }

    func inputPlayerScore(index: Int, score: String) async -> Void {
        if let score = Int(score) {
            scores[index] = score
            DispatchQueue.main.async {
                if index == 0 {
                    self.totalScores[0] += score
                } else {
                    let player = index % self.playerNumber
                    self.totalScores[player] += score
                }
            }
        } else {
            showInputErrorMessageSubject.send(())
        }
        return
    }

    func addTableRows() {
        tableViewRows += playerNumber
        addScores()
    }

    func countRows(index: Int) -> Int {
        return index / playerNumber
    }

    func playerColumn(index: Int) -> Int {
        return index % playerNumber
    }

    private func addScores() {
        for _ in 0 ..< playerNumber {
            scores.append(0)
        }
    }

    private func initTotalScores() {
        for _ in 0 ..< playerNumber {
            totalScores.append(0)
        }
    }

}
