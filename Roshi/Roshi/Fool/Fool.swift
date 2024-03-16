//
//  Fool.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation
import Network
import AppKit


class Fool: FoolProtocol, ObservableObject {
    let fileManager = FileManager.default

    @discardableResult
    func shell(_ command: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/bin/zsh"
        task.arguments = ["-c", "echo '' | " + command.joined(separator: " ")]
        var environment = ProcessInfo.processInfo.environment // Get current environment
        environment["PATH"] = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin" // Append Homebrew path
        task.environment = environment
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }

    func executeCommand(command: String) {
        // navigate to document directory and execute the command
        let status = shell("cd ~/Documents && echo '' | \(command)")
        if status == 0 {
            // TODO: send a message to the chat saying is done and to check Documents folder
            print("Done")
        } else {
            print("Command failed with exit code \(status)")
        }
    }


    func testProject() {
        let portToCheck = 3000
        let host = "localhost"

        checkPortOpen(host: host, port: portToCheck) { isOpen in
            if isOpen {
                print("Port \(portToCheck) is open.")
                // Proceed to take a screenshot of the browser
                self.takeBrowserScreenshot()
            } else {
                print("Port \(portToCheck) is not open.")
            }
        }
    }

    private func checkPortOpen(host: String, port: Int, completion: @escaping (Bool) -> Void) {
        let connection = NWConnection(host: NWEndpoint.Host(host), port: NWEndpoint.Port(rawValue: UInt16(port))!, using: .tcp)
        connection.start(queue: .global())
        connection.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("Connected to \(host) on port \(port)")
                completion(true)
                connection.cancel()
            case .failed(_):
                completion(false)
                connection.cancel()
            default:
                break
            }
        }
    }

    private func takeBrowserScreenshot() {
        // Browser automation to take a screenshot
        // This part requires external tools or libraries
    }

    private func segmentImage() {
        // Image segmentation
        // This part requires external tools or libraries
    }
}
