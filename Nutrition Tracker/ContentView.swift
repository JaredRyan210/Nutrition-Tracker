import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var isShowingScanner = false
    @State private var nutritionalData: NutritionalData?

    var body: some View {
        VStack {
            Button("Scan Barcode") {
                AVCaptureDevice.requestAccess(for: .video) { response in
                    if response {
                        isShowingScanner = true
                    } else {
                        // Handle the case where the user denied the camera access
                        print("Camera access denied")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                BarcodeScannerView { barcode in
                    fetchNutritionalData(for: barcode)
                }
            }

            if let data = nutritionalData {
                VStack(alignment: .leading) {
                    Text(data.food_name).font(.headline)
                    Text(data.brand_name)
                    Text("\(data.nf_calories) calories")
                }
                .padding()
            }
        }
        .padding()
    }

    func fetchNutritionalData(for barcode: String) {
        NetworkManager().fetchNutritionalData(for: barcode) { data in
            DispatchQueue.main.async {
                self.nutritionalData = data
            }
        }
    }
}
