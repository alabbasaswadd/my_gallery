# ─────────────────────────────────────────────────────────────────────────────
# Flutter embedding — the Flutter Gradle plugin already injects most rules,
# but be explicit to survive future toolchain changes.
# ─────────────────────────────────────────────────────────────────────────────
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-dontwarn io.flutter.**

# ─────────────────────────────────────────────────────────────────────────────
# Firebase Core (and Google Play Services transport layer)
# ─────────────────────────────────────────────────────────────────────────────
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.firebase.components.** { *; }
-keep class com.google.firebase.provider.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# ─────────────────────────────────────────────────────────────────────────────
# Kotlin metadata (required for Kotlin reflection used by some plugins)
# ─────────────────────────────────────────────────────────────────────────────
-keep class kotlin.Metadata { *; }
-keepclassmembers class **$WhenMappings { <fields>; }
-keepclassmembers class kotlin.Lazy { *; }
-dontwarn kotlin.**

# ─────────────────────────────────────────────────────────────────────────────
# OkHttp / Okio (transitive dep of several network-related plugins)
# ─────────────────────────────────────────────────────────────────────────────
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

# ─────────────────────────────────────────────────────────────────────────────
# AndroidX & Jetpack (used by multiple Flutter plugins)
# ─────────────────────────────────────────────────────────────────────────────
-dontwarn androidx.**
-keep class androidx.lifecycle.** { *; }
-keep class androidx.core.** { *; }

# ─────────────────────────────────────────────────────────────────────────────
# Flutter plugins used by this app
# ─────────────────────────────────────────────────────────────────────────────

# image_picker
-keep class io.flutter.plugins.imagepicker.** { *; }

# url_launcher
-keep class io.flutter.plugins.urllauncher.** { *; }

# share_plus
-keep class dev.fluttercommunity.plus.share.** { *; }

# flutter_secure_storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# shared_preferences
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# path_provider
-keep class io.flutter.plugins.pathprovider.** { *; }

# cached_network_image / flutter_cache_manager
-keep class com.baseflow.cachemanager.** { *; }

# gal (gallery save)
-keep class com.naeghwi.gal.** { *; }

# fluttertoast
-keep class io.github.ponnamkarthik.toast.fluttertoast.** { *; }

# flutter_native_splash
-keep class com.zp.flutter_native_splash.** { *; }

# ─────────────────────────────────────────────────────────────────────────────
# Suppress noisy warnings from annotation processors included transitively
# ─────────────────────────────────────────────────────────────────────────────
-dontwarn com.google.errorprone.annotations.**
-dontwarn javax.lang.model.element.Modifier
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
