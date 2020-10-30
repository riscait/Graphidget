//
//  ChartEditingPage.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/29.
//

import SwiftUI

struct ChartEditingPage: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = ChartEditingViewModel()

    var body: some View {
        NavigationView {
            VStack {
                typeSelection

                Form {
                    chartNameSection
                    itemSections
                    if viewModel.chartItems.count < 6 {
                        appendItemSection
                    }
                }
                .navigationBarTitle("New Chart", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .frame(width: 44, height: 44, alignment: .center)
                    }),
                    trailing: EditButton()
                )
                registerSection
            }
        }
    }

    private var typeSelection: some View {
        Picker("", selection: $viewModel.chartType) {
            Text("Percentage")
                .tag(ChartModel.ValueType.percentage)
            Text("Currency")
                .tag(ChartModel.ValueType.currency)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }

    private var chartNameSection: some View {
        Section(header: Text("Chart name")) {
            TextField("My Assets", text: $viewModel.chartName)
                .multilineTextAlignment(.trailing)
        }
    }

    private var itemSections: some View {
        ForEach(viewModel.chartItems.indices, id: \.self) { index in
            Section(header: Text("Item \(index + 1)")) {
                HStack {
                    Text("Name").bold()
                    TextField("Stock", text: $viewModel.chartItems[index].name)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Value").bold()
                    TextField("20", text: $viewModel.chartItems[index].value)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                    Text(viewModel.chartType.suffix)
                        .foregroundColor(Color(.placeholderText))
                        .bold()
                }
            }
        }
        .onDelete(perform: viewModel.delete)
    }

    private var appendItemSection: some View {
        Section {
            Button(action: {
                viewModel.appendEntryField()
            }, label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus.circle")
                    Text("Append item").multilineTextAlignment(.center)
                    Spacer()
                }
            })
        }
    }

    private var registerSection: some View {
        Button(action: {
            viewModel.wtite { result in
                switch result {
                case .success:
                    presentationMode.wrappedValue.dismiss()
                case .failure:
                    break
                }
            }
        }, label: {
            HStack {
                Spacer()
                Text("Register")
                    .bold()
                Spacer()
            }
        })
        .padding()
        .disabled(viewModel.chartName.isEmpty)
    }
}

struct ChartEditingPage_Previews: PreviewProvider {
    static var viewModel: ChartEditingViewModel {
        let viewModel = ChartEditingViewModel()

        viewModel.chartName = ""
        viewModel.chartItems = [ChartItem()]

        return viewModel
    }
    static var previews: some View {
        ChartEditingPage(viewModel: viewModel)
    }
}
