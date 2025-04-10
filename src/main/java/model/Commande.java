package model;

import java.sql.Timestamp;

public class Commande {
    private int id;
    private int utilisateurId;
    private Timestamp dateCommande;
    private String statut;
    private double montantTotal; // Not in DB but calculated
    
    // Default constructor
    public Commande() {
    }
    
    // Getters and setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUtilisateurId() {
        return utilisateurId;
    }
    
    public void setUtilisateurId(int utilisateurId) {
        this.utilisateurId = utilisateurId;
    }
    
    public Timestamp getDateCommande() {
        return dateCommande;
    }
    
    public void setDateCommande(Timestamp dateCommande) {
        this.dateCommande = dateCommande;
    }
    
    public String getStatut() {
        return statut;
    }
    
    public void setStatut(String statut) {
        this.statut = statut;
    }
    
    public double getMontantTotal() {
        return montantTotal;
    }
    
    public void setMontantTotal(double montantTotal) {
        this.montantTotal = montantTotal;
    }

	public void setUtilisateur(Utilisateur user) {
		this.utilisateurId =  user.getId();
		
	}
}