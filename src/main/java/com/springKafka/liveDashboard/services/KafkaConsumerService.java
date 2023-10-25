package com.springKafka.liveDashboard.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.concurrent.ThreadLocalRandom;

@Service
public class KafkaConsumerService {

    @Autowired
    SimpMessagingTemplate template;
    private Integer start = 50;

    @Scheduled(fixedRate = 60000)
    public void consume() {
        Integer randomNum = ThreadLocalRandom.current().nextInt(1, 9);
        Integer finalNumber = start + randomNum;
        if (isNumeric(String.valueOf(finalNumber))) {
            template.convertAndSend("/topic/temperature", String.valueOf(finalNumber));
        }

    }

    public boolean isNumeric(String str) {
        try {
            @SuppressWarnings("unused")
            double d = Double.parseDouble(str);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }

}
