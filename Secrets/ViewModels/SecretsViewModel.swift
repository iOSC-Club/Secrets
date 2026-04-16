import Foundation
import Combine

@MainActor
final class SecretsViewModel: ObservableObject {
    private let generationService: SecretGenerationService

    @Published var secrets: [Secret]
    @Published var activeGeneration: ActiveSecretGeneration?

    init() {
        self.generationService = SecretGenerationService()
        self.secrets = []
    }

    var isShowingEmptyState: Bool {
        secrets.isEmpty && activeGeneration == nil
    }

    var isGeneratingFirstSecret: Bool {
        secrets.isEmpty && activeGeneration != nil
    }

    var canGenerateMoreSecrets: Bool {
        activeGeneration == nil && nextSeed != nil
    }

    var hasGeneratedAllSecrets: Bool {
        secrets.count == SecretSeedLibrary.all.count && activeGeneration == nil
    }

    func startNextSecretGeneration() {
        guard activeGeneration == nil, let nextSeed else {
            return
        }

        Task {
            let secret = await generationService.generate(from: nextSeed) { [weak self] progress in
                self?.activeGeneration = progress
            }

            activeGeneration = nil
            secrets.insert(secret, at: 0)
        }
    }

    private var nextSeed: SecretSeed? {
        let generatedTitles = Set(secrets.map(\.title))
        let remainingSeeds = SecretSeedLibrary.all.filter { !generatedTitles.contains($0.title) }

        return remainingSeeds.randomElement()
    }
}
