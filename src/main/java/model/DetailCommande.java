package model;

import java.math.BigDecimal;

public class DetailCommande {
    private int id;
    private int commandeId;
    private int produitId;
    private int quantite;
    private BigDecimal prixUnitaire;
    
    // Default constructor
    public DetailCommande() {
    }
    
    // Getters and setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getCommandeId() {
        return commandeId;
    }
    
    public void setCommandeId(int commandeId) {
        this.commandeId = commandeId;
    }
    
    public int getProduitId() {
        return produitId;
    }
    
    public void setProduitId(int produitId) {
        this.produitId = produitId;
    }
    
    public int getQuantite() {
        return quantite;
    }
    
    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }
    
    public BigDecimal getPrixUnitaire() {
        return prixUnitaire;
    }
    
    public void setPrixUnitaire(BigDecimal prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }
    
    // Added for convenience
    public void setPrixUnitaire(double prixUnitaire) {
        this.prixUnitaire = BigDecimal.valueOf(prixUnitaire);
    }
    
    // Calculate total for this line item
    public BigDecimal getTotal() {
        return prixUnitaire.multiply(BigDecimal.valueOf(quantite));
    }
}