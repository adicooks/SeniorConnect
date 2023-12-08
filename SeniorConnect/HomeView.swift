//  HomeView.swift
//  LifeSavior
//
//  Created by Adi Khurana on 4/29/23.
//

import SwiftUI

struct HomeView: View {
    @State private var isMenuVisible = false
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            if isMenuVisible {
                Color.black.opacity(0.5) 
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isMenuVisible = false
                    }
            }
            TabView {
                HomeTabView()
                GraphTabView()
                AlertsTabView()
                SettingsTabView()
            }
        }
        .navigationBarBackButtonHidden(true) 
    }
}

