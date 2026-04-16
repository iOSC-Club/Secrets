import SwiftUI

struct EmptySecretsView: View {
    var body: some View {
        ContentUnavailableView(
            "No Secrets Yet",
            systemImage: "sparkles.rectangle.stack",
            description: Text("Generate your first sample secret to populate the vault.")
        )
    }
}
