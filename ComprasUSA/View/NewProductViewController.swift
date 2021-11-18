import UIKit
import SnapKit
import AVFoundation

class NewProductViewController: ViewController<NewProductViewModel> {

    //MARK: -
    //MARK: - OUTLETS
    private var productTextField: TextField!
    private var productImageView: UIImageView!
    private var stateStackView: UIStackView!
    private var stateTextField: TextField!
    private var addStateButton: UIButton!
    private var valueStackView: UIStackView!
    private var valueTextField: TextField!
    private var switchLabel: UILabel!
    private var cardSwitch: UISwitch!
    private var saveButton: UIButton!
    
    private var statePickerView: UIPickerView!
    private var toolBar: UIToolbar!
    
    private var permissionManager = PermissionsManager()
    private var stateIndex = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.viewModelLoad()
    }
    
    //MARK: -
    //MARK: - VIEW CODE LIFE CYCLE
    override func prepareViews() {
        view.backgroundColor = .white
        productTextField = .init()
        productImageView = .init()
        stateTextField = .init()
        addStateButton = .init()
        valueTextField = .init()
        switchLabel = .init()
        cardSwitch = .init()
        saveButton = .init()
        stateStackView = .init()
        valueStackView = .init()
        
        statePickerView = .init()
        toolBar = .init()
    }
    
    override func addViewHierarchy() {
    
        stateStackView.addArrangedSubviews([
            stateTextField,
            addStateButton
        ])
        
        valueStackView.addArrangedSubviews([
            valueTextField,
            switchLabel,
            cardSwitch
        ])
        
        view.addSubviews([
            productTextField,
            productImageView,
            stateStackView,
            valueStackView,
            saveButton
        ])
    }
    
    //MARK: -
    //MARK: - VIEW CONFIGURATIONS
    override func setupConstraints() {
        
        productTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIWindow.getSafeAreaInsets().top + 60)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.equalTo(productTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
        
        addStateButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
        }
        
        stateTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        valueTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        stateStackView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        valueStackView.snp.makeConstraints { make in
            make.top.equalTo(stateStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(valueStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
    }

    override func configureViews() {
        vm.presenter = self
        configureProductTextField()
        configureProductImageView()
        configureAddButton()
        configureState()
        configuereValue()
        configureSaveButton()
        configurePickerView()
    }
    
    private func configureProductTextField() {
        productTextField.placeholder = "Nome do produto"
    }
    
    private func configureProductImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProductImage(_ :)))
        productImageView.isUserInteractionEnabled = true
        productImageView.addGestureRecognizer(tapGesture)
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        productImageView.image = UIImage(named: "placeholder")
        permissionManager.delegate = self
    }
    
    private func configureState() {
        stateTextField.placeholder = "Estado da compra"
        stateTextField.inputView = statePickerView
        
        stateStackView.axis = .horizontal
        stateStackView.alignment = .center
        stateStackView.distribution = .fill
        stateStackView.spacing = 10
    }
    
    private func configuereValue() {
        valueTextField.placeholder = "Valor (U$)"
        valueTextField.keyboardType = .decimalPad
        switchLabel.text = "Cartão?"
        cardSwitch.isOn = true
        
        valueStackView.axis = .horizontal
        valueStackView.alignment = .center
        valueStackView.distribution = .fill
        valueStackView.spacing = 10
    }
    
    private func configureAddButton() {
        addStateButton.layer.borderColor = UIColor.blue.cgColor
        addStateButton.layer.borderWidth = 1.0
        addStateButton.layer.cornerRadius = 16
        addStateButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addStateButton.setTitleColor(.blue, for: .normal)
        addStateButton.addTarget(self, action: #selector(addStateTapped(_ :)), for: .touchUpInside)
    }
    
    private func configureSaveButton() {
        saveButton.backgroundColor = .blue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle(vm.getButtonTitle(), for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_ :)), for: .touchUpInside)
    }
    
    private func configurePickerView() {
        statePickerView.backgroundColor = .white
        statePickerView.delegate = self
        statePickerView.dataSource = self
        
        toolBar.sizeToFit()
        let doneButtonn = UIBarButtonItem(title: "Pronto", style: .plain, target: self, action: #selector(doneButtonTapped(_ :)))
        toolBar.setItems([doneButtonn], animated: true)
        toolBar.isUserInteractionEnabled = true
        stateTextField.inputAccessoryView = toolBar
    }
    
    //MARK: -
    //MARK: - BUTTON ACTIONS
    @objc func doneButtonTapped(_ sender: UIButton) {
        vm.didSelectState(at: stateIndex)
        stateTextField.text = vm.getStateNameSelected()
        view.endEditing(true)
    }

    
    @objc private func didTapProductImage(_ gestureRecognizer: UITapGestureRecognizer) {
        showActionSheetForImagePicker()
    }
    
    @objc private func addStateTapped(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        if let prod = productTextField.text, !prod.isEmpty,
            let image = productImageView.image?.jpegData(compressionQuality: 0.7), !image.isEmpty, productImageView.image != UIImage(named: "placeholder"),
            let prodValue = valueTextField.text, !prodValue.isEmpty,
            !(stateTextField.text?.isEmpty ?? true) {
                let product = Product()
                product.name = prod
                product.image = image
                product.value = prodValue.getDoubleValue()
                product.isCreditCard = cardSwitch.isOn
                vm.save(product: product) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
        } else {
            let alert = UIAlertController(title: "Alerta", message: "É necessário preencher todos os campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
    }

    //MARK: -
    //MARK: - UIMAGEPICKER
    private func showActionSheetForImagePicker() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                if self.permissionManager.hasCameraPermission() {
                    self.openImagePicker(for: .camera)
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            DispatchQueue.main.async {
                if self.permissionManager.hasPhotoLibraryPermission() {
                    self.openImagePicker(for: .photoLibrary)
                }
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.navigationController?.present(actionSheet, animated: true, completion: nil)
    }
    
    private func openImagePicker(for type: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(type) {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = type
                self.navigationController?.present(myPickerController, animated: true, completion: nil)
            }
        }
    }

}

//MARK: -
//MARK: - PICKERVIEW DELEGATE & DATA SOURCE
extension NewProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return vm.statesNumberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = vm.states[row].name
        return state
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateIndex = row
    }
}

//MARK: -
//MARK: - UIIMAGEPICKER DELEGATE
extension NewProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageUrl = info[.phAsset] as? NSURL,
            let imageName = imageUrl.lastPathComponent,
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            let photoURL = NSURL(fileURLWithPath: documentDirectory)
            let localPath = photoURL.appendingPathComponent(imageName)
            print("LOCAL PATH: \(String(describing: localPath?.absoluteString))")
            
        }
        
        if let image = info[.originalImage] as? UIImage {
            self.productImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}

//MARK: -
//MARK: - PERMISSION DELEGATE
extension NewProductViewController: PermissionDelegate {
    func updateCameraPermission(for granted: Bool) {
        if granted {
            self.openImagePicker(for: .camera)
        }
    }
    
    func updatePhotoLibraryPermission(for granted: Bool) {
        if granted {
            self.openImagePicker(for: .photoLibrary)
        }
    }
}

extension NewProductViewController: NewProductPresentable {
    func reloadPickerView() {
        statePickerView.reloadAllComponents()
    }
    
    func presentProduct(product: Product) {
        productTextField.text = product.name
        if let data = product.image {
            productImageView.image = UIImage(data: data)
        }
        stateTextField.text = product.state?.name
        valueTextField.text = "\(product.value)"
        cardSwitch.setOn(product.isCreditCard, animated: false)
    }
}
