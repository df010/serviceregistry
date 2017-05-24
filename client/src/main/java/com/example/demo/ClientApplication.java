package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.feign.EnableFeignClients;
import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
public class ClientApplication {

	public static void main(String[] args) {
		SpringApplication.run(ClientApplication.class, args);
	}
}

@FeignClient("service1")
interface RestClient1 {
	@RequestMapping("/hi")
	public String hi();
}

@FeignClient("service2")
interface RestClient2 {
	@RequestMapping("/hi")
	public String hi();
}
@RestController
class Controller {

	@Autowired
	public RestClient1 restClient1;

	@Autowired
	public RestClient2 restClient2;

	public String hi(){
		return restClient1.hi() +" and "+restClient2.hi();
	}

}

