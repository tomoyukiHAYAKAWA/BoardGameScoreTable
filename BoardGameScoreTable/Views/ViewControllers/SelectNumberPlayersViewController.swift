import UIKit
import UIKit
import Combine

// アイディアメモ
// ・ゲームマスターが一人で入力する、プレイヤーが個人で入力するみたいなモードをつけたい

final class SelectNumberPlayersViewController: UIViewController {

    private let viewModel = SelectNumberPlayersViewModel()

    @IBOutlet private weak var picker: UIPickerView!
    @IBOutlet private weak var confirmButton: UIButton!

    private var choosePlayerNumber: Int = 1
    private let playerNumbers: [Int] = [Int](1...6)
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        picker.dataSource = self
        picker.delegate = self

        confirmButton.publisher(for: .touchUpInside)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                let vc = ScoreTableViewController.instantiate(
                    viewModel: ScoreTableViewModel(playerNumber: self.choosePlayerNumber)
                )
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .store(in: &cancellables)

    }
}

// MARK: - UIPickerViewDelegate
extension SelectNumberPlayersViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choosePlayerNumber = playerNumbers[row]
    }

}

// MARK: - UIPickerViewDataSource
extension SelectNumberPlayersViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playerNumbers.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return playerNumbers[row].description
    }
}
