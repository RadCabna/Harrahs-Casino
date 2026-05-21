import AudioToolbox

enum AppSounds {
    static func ticketChirp() {
        AudioServicesPlaySystemSound(1104)
    }
}
