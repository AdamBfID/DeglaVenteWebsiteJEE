package model;



public class Produit {
    private int id;
    private String nom;
    private String variete;
    private double prix;
    private int stock;
    private String description;
    private String image;

    // Constructors, Getters & Setters
    public Produit() {}
    public Produit(int id , String nom , String variete , double prix , int stock , String description , String image) {
        this.id = id;
        this.nom = nom;
        this.variete = variete;
        this.prix = prix;
        this.stock = stock;
        this.description = description;
        this.image = image;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public String getVariete() {
        return variete;
    }
    public void setVariete(String variete) {
        this.variete = variete;
    }
    public double getPrix() {
        return prix;
    }
    public void setPrix(double prix) {
        this.prix = prix;
    }
    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }
    public String getDescription() {        
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    } 
    
    @Override
    public String toString() {
        return "Produit{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", variete='" + variete + '\'' +
                ", prix=" + prix +
                ", stock=" + stock +
                ", description='" + description + '\'' +
                '}';
    }
}