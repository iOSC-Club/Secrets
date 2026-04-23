import Foundation

@MainActor
final class SecretGenerationService {
    private let minimumGenerationDuration: TimeInterval

    init(minimumGenerationDuration: TimeInterval = 15) {
        self.minimumGenerationDuration = minimumGenerationDuration
    }

    func generate(
        from seed: SecretSeed,
        onProgress: @escaping @MainActor (ActiveSecretGeneration) async -> Void
    ) async -> Secret {
        let characters = Array(seed.body)
        var revealedText = ""

        await onProgress(
            ActiveSecretGeneration(
                title: seed.title,
                revealedText: revealedText,
                totalCharacterCount: characters.count
            )
        )

        let delays = delaysForCharacterReveal(count: characters.count)

        for (character, delay) in zip(characters, delays) {
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            revealedText.append(character)

            await onProgress(
                ActiveSecretGeneration(
                    title: seed.title,
                    revealedText: revealedText,
                    totalCharacterCount: characters.count
                )
            )
        }

        return Secret(title: seed.title, body: seed.body)
    }

    private func delaysForCharacterReveal(count: Int) -> [TimeInterval] {
        guard count > 0 else {
            return []
        }

        let weights = (0..<count).map { _ in Double.random(in: 0.35...1.75) }
        let totalWeight = weights.reduce(0, +)

        return weights.map { weight in
            minimumGenerationDuration * (weight / totalWeight)
        }
    }
}
