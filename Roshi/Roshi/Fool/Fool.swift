//
//  Fool.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation
import Network

class Fool: FoolProtocol, ObservableObject {

    func executeCommand(command: String) {
        // Implementation of command execution
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
