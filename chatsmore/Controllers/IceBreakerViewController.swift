//
//  IceBreakerViewController.swift
//  chatsmore
//
//  Created by Paul Nguyen on 2/16/22.
//

import UIKit
import MessageKit

class IceBreakerViewController: MessagesViewController {
    
    let buttonOne = UIButton()
    let buttonTwo = UIButton()
    let buttonThree = UIButton()
    let buttonFour = UIButton()
    let plusButton = UIButton()
    let boltButton = UIButton()
    let planeButton = UIButton()
    let xButton = UIButton()
    var buttonSize: CGFloat = 20
    var sparkOn: Bool = false
    
    private var messages = [Message]()
    
    private var selfSender: Sender? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        return Sender(photoURL: "",
                      senderId: safeEmail,
                      displayName: "Me")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        boltButton.addTarget(self, action: #selector(boltButtonTapped), for: .touchUpInside)
        buttonOne.addTarget(self, action: #selector(boltButtonTapped), for: .touchUpInside)
        buttonTwo.addTarget(self, action: #selector(boltButtonTapped), for: .touchUpInside)
        buttonThree.addTarget(self, action: #selector(boltButtonTapped), for: .touchUpInside)
        buttonFour.addTarget(self, action: #selector(boltButtonTapped), for: .touchUpInside)
        xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        showOtherUserProfile()
        configureButtons()
    }
    
    func showOtherUserProfile() {
        guard let otherUserEmail = UserDefaults.standard.value(forKey: "otherUserEmail") as? String else {
            return
        }
        
        let safeEmail = DatabaseManager.safeEmail(emailAddress: otherUserEmail)
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
            self.addIceBreakers()
            UIView.animate(withDuration: 1.0) {
                self.boltButton.alpha = 0.0
            }
            sparkOn = true
        }
    }
    
    @objc private func xButtonTapped() {
        if (sparkOn == true) {
            UIView.animate(withDuration: 1.0) {
                self.buttonOne.alpha = 0.0
                self.buttonTwo.alpha = 0.0
                self.buttonThree.alpha = 0.0
                self.buttonFour.alpha = 0.0
                self.xButton.alpha = 0.0
                self.boltButton.alpha = 1.0
                
                self.buttonOne.removeFromSuperview()
                self.buttonTwo.removeFromSuperview()
                self.buttonThree.removeFromSuperview()
                self.buttonFour.removeFromSuperview()
                self.xButton.removeFromSuperview()
            }
            sparkOn = false
        }
    }
    
    @objc private func buttonOneTapped() {
        
    }
    
    @objc private func buttonTwoTapped() {
        
    }
    
    @objc private func buttonThreeTapped() {
        
    }
    
    @objc private func buttonFourTapped() {
        
    }
    
    func configureButtons() {
        plusButton.configuration = .filled()
        plusButton.configuration?.image = UIImage(systemName: "plus.circle")
        plusButton.configuration?.background.cornerRadius = buttonSize

        boltButton.configuration = .filled()
        boltButton.configuration?.image = UIImage(systemName: "bolt.circle")
        boltButton.configuration?.background.cornerRadius = buttonSize
        
        planeButton.configuration = .filled()
        planeButton.configuration?.image = UIImage(systemName: "paperplane.circle")
        planeButton.configuration?.background.cornerRadius = buttonSize
        
        xButton.configuration = .filled()
        xButton.configuration?.image = UIImage(systemName: "x.circle")
        xButton.configuration?.background.cornerRadius = buttonSize
        
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
        planeButton.alpha = 0.0
        view.addSubview(planeButton)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        boltButton.translatesAutoresizingMaskIntoConstraints = false
        planeButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: buttonSize),
            plusButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            boltButton.leftAnchor.constraint(equalTo: plusButton.rightAnchor, constant: 20),
            boltButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            boltButton.widthAnchor.constraint(equalToConstant: buttonSize),
            boltButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            planeButton.leftAnchor.constraint(equalTo: boltButton.rightAnchor, constant: 20),
            planeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            planeButton.widthAnchor.constraint(equalToConstant: buttonSize),
            planeButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func addIceBreakers() {
        buttonOne.alpha = 0.0
        buttonTwo.alpha = 0.0
        buttonThree.alpha = 0.0
        buttonFour.alpha = 0.0
        
        view.addSubview(buttonOne)
        view.addSubview(buttonTwo)
        view.addSubview(buttonThree)
        view.addSubview(buttonFour)
        view.addSubview(xButton)
        
        UIView.animate(withDuration: 1.0) {
            self.buttonOne.alpha = 1.0
            self.buttonTwo.alpha = 1.0
            self.buttonThree.alpha = 1.0
            self.buttonFour.alpha = 1.0
            self.xButton.alpha = 1.0
        }
        
        xButton.translatesAutoresizingMaskIntoConstraints = false
        buttonOne.translatesAutoresizingMaskIntoConstraints = false
        buttonTwo.translatesAutoresizingMaskIntoConstraints = false
        buttonThree.translatesAutoresizingMaskIntoConstraints = false
        buttonFour.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
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
            
            xButton.leftAnchor.constraint(equalTo: buttonOne.rightAnchor, constant: 20),
            xButton.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 20),
            xButton.widthAnchor.constraint(equalToConstant: buttonSize),
            xButton.heightAnchor.constraint(equalToConstant: buttonSize),
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
    
    public static let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        formatter.locale = .current
        return formatter
    }()
    
    private func createMessageId() -> String? {
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String,
        let otherUserEmail = UserDefaults.standard.value(forKey: "otherUserEmail") as? String else {
            return nil
        }
        
        let safeCurrentEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        
        let dateString = Self.dateFormatter.string(from: Date())
        let newIdentifier = "\(otherUserEmail)_\(safeCurrentEmail)_\(dateString)"
        print ("Created Message: \(newIdentifier)")
        return newIdentifier
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage,
              let imageData = image.pngData(),
              let messageId = createMessageId(),
              let conversationId = UserDefaults.standard.value(forKey: "conversationId") as? String,
              let name = UserDefaults.standard.value(forKey: "name") as? String,
              let selfSender = self.selfSender else {
                  return
            }
        
        let fileName = "photo_message_" + messageId.replacingOccurrences(of: " ", with: "-") + ".png"
        // Upload Image
        StorageManager.shared.uploadMessagePhoto(with: imageData, fileName: fileName, completion: { [weak self] result in
            switch result {
            case .success(let urlString):
                //Ready to send message
                print("Uploaded Message Photo: \(urlString)")
                
                guard let url = URL(string: urlString),
                      let placeholder = UIImage(systemName: "plus") else {
                          return
                      }
                
                let media = Media(url: url,
                                  image: nil,
                                  placeholderImage: placeholder,
                                  size: .zero)
                
                
                let message = Message(sender: selfSender,
                                      messageId: messageId,
                                      sentDate: Date(),
                                      kind: .photo(media))
                
                guard let otherUserEmail = UserDefaults.standard.value(forKey: "otherUserEmail") as? String else {
                    return
                }
                
                DatabaseManager.shared.sendMessage(to: conversationId, otherUserEmail: otherUserEmail, name: name, newMessage: message, completion: { success in
                    if success {
                        print("sent photo message")
                    }
                    else {
                        print("failed to send photo message")
                    }
                })
            case .failure(let error):
                print("message photo upload error: \(error)")
            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


