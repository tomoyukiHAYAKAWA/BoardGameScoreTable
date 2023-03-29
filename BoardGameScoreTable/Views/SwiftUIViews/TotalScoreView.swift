import SwiftUI

struct TotalScoreView: View {
    @EnvironmentObject var viewModel: ScoreTableViewModel
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.black)
                .frame(height: 3)
            HStack(spacing: 0) {
                ForEach(0 ..< viewModel.playerNumber, id: \.self) { index in
                    ZStack {
                        Text("\(viewModel.totalScores[index])")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(Player.init(rawValue: index)!.darkColor))
                            .frame(width: UIScreen.main.bounds.width / CGFloat(viewModel.playerNumber), height: 70)
                        HStack(spacing: 0) {
                            if 0 < index  {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .frame(width: 1, height: 70)
                            }
                            Spacer()
                            if index < viewModel.playerNumber - 1 {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .frame(width: 1, height: 70)
                            }
                        }
                    }
                }
            }
        }
        .background(Color(UIColor(red: 0.93, green: 0.86, blue: 0.70, alpha: 0.5)))
    }
}

struct TotalScoreView_Previews: PreviewProvider {
    static var previews: some View {
        TotalScoreView().environmentObject(ScoreTableViewModel(playerNumber: 3))
    }
}
