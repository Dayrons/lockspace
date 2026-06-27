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

    project.evaluationDependsOn(":app")

    // Force compileSdk 36 for all subprojects (plugins like clipboard)
    // to prevent AGP 9.x failures when plugins target older compileSdk.
    // This replaces the fragile pub cache patch.
    if (!project.state.executed) {
        afterEvaluate {
            val android = project.extensions.findByType<com.android.build.gradle.BaseExtension>()
            android?.compileSdkVersion(36)
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}