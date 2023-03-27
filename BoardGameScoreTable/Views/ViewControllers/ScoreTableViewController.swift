import UIKit
import SwiftUI
import Combine

final class ScoreTableViewController: UIViewController {

    @IBOutlet private weak var scoreTableView: UICollectionView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var playersView: UIView!
    @IBOutlet private weak var totalScoreView: UIView!

    private var viewModel: ScoreTableViewModel?

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = viewModel else { return }

        navigationItem.title = "得点表"

        setupCollectionView()
        updatePlayersView()
        updateTotalScoreView(scores: viewModel.totalScores)

        addButton.publisher(for: .touchUpInside)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self,
                      let viewModel = self.viewModel else { return }
                viewModel.addTableRows()
                self.scoreTableView.reloadData()
            })
            .store(in: &cancellables)

        viewModel.showInputErrorMessage
            .sink(receiveValue: { _ in
                let inputErrorMessage: UIAlertController = UIAlertController(title:"エラー",
                                                                           message: "整数(半角)を入力してください",
                                                                           preferredStyle: .alert)
                let closeAction: UIAlertAction = UIAlertAction(title: "閉じる", style: .default)
                inputErrorMessage.addAction(closeAction)
                DispatchQueue.main.async {
                    self.present(inputErrorMessage, animated: true)
                }
            })
            .store(in: &cancellables)

    }

    class func instantiate(viewModel: ScoreTableViewModel) -> ScoreTableViewController {
        let storyBoard = UIStoryboard(name: "ScoreTable", bundle: nil)
        let vc = storyBoard.instantiateInitialViewController() as! ScoreTableViewController
        vc.viewModel = viewModel
        return vc
    }

    private func setupCollectionView() {
        scoreTableView.dataSource = self
        scoreTableView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")

        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 0
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / CGFloat(viewModel?.playerNumber ?? 1), height: 60.0)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        scoreTableView.collectionViewLayout = flowLayout
    }

    private func updatePlayersView() {
        let vc = UIHostingController(rootView: PlayersView(playerNumber: viewModel?.playerNumber ?? 1))
        self.addChild(vc)
        playersView.addSubview(vc.view)
        vc.didMove(toParent: self)

        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: self.self.playersView.topAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: self.playersView.trailingAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: self.playersView.bottomAnchor).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: self.playersView.leadingAnchor).isActive = true
    }

    private func updateTotalScoreView(scores: [Int]) {
        guard let viewModel = viewModel else { return }
        let vc = UIHostingController(rootView:
                                        TotalScoreView().environmentObject(viewModel)
        )
        self.addChild(vc)
        totalScoreView.addSubview(vc.view)
        vc.didMove(toParent: self)

        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: self.self.totalScoreView.topAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: self.totalScoreView.trailingAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: self.totalScoreView.bottomAnchor).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: self.totalScoreView.leadingAnchor).isActive = true
    }
}

extension ScoreTableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.tableViewRows
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let rowCount = indexPath.item / viewModel.playerNumber
        let player = indexPath.item % viewModel.playerNumber
        let isOddRow = rowCount % 2 == 0
        cell.contentConfiguration = UIHostingConfiguration(content: {
            Text("\(viewModel.scores[indexPath.item])")
                .font(.system(size: 20))
        })
        cell.backgroundColor = isOddRow ? Player.init(rawValue: player)?.paleColor : Player.init(rawValue: player)?.darkColor
        return cell
    }
}

extension ScoreTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let rowCount = indexPath.item / viewModel.playerNumber
        let player = indexPath.item % viewModel.playerNumber
        print("\(rowCount + 1)列目のPlayer\(player + 1)")
        var alertTextField: UITextField?
        let alert = UIAlertController(
            title: "得点を入力してください",
            message: "整数(半角)のみ入力可",
            preferredStyle: .alert
        )
        alert.addTextField(configurationHandler: { textField in
            alertTextField = textField
        })
        alert.addAction(
            UIAlertAction(
                title: "決定",
                style: .default,
                handler: { _ in
                    if let inputScore = alertTextField?.text {
                        Task {
                            await viewModel.inputPlayerScore(index: indexPath.item, score: inputScore)
                            collectionView.reloadData()
                        }

                    }
                }
            )
        )
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .cancel
            )
        )
        present(alert, animated: true)
    }
}

extension ScoreTableViewController: UITextFieldDelegate {}
