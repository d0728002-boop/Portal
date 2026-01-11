import SwiftUI

// MARK: - Update Banner View
/// Displays a banner at the top of the screen when an update is available
struct UpdateBannerView: View {
    let version: String
    let message: String
    let onDismiss: () -> Void
    let onUpdate: () -> Void
    
    @State private var isVisible = true
    
    var body: some View {
        if isVisible {
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    // Update icon
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 36, height: 36)
                        
                        Image(systemName: "arrow.down.circle.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(.blue)
                    }
                    
                    // Message
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Update Available")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                        
                        Text("\(message) (v\(version))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    // Update button
                    Button(action: {
                        onUpdate()
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            isVisible = false
                        }
                        HapticsManager.shared.success()
                    }) {
                        Text("Update")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color.blue)
                            )
                    }
                    
                    // Dismiss button
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            isVisible = false
                        }
                        onDismiss()
                        HapticsManager.shared.softImpact()
                    }) {
                        Image(systemName: "xmark")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                            .frame(width: 28, height: 28)
                            .background(
                                Circle()
                                    .fill(Color(UIColor.tertiarySystemBackground))
                            )
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(UIColor.secondarySystemBackground),
                                    Color(UIColor.tertiarySystemBackground)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .strokeBorder(Color.blue.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 6)
                )
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
            .transition(.asymmetric(
                insertion: .move(edge: .top).combined(with: .opacity),
                removal: .move(edge: .top).combined(with: .opacity)
            ))
        }
    }
}

// MARK: - Preview
#if DEBUG
struct UpdateBannerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UpdateBannerView(
                version: "1.2.0",
                message: "New features and bug fixes",
                onDismiss: {},
                onUpdate: {}
            )
            Spacer()
        }
        .background(Color(UIColor.systemBackground))
    }
}
#endif
