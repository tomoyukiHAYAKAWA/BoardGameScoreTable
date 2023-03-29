import SwiftUI

struct PlayersView: View {
    var playerNumber: Int
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(0 ..< playerNumber, id: \.self) { index in
                    ZStack {
                        Image(Player(rawValue: index)!.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / CGFloat(playerNumber), height: 50)
                        HStack(spacing: 0) {
                            if 0 < index  {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .frame(width: 1, height: 67)
                            }
                            Spacer()
                            if index < playerNumber - 1 {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .frame(width: 1, height: 67)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, playerNumber == 1 ? 9 : 0)
            Rectangle()
                .foregroundColor(.black)
                .frame(height: 3)
        }
        .background(Color(UIColor(red: 0.93, green: 0.86, blue: 0.70, alpha: 0.5)))
    }
}

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(playerNumber: 3)
    }
}
