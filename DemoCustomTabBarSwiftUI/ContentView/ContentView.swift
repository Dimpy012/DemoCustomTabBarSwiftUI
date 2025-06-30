//
//  ContentView.swift
//  DemoCustomTabBarSwiftUI
//
//  Created by Dimpy Patel on 30/06/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - HIDING NATIVE TAB BAR
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    // MARK: - Variables
    @State private var tabBarItems = [
        TabBarItems(imageIcon: "home_icon", selectedImageIcon: "homeSelected_icon", title: "Home"),
        TabBarItems(imageIcon: "calendar_icon", selectedImageIcon: "calendarSelected_icon", title: "Schedule"),
        TabBarItems(imageIcon: "notification_icon", selectedImageIcon: "notificationSelected_icon", title: "Notification"),
        TabBarItems(imageIcon: "setting_icon", selectedImageIcon: "settingSelected_icon", title: "Setting"),
    ]
    @State private var selectedTab = 0
    @State private var routePath = NavigationPath()

    var body: some View {
        NavigationStack(path: $routePath) {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tag(0)
                    CalendarView()
                        .tag(1)
                    NotificationView()
                        .tag(2)
                    SettingView()
                        .tag(3)
                }
                .zIndex(0)
                
                GeometryReader { proxy in
                    VStack {
                        Spacer()
                        HStack(alignment: .bottom, spacing: 20) {
                            Spacer()
                            ForEach(0..<2) { index in
                                Button{
                                    selectedTab = index
                                } label: {
                                    CustomTabItem(imageName: tabBarItems[index].imageIcon, selectedImageName: tabBarItems[index].selectedImageIcon, title: tabBarItems[index].title, isActive: (selectedTab == index))
                                }
                            }
                            Spacer()
                            Spacer()
                            ForEach(2..<self.tabBarItems.count) { index in
                                Button{
                                    selectedTab = index
                                } label: {
                                    CustomTabItem(imageName: tabBarItems[index].imageIcon, selectedImageName: tabBarItems[index].selectedImageIcon, title: tabBarItems[index].title, isActive: (selectedTab == index))
                                }
                            }
                            Spacer()
                        }
                        .font(.footnote)
                        .padding(.top, 42)
                        .overlay(alignment: .top) {
                            VStack(spacing: -3) {
                                // MARK: - Button Create
                                Button {
                                    routePath.append(Route.createMatch)
                                } label: {
                                    Image("plus_icon")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(.white)
                                        .background {
                                            Circle()
                                                .fill(Color(UIColor(red: 100.0/255.0, green: 176.0/255.0, blue: 84.0/255.0, alpha: 1.0)))
                                                .shadow(radius: 3)
                                        }
                                }
                                .padding(9)
                            }
                        }
                        .padding(.bottom, max(32, proxy.safeAreaInsets.bottom))
                        .background {
                            CustomTabBarShape()
                                .fill(.white)
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: -1)
                        }
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
            }
            .navigationBarHidden(true)
            // MARK: - Navigate to Create Match
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .createMatch:
                    CreateMatchView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


// MARK: - Custom TabBar Items
extension ContentView {
    func CustomTabItem(imageName: String, selectedImageName: String, title: String, isActive: Bool) -> some View {
        VStack(spacing: 4) {
            Spacer()
            Image(isActive ? selectedImageName : imageName)
                .resizable()
                .frame(width: 28, height: 28)
            
            if isActive {
                Text(title)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color(UIColor(red: 100.0/255.0, green: 176.0/255.0, blue: 84.0/255.0, alpha: 1.0)))
                    .padding(.bottom, 20)
            } else {
                Text(title)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black.opacity(0.6))
                    .padding(.bottom, 20)
            }
        }
        .padding(.top, 18)
        .frame(height: 40)
    }
}
