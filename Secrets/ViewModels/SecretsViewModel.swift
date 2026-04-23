import Foundation
import Combine
import SwiftUI

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

        Task { [weak self] in
            guard let self else {
                return
            }

            let secret = await self.generationService.generate(from: nextSeed) { [weak self] progress in
                guard let self else {
                    return
                }
            }
            
            #warning("Add animation")
            self.activeGeneration = nil
        }
    }

    private var nextSeed: SecretSeed? {
        let generatedTitles = Set(secrets.map(\.title))
        let remainingSeeds = SecretSeedLibrary.all.filter { !generatedTitles.contains($0.title) }

        return remainingSeeds.randomElement()
    }
}
