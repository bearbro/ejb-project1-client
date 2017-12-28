<%--
  Created by IntelliJ IDEA.
  User: bear
  Date: 2017/12/28
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="cn.edu.zjut.ejb.ProductCartRemote" pageEncoding="UTF-8" %>
<%@ page import="javax.naming.Context, javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%
    try {
        final Hashtable jndiProperties = new Hashtable();
        jndiProperties.put(Context.URL_PKG_PREFIXES, "org.jboss.ejb.client.naming");
        final Context context = new InitialContext(jndiProperties);
        final String appName = "";
        final String moduleName = "ejb_project1_war_exploded";
        final String distinctName = "";
        final String beanName = "ProductCartBean";
        final String viewClassName = ProductCartRemote.class.getName();
        final String namespace = "ejb:" + appName + "/" + moduleName
                + "/" + distinctName + "/" + beanName + "!" + viewClassName
                + "?stateful";
        ProductCartRemote cart = null;
        cart = (ProductCartRemote) session.getAttribute("cart");
        if (cart == null) {
            cart = (ProductCartRemote) context.lookup(namespace);
            session.setAttribute("cart", cart);
        } else {
            String productName = request.getParameter("product");
            String sPrice = request.getParameter("price");
            int price = 0;
            if (sPrice != null) price = Integer.parseInt(sPrice);
            cart.addProduct(productName, price);
            List<String> myProducts = cart.listProducts();
            out.println("Total Price:" + cart.totalPrice() + "<br>");
            out.println("My Products:<br>" + myProducts);
        }
    } catch (NamingException e) {
        e.printStackTrace();
    }
%>
<table border=1>
    <tr>
        <td><a href="myCart.jsp?product=fridge&price=3000">fridgebuy</a></td>
    </tr>
    <tr>
        <td><a href="myCart.jsp?product=ledtv&price=5000">ledtvbuy</a></td>
    </tr>
    <tr>
        <td><a href="myCart.jsp?product=waterheater&price=2800">waterheaterbuy</a></td>
    </tr>
    <tr>
        <td><a href="myCart.jsp?product=car&price=300000">carbuy</a></td>
    </tr>
</table>