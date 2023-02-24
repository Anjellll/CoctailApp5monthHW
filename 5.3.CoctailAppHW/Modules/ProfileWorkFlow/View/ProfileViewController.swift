//
//  ProfileViewController.swift
//  5.3.CoctailAppHW
//
//  Created by anjella on 23/2/23.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet weak var dateBirthTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    private let collection = "App"
    private let document = "User"
    
    private let phoneNumber = "+996707158727"
    
    private var verificationID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        authentificateWithPN()
        //        DatabaseManager.shared.setTo(collection: collection, document: document, withData: ["Anjella" : "Kattoobekova"])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DatabaseManager.shared.readFrom(collection: collection, document: document)
    }
    
    private func authentificateWithPN() {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.verificationID = verificationID
                // Sign in using the verificationID and the code sent to the user
                // ...
            }
    }
    
    @IBAction private func verifyPhoneAuth() {
        verifyPhoneAuthTapped()
    }
    
    private func verifyPhoneAuthTapped() {
        guard let code = emailTF.text,
              let vID = verificationID else {
                  return
                  
              }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: vID,
            verificationCode: code
        )
        authInApp(with: credential)
    }
    
    private func authInApp(with credential: PhoneAuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error is: \(error.localizedDescription)")
            } else {
                print("Authorizied: \(authResult?.user)")
            }
        }
    }
}
