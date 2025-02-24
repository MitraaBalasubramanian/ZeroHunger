plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services") // Ensure this line is present
}

android {
    namespace = "com.zerohunger.app" // 🔥 Use your actual package name!
    compileSdk = 34

    defaultConfig {
        applicationId = "com.zerohunger.app" // 🔥 Use the same package name!
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.9.0"))
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-storage")
    implementation("com.google.firebase:firebase-messaging")
}

buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.3.15") // Ensure Firebase plugin is available
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
