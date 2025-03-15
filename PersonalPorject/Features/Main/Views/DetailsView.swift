import SwiftUI

struct DetailsView: View {
    var title: String
    var descrption: String
    var imageUrl: String

    var body: some View {

        VStack(alignment: .leading) {

            AsyncImage(url: URL(string: imageUrl)) {
                image in
                switch image {
                case .success(let image):
                    image.resizable().frame(height: 200)
                default:
                    Image(systemName: "photo")

                }
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(title).font(.system(size: 18))
                        .fontWeight(.bold).fontDesign(.serif)

                    Text(descrption).font(.system(size: 14)).fontDesign(.serif)
                }
            }

        }
    }
}
