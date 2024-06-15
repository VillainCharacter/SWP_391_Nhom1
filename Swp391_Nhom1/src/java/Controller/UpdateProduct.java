/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

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
import java.util.ArrayList;

/**
 *
 * @author TRONG TAI
 */
public class UpdateProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProductController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        ProductDao dao = new ProductDao();
        Product product = dao.getProductById(productId);
        request.setAttribute("o", product);
        ProductDao pdao = new ProductDao();
        ArrayList<Category> cl = pdao.getCategory();
        request.setAttribute("category", cl);
        ArrayList<Brand> list = pdao.getBrand();
        request.setAttribute("brand", list);
        request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        // Mặc định giá trị của stock là 1 nếu người dùng không nhập hoặc nhập giá trị không hợp lệ
        int stock = 1;
        try {
            stock = Integer.parseInt(request.getParameter("stock"));
            // Kiểm tra nếu stock dưới 1, gán lại giá trị mặc định là 1
            if (stock < 1) {
                stock = 1;
            }
        } catch (NumberFormatException e) {
            // Xử lý khi người dùng nhập giá trị không hợp lệ
            stock = 1;
        }
        int brandId = Integer.parseInt(request.getParameter("brand"));
        int categoryId = Integer.parseInt(request.getParameter("category"));
        Brand brand = new Brand(brandId, "");
        Category category = new Category(categoryId, "");
        Product product = new Product();
        product.setId(productId);
        product.setName(name);
        product.setImage(image);
        product.setPrice((int) price);
        product.setDescription(description);
        product.setStock(stock); // Sử dụng giá trị stock đã xử lý
        product.setBrand(brand);
        product.setCategory(category);

        // Tạo instance của ProductDao và cập nhật sản phẩm
        ProductDao productDao = new ProductDao();
        productDao.editProduct(product);

        // Chuyển hướng về trang danh sách sản phẩm
        response.sendRedirect("manageproduct");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
