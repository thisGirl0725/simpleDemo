package com.by;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.by.mapper")
public class ShiroDemon02Application {

    public static void main(String[] args) {
        SpringApplication.run(ShiroDemon02Application.class, args);
    }

}
