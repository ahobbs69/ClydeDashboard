//
//  ClydeDashboardApp.swift
//  ClydeDashboard
//
//  Created by Clyde on 2/15/2026.
//

import SwiftUI
import WebKit

// MARK: - Apple Liquid Glass Design System
struct GlassDesign {
    static let primary = Color(red: 0, green: 122/255, blue: 1) // #007AFF
    static let green = Color(red: 52/255, green: 199/255, blue: 89/255) // #34C759
    static let red = Color(red: 1, green: 59/255, blue: 48/255) // #FF3B30
    static let orange = Color(red: 1, green: 149/255, blue: 0) // #FF9500
    static let purple = Color(red: 88/255, green: 86/255, blue: 214/255) // #5856D6
    
    static let glassBackground = Color(nsColor: .windowBackgroundColor).opacity(0.7)
    static let glassMaterial = NSVisualEffectView.Material.hudWindow
    
    static func glassCard() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
    }
}

struct ContentView: View {
    @State private var selectedTab: Int? = 0
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedTab) {
                Section("Trading") {
                    NavigationLink(value: 0) {
                        Label("Dashboard", systemImage: "chart.bar.fill")
                    }
                    NavigationLink(value: 1) {
                        Label("Gainium", systemImage: "arrow.triangle.branch")
                    }
                    NavigationLink(value: 2) {
                        Label("TradingView", systemImage: "chart.line.uptrend.xyaxis")
                    }
                }
                
                Section("Status") {
                    NavigationLink(value: 3) {
                        Label("Bot Performance", systemImage: "brain")
                    }
                    NavigationLink(value: 4) {
                        Label("Tasks", systemImage: "checklist")
                    }
                    NavigationLink(value: 5) {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationSplitViewColumnWidth(min: 200, ideal: 220, max: 280)
        } detail: {
            currentView
                .frame(minWidth: 800, minHeight: 500)
        }
        .navigationTitle("")
    }
    
    @ViewBuilder
    var currentView: some View {
        switch selectedTab {
        case 0:
            DashboardView()
        case 1:
            WebView(url: URL(string: "https://app.gainium.io")!)
                .navigationTitle("Gainium")
        case 2:
            WebView(url: URL(string: "https://www.tradingview.com")!)
                .navigationTitle("TradingView")
        case 3:
            BotPerformanceView()
        case 4:
            TaskBoardView()
        case 5:
            SettingsView()
        default:
            DashboardView()
        }
    }
}

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("🐙 Clyde's Trading Dashboard")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(.primary)
                        Text("Paper Trading Mode")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text("LIVE")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(GlassDesign.green.opacity(0.2))
                        .foregroundColor(GlassDesign.green)
                        .clipShape(Capsule())
                }
                .padding(30)
                .background(GlassDesign.glassCard())
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Quick Stats
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    StatCard(title: "Portfolio Value", value: "$1,500", subtitle: "USDT", color: GlassDesign.primary)
                    StatCard(title: "Total Profit", value: "$210.51", subtitle: "All time", color: GlassDesign.green)
                    StatCard(title: "Active Bots", value: "3", subtitle: "Running", color: GlassDesign.orange)
                    StatCard(title: "Open Deals", value: "28", subtitle: "Tracked", color: GlassDesign.purple)
                }
                .padding(.horizontal, 20)
                
                // Quick Links
                HStack(spacing: 16) {
                    QuickLinkButton(title: "Open Gainium", icon: "arrow.triangle.branch", url: "https://app.gainium.io", color: GlassDesign.primary)
                    QuickLinkButton(title: "Open TradingView", icon: "chart.line.uptrend.xyaxis", url: "https://www.tradingview.com", color: GlassDesign.green)
                }
                .padding(.horizontal, 20)
                
                // Recent Activity
                VStack(alignment: .leading, spacing: 16) {
                    Text("Recent Trades")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    RecentTradesCard()
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
        .background(.regularMaterial)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "chart.bar.fill")
                    .foregroundStyle(color)
                Spacer()
            }
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(color)
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(GlassDesign.glassCard())
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct QuickLinkButton: View {
    let title: String
    let icon: String
    let url: String
    let color: Color
    
    var body: some View {
        Button {
            if let link = URL(string: url) {
                NSWorkspace.shared.open(link)
            }
        } label: {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}

struct RecentTradesCard: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(trades, id: \.pair) { trade in
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(trade.pair)
                            .font(.system(.body, design: .monospaced))
                            .fontWeight(.semibold)
                        Text(trade.side)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(trade.side == "BUY" ? GlassDesign.green.opacity(0.2) : GlassDesign.red.opacity(0.2))
                            .foregroundColor(trade.side == "BUY" ? GlassDesign.green : GlassDesign.red)
                            .clipShape(Capsule())
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(trade.status.uppercased())
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                        Text(trade.pnl)
                            .foregroundColor(trade.pnl.contains("+") ? GlassDesign.green : .secondary)
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                
                if trade.pair != trades.last?.pair {
                    Divider()
                        .padding(.horizontal, 16)
                }
            }
        }
        .background(GlassDesign.glassCard())
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    var trades: [TradeItem] {
        [
            TradeItem(pair: "WLFI/USDC", side: "SHORT", status: "open", pnl: "+$1.71"),
            TradeItem(pair: "PENDLE/USDT", side: "BUY", status: "pending", pnl: "—"),
            TradeItem(pair: "CVX/USDT", side: "BUY", status: "pending", pnl: "—")
        ]
    }
}

