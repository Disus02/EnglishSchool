package ru.sapteh.model;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import lombok.*;

import javax.persistence.*;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@RequiredArgsConstructor
@Entity
@Table(name = "product")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @NonNull
    private String title;
    @NonNull
    private double cost;
    private String description;
    @NonNull
    private String mainImagePath;
    @NonNull
    private int isActive;
    @ManyToOne(cascade = CascadeType.ALL)
    @NonNull
    private Manufacture manufacture;
    @OneToMany(cascade = CascadeType.ALL,fetch = FetchType.EAGER,mappedBy = "product")
    private Set<ProductSale> productSales;
    @Transient
    private ImageView imagePath;

    public ImageView getImagePath() throws IOException {
        InputStream is= new FileInputStream("C:/Users/student/Desktop/Экзамен Стожков/09A_1.9_6/Сессия 1/products_s_import.zip/".concat(mainImagePath));
        ImageView imageView=new ImageView(new Image(is));
        is.close();
        imageView.setOnMouseEntered(mouseEvent->{
                imageView.setFitHeight(123);
                imageView.setFitWidth(232);});

        return imageView;
    }
}
