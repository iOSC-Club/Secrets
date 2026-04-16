import SwiftUI

struct SecretRowView: View {
    let secret: Secret

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(secret.title)
                .font(.headline)

            Text(secret.body)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 4)
    }
}
