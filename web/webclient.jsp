<%--
  Created by IntelliJ IDEA.
  User: bear
  Date: 2017/12/28
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="cn.edu.zjut.ejb.UserServiceRemote" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="java.util.Hashtable" %>
<%
    try{
        final Hashtable jndiProperties = new Hashtable();
        jndiProperties.put(Context.URL_PKG_PREFIXES,
                "org.jboss.ejb.client.naming");
        final Context context = new InitialContext(jndiProperties);
        final String appName = "";
        final String moduleName = "ejb_project1_war_exploded";
        final String distinctName = "";
        final String beanName = "UserService";
        final String viewClassName = UserServiceRemote.class.getName();
        final String namespace = "ejb:" + appName + "/" + moduleName
                + "/" + distinctName + "/" + beanName + "!" + viewClassName;
        UserServiceRemote usBean =(UserServiceRemote)
                context.lookup(namespace);
        System.out.println(usBean);
        if(usBean.login("zjut","zjut"))
            out.println("login ok!");
        else
            out.println("login failed!");
    }catch(NamingException e){
        e.printStackTrace();
    }
%>