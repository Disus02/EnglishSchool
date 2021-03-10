package ru.sapteh.controller;

import javafx.fxml.FXML;
import javafx.scene.control.TextField;

public class UpdateProductController {
    @FXML
    private TextField txtPath;

    @FXML
    private TextField txtTitle;

    @FXML
    private TextField txtCost;

    @FXML
    private TextField txtStatus;

    @FXML
    public void initialize(){
        txtTitle.setText(ControllerMain.title);
        txtPath.setText(ControllerMain.imagePathes);
        txtCost.setText(ControllerMain.costs);
        txtStatus.setText(ControllerMain.statuses);
    }
}
