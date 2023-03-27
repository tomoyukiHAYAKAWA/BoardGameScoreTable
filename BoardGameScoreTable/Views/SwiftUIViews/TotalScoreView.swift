import SwiftUI

struct TotalScoreView: View {
    @EnvironmentObject var viewModel: ScoreTableViewModel
    var body: some View {
        VStack(spacing: 3) {
            Rectangle()
                .foregroundColor(.black)
                .frame(height: 4)
            HStack(spacing: 0) {
                ForEach(0 ..< viewModel.playerNumber, id: \.self) { index in
                    Text("\(viewModel.totalScores[index])")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(Player.init(rawValue: index)!.darkColor))
                        .frame(width: UIScreen.main.bounds.width / CGFloat(viewModel.playerNumber), height: 70)
                }
            }
        }
    }
}

struct TotalScoreView_Previews: PreviewProvider {
    static var previews: some View {
        TotalScoreView().environmentObject(ScoreTableViewModel(playerNumber: 3))
    }
}
