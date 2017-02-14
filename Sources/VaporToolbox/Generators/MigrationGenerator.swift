import Foundation
import Console

public final class MigrationGenerator: AbstractGenerator {
    
    private static let migrationsDirectoryPath = "Sources/App/"
    private static let applicationStartFileName = "main.swift"
    private static let migrationsFileName = "Preparations.swift"
    
    private static let routesOriginalText = "func loadPreparations(drop:Droplet) {"
    private static let routesConfigOriginalText = "drop.run()"
    private static let routesConfigReplacementText = "loadPreparations(drop: drop)"
    
	override public var id: String {
	    return "migration"
	}

	override public var signature: [Argument] {
	    return super.signature + [
	        Value(name: "model", help: ["Will specify the table / model name being used in the migration"]),
	    ]
	}

	override public func generate(arguments: [String]) throws {
        guard let name = arguments.first else {
            throw ConsoleError.argumentNotFound
        }
        var forModel: String? = nil
        
        if(arguments.count < 2) {
            console.warning("You can specify a table name in the migration command: vapor generate migration MigrationName [tablename]", newLine: true)
        
        }else{
            forModel = arguments.last
        }

        let filePath = "Sources/App/Models/Migrations//\(name.capitalized).swift"
        let templatePath = defaultTemplatesDirectory + "MigrationTemplate.swift"
        let fallbackURL = URL(string: defaultTemplatesURLString)!
        //let ivars = arguments.values.filter { return $0.contains(":") }
        //console.print("Model ivars => \(ivars)")
        try copyTemplate(atPath: templatePath, fallbackURL: fallbackURL, toPath: filePath) { (contents) in
            func spacing(_ x: Int) -> String {
                guard x > 0 else { return "" }
                var result = ""
                for _ in 0 ..< x {
                    result += " "
                }
                return result
            }

            var newContents = contents
            newContents = newContents.replacingOccurrences(of: "_MIGRATION_NAME_", with: name.capitalized)
            if((forModel) != nil) {
                newContents = newContents.replacingOccurrences(of: "_TABLE_NAME_", with: (forModel?.lowercased())!)
            }else {
                newContents = newContents.replacingOccurrences(of: "_TABLE_NAME_", with: name.lowercased())
            }
            
            
            
            
            return newContents
        }
        
        self.appendPreparation(name: name)
        
    }
    
     func appendPreparation(name:String) {

        self.console.info("Appending Preparation:\(name)", newLine: true)
    
        do {
            let template = try loadTemplate(atPath: defaultTemplatesDirectory + "PreparationsAppendTemplate.swift",
                                            fallbackURL: URL(string: defaultTemplatesURLString)!)
            
            let preparationName = "\(name.capitalized)"
            let preparationText = preparationsString(fromTemplate: template, preparation: preparationName)
            
            try! addPreparation(preparationText)
            
            
            
        }catch {
            console.error("Cannot find Preparations Template", newLine: true)
            return
        }
    
    }

    
    private func addPreparation(_ text: String) throws {
        let originalText = MigrationGenerator.routesOriginalText
        let replacementString = originalText + "\n\(text)"
        try openPreparationsFile() { (file) in
            file.contents = file.contents.replacingOccurrences(of: originalText, with: replacementString)
        }
    }
    
    
    private func openPreparationsFile(_ editClosure: ((inout File) -> Void)) throws {
        let filePath = try migrationsFilePath()
        try openFile(atPath: filePath, editClosure)
    }
    
    
    private func migrationsFilePath() throws -> String {
        let filePath = MigrationGenerator.migrationsDirectoryPath + MigrationGenerator.migrationsFileName
        guard !fileExists(atPath: filePath) else { return filePath }
        console.warning("\(filePath) not found. Creating it...")
        let template = try loadTemplate(atPath: defaultTemplatesDirectory + MigrationGenerator.migrationsFileName,
                                        fallbackURL: URL(string: defaultTemplatesURLString)!)
        try template.saveCopy(atPath: filePath)
        try configureDropletUsingPreparationsFile()
        return filePath
    }
    
    
    private func configureDropletUsingPreparationsFile() throws {
        let originalText = MigrationGenerator.routesConfigOriginalText
        let replacementString = MigrationGenerator.routesConfigReplacementText + "\n\(originalText)"
        let filePath = MigrationGenerator.migrationsDirectoryPath + MigrationGenerator.applicationStartFileName
        try openFile(atPath: filePath) { (file) in
            file.contents = file.contents.replacingOccurrences(of: originalText, with: replacementString)
        }
    }
    
    
    private func preparationsString(fromTemplate template: File, preparation: String, method: String = "") -> String {
        var contents = template.contents
        contents = contents.replacingOccurrences(of: "_PREPARATION_", with: preparation)
        return contents
    }

}
