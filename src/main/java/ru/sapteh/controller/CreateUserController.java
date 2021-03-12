package ru.sapteh.controller;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import ru.sapteh.model.Users;
import ru.sapteh.service.UsersService;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class CreateUserController {
    ObservableList<String> list= FXCollections.observableArrayList();
    @FXML
    private TextField txtName;

    @FXML
    private TextField txtLogin;

    @FXML
    private TextField txtPassword;

    @FXML
    private ComboBox<String> comboRole;
    @FXML
    private Label status;

    @FXML
    private Button close;

    private String login;

    @FXML
    void initialize(){
        close.setOnAction(event -> {
            close.getScene().getWindow().hide();
            try {
                Parent parent = FXMLLoader.load(getClass().getResource("/view/main.fxml"));
                Stage stage=new Stage();
                stage.setTitle("Информация о товаре");
                stage.setScene(new Scene(parent));
                stage.show();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
        getRole();
        comboRole.setItems(list);
    }

    @FXML
    void createUser(ActionEvent event) {
        SessionFactory factory = new Configuration().configure().buildSessionFactory();
        UsersService usersService = new UsersService(factory);
        Users users = new Users();
        for (Users users1 : usersService.readByAll()) {
            if (users1.getLogin().equals(txtLogin.getText()))
                login = users1.getLogin();
        }
        if (!login.equals(txtLogin.getText())) {
            users.setName(txtName.getText());
            users.setRole(comboRole.getValue());
            users.setPassword(txtPassword.getText());
            users.setLogin(txtLogin.getText());
            usersService.create(users);
            status.setText(String.format("Пользователь %s зарегистрирован",users.getName()));
        }else status.setText("Логин занят");
    }
    private void getRole(){
        SessionFactory factory=new Configuration().configure().buildSessionFactory();
        UsersService usersService=new UsersService(factory);
        List<Users> users=usersService.readByAll();
        Set<String> roles=new HashSet<>();
        for (Users users1:users) {
            roles.add(users1.getRole());
        }
        list.addAll(roles);

    }
}
