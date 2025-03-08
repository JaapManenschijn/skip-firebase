// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
#if !SKIP_BRIDGE
#if SKIP
import Foundation
import SkipFirebaseCore
import kotlinx.coroutines.tasks.await

public final class RemoteConfig {
    public let remoteConfig: com.google.firebase.remoteconfig.FirebaseRemoteConfig

    public init(remoteConfig: com.google.firebase.remoteconfig.FirebaseRemoteConfig) {
        self.remoteConfig = remoteConfig
    }

    public static func remoteConfig() -> RemoteConfig {
        RemoteConfig(remoteConfig: com.google.firebase.remoteconfig.FirebaseRemoteConfig.getInstance())
    }

    public static func remoteConfig(app: FirebaseApp) -> RemoteConfig {
        RemoteConfig(remoteConfig: com.google.firebase.remoteconfig.FirebaseRemoteConfig.getInstance(app.app))
    }
    
    public func setSettings(remoteConfigSettings: RemoteConfigSettings) async throws {
        remoteConfig.setConfigSettingsAsync(remoteConfigSettings.settings).await()
    }
    
    public func fetchAndActivate() async throws {
        remoteConfig.fetchAndActivate().await()
    }
    
    public func configValue(forKey: String) -> RemoteConfigValue {
        .init(remoteConfigValue: remoteConfig.getValue(forKey))
    }
}

public final class RemoteConfigSettings {
    public let settings: com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings

    public init(remoteConfigSettings: com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings) {
        self.settings = remoteConfigSettings
    }

    public static func remoteConfigSettings(minimumFetchInterval: Int) -> RemoteConfigSettings {
        var builder = com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings.Builder()
            .setMinimumFetchIntervalInSeconds(minimumFetchInterval)
        return RemoteConfigSettings(remoteConfigSettings: builder.build())
    }
}

public final class RemoteConfigValue {
    public let remoteConfigValue: com.google.firebase.remoteconfig.FirebaseRemoteConfigValue
    
    public init(remoteConfigValue: com.google.firebase.remoteconfig.FirebaseRemoteConfigValue) {
        self.remoteConfigValue = remoteConfigValue
    }
    
    public var dataValue: NSData {
        let bytes = remoteConfigValue.asByteArray()
        return NSData(bytes: bytes, length: bytes.count)
    }
    
    public var stringValue: String {
        return remoteConfigValue.asString()
    }
    
    public var boolValue: Bool {
        return remoteConfigValue.asBoolean()
    }
}
#endif
#endif
