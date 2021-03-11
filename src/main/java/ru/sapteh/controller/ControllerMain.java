package ru.sapteh.controller;


import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Orientation;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.TilePane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import ru.sapteh.dao.MyListener;
import ru.sapteh.model.Manufacture;
import ru.sapteh.model.Product;
import ru.sapteh.service.ManufactureService;
import ru.sapteh.service.ProductService;

import java.io.IOException;

public class ControllerMain {
    private ObservableList<Product> products= FXCollections.observableArrayList();
    private ObservableList<Manufacture> manufactures=FXCollections.observableArrayList();
    @FXML
    private TilePane tilePane;
    @FXML
    private ScrollPane scrollPane;
    @FXML
    private ComboBox<Manufacture> comboManufacture;
    @FXML
    private TextField txtSearch;

    FlowPane pane;

    private MyListener myListener;

    @FXML
    public void initialize() throws IOException {
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

    }

}


