import SwiftUI

struct TotalScoreView: View {
    @EnvironmentObject var viewModel: ScoreTableViewModel
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.black)
                .frame(height: 1)
            HStack(spacing: 0) {
                ForEach(0 ..< viewModel.playerNumber, id: \.self) { index in
                    ZStack {
                        Text("\(viewModel.totalScores[index])")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(Player.init(rawValue: index)!.PlayerColor))
                            .frame(width: UIScreen.main.bounds.width / CGFloat(viewModel.playerNumber), height: 70)
                        HStack(spacing: 0) {
                            if 0 < index  {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .frame(width: 0.5, height: 70)
                            }
                            Spacer()
                            if index < viewModel.playerNumber - 1 {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .frame(width: 0.5, height: 70)
                            }
                        }
                    }
                }
            }
            Rectangle()
                .foregroundColor(.black)
                .frame(height: 1)
        }
    }
}

struct TotalScoreView_Previews: PreviewProvider {
    static var previews: some View {
        TotalScoreView().environmentObject(ScoreTableViewModel(playerNumber: 3))
    }
}
