//
//  ProtocolOrientedTest.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import Alamofire
import SwiftUI

struct InputView<ViewModel>: View where ViewModel: InputViewModelProtocol {
    @StateObject var viewModel: ViewModel
    @Binding var shouldShowOutput: Bool

    @EnvironmentObject var safeArea: SafeArea
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        VStack {
            Spacer()

            VStack {
                InputForm("Name") {
                    TextField("JohnDoe", text: $viewModel.name)
                        .multilineTextAlignment(.trailing)
                        .submitLabel(.next)
                        /// Below sets FocusState to Name TextField, and sync it with viewModel's Published<Bool> property. Wanna write in a cleaner way.
                        .focused(self.$isTextFieldFocused)
                        .onAppear { self.isTextFieldFocused = viewModel.isTextFieldFocused }
                        .onChange(of: self.isTextFieldFocused) { viewModel.isTextFieldFocused = $0 }
                        .onChange(of: viewModel.isTextFieldFocused) { self.isTextFieldFocused = $0 }

                }.shadow(color: viewModel.isTextFieldFocused ? .white : .clear, radius: 8)
                    .onSubmit { viewModel.focus(at: .birthday) }
                    .onTapGesture { viewModel.focus(at: .name) }

                InputForm("Birthday") {
                    Text("\(YearMonthDay(from: viewModel.birthday).toString())")
                }
                .shadow(color: viewModel.isBirthdayFocused ? .white : .clear, radius: 8)
                .onTapGesture { viewModel.focus(at: .birthday) }

                InputForm("BloodType") {
                    Text(viewModel.bloodType.rawValue)

                }
                .shadow(color: viewModel.isBloodTypeFocused ? .white : .clear, radius: 8)
                .onTapGesture { viewModel.focus(at: .bloodType) }

                if viewModel.isFetchButtonDisplayed {
                    Button {
                        fetchAction()
                    } label: {
                        HStack {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("SeeLuckyPrefecture")
                        }
                    }.buttonStyle(.borderedProminent)
                        .compositingGroup()
                        .shadow(color: .white, radius: 8)
                }

            }
            .padding(.bottom, 40)
            .padding(.bottom, safeArea.insets.bottom)

            if viewModel.isBirthdayFocused {
                KeyboardAlikeView {
                    HStack {
                        DatePicker(
                            "Birthday", selection: $viewModel.birthday, in: viewModel.dateRange,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()

                        Button {
                            viewModel.focus(at: .bloodType)
                        } label: {
                            Image(systemName: "checkmark")
                        }
                        .buttonStyle(.borderedProminent)
                        .keyboardShortcut(.return, modifiers: [])  // for Mac
                    }
                    .padding(.horizontal)
                }

            } else if viewModel.isBloodTypeFocused {
                KeyboardAlikeView {
                    HStack {
                        Picker("BloodType", selection: $viewModel.bloodType) {
                            ForEach(ABOBloodType.allCases) { bloodType in
                                Text(bloodType.rawValue).tag(bloodType)
                            }
                        }.pickerStyle(.wheel)

                        Button("SeeFortune") {
                            viewModel.focus(at: .none)
                            fetchAction()
                        }.buttonStyle(.borderedProminent)
                            .keyboardShortcut(.return, modifiers: [])  // for Mac
                            .disabled(!viewModel.input.isValid)
                    }
                    .padding(.horizontal)
                }
            }

        }.background(
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .onTapGesture { viewModel.focus(at: .none) }
        )
        .onDisappear { viewModel.viewDidDisappear() }

    }

    func fetchAction() {
        print("InputViews: on receive, setting shouldShowOutput to true \n\n\n")
        viewModel.fetchLuckyPrefecture(onReceive: { self.shouldShowOutput = true },
                                       onSucess: {},
                                       onFailure: {_ in})
    }

}

struct ViewForResearch_Previews: PreviewProvider {
    @State static var shouldShowOutput = false
    @State static var shouldSaveUserInput = false
    @State static var userInputToSave = PreviewData.input

    static var previews: some View {
        GeometryReader { geo in
            InputView(
                viewModel: InputViewModel(prefectureModel: PrefectureModel()),
                shouldShowOutput: $shouldShowOutput
            )
            .environmentObject(SafeArea())
        }
    }
}
