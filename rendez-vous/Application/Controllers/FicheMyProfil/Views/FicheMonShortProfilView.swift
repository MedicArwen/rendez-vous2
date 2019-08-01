//
//  FicheMonShortProfilView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 30/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class FicheMonShortProfilView: UIView {

    @IBOutlet weak var portraitView:RoundPortraitUIImageView!
    @IBOutlet weak var pseudoLabel:RoundUILabel!
    @IBOutlet weak var catchPhrase:UILabel!
    private var urlImage: URL?
    let myPickerController = UIImagePickerController()
    var parentControleur:RamonViewController?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func onClickFavorites(_ sender: UIButton) {
    }
    
    @IBAction func onClickMatchs(_ sender: UIButton) {
    }
    
    @IBAction func onClickStories(_ sender: UIButton) {
    }
    @IBAction func onClickEditProfile(_ sender: UIButton) {
    }
    
    
    func update(controleur:RamonViewController, utilisateur:Utilisateur)
    {
        print("FicheMonShortProfilView:update")
        let url = URL(string: "https://api.ramon-technologies.com/rendez-vous/img/rdv/\(utilisateur.urlImage)")!
        self.portraitView.af_setImage(withURL: url)
        self.pseudoLabel.text = utilisateur.pseudo
        self.catchPhrase.text = "\"\(utilisateur.catchPhrase.removingPercentEncoding!)\""
        self.portraitView.cornerRadius = 128 / 2
        self.parentControleur = controleur
        myPickerController.delegate = self
    }
    @IBAction func onClickTakePicture(_ sender: RoundButtonUIButton) {
        let alertCtrl = UIAlertController(title: "My portrait", message: "Choose your picture from", preferredStyle: UIAlertController.Style.alert)
        alertCtrl.addAction(UIAlertAction(title: "Take a picture", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.takePicture()}))
        alertCtrl.addAction(UIAlertAction(title: "Take a file", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.takeFromFile()}))
        self.parentControleur!.present(alertCtrl, animated: true, completion: nil)
    }
    private func takePicture()
    {
        myPickerController.sourceType = .camera
        myPickerController.allowsEditing = true
        self.parentControleur!.present(myPickerController, animated: true, completion: nil)
    }
    private func takeFromFile()
    {
        myPickerController.sourceType = .savedPhotosAlbum
        myPickerController.allowsEditing = true
        self.parentControleur!.present(myPickerController, animated: true, completion: nil)
    }
}

extension FicheMonShortProfilView:UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image selectionnee")
        
        var image: UIImage
        var url : URL
        if myPickerController.sourceType == .camera
        {
            print(info)
            image = info[.editedImage] as! UIImage
            NewProfile.SharedInstance.uiImage = image
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            self.parentControleur!.dismiss(animated: true, completion: nil)
            myPickerController.sourceType = .savedPhotosAlbum
            myPickerController.allowsEditing = true
            self.parentControleur!.present(myPickerController, animated: true, completion: nil)
        }
        else
        {
            image = info[.editedImage] as! UIImage
            if #available(iOS 11.0, *) {
                url = info[.imageURL] as! URL
            } else {
                // Fallback on earlier versions
                url = info[.referenceURL] as! URL
            }
            portraitView.image = image
            
            self.urlImage = url
            uploadImage()
            
            self.parentControleur!.dismiss(animated: true, completion: nil)
        }
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.parentControleur!.dismiss(animated: true, completion: nil)
    }
    
    public var documentsDirectoryURL: URL {
        return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
    }
    public func fileURLInDocumentDirectory(_ fileName: String) -> URL {
        return self.documentsDirectoryURL.appendingPathComponent(fileName)
    }
    func uploadImage() {
        
        // User "authentication":
        let parameters = ["user":"Sol", "password":"secret1234"]
        // Image to upload:
        let imageToUploadURL = self.urlImage
        // Server address (replace this with the address of your own server):
        let url = "https:/api.ramon-technologies.com/rendez-vous/up2.php"
        // Use Alamofire to upload the image
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                // On the PHP side you can retrive the image using $_FILES["image"]["tmp_name"]
                multipartFormData.append(imageToUploadURL!, withName: "image")
                for (key, val) in parameters {
                    multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                }
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let jsonResponse = response.result.value as? [String: Any] {
                            let imageinfo = JSON(jsonResponse["files"]!)
                            RendezVousApplication.sharedInstance.connectedUtilisateur!.setImage(url: imageinfo["image"]["name"].stringValue)
                            print(imageinfo)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
}

