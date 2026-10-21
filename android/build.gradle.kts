import com.android.build.gradle.BaseExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Standard Flutter subproject evaluation dependency.
    // We skip the app project itself to avoid "already evaluated" errors.
    if (project.name != "app") {
        project.evaluationDependsOn(":app")
    }

    // Force compileSdkVersion 36 for all Android modules to resolve AAR metadata conflicts.
    val configureAndroid = {
        val android = project.extensions.findByName("android") as? com.android.build.gradle.BaseExtension
        android?.compileSdkVersion(36)
    }

    // Safely apply configuration whether the project is already evaluated or not.
    // This avoids the "already evaluated" exception for the :app module.
    if (project.state.executed) {
        configureAndroid()
    } else {
        project.afterEvaluate {
            configureAndroid()
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
