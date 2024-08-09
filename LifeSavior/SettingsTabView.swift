//
//  SettingsTabView.swift
//  LifeSavior
//
//  Created by Adi Khurana on 5/29/23.
//

import SwiftUI

struct SettingsTabView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")) {
                    Text("Edit Profile")
                    Text("Change Password")
                    Text("Notifications")
                }
                
                Section(header: Text("Device Settings")) {
                    Text("WiFi Settings")
                    Text("Location Settings")
                    Text("Cellular Settings")
                }
                
                Section(header: Text("App Settings")) {
                    Text("Theme")
                    Text("Language")
                    Text("Privacy")
                }
                
                Section(header: Text("About")) {
                    Text("App Version")
                    Text("Terms of Service")
                    Text("Privacy Policy")
                }
            }
            .navigationBarTitle("Settings")
        }
        .tabItem {
            Label("Settings", systemImage: "gearshape")
        }
    }
}
