//
//  ClydeDashboardApp.swift
//  ClydeDashboard
//
//  Liquid Glass Design - iOS 18 Style
//

import SwiftUI

@main
struct ClydeDashboardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Apple Liquid Glass Background
            LinearGradient(
                colors: [Color.purple.opacity(0.3), Color.blue.opacity(0.2), Color.cyan.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Glass Header
                GlassHeader()
                
                // Content
                TabView(selection: $selectedTab) {
                    DashboardView()
                        .tag(0)
                    
                    GainiumView()
                        .tag(1)
                    
                    BotsView()
                        .tag(2)
                    
                    SettingsView()
                        .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // Glass Tab Bar
                GlassTabBar(selectedTab: $selectedTab)
            }
        }
    }
}

// MARK: - Liquid Glass Components

struct GlassHeader: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
            
            VStack {
                Spacer()
                Text("Clyde")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.top, 50)
        }
        .frame(height: 100)
    }
}

struct GlassTabBar: View {
    @Binding var selectedTab: Int
    
    let tabs = [
        ("house.fill", "Home"),
        ("chart.line.uptrend.xyaxis", "Gainium"),
        ("brain.fill", "Bots"),
        ("gearshape.fill", "Settings")
    ]
    
    var body: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        selectedTab = index
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].0)
                            .font(.title3)
                        Text(tabs[index].1)
                            .font(.caption2)
                    }
                    .foregroundStyle(selectedTab == index ? Color.blue : Color.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background {
                        if selectedTab == index {
                            Capsule()
                                .fill(.ultraThinMaterial)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
    }
}

struct GlassCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    }
            }
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Dashboard View

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // P&L Card
                GlassCard {
                    VStack(spacing: 10) {
                        Text("Total P&L")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                        Text("+$601.28")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundStyle(.green)
                    }
                }
                
                // Stats
                HStack(spacing: 15) {
                    GlassStatBox(title: "Bots", value: "3", icon: "brain.fill", color: .blue)
                    GlassStatBox(title: "Used", value: "59%", icon: "banknote.fill", color: .orange)
                }
                
                // Market
                GlassCard {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Market")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        GlassMarketRow(coin: "BTC", price: "$68,377", change: "+2.1%", up: true)
                        Divider().padding(.vertical, 5)
                        GlassMarketRow(coin: "ETH", price: "$1,985", change: "+1.3%", up: true)
                        Divider().padding(.vertical, 5)
                        GlassMarketRow(coin: "SOL", price: "$86", change: "+0.8%", up: true)
                        Divider().padding(.vertical, 5)
                        GlassMarketRow(coin: "SPY", price: "$681.75", change: "-0.2%", up: false)
                        Divider().padding(.vertical, 5)
                        GlassMarketRow(coin: "TSLA", price: "$417.44", change: "-1.1%", up: false)
                    }
                }
            }
            .padding(20)
        }
    }
}

struct GlassStatBox: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(color)
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial)
        }
    }
}

struct GlassMarketRow: View {
    let coin: String
    let price: String
    let change: String
    let up: Bool
    
    var body: some View {
        HStack {
            Text(coin)
                .font(.headline)
            Spacer()
            Text(price)
                .font(.subheadline)
            Text(change)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(up ? .green : .red)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background {
                    Capsule()
                        .fill(up ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                }
        }
    }
}

// MARK: - Gainium View

struct GainiumView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                GlassBotCard(name: "Moccasin Tortoise", pair: "WLFI/USDC", pnl: "+$210.51", status: "Active")
                GlassBotCard(name: "Bronze Crane", pair: "PENDLE", pnl: "+$146.36", status: "Closed")
                GlassBotCard(name: "Green Chickadee", pair: "CVX", pnl: "+$244.41", status: "Error")
            }
            .padding(20)
        }
    }
}

struct GlassBotCard: View {
    let name: String
    let pair: String
    let pnl: String
    let status: String
    
    var statusColor: Color {
        switch status {
        case "Active": return .green
        case "Closed": return .blue
        case "Error": return .red
        default: return .gray
        }
    }
    
    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(name)
                        .font(.headline)
                    Spacer()
                    Text(status)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background {
                            Capsule()
                                .fill(statusColor)
                        }
                }
                
                HStack {
                    Text(pair)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(pnl)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                }
            }
        }
    }
}

// MARK: - Bots View

struct BotsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                GlassCard {
                    VStack(alignment: .leading, spacing: 15) {
                        Label("Gainium Bots", systemImage: "chart.line.uptrend.xyaxis")
                            .font(.headline)
                        Divider()
                        Label("Paper Trading", systemImage: "doc.text")
                            .font(.headline)
                        Divider()
                        Label("Fragrance ROI", systemImage: "flame")
                            .font(.headline)
                    }
                }
            }
            .padding(20)
        }
    }
}

// MARK: - Settings View

struct SettingsView: View {
    @State private var notifications = true
    @State private var autoRefresh = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                GlassCard {
                    VStack(spacing: 0) {
                        Toggle(isOn: $notifications) {
                            Label("Notifications", systemImage: "bell.fill")
                        }
                        .tint(.blue)
                        Divider().padding(.vertical, 10)
                        Toggle(isOn: $autoRefresh) {
                            Label("Auto Refresh", systemImage: "arrow.clockwise")
                        }
                        .tint(.blue)
                    }
                }
                
                GlassCard {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("About")
                            .font(.headline)
                        
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("1.0.0")
                                .foregroundStyle(.secondary)
                        }
                        
                        HStack {
                            Text("Clyde")
                            Spacer()
                            Text("🐙")
                        }
                    }
                }
            }
            .padding(20)
        }
    }
}
