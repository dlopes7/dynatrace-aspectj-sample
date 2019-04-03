package com.dynatrace.services.aspects;

import com.dynatrace.oneagent.sdk.OneAgentSDKFactory;
import com.dynatrace.oneagent.sdk.api.OneAgentSDK;
import com.dynatrace.oneagent.sdk.api.OutgoingWebRequestTracer;

import com.pega.apache.http.HttpClientConnection;
import com.pega.apache.http.HttpRequest;
import com.pega.apache.http.RequestLine;
import com.pega.apache.http.impl.DefaultHttpClientConnection;
import com.pega.apache.http.message.BasicHttpRequest;
import com.pega.apache.http.protocol.HttpContext;


public aspect DynatracePegaAspect {

    public static OneAgentSDK oneAgentSDK = OneAgentSDKFactory.createInstance();

    pointcut dynatraceExecutor(HttpRequest request,
                               HttpClientConnection conn,
                               HttpContext context): (execution(* com.pega.apache.http.protocol.HttpRequestExecutor.execute(..)) && args(request, conn, context));

    Object around(HttpRequest request,
                  HttpClientConnection conn,
                  HttpContext context): dynatraceExecutor(request, conn, context){

        OutgoingWebRequestTracer outgoingWebRequestTracer = null;
        try {

            // System.out.println("Entering the execute method!");
            RequestLine requestLine = request.getRequestLine();

            // System.out.println(conn.getClass().getCanonicalName());

            String host = ((DefaultHttpClientConnection) conn).getRemoteAddress().getHostAddress();
            int port = ((DefaultHttpClientConnection) conn).getRemotePort();


            //String url = String.format("http://%s:%d%s", host, port, requestLine.getUri());

            String url = "http://" + host + ":" + String.valueOf(port) + requestLine.getUri();
            // System.out.println(url);

            //String url = String.format("%s://%s:%d%s", requestLine.getProtocolVersion().getProtocol())
            outgoingWebRequestTracer = oneAgentSDK.traceOutgoingWebRequest(url, "GET");
            outgoingWebRequestTracer.start();

            ((BasicHttpRequest)request).addHeader(oneAgentSDK.DYNATRACE_HTTP_HEADERNAME,
                                                  outgoingWebRequestTracer.getDynatraceStringTag());

        }catch(Exception e){
            System.out.println("Error with AspectJ: " + e.getMessage());
        }

        Object ret = proceed(request, conn, context);

        try {
            //System.out.println("Leaving the execute method!");
            if (outgoingWebRequestTracer != null){
                outgoingWebRequestTracer.end();
            }


        }catch(Exception e){
            System.out.println("Error with AspectJ: " + e.getMessage());

        }

        return ret;

    }




}
