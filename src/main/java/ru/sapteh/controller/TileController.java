package ru.sapteh.controller;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import ru.sapteh.dao.MyListener;
import ru.sapteh.model.Product;

public class TileController {

    @FXML
    private ImageView imageView;

    @FXML
    private Label labelTitle;

    @FXML
    private Label labelCost;

    @FXML
    private Label labelIsActive;

    private Product product;
    private MyListener myListener;

    @FXML
    public void click(MouseEvent event){
        myListener.onClickListener(product);
    }

    public void setData(Product product,MyListener myListener){
        this.product=product;
        this.myListener=myListener;
        imageView.setImage(new Image(product.getMainImagePath()));
        labelTitle.setText(subTitle(product.getTitle()));
        labelCost.setText(String.format("%.0f",product.getCost()));
        labelIsActive.setText(isActive(product.getIsActive()));
    }
    private String subTitle(String title){
        if (title.length()<15)
            return title;
            return title.substring(0,15) + "...";
    }
    private String isActive(int active){
        return active==0?"не активен":"активен";
    }


}
