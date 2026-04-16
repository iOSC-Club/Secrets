import SwiftUI

struct SecretsListView: View {
    @ObservedObject var viewModel: SecretsViewModel

    var body: some View {
        List {
            if let generation = viewModel.activeGeneration {
                Section("Generating") {
                    ActiveSecretGenerationView(generation: generation)
                }
            }

            if !viewModel.secrets.isEmpty {
                Section("Generated Secrets") {
                    ForEach(viewModel.secrets) { secret in
                        SecretRowView(secret: secret)
                    }
                }
            }

            if viewModel.hasGeneratedAllSecrets {
                Section {
                    Text("All 25 sample secrets have been generated.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .listStyle(.insetGrouped)
        
        #warning("TO DO: Add animation here.")
    }
}
