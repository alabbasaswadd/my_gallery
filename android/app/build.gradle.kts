plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.my_gallery"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.example.my_gallery"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")

            // R8 full-mode: shrinks, obfuscates, and optimises Kotlin/Java from plugins.
            isMinifyEnabled = true
            // Removes unused Android resources (drawables, layouts, strings, etc.).
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            // Exclude x86_64 (emulator-only) and keep only real-device ABIs.
            // For Play Store, use `flutter build appbundle` instead — Play delivers
            // the right ABI automatically without any filter needed here.
            // For a direct-download APK, pass --target-platform android-arm64 to
            // flutter build apk to get the smallest single-ABI APK (~31 MB).
            ndk {
                abiFilters += setOf("arm64-v8a", "armeabi-v7a")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
