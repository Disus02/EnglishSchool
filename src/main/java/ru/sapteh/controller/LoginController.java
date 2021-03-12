package ru.sapteh.controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import ru.sapteh.model.Users;
import ru.sapteh.service.UsersService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class LoginController {

    private List<Users> usersList=new ArrayList<>();
    @FXML
    private TextField txtLogin;

    @FXML
    private Label status;

    @FXML
    private Button buttonOpen;

    @FXML
    private PasswordField txtPassword;
    public static String role;

    @FXML
    void exit(ActionEvent event) {
        System.exit(0);

    }

    @FXML
    void openMain(ActionEvent event) throws IOException {
        getList();
        if (txtLogin.getText().isEmpty()&&txtPassword.getText().isEmpty()) {
            status.setText("Логин и пароль не заполнены");
        }else if (txtLogin.getText().isEmpty()){
            status.setText("Логин пустой");
        }else if (txtPassword.getText().isEmpty()){
            status.setText("Пароль пустой");
        } else
        for (Users users:usersList){
            if (users.getLogin().equals(txtLogin.getText())&&users.getPassword().equals(txtPassword.getText())){
                role=users.getRole();
                buttonOpen.getScene().getWindow().hide();
                Parent parent= FXMLLoader.load(getClass().getResource("/view/main.fxml"));
                Stage stage=new Stage();
                stage.setTitle("Информация о товаре");
                stage.setScene(new Scene(parent));
                stage.show();
            }else status.setText("Неправельный логин или пароль");
        }

    }
    private void getList(){
        SessionFactory factory=new Configuration().configure().buildSessionFactory();
        UsersService usersService=new UsersService(factory);
        usersList=usersService.readByAll();
    }
}
