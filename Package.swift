// Generated automatically by Perfect Assistant Application
// Date: 2017-09-20 19:30:47 +0000
import PackageDescription

let package = Package(
	name: "GraphQL-Server",
	targets: [],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-RequestLogger.git", majorVersion: 1),
		.Package(url: "https://github.com/GraphQLSwift/GraphQL.git", majorVersion: 0, minor: 2),
		.Package(url: "https://github.com/GraphQLSwift/Graphiti.git", majorVersion: 0, minor: 3)
	]
)
