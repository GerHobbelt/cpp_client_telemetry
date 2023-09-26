//
// Copyright (c) Microsoft Corporation. All rights reserved.
// SPDX-License-Identifier: Apache-2.0
//

import OneDSSwift
import SwiftUI

private var logger:Logger?
private var token:String = ""

struct ContentView: View {
	@State private var enteredText = ""

    var body: some View {
		VStack {
			TextField("Enter text", text: $enteredText)
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding()

			Button(action: {
				// Perform an action with the captured text
				print("Entered text: \(enteredText)")
				sendTelemetry(enteredText)
				print("Telemetry Sent.")
			}) {
				Text("Send Telemtery")
					.padding()
					.foregroundColor(.white)
					.background(Color.accentColor)
					.cornerRadius(10)
			}
		}
		.padding()
		.onAppear() {
			initTelemetry()
		}
		.onDisappear() {
			closeTelemetrySession()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/// Method accessing Swift Wrapper package OneDSSwift telemetry classes

func initTelemetry() {
	token = "7c8b1796cbc44bd5a03803c01c2b9d61-b6e370dd-28d9-4a52-9556-762543cf7aa7-6991"
	logger = LogManager.loggerWithTenant(tenantToken: token, withSource: "example_proj_source")
}

func sendTelemetry(_ text:String) {
	let event:EventProperties = EventProperties(name: "SetProps_Swift_Wrapper_Example_Proj")
	event.setProperty("enteredtext", withValue: text)
	event.setProperty("from", withValue: "Swift_Wrappers_Package_Example_Project")

	if (logger != nil) {
		logger!.logEvent(properties: event)
	}
	LogManager.uploadNow()
}

func closeTelemetrySession() {
	_ = LogManager.flushAndTeardown()
}