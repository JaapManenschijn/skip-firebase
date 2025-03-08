// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
#if !SKIP_BRIDGE
#if SKIP
import SkipFirebaseCore
import kotlinx.coroutines.tasks.await

public final class RemoteConfig {
    public let remoteConfig: com.google.firebase.remoteconfig.FirebaseRemoteConfig

    public init(remoteConfig: com.google.firebase.remoteconfig.FirebaseRemoteConfig) {
        self.remoteConfig = remoteConfig
    }

    public static func remoteConfig() -> RemoteConfig {
        RemoteConfig(remoteconfig: com.google.firebase.remoteconfig.FirebaseRemoteConfig.getInstance())
    }

    public static func remoteConfig(app: FirebaseApp) -> RemoteConfig {
        RemoteConfig(remoteconfig: com.google.firebase.remoteconfig.FirebaseRemoteConfig.getInstance(app.app))
    }
    
    public func setSettings(remoteConfigSettings: RemoteConfigSettings) async throws {
        remoteConfig.setConfigSettingsAsync(settings: remoteConfigSettings.settings).await()
    }
    
    public func fetchAndActivate() async throws {
        remoteConfig.fetchAndActivate().await()
    }
    
    public func configValue(forKey: String) -> RemoteConfigValue {
        .init(remoteConfigValue: remoteConfig.getValue(key: forKey))
    }
}

public final class RemoteConfigSettings {
    public let settings: com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings

    public init(remoteConfigSettings: com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings) {
        self.settings = remoteConfigSettings
    }

    public static func remoteConfigSettings(minimumFetchInterval: Int) -> RemoteConfigSettings {
        var builder = com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings.Builder()
            .setMinimumFetchIntervalInSeconds(duration: minimumFetchInterval)
        return builder.build()
    }
}

public final class RemoteConfigValue {
    public let remoteConfigValue: com.google.firebase.remoteConfig.FirebaseRemoteConfigValue
    
    public init(remoteConfigValue: com.google.firebase.remoteConfig.FirebaseRemoteConfigValue) {
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
    
    public var numberValue: NSNumber {
        return NSNumber(value: remoteConfigValue.asDouble())
    }
}
#endif
#endif
