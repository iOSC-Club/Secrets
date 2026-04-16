import SwiftUI

struct ActiveSecretGenerationView: View {
    let generation: ActiveSecretGeneration

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(generation.title)
                    .font(.headline)

                Text("Generating secret...")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            ProgressView(value: generation.progress)
                .bold()

            Text(generation.progressText)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            #warning("TO DO: Animation to be added.")
            // MARK: TO BE ADDED - Animation
            Text(generation.revealedText)
                .font(.body.monospaced())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}
