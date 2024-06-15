/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Dal.BrandDao;
import Dal.CategoryDao;
import Dal.ProductDao;
import Model.Brand;
import Model.Category;
import Model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author TRONG TAI
 */
public class AddProduct extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String priceStr = request.getParameter("price");
            int stock = Integer.parseInt(request.getParameter("stock"));
            String img = request.getParameter("image");
            String description = request.getParameter("description");
            String name = request.getParameter("name");
            String categoryId = request.getParameter("category");
            String brandId = request.getParameter("brand");
            double price = Double.parseDouble(priceStr);
            CategoryDao cao = new CategoryDao();
            BrandDao bao = new BrandDao();
            Category c = cao.getCategoryById(categoryId);
            Brand b = bao.getBrandById(brandId);
            Product product = new Product();
            product.setCategory(c);
            product.setBrand(b);
            product.setName(name);
            product.setImage(img);
            product.setPrice((int) price);
            product.setDescription(description);
            product.setStock(stock);
            ProductDao pdao = new ProductDao();
            pdao.addProduct(product);
            response.sendRedirect("manageproduct");
            
        }
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
