import SwiftUI

struct SecretsHomeView: View {
    @StateObject private var viewModel = SecretsViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isShowingEmptyState {
                    EmptySecretsView()
                } else {
                    SecretsListView(viewModel: viewModel)
                }
            }
            .navigationTitle("🤫 Secrets")
            .safeAreaBar(edge: .bottom) {
                Button("Generate Secret", systemImage: "plus", action: viewModel.startNextSecretGeneration)
                    .buttonStyle(.borderedProminent)
                    .disabled(!viewModel.canGenerateMoreSecrets)
                    .padding()
            }
        }
    }
}
