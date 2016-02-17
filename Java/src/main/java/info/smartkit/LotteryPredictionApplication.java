package info.smartkit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan
public class LotteryPredictionApplication {

    public static void main(String[] args) {
        SpringApplication.run(LotteryPredictionApplication.class, args);
    }
}
