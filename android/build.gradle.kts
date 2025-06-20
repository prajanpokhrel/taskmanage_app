//  Firebase & Kotlin Plugin Setup
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Required for Firebase Google Sign-In
        classpath("com.google.gms:google-services:4.3.15")

        //  Required to fix Kotlin version mismatch error
      classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.0.0")
    }
}

//  Keep your custom repo setup
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}


val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
