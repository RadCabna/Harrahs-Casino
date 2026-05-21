import Foundation

enum UserPersistence {
    private static let storageKey = "harrahs.user.data"

    static func load() -> StoredUserData {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode(StoredUserData.self, from: data) else {
            return StoredUserData()
        }
        return decoded
    }

    static func save(_ state: StoredUserData) {
        guard let data = try? JSONEncoder().encode(state) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    static func update(_ mutate: (inout StoredUserData) -> Void) {
        var state = load()
        mutate(&state)
        save(state)
    }

    static func reset() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}
