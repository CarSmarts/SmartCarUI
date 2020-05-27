//
//  Picker.swift
//  SmartCarUI
//
//  Created by Robert Smith on 5/26/20.
//  Copyright © 2020 Robert Smith. All rights reserved.
//

#if canImport(UIKit)
import SwiftUI
import UIKit

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public class PickerObject: NSObject, ObservableObject, UIDocumentPickerDelegate {
    @Published public var isPresented: Bool = false {
        didSet {
            if isPresented && rootVC.presentedViewController == nil {
                rootVC.present(picker, animated: true, completion: nil)
            } else if !isPresented && rootVC.presentedViewController != nil {
                rootVC.dismiss(animated: true)
            }
        }
    }
    
    private var picker: UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.plain-text"], in: .import)
        picker.allowsMultipleSelection = false
        
        picker.delegate = self
        return picker
    }

    private var rootVC: UIViewController
    public var didPickDocument: ((URL) -> Void)?
    
    public init(rootVC: UIViewController) {
        self.rootVC = rootVC
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        
        self.didPickDocument?(url)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        isPresented = false
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct Picker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.plain-text"], in: .import)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> PickerCoordinator {
        PickerCoordinator(picker: self)
    }
    
    public mutating func onPickDocument(_ didPickDocument: @escaping (URL) -> Void) {
        self.didPickDocument = didPickDocument
    }
    fileprivate var didPickDocument: ((URL) -> Void)?
    
    class PickerCoordinator: NSObject, UIDocumentPickerDelegate {
        internal init(picker: Picker) {
            self.picker = picker
        }
        
        var picker: Picker
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            
            picker.didPickDocument?(url)
        }
    }
}

#endif