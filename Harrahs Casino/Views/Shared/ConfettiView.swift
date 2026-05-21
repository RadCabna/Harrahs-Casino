import SwiftUI

struct ConfettiView: View {
    var isActive: Bool

    @State private var particles: [ConfettiParticle] = []

    var body: some View {
        TimelineView(.animation(minimumInterval: 1 / 30)) { timeline in
            Canvas { context, size in
                guard isActive else { return }
                let time = timeline.date.timeIntervalSinceReferenceDate
                for particle in particles {
                    let y = particle.y + CGFloat(time - particle.birth) * particle.speed
                    let x = particle.x + sin(CGFloat(time) * particle.wobble) * ScreenLayout.height * 0.014
                    guard y < size.height + ScreenLayout.height * 0.024 else { continue }
                    var path = Path(ellipseIn: CGRect(x: x, y: y, width: particle.size, height: particle.size * 0.6))
                    context.fill(path, with: .color(particle.color))
                }
            }
        }
        .allowsHitTesting(false)
        .onChange(of: isActive) { _, active in
            if active { spawnParticles() }
        }
        .onAppear {
            if isActive { spawnParticles() }
        }
    }

    private func spawnParticles() {
        particles = (0..<80).map { _ in
            ConfettiParticle(
                x: CGFloat.random(in: 0...screenHeight),
                y: CGFloat.random(in: -screenHeight * 0.1...0),
                size: CGFloat.random(in: screenHeight * 0.006...screenHeight * 0.012),
                speed: CGFloat.random(in: screenHeight * 0.11...screenHeight * 0.21),
                wobble: CGFloat.random(in: screenHeight * 0.001...screenHeight * 0.005),
                birth: Date.timeIntervalSinceReferenceDate,
                color: [AppColors.brandGold, AppColors.brandRed, AppColors.white, AppColors.available].randomElement()!
            )
        }
    }
}

private struct ConfettiParticle {
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let speed: CGFloat
    let wobble: CGFloat
    let birth: TimeInterval
    let color: Color
}

#Preview {
    ConfettiView(isActive: true)
        .frame(height: ScreenLayout.height * 0.47)
        .background(AppColors.background)
}
