package com.example.observability.controller;


import com.example.observability.service.SampleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api")
public class DemoController {
    private static final Logger logger = LoggerFactory.getLogger(DemoController.class);
    private final SampleService service;

    public DemoController(SampleService service) {
        this.service = service;
    }

    @GetMapping("/hello")
    public String hello() {
        logger.info("Hello from /hello endpoint");
        return "Hello, observability!";
    }

    @GetMapping("/slow")
    public String slow() throws InterruptedException {
        Thread.sleep(3000); // simulate delay
        return "This was slow!";
    }

    @GetMapping("/error")
    public String error() {
        logger.info("we are getting some exception");
        throw new RuntimeException("Simulated exception!");
    }

    @GetMapping("/business")
    public String business() {
        return service.processTransaction();
    }
}
