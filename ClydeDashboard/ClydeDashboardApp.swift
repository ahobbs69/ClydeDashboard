//
//  ClydeDashboardApp.swift
//  ClydeDashboard
//
//  Super simple working version
//

import SwiftUI

@main
struct ClydeDashboardApp: App {
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 0) {
                // Header
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("Clyde Dashboard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(height: 100)
                
                // Content
                ScrollView {
                    VStack(spacing: 20) {
                        // P&L
                        VStack {
                            Text("Total P&L")
                                .font(.title3)
                            Text("+$601.28")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.green)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(30)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        
                        // Stats
                        HStack(spacing: 20) {
                            VStack {
                                Image(systemName: "brain")
                                    .font(.largeTitle)
                                Text("3")
                                    .font(.title)
                                Text("Bots")
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(20)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            
                            VStack {
                                Image(systemName: "banknote")
                                    .font(.largeTitle)
                                Text("59%")
                                    .font(.title)
                                Text("Used")
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(20)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                        }
                        
                        // Market
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Market")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Group {
                                HStack { Text("BTC"); Spacer(); Text("$68,377"); Text("+2%").foregroundColor(.green) }
                                Divider()
                                HStack { Text("ETH"); Spacer(); Text("$1,985"); Text("+1%").foregroundColor(.green) }
                                Divider()
                                HStack { Text("SOL"); Spacer(); Text("$86"); Text("+1%").foregroundColor(.green) }
                                Divider()
                                HStack { Text("SPY"); Spacer(); Text("$681.75"); Text("-0%").foregroundColor(.gray) }
                                Divider()
                                HStack { Text("TSLA"); Spacer(); Text("$417.44"); Text("-1%").foregroundColor(.red) }
                            }
                            .font(.body)
                        }
                        .padding(20)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                    }
                    .padding(20)
                }
                
                // Tab Bar
                HStack {
                    Button { } label: { VStack { Image(systemName: "house.fill"); Text("Home") } }
                    Spacer()
                    Button { } label: { VStack { Image(systemName: "chart.line.uptrend.xyaxis"); Text("Gainium") } }
                    Spacer()
                    Button { } label: { VStack { Image(systemName: "brain"); Text("Bots") } }
                    Spacer()
                    Button { } label: { VStack { Image(systemName: "gear"); Text("Settings") } }
                }
                .font(.caption)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.1))
            }
        }
    }
}