struct TradeItem: Identifiable {
    let id = UUID()
    let pair: String
    let side: String
    let status: String
    let pnl: String
}

struct BotPerformanceView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Bot Performance")
                    .font(.system(size: 32, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 16) {
                    BotRow(name: "Moccasin Tortoise", pair: "WLFI/USDC", profit: "$210.51", returns: "+244.05%", status: "open", icon: "🐢")
                    BotRow(name: "Bronze Crane", pair: "PENDLE/USDC", profit: "$146.36", returns: "+27.5%", status: "open", icon: "🦢")
                    BotRow(name: "Green Chickadee", pair: "CVX/USDT", profit: "$244.41", returns: "+15.7%", status: "warning", icon: "🐦")
                }
                .padding(20)
                .background(GlassDesign.glassCard())
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 30)
        }
        .background(.regularMaterial)
    }
}

struct BotRow: View {
    let name: String
    let pair: String
    let profit: String
    let returns: String
    let status: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Text(icon)
                .font(.system(size: 36))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                Text(pair)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(profit)
                    .font(.system(.title3, design: .monospaced))
                    .fontWeight(.bold)
                    .foregroundStyle(GlassDesign.green)
                Text(returns)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            statusBadge
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    var statusBadge: some View {
        Text(status.uppercased())
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(statusColor.opacity(0.2))
            .foregroundColor(statusColor)
            .clipShape(Capsule())
    }
    
    var statusColor: Color {
        switch status {
        case "open": return GlassDesign.green
        case "warning": return GlassDesign.orange
        case "error": return GlassDesign.red
        default: return .secondary
        }
    }
}

struct TaskBoardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("🎯 Clyde's Task Board")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.horizontal, 20)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    TaskColumn(title: "🔴 In Progress", color: GlassDesign.red, tasks: [
                        TaskItem(title: "Learning Crypto Trading", detail: "Analyzing Gainium bots", action: "Ongoing")
                    ])
                    TaskColumn(title: "🟡 Waiting on You", color: GlassDesign.orange, tasks: [
                        TaskItem(title: "iOS App Build", detail: "Need Xcode permission", action: "sudo xcode-select")
                    ])
                    TaskColumn(title: "🟢 Completed Today", color: GlassDesign.green, tasks: [
                        TaskItem(title: "Gainium Account", detail: "Paper trading enabled", action: "✅ Done"),
                        TaskItem(title: "GitHub Pages", detail: "ahobbs69.github.io", action: "✅ Done"),
                        TaskItem(title: "Mac App", detail: "ClydeDashboard.app built", action: "✅ Done")
                    ])
                    TaskColumn(title: "🔵 Future", color: GlassDesign.primary, tasks: [
                        TaskItem(title: "Auto-refresh", detail: "Fetch live data", action: ""),
                        TaskItem(title: "Telegram Alerts", detail: "Send notifications", action: ""),
                        TaskItem(title: "iOS Deploy", detail: "Deploy to phone", action: "")
                    ])
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 30)
        }
        .background(.regularMaterial)
    }
}

struct TaskColumn: View {
    let title: String
    let color: Color
    let tasks: [TaskItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .foregroundStyle(color)
            
            ForEach(tasks, id: \.title) { task in
                TaskCard(task: task, color: color)
            }
        }
    }
}

struct TaskItem {
    let title: String
    let detail: String
    let action: String
}

struct TaskCard: View {
    let task: TaskItem
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.title)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(task.detail)
                .font(.caption)
                .foregroundStyle(.secondary)
            if !task.action.isEmpty {
                Text(task.action)
                    .font(.caption2)
                    .padding(8)
                    .background(color.opacity(0.15))
                    .foregroundColor(color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}

struct SettingsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Settings")
                    .font(.system(size: 32, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 16) {
                    SettingsRow(icon: "envelope.fill", title: "Email", value: "ahobbs21@icloud.com", color: GlassDesign.primary)
                    SettingsRow(icon: "chart.line.uptrend.xyaxis", title: "Trading Mode", value: "Paper Trading", color: GlassDesign.green)
                    SettingsRow(icon: "link.circle.fill", title: "Gainium Account", value: "Connected ✅", color: GlassDesign.orange)
                    SettingsRow(icon: "chart.bar.fill", title: "TradingView", value: "Logged In ✅", color: GlassDesign.purple)
                }
                .padding(20)
                .background(GlassDesign.glassCard())
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.vertical, 30)
        }
        .background(.regularMaterial)
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 32)
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Text(value)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
    }
}

struct WebView: View {
    let url: URL
    
    var body: some View {
        WebViewRepresentable(url: url)
            .navigationTitle(url.host ?? "Web")
    }
}

struct WebViewRepresentable: NSViewRepresentable {
    let url: URL
    
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.load(URLRequest(url: url))
    }
}

@main
struct ClydeDashboardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
