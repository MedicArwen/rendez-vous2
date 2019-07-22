//
//  ProfileScreen1ViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 05/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PictureViewController: UIViewController {

    @IBOutlet weak var photoImageView: RoundPortraitUIImageView!
    @IBOutlet weak var buttonPicture: RoundButtonUIButton!
    @IBOutlet weak var buttonNext: RoundButtonUIButton!
    
    @IBOutlet weak var pseudoUILabel: UILabel!
    private var urlImage: URL?
    let myPickerController = UIImagePickerController()
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let ramonUser = AuthWebService.sharedInstance.ramonUser
        {
            NewProfile.SharedInstance.pseudo = ramonUser.pseudonyme
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        myPickerController.delegate = self
        photoImageView.cornerRadius = photoImageView.layer.frame.height / 2
        pseudoUILabel.text = NewProfile.SharedInstance.pseudo
        
    }
   
    @IBAction func onClickTakePicture(_ sender: RoundButtonUIButton) {
        let alertCtrl = UIAlertController(title: "My portrait", message: "Choose your picture from", preferredStyle: UIAlertController.Style.alert)
        alertCtrl.addAction(UIAlertAction(title: "Take a picture", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.takePicture()}))
        alertCtrl.addAction(UIAlertAction(title: "Take a file", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.takeFromFile()}))
        self.present(alertCtrl, animated: true, completion: nil)
    }
    private func takePicture()
    {
        myPickerController.sourceType = .camera
        myPickerController.allowsEditing = true
        self.present(myPickerController, animated: true, completion: nil)
    }
    private func takeFromFile()
    {
        myPickerController.sourceType = .savedPhotosAlbum
        myPickerController.allowsEditing = true
        self.present(myPickerController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickNext(_ sender: RoundButtonUIButton) {
        performSegue(withIdentifier: "GoToDescription", sender: self)
    }
    
}
extension PictureViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate
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
            
            self.dismiss(animated: true, completion: nil)
            myPickerController.sourceType = .savedPhotosAlbum
            myPickerController.allowsEditing = true
            self.present(myPickerController, animated: true, completion: nil)
        }
        else
        {
            image = info[.editedImage] as! UIImage
            NewProfile.SharedInstance.uiImage = image
            if #available(iOS 11.0, *) {
                url = info[.imageURL] as! URL
            } else {
                // Fallback on earlier versions
                url = info[.referenceURL] as! URL
            }
            photoImageView.image = image

           self.urlImage = url
            uploadImage()
            buttonNext!.isEnabled = true
            self.dismiss(animated: true, completion: nil)
        }

        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
                            
                            NewProfile.SharedInstance.urlImage = imageinfo["image"]["name"].stringValue
                            
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


