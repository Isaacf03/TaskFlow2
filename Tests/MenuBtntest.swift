//
//  MenuBtntest.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/25/24.
//
//
//import SwiftUI
//import UIKit
//
//struct MenuBtntest: View {
//    @State var showText = false
//    var body: some View {
//        FloatingMenuButton()
//        Spacer()
//        Menu2()
//            .onTapGesture {
//                showText.toggle()
//            }
//        if showText{
//            Text("button pressed")
//            FloatingMenuButton()
//        }
//    }
//}
//
//#Preview {
//    MenuBtntest()
//}
//
//class FloatingButtonMenu: UIButton{
//    override init(frame: CGRect){
//        super.init(frame: frame)
//        
//        let firstAction = self.firstAction()
//        let secondAction = self.secondAction()
//        let thirdAction = self.ThirdtAction()
//        
//        
//        setTitle("+", for: .normal)
//        setTitleColor(.black, for: .normal)
//        menu = UIMenu(title: "", children: [firstAction,secondAction,thirdAction])
//        menu?.preferredElementSize = .automatic
//        showsMenuAsPrimaryAction = false
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    func firstAction() -> UIAction{
//        UIAction(title: "Add Category"){ action in
//            
//        }
//    }
//    func secondAction() -> UIAction{
//        UIAction(title: "Add task"){ action in
//            
//        }
//    }
//    
//    func ThirdtAction() -> UIAction{
//        UIAction(title: "Select Cat"){ action in
//            
//        }
//    }
//    
//    
//    
//    
//}
//
//
//
//
//class MenuButton: UIButton {
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        let inspectAction = self.inspectAction()
//        let duplicateAction = self.duplicateAction()
//        let deleteAction = self.deleteAction()
//
//        setImage(UIImage(systemName: "plus"), for: .normal)
//        menu = UIMenu(title: "", children: [inspectAction, duplicateAction, deleteAction])
//        menu?.preferredElementSize = .medium
//        showsMenuAsPrimaryAction = false
//    
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func inspectAction() -> UIAction {
//        UIAction(title: "Add Category",
//                 image: UIImage(systemName: "arrow.up.square")) { action in
//           //
//        }
//    }
//        
//    func duplicateAction() -> UIAction {
//        UIAction(title: "Add Task",
//                 image: UIImage(systemName: "plus.square.on.square")) { action in
//           //
//        }
//    }
//        
//    func deleteAction() -> UIAction {
//        UIAction(title: "New Task",
//                 image: UIImage(systemName: "trash"),
//            attributes: .destructive) { action in
//           //
//        }
//    }
//
//}
//
//
//struct FloatingMenuButton: UIViewRepresentable {
//    func updateUIView(_ uiView: FloatingButtonMenu, context: Context) {
//    }
//    
//    func makeUIView(context: Context) -> FloatingButtonMenu {
//        FloatingButtonMenu(frame: .zero)
//    }
//}
//
//struct Menu2: UIViewRepresentable {
//    func makeUIView(context: Context) -> MenuButton {
//        MenuButton(frame: .zero)
//    }
//    
//    func updateUIView(_ uiView: MenuButton, context: Context) {
//    }
//}
