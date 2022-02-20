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
    var sparkOn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        boltButton.addTarget(self, action: #selector(boltButtonTapped), for: .touchUpInside)
        showOtherUserProfile()
        configureButtons()
    }
    
    func showOtherUserProfile() {
        guard let email = UserDefaults.standard.value(forKey: "otherUserEmail") as? String else {
            return
        }
        
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let filename = safeEmail + "_profile_picture.png"
        
        let path = "images/" + filename
        let headerView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: self.view.width,
                                        height: 300))
        
        headerView.backgroundColor = .link
        let imageView = UIImageView(frame: CGRect(x: (view.width-150) / 2,
                                                  y: (view.height) / 9,
                                                  width: 150,
                                                  height: 150))
        
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.width/2
        view.addSubview(imageView)
        StorageManager.shared.downloadURL(for: path, completion: { [weak self] result in
            switch result {
            case .success(let url):
                self?.downloadImage(imageView: imageView, url: url)
            case .failure(let error):
                print("Failed to get download url: \(error)")
            }
        })
    }
    
    func downloadImage(imageView: UIImageView, url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
            
        }).resume()
    }
    
    @objc private func plusButtonTapped() {
        presentPhotoActionSheet()
    }
    
    @objc private func boltButtonTapped() {
        if (sparkOn == false) {
            UIView.animate(withDuration: 1.0) {
                self.buttonOne.alpha = 1.0
                self.buttonTwo.alpha = 1.0
                self.buttonThree.alpha = 1.0
                self.buttonFour.alpha = 1.0
                self.view.addSubview(self.buttonOne)
                self.view.addSubview(self.buttonTwo)
                self.view.addSubview(self.buttonThree)
                self.view.addSubview(self.buttonFour)
                self.configureButtons()
            }
            sparkOn = true
        } else {
            UIView.animate(withDuration: 1.0) {
                self.buttonOne.alpha = 0.0
                self.buttonTwo.alpha = 0.0
                self.buttonThree.alpha = 0.0
                self.buttonFour.alpha = 0.0
                
                self.buttonOne.removeFromSuperview()
                self.buttonTwo.removeFromSuperview()
                self.buttonThree.removeFromSuperview()
                self.buttonFour.removeFromSuperview()
            }
            sparkOn = false
        }
    }
    
    func configureButtons() {
        plusButton.configuration = .filled()
        plusButton.configuration?.image = UIImage(systemName: "plus.circle")
        
        
        boltButton.configuration = .filled()
        boltButton.configuration?.image = UIImage(systemName: "bolt.circle")
        
        planeButton.configuration = .filled()
        planeButton.configuration?.image = UIImage(systemName: "paperplane.circle")
        
        buttonOne.configuration = .tinted()
        buttonOne.configuration?.baseBackgroundColor = .systemOrange
        buttonOne.configuration?.baseForegroundColor = .systemOrange
        buttonOne.configuration?.title = "What's your COVID silver lining?"
        buttonOne.configuration?.image = UIImage(systemName: "questionmark.circle")
        buttonOne.configuration?.imagePadding = 5
        
        
        buttonTwo.configuration = .tinted()
        buttonTwo.configuration?.baseBackgroundColor = .systemOrange
        buttonTwo.configuration?.baseForegroundColor = .systemOrange
        buttonTwo.configuration?.title = "Favorite sports team?"
        buttonTwo.configuration?.image = UIImage(systemName: "questionmark.circle")
        buttonTwo.configuration?.imagePadding = 5
        
        buttonThree.configuration = .tinted()
        buttonThree.configuration?.baseBackgroundColor = .systemOrange
        buttonThree.configuration?.baseForegroundColor = .systemOrange
        buttonThree.configuration?.title = "Dream celebrity date (alive or dead)?"
        buttonThree.configuration?.image = UIImage(systemName: "questionmark.circle")
        buttonThree.configuration?.imagePadding = 5
        
        buttonFour.configuration = .tinted()
        buttonFour.configuration?.baseBackgroundColor = .systemOrange
        buttonFour.configuration?.baseForegroundColor = .systemOrange
        buttonFour.configuration?.title = "Favorite show on Netflix?"
        buttonFour.configuration?.image = UIImage(systemName: "questionmark.circle")
        buttonFour.configuration?.imagePadding = 5
        
        addButtonConstraints()
        
    }
    
    func addButtonConstraints() {
        view.addSubview(plusButton)
        view.addSubview(boltButton)
        view.addSubview(planeButton)
        
        view.addSubview(buttonOne)
        view.addSubview(buttonTwo)
        view.addSubview(buttonThree)
        view.addSubview(buttonFour)
         
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        boltButton.translatesAutoresizingMaskIntoConstraints = false
        planeButton.translatesAutoresizingMaskIntoConstraints = false
        buttonOne.translatesAutoresizingMaskIntoConstraints = false
        buttonTwo.translatesAutoresizingMaskIntoConstraints = false
        buttonThree.translatesAutoresizingMaskIntoConstraints = false
        buttonFour.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            
            boltButton.leftAnchor.constraint(equalTo: plusButton.rightAnchor, constant: 20),
            boltButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            boltButton.widthAnchor.constraint(equalToConstant: 50),
            boltButton.heightAnchor.constraint(equalToConstant: 50),
            
            planeButton.leftAnchor.constraint(equalTo: boltButton.rightAnchor, constant: 20),
            planeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            planeButton.widthAnchor.constraint(equalToConstant: 50),
            planeButton.heightAnchor.constraint(equalToConstant: 50),
            
            buttonOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonOne.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 20),
            buttonOne.widthAnchor.constraint(equalToConstant: 260),
            buttonOne.heightAnchor.constraint(equalToConstant: 50),
            
            buttonTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonTwo.topAnchor.constraint(equalTo: buttonOne.bottomAnchor, constant: 20),
            buttonTwo.widthAnchor.constraint(equalToConstant: 260),
            buttonTwo.heightAnchor.constraint(equalToConstant: 50),
            
            buttonThree.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonThree.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: 20),
            buttonThree.widthAnchor.constraint(equalToConstant: 260),
            buttonThree.heightAnchor.constraint(equalToConstant: 50),
            
            buttonFour.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonFour.topAnchor.constraint(equalTo: buttonThree.bottomAnchor, constant: 20),
            buttonFour.widthAnchor.constraint(equalToConstant: 260),
            buttonFour.heightAnchor.constraint(equalToConstant: 50),
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


