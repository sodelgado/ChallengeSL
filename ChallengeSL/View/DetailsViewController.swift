//
//  DetailsViewController.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 29/3/22.
//
import Foundation
import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var identityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    
    @IBOutlet weak var imageDetail: UIImageView!
    
    var img = UIImageView()
    var titleText: String = ""
  var desc = """
    "Lepic - CONCESIONARIO OFICIAL RENAULT – CASA CENTRAL

    ¡¡¡¡¡LEER CON ATENCION!!!!!
    PRECIO PUBLICADO NO INCLUYE GASTOS

    UNIDAD DISPONIBLE EN CONCESIONARIO PARA ENTREGA INMEDIATA
    STOCK FÍSICO (Nro de Chasis y Motor)

    ---------------------------------------------------------------------------------
    (Precio publicado no incluye gastos)
    NUEVAS OPORTUNIDADES 2021
    (Deposito – Transferencia bancaria - Cheque Común)
    ---------------------------------------------------------------------------------

    ENTREGA INMEDIATA - NO ES PLAN DE AHORRO

    UNIDAD DISPONIBLE EN CONCESIONARIO PARA ENTREGA INMEDIATA
"""
    var identity: String = "Vendedor con identidad verificada"
    var descTitle: String = "Descripción"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        identityLabel.text = identity
        descriptionTitleLabel.text = descTitle
        descriptionLabel.text = desc
        titleLabel.text = titleText
        nameLabel.text = titleText
        imageDetail.image = img.image
        
    }
}
