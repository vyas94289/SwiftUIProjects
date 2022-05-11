//
//  OTPField.swift
//  SnapChatInput
//
//  Created by Gaurang on 10/05/22.
//

import SwiftUI

struct OTPField: View {
    @State var inputs: [String]
    @Binding var otpString: String
    @Binding var isValidInput: Bool
    init(numberOfFields: Int, otpString: Binding<String>, isValidInput: Binding<Bool>) {
        inputs = [String](repeating: "", count: numberOfFields)
        self._otpString = otpString
        self._isValidInput = isValidInput
    }
    @FocusState private var focus: Int?
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0 ..< inputs.count) { index in
                VStack(alignment: .leading, spacing: 4) {
                    TextField("", text: Binding<String>(get: { inputs[index] },
                                                        set: { value in
                        inputs[index] = value
                        if value.isEmpty == false {
                            if index < inputs.count - 1{
                                focus = index + 1
                            } else {
                                focus = nil
                            }
                        }
                    }), onEditingChanged: { changed in
                        if changed {
                            self.inputs[index] = ""
                        }
                    }).focused($focus, equals: index)
                    Color.themeGray.frame(height: 1)
                }
            }
        }
        .frame(height: 25)
        .font(.callout)
        .multilineTextAlignment(.center)
        .keyboardType(.decimalPad)
        .onChange(of: inputs, perform: { newValue in
            isValidInput = newValue.contains(where: {$0.isEmpty}) == false
        })
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.focus = 0
            }
        }
    }
}
