import ArgumentParser
import Foundation

@main
struct IOSGen: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "iosgen",
        abstract: "iOS project generator",
        subcommands: [Init.self]
    )
}

struct Init: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "init",
        abstract: "Initialize a new SwiftUI project using Tuist, SwiftLint, and SwiftFormat"
    )

    @Argument(help: "Project name")
    var projectName: String

    func run() throws {
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        let outputPath = "\(currentPath)/\(projectName)"

        print("🛠️ Generating project: \(projectName)")

        let templatePath = "/usr/local/share/iosgen/Templates/BaseProject-SwiftUI"

        guard fileManager.fileExists(atPath: templatePath) else {
            print("❌ Template not found at \(templatePath)")
            return
        }

        do {
            try fileManager.copyItem(atPath: templatePath, toPath: outputPath)
            print("✅ Project created at \(outputPath)")

            try replacePlaceholders(in: outputPath, projectName: projectName)

        } catch {
            print("❌ Failed to generate project: \(error)")

            // Clean up partially copied project
            if fileManager.fileExists(atPath: outputPath) {
                do {
                    try fileManager.removeItem(atPath: outputPath)
                    print("🧹 Removed incomplete project folder: \(outputPath)")
                } catch {
                    print("⚠️ Failed to remove folder: \(outputPath), error: \(error)")
                }
            }
        }
    }

    func replacePlaceholders(in folderPath: String, projectName: String) throws {
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(atPath: folderPath)

        let allowedExtensions = ["swift", "xcodeproj", "pbxproj", "plist", "md", "yaml", "yml", "txt", "sh"]
        let allowedExactFilenames = [".swiftformat", ".gitignore", ".editorconfig"]

        while let file = enumerator?.nextObject() as? String {
            let filePath = "\(folderPath)/\(file)"
            var isDir: ObjCBool = false

            if fileManager.fileExists(atPath: filePath, isDirectory: &isDir), !isDir.boolValue {
                let fileExtension = URL(fileURLWithPath: filePath).pathExtension
                let filename = URL(fileURLWithPath: filePath).lastPathComponent

                guard allowedExtensions.contains(fileExtension) || allowedExactFilenames.contains(filename) else {
                    continue
                }

                var content = try String(contentsOfFile: filePath)
                content = content.replacingOccurrences(of: "__PROJECT_NAME__", with: projectName)
                try content.write(toFile: filePath, atomically: true, encoding: .utf8)
            }
        }

        print("🔁 Placeholder replaced with \(projectName)")
    }
}
