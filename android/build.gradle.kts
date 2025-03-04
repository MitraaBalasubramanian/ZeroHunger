plugins {
    id("com.zerohunger.app")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services") // Apply Google Services plugin
}

android {
    namespace = "com.zerohunger.app" // Replace with your actual package name
    compileSdk = 34

    defaultConfig {
        applicationId = "com.zerohunger.appr" // Use your actual package name
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            minifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.9.0"))
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
}

buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.3.15") // ✅ Firebase plugin version
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
