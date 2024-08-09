//
//  HomeTabView.swift
//  LifeSavior
//
//  Created by Adi Khurana on 5/29/23.
//

import SwiftUI
import MapKit

struct HomeTabView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image("icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .cornerRadius(5)
                            .onAppear {
                                NotificationManager.scheduleHelloNotification()
                            }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hello, Adi!")
                                .font(.title)
                                .fontWeight(.bold)
                                .offset(x: 20, y: 0)
                            
                            Text("Stay connected with your loved one.")
                                .foregroundColor(.gray)
                                .offset(x: 20, y: 0)
                        }
                    }
                
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Device Overview")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack(spacing: 80) {
                            OverviewItem(imageName: "antenna.radiowaves.left.and.right", title: "Status", value: "Connected")
                            OverviewItem(imageName: "battery.100", title: "Battery %", value: "100%")
                            OverviewItem(imageName: "link.circle", title: "Linked #", value: "1")

                        }
                        
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Latest Alerts")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        ForEach(alertsData) { alert in
                            AlertItem(alert: alert)
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Device Location: Greater Philadelphia Expo Center")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        LocationMap()
                            .frame(height: 250)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
        .tabItem {
            Label("Home", systemImage: "house")
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}

struct OverviewItem: View {
    var imageName: String
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.green)
        }
    }
}

struct AlertItem: View {
    var alert: AlertModel
    
    var body: some View {
        HStack {
            Image(systemName: alert.iconName)
                .foregroundColor(alert.iconColor)
                .frame(width: 40, height: 40)
                .background(alert.iconBackgroundColor)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(alert.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(alert.timestamp)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct AlertModel: Identifiable {
    var id = UUID()
    var iconName: String
    var iconColor: Color
    var iconBackgroundColor: Color
    var title: String
    var timestamp: String
}

let alertsData: [AlertModel] = [
    AlertModel(iconName: "exclamationmark.circle.fill", iconColor: .red, iconBackgroundColor: Color.red.opacity(0.2), title: "Help Required", timestamp: "2 hours ago"),
    AlertModel(iconName: "exclamationmark.circle.fill", iconColor: .blue, iconBackgroundColor: Color.blue.opacity(0.2), title: "Device Operational", timestamp: "5 hours ago"),
]

struct LocationMap: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.122359, longitude: -75.458641),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    )

    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .cornerRadius(10)
    }
}

