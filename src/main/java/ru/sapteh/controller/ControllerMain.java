package ru.sapteh.controller;

import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Insets;
import javafx.geometry.Orientation;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.TilePane;
import javafx.scene.paint.Color;
import javafx.stage.Modality;
import javafx.stage.Stage;
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
    public static String title;
    public static String costs;
    public static String statuses;
    public static String imagePathes;
    @FXML
    private TilePane tilePane;
    @FXML
    private ScrollPane scrollPane;
    @FXML
    public void initialize(){
        tilePane.setAlignment(Pos.TOP_LEFT);
//        tilePane.setHgap(25);
        tilePane.setVgap(20);
        tilePane.setOrientation(Orientation.HORIZONTAL);
        tilePane.setPrefColumns(5);
        scrollPane.widthProperty().addListener(((observableValue, number, t1) ->
                tilePane.setPrefWidth(t1.doubleValue())));
        getListProduct();
        for (Product product:products) {
           tilePane.getChildren().add(getNode(product.getMainImagePath(),product.getTitle(),
                   product.getCost(),String.valueOf(product.getIsActive())));
        }
    }
    private Node getNode(String imagePath,String nameBook,double cost,String status){
        AnchorPane pane=new AnchorPane();
        pane.setPrefHeight(340);
        pane.setPrefWidth(200);
        Image image=new Image(imagePath);
        ImageView imageView=new ImageView(image);
        imageView.setFitHeight(300);
        imageView.setFitWidth(200);
        pane.getChildren().add(imageView);
        Label labelTitle=new Label();
        Label labelCost=new Label();

        Label labelActive=new Label();
        if (status.equals("0")){
            labelActive.setText("не активен");
            labelActive.setTextFill(Color.RED);
            pane.setStyle("-fx-background-color: grey");
        }else if(status.equals("1")){
            labelActive.setText("Активен");
            labelActive.setTextFill(Color.GREEN);
        }
        labelActive.setLayoutY(370);
        labelTitle.setLayoutY(300);
        labelCost.setLayoutY(350);
        labelTitle.setMaxWidth(200);
        labelTitle.setWrapText(true);
        labelCost.setText(String.format("%.0f рублей",cost));
        labelTitle.setText(String.format("%s",nameBook));
        pane.getChildren().add(labelTitle);
        pane.getChildren().add(labelCost);
        pane.getChildren().add(labelActive);
//        imageView.setOnMouseEntered(event->{
//            imageView.setFitWidth(300);
//            imageView.setFitHeight(400);
//        });
//        imageView.setOnMouseExited(event->{imageView.setFitWidth(200);
//        imageView.setFitHeight(300);
//        });
        pane.setOnMouseEntered(event->{
            pane.setPrefWidth(250);
            pane.setPrefHeight(390);
            imageView.setFitWidth(250);
        });

        pane.setOnMouseExited(event->{
            pane.setPrefWidth(200);
            pane.setPrefHeight(340);
            imageView.setFitWidth(200);
        });
        pane.setOnMouseClicked(event->{
            title=labelTitle.getText();
            statuses=labelActive.getText();
            imagePathes=imageView.getImage().getUrl();
            costs=labelCost.getText();
                    Stage stage=new Stage();
                    try {
                        Parent parent= FXMLLoader.load(getClass().getResource("/view/updateProduct.fxml"));
                        stage.setTitle("Лох");
                        stage.initModality(Modality.APPLICATION_MODAL);
                        stage.setScene(new Scene(parent));
                        stage.show();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                );
        return pane;
    }
    private void getListProduct(){
        SessionFactory factory=new Configuration().configure().buildSessionFactory();
        ProductService productService=new ProductService(factory);
        products.addAll(productService.readByAll());
    }

}

