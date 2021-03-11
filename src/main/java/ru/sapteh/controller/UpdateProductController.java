package ru.sapteh.controller;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import ru.sapteh.model.Product;

public class UpdateProductController {
    @FXML
    private ImageView imageProduct;

    @FXML
    private Label labelID;

    @FXML
    private Label labelTitle;

    @FXML
    private Label labelCost;

    @FXML
    private Label labelDescription;

    @FXML
    private Label labelIsActive;

    @FXML
    private Label labelManufacture;

    public void setData(Product product){
        imageProduct.setImage(new Image(product.getMainImagePath()));
        labelID.setText(String.format("%d",product.getId()));
        labelTitle.setText(product.getTitle());
        labelDescription.setText(product.getDescription());
        labelCost.setText(String.format("%.0f",product.getCost()));
        labelIsActive.setText(isActive(product.getIsActive()));
        labelManufacture.setText(product.getManufacture().getName());

    }
    private String isActive(int active){
        return active==0?"Не активен":"Активен";
    }
}
