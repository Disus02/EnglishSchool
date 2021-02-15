package ru.sapteh.controller;

import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.image.ImageView;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import ru.sapteh.model.Product;
import ru.sapteh.service.ProductService;

import java.io.FileNotFoundException;
import java.io.IOException;

public class ControllerMain {
    private ObservableList<Product> products= FXCollections.observableArrayList();
    @FXML
    private TableView<Product> tableProduct;
    @FXML
    private TableColumn<Product,String> columnTitle;
    @FXML
    private TableColumn<Product,Double> columnCost;
    @FXML
    private TableColumn<Product,Integer> columnStatus;
    @FXML
    private TableColumn<Product, ImageView> columnImage;
    @FXML
    public void initialize(){
        SessionFactory factory=new Configuration().configure().buildSessionFactory();
        ProductService productService=new ProductService(factory);
        products.addAll(productService.readByAll());
        columnTitle.setCellValueFactory(p->new SimpleObjectProperty<>(p.getValue().getTitle()));
        columnCost.setCellValueFactory(p->new SimpleObjectProperty<>(p.getValue().getCost()));
        columnStatus.setCellValueFactory(p->new SimpleObjectProperty<>(p.getValue().getIsActive()));
        columnImage.setCellValueFactory(p-> {
            try {
                return new SimpleObjectProperty<>(p.getValue().getImagePath());
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        });
            tableProduct.setItems(products);

    }
}

