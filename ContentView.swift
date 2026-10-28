import SwiftUI

// 1. Data model tracking live customer leads and automation steps
struct SalesLead: Identifiable, Hashable {
    let id = UUID()
    let businessName: String
    let contactPerson: String
    let revenuePotential: String
    var automatedStatus: String = "Lead Captured"
    var stepColor: Color = .orange
}

struct ContentView: View {
    // 2. Real-world target dataset showing your n8n pipeline operations
    @State private var activeLeads = [
        SalesLead(businessName: "Nexus Retail Group", contactPerson: "Sarah Jenkins", revenuePotential: "$4,500/mo"),
        SalesLead(businessName: "Vertex Logistics", contactPerson: "David Miller", revenuePotential: "$8,200/mo")
    ]
    
    @State private var isSyncing = false
    @State private var currentSyncMessage = "Ready to fire pipelines"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Section A: Live Pipeline Control Hub Banner
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "circle.badge.ellipsis")
                            .foregroundColor(.orange)
                        Text("Low-Code Automation Status: Active")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text(currentSyncMessage)
                            .font(.subheadline)
                            .foregroundColor(.orange)
                            .bold()
                        
                        Spacer()
                        
                        Button(action: {
                            triggerSalesPipeline()
                        }) {
                            HStack {
                                if isSyncing {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                }
                                Text(isSyncing ? "Syncing..." : "Execute Automation")
                            }
                            .font(.footnote)
                            .bold()
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(isSyncing ? Color.gray : Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .disabled(isSyncing)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                
                // Section B: Beautiful Target Customer Grid Blocks
                List(activeLeads) { lead in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(lead.businessName)
                                .font(.headline)
                            Spacer()
                            Text(lead.revenuePotential)
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.green)
                        }
                        
                        HStack {
                            Label(lead.contactPerson, systemImage: "person.crop.circle")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text(lead.automatedStatus)
                                .font(.caption2)
                                .bold()
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(lead.stepColor.opacity(0.15))
                                .foregroundColor(lead.stepColor)
                                .cornerRadius(6)
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("AI Sales Dashboard")
        }
    }
    
    // 3. Simulates the multi-step background n8n node automation loop
    func triggerSalesPipeline() {
        isSyncing = true
        currentSyncMessage = "🔗 Contacting n8n Webhook Router..."
        
        // Step 1: AI Analysis Node
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            currentSyncMessage = "🤖 Running Claude Intent Scoring..."
            activeLeads[0].automatedStatus = "AI Qualified"
            activeLeads[0].stepColor = .blue
            
            activeLeads[1].automatedStatus = "AI Qualified"
            activeLeads[1].stepColor = .blue
        }
        
        // Step 2: CRM Data Sync & Auto-Calendar Scheduling Node
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
            currentSyncMessage = "📅 Calendar Meeting Booked Successfully!"
            activeLeads[0].automatedStatus = "Meeting Slotted"
            activeLeads[0].stepColor = .green
            
            activeLeads[1].automatedStatus = "Meeting Slotted"
            activeLeads[1].stepColor = .green
            
            isSyncing = false
        }
    }
}
