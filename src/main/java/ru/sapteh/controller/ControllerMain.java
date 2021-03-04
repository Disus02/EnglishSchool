package ru.sapteh.controller;

import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.FlowPane;
import javafx.scene.paint.Color;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import ru.sapteh.model.Manufacture;
import ru.sapteh.model.Product;
import ru.sapteh.service.ManufactureService;
import ru.sapteh.service.ProductService;

import java.io.FileNotFoundException;
import java.io.IOException;

public class ControllerMain {
    private ObservableList<Product> products= FXCollections.observableArrayList();
    private ObservableList<Manufacture> manufactures=FXCollections.observableArrayList();
    @FXML
    private FlowPane flowPane;
    @FXML
    private ComboBox<Manufacture> comboManufacture;
    @FXML
    public void initialize(){
        flowPane.setAlignment(Pos.TOP_LEFT);
        flowPane.setHgap(10);
        flowPane.setVgap(20);
        getListProduct();
        for (Product product:products) {
            System.out.println(product.getManufacture());
           flowPane.getChildren().add(getNode(product.getMainImagePath(),product.getTitle(),
                   product.getCost(),String.valueOf(product.getIsActive())));
        }
    }
    private Node getNode(String imagePath,String nameBook,double cost,String status){
        AnchorPane pane=new AnchorPane();
        pane.setPrefHeight(270);
        Image image=new Image(imagePath);
        ImageView imageView=new ImageView(image);
        imageView.setFitWidth(200);
        imageView.setFitHeight(250);
        pane.getChildren().add(imageView);
        Label labelTitle=new Label();
        Label labelActive=new Label();
        if (status.equals("0")){
            labelActive.setText("не активен");
            labelActive.setTextFill(Color.RED);
            pane.setStyle("-fx-background-color: grey");
        }else if(status.equals("1")){
            labelActive.setText("Активен");
            labelActive.setTextFill(Color.GREEN);
        }
        labelActive.setLayoutY(300);
        labelTitle.setLayoutY(270);
        labelTitle.setText(String.format("%s \n %.0f рублей",nameBook,cost));
        pane.getChildren().add(labelTitle);
        pane.getChildren().add(labelActive);
        return pane;
    }
    private void getListProduct(){
        SessionFactory factory=new Configuration().configure().buildSessionFactory();
        ProductService productService=new ProductService(factory);
        products.addAll(productService.readByAll());
    }
    private void getManufacture(){
        SessionFactory factory=new Configuration().configure().buildSessionFactory();
        ManufactureService manufactureService=new ManufactureService(factory);
        manufactures.addAll(manufactureService.readByAll());
        comboManufacture.setItems(manufactures);
    }
    private void sortManufacture(){
        getManufacture();
        comboManufacture.setOnAction(event -> {
            ObservableList<Product> productList=FXCollections.observableArrayList();
            for (Product product:products) {
                System.out.println(product.getManufacture());
//                if (comboManufacture.getValue().equals(product.getManufacture())) {
//                    productList.addAll(product);
//                    products.clear();
//                    System.out.println(productList);
//                    for (Product product1 : productList) {
//                        flowPane.getChildren().add(getNode(product1.getMainImagePath(), product1.getTitle(), product1.getCost(), String.valueOf(product1.getIsActive())));
//                    }
//                }
            }
        });
//        ObservableList<Product> productList=FXCollections.observableArrayList();
//        for (Product product:products) {
//            if (comboManufacture.getValue().equals(product.getManufacture())){
//                productList.addAll(product);
//                System.out.println(productList);
//                for (Product product1:productList) {
//                    flowPane.getChildren().add(getNode(product1.getMainImagePath(),product1.getTitle(),product1.getCost(),String.valueOf(product1.getIsActive())));
//                }
//            }
//        }
    }
}

