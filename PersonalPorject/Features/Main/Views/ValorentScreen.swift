import SwiftUI

struct ValorentScreen: View {
    @StateObject var valorentObject = ValorentViewModel()
    var body: some View {
        VStack {
            switch valorentObject.apiState {
            case .isLoading:
                ProgressView()
            case .succucs(data: let valorentData):
                if (valorentData?.data ?? []).isEmpty {
                    EmptyView()
                } else {
                    List {
                        ForEach(valorentData?.data ?? []) {
                            valorentData in

                            Text("\(valorentData.developerName ?? "")")

                        }
                    }
                }
            case .isError(message: let error):
                Text("Error \(error)")

            }

            //            else {
            //                if (valorentObject.jsonDataModel.data ?? []).isEmpty {
            //                    EmptyView()
            //                }
            //                List {
            //                    ForEach(valorentObject.jsonDataModel.data ?? []) {
            //                        valorentData in
            //
            //                        Text("\(valorentData.developerName ?? "")")
            //
            //                    }
            //                }
            //            }
        }.task {
            print("*** task *** ")
            valorentObject.getValorentAgentsAlamoFireStore()

            print("*** Completed *** ")

        }.onDisappear {
            print("*** onDisappear *** ")
        }

    }
}
#Preview("from getValueAsync") {
    ValorentScreen()
}
