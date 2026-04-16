import Foundation

struct ActiveSecretGeneration {
    let title: String
    let revealedText: String
    let totalCharacterCount: Int

    var progress: Double {
        guard totalCharacterCount > 0 else {
            return 0
        }

        return Double(revealedText.count) / Double(totalCharacterCount)
    }

    var progressText: String {
        "\(revealedText.count) of \(totalCharacterCount) characters generated"
    }
}
