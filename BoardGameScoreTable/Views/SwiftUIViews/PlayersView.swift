import SwiftUI

struct PlayersView: View {
    var playerNumber: Int
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< playerNumber, id: \.self) { index in
                Text("Player\(index+1)")
                    .frame(width: UIScreen.main.bounds.width / CGFloat(playerNumber))
            }
            Spacer()
        }
    }
}

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(playerNumber: 3)
    }
}
