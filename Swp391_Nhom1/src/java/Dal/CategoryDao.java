/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author TRONG TAI
 */
public class CategoryDao extends DBContext{
     public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Category";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category a = new Category();
                a.setId(rs.getInt(1));
                a.setName(rs.getString(2));
                list.add(a);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;

    }
        public Category getCategoryById(String id){
        Category category = null;
        try{
            String sql = "Select * from Category WHERE cid = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                category = new Category();
                category.setId(rs.getInt("cid"));
                category.setName(rs.getString("name"));
            }
        }catch(Exception e){
            System.out.println(e);
        }
        return category;
    }
    public static void main(String[] args) {

        CategoryDao categoryDao = new CategoryDao();
        String testCategoryId = "1"; 
        Category category = categoryDao.getCategoryById(testCategoryId);

        if (category != null) {
            System.out.println("Category found: " + category);
        } else {
            System.out.println("No category found with ID: " + testCategoryId);
        }
    }
}
