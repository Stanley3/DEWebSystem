package com.zh.rest.services;

import org.glassfish.jersey.jackson.JacksonFeature;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.spring.scope.RequestContextFilter;

public class ZHApplication extends ResourceConfig {
	public ZHApplication(){
	register(RequestContextFilter.class);
	register(ZH_GuestService.class);
	register(ZH_UserService.class);
	register(ZH_AreaService.class);
	register(ZH_VehicleService.class);
	register(JacksonFeature.class);
	}
}