//
//  IceBreakerViewController.swift
//  chatsmore
//
//  Created by Paul Nguyen on 2/16/22.
//

import UIKit

class IceBreakerViewController: UIViewController {
    
    let buttonOne = UIButton()
    let buttonTwo = UIButton()
    let buttonThree = UIButton()
    let buttonFour = UIButton()
    let plusButton = UIButton()
    let boltButton = UIButton()
    let planeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    func configureButtons() {
        buttonOne.configuration = .tinted()
        buttonOne.configuration?.baseForegroundColor = .systemOrange
        buttonOne.configuration?.title = "What's your COVID silver lining?"
        buttonOne.configuration?.image = UIImage(systemName: "question.circle")
        buttonOne.configuration?.imagePadding = 5
        
        buttonTwo.configuration = .tinted()
        buttonTwo.configuration?.baseForegroundColor = .systemOrange
        buttonTwo.configuration?.title = "Favorite sports team?"
        buttonTwo.configuration?.image = UIImage(systemName: "question.circle")
        buttonTwo.configuration?.imagePadding = 5
        
        buttonThree.configuration = .tinted()
        buttonThree.configuration?.baseForegroundColor = .systemOrange
        buttonThree.configuration?.title = "Dream celebrity date (alive or dead)?"
        buttonThree.configuration?.image = UIImage(systemName: "question.circle")
        buttonThree.configuration?.imagePadding = 5
        
        buttonFour.configuration = .tinted()
        buttonFour.configuration?.baseForegroundColor = .systemOrange
        buttonFour.configuration?.title = "Favorite show on Netflix?"
        buttonFour.configuration?.image = UIImage(systemName: "question.circle")
        buttonFour.configuration?.imagePadding = 5
        
        addButtonConstraints()
        
    }
    
    func addButtonConstraints() {
        view.addSubview(buttonOne)
        view.addSubview(buttonTwo)
        view.addSubview(buttonThree)
        view.addSubview(buttonFour)
        
        NSLayoutConstraint.activate([
            buttonOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonOne.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonOne.widthAnchor.constraint(equalToConstant: 260),
            buttonOne.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension IceBreakerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func presentPhotoActionSheet() {
     let actionSheet = UIAlertController(title: "Attach Media",
                                         message: "What would you like to attach?",
                                         preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title:"Camera",
                                            style: .default,
                                            handler: { [weak self] _ in
        
            self?.presentCamera()
            
        }))
        actionSheet.addAction(UIAlertAction(title:"Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))

     actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
     
     present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


