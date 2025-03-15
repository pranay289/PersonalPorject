import SwiftUI

struct ContentView: View {
    @EnvironmentObject var setupAppTheme: SetupAppTheme
    @Environment(\.colorScheme) var colorScheme
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                List {
                    ForEach(
                        [
                            MenuItem(
                                url: "https://picsum.photos/200",
                                title: "The standard Lorem Ipsum passage",
                                description:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.ut aliquip ex ea commodoLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequatut aliquip ex ea commodoLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                                id: 0),
                            MenuItem(
                                url: "https://picsum.photos/200",
                                title: "The standard Lorem Ipsum passage",
                                description:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                id: 1),
                            MenuItem(
                                url: "https://picsum.photos/200",
                                title: "The standard Lorem Ipsum passage",
                                description:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                id: 2),
                            MenuItem(
                                url: "https://picsum.photos/200",
                                title: "The standard Lorem Ipsum passage",
                                description:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                id: 3),
                            MenuItem(
                                url: "https://picsum.photos/200",
                                title: "The standard Lorem Ipsum passage",
                                description:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                id: 4),
                            MenuItem(
                                url: "https://picsum.photos/200",
                                title: "The standard Lorem Ipsum passage",
                                description:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                id: 5),
                            MenuItem(
                                url: "https://picsum.photos/200",
                                title: "The standard Lorem Ipsum passage",
                                description:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                id: 6),
                        ]) {
                            data in
                            ListCommonView(
                                menuItem: data
                            ).listRowSeparator(.hidden).gesture(
                                TapGesture().onEnded({
                                    path.append(data)

                                })
                            ).listRowInsets(
                                .init(
                                    top: 0.0, leading: 0.0, bottom: 30,
                                    trailing: 0.0
                                ))

                        }
                }.listStyle(.plain)

                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        .linearGradient(
                            colors: [.indigo, .mint],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                Toggle(isOn: $setupAppTheme.isDarkMode) {
                    Text("Dark mode")
                }

                Button(
                    action: {
                        //                    path.append("Detail")
                        setupAppTheme.changeAppTheme()

                    },
                    label: {
                        NavigationLink(destination: ValorentScreen()) {
                            Text("Navigate").frame(maxWidth: .infinity)
                                .padding()
                        }.buttonStyle(.borderedProminent)

                    })
            }  // Define the destinations for the path values inside the NavigationStack
            .navigationDestination(for: MenuItem.self) { data in
                DetailsView(
                    title: data.title, descrption: data.description,
                    imageUrl: data.url
                )
            }
            .navigationTitle("Home")

        }.onAppear {
            if let savedTheme = UserDefaults.standard.value(
                forKey: "isDarkMode") as? Bool
            {
                setupAppTheme.isDarkMode = savedTheme
            }
            print("**** APPREAD ********")
        }
        .onDisappear {
            print("**** Disappear ********")
        }.task({
            print("**** task ********")
        }).preferredColorScheme(setupAppTheme.isDarkMode ? .dark : .light)
        //        NavigationStack(path: $path) {
        //            VStack {
        //                List {
        //                    ForEach([
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                        IdentifiableString(id: "1", value: "First"),
        //                        IdentifiableString(id: "2", value: "Second"),
        //                    ]) {
        //
        //                        data in
        //
        //                        Text(data.value).listRowSeparator(.hidden).overlay {
        //                            NavigationLink(
        //                                destination: Second(data: data.value)
        //                            ) {
        //                                Text("")
        //                            }
        //                        }
        //
        //                    }
        //
        //                }.listStyle(.plain)
        //
        //                Button(action: {
        //                    path.append("Third")
        //                }) {
        //                    Text("Navigate").frame(minWidth: 0, maxWidth: .infinity)
        //                        .padding(10)
        //
        //                }.buttonStyle(.borderedProminent).padding(.horizontal, 20)
        //
        //            }.navigationTitle("Home").fontWeight(.light)
        //                .toolbar {
        //                    ToolbarItem(placement: .primaryAction) {
        //                        Menu {
        //                            Button(action: {}) {
        //                                Label("Create a file", systemImage: "doc")
        //                            }
        //
        //                            Button(action: {}) {
        //                                Label("Create a folder", systemImage: "folder")
        //                            }
        //                        } label: {
        //                            Label("Add", systemImage: "ellipsis.circle")
        //                        }
        //                    }
        //                }
        //        }.navigationDestination(for: String.self){
        //            value in
        //            switch value {
        //            case "Third":
        //                MyThirdView()
        //            default :
        //                EmptyView()
        //            }
        //        }
    }
}

struct MyThirdView: View {
    @State var count: Int = 0
    var body: some View {

        VStack {

            Text("\(count)")
            Button("Update") {
                count += 1
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(SetupAppTheme())
}
