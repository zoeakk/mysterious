package com.lihuia.mysterious.common.ping;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.net.InetAddress;



@Slf4j
@Component
public class PingUtil {


    public void ping(String host) throws IOException {
        InetAddress address = InetAddress.getByName(host);
        boolean reachable = address.isReachable(5000);
        log.info("PingUtil, ping host {}, reachable {}", host, reachable);
    }

    public static void main(String[] args) {
        PingUtil pingUtil = new PingUtil();
        try {
            pingUtil.ping("8.8.8.8");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
