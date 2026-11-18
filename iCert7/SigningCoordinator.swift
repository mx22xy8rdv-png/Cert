import Foundation

/// Deliberately does not fake Apple certificate issuance.
/// A production implementation must use an Apple-supported authorization
/// and provisioning flow and must possess a valid signing identity.
actor SigningCoordinator {
    enum SigningError: LocalizedError {
        case notConfigured
        var errorDescription: String? {
            "Подписание не настроено: нет подтверждённого Apple signing workflow и signing identity."
        }
    }

    func signIPA(at url: URL) async throws -> URL {
        _ = url
        throw SigningError.notConfigured
    }
}
