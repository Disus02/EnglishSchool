package ru.sapteh.controller;


import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
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
import javafx.stage.Stage;
import lombok.NonNull;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import ru.sapteh.dao.MyListener;
import ru.sapteh.model.Manufacture;
import ru.sapteh.model.Product;
import ru.sapteh.service.ManufactureService;
import ru.sapteh.service.ProductService;

import java.io.IOException;

public class ControllerMain {
    private final ObservableList<Product> products= FXCollections.observableArrayList();
    private final ObservableList<Manufacture> manufactures=FXCollections.observableArrayList();
    @FXML
    private TilePane tilePane;
    @FXML
    private ScrollPane scrollPane;
    @FXML
    private ComboBox<Manufacture> comboManufacture;
    @FXML
    private TextField txtSearch;
    @FXML
    private Button openCreateUser;
    FlowPane pane;

    private MyListener myListener;

    @FXML
    public void initialize() throws IOException {
        if (LoginController.role.equals("user")){
            openCreateUser.setVisible(false);
        }
        getListProduct();
        getManufacture();

        scrollPane.widthProperty().addListener(((observableValue, number, t1) ->
                tilePane.setPrefWidth(t1.doubleValue())));
        Stage stage=new Stage();
        FXMLLoader loader=new FXMLLoader(getClass().getResource("/view/updateProduct.fxml"));
        AnchorPane anchorPane=loader.load();
        stage.setScene(new Scene(anchorPane));
        stage.setTitle("Информация о товаре");
        UpdateProductController updateProductController=loader.getController();
        myListener=new MyListener() {
            @Override
            public void onClickListener(Product product) {
                updateProductController.setData(product);
                stage.show();
            }
        };
        openCreateUser();
        initializeData(products);
        search();
        sortManufacture();
    }
    private void initializeData(ObservableList<Product> products) throws IOException {
        tilePane.getChildren().clear();
        for (Product product:products) {
            FXMLLoader fxmlLoader= new FXMLLoader(getClass().getResource("/view/tile.fxml"));
            pane=fxmlLoader.load();
            TileController tileController=fxmlLoader.getController();
            tileController.setData(product,myListener);
            tilePane.getChildren().add(pane);
            if (product.getIsActive()==0){
                pane.setStyle("-fx-background-color: grey");
            }
        }
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
    private void search(){
        txtSearch.setOnKeyReleased(key->{
            ObservableList<Product> list=FXCollections.observableArrayList();
            for (Product product:products){
                if (product.getTitle().toLowerCase().contains(txtSearch.getText().toLowerCase())){
                    list.add(product);
                }
            }
            try {
                initializeData(list);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });

    }
    private void sortManufacture(){
        comboManufacture.valueProperty().addListener((obj,oldValue,newValue)->{
            ObservableList<Product> sort=FXCollections.observableArrayList();
            for (Product product:products){
                if (newValue.equals(product.getManufacture())){
                    sort.add(product);
                }
            }
            try {
                initializeData(sort);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
    private void openCreateUser(){
        openCreateUser.setOnAction(event -> {
            openCreateUser.getScene().getWindow().hide();
            try {
                Parent parent=FXMLLoader.load(getClass().getResource("/view/createUser.fxml"));
                Stage stage=new Stage();
                stage.setTitle("Регистрация пользователя");
                stage.setScene(new Scene(parent));
                stage.show();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }

}


