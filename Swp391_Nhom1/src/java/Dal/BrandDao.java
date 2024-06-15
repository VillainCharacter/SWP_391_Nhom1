/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;
import Model.Brand;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BrandDao extends DBContext{
    public List<Brand> getAllBrand(){
        List<Brand> list = new ArrayList<>();
        try{
           String sql = "SELECT * FROM Brand";
           PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                Brand a = new Brand();
                a.setId(rs.getInt(1));
                a.setName(rs.getString(2));
                list.add(a);
            }
        }catch(SQLException e){
                System.out.println(e);
                }
        return list;
    }
     public Brand getBrandById(String id){
        Brand brand = null;
        try{
            String sql = "Select * from Brand WHERE bid = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                brand = new Brand();
                brand.setId(rs.getInt("bid"));
                brand.setName(rs.getString("name"));
            }
        }catch(SQLException e){
            System.out.println(e);
        }
        return brand;
    }
    public static void main(String[] args) {

        BrandDao bao = new BrandDao();
        String testBrandId = "1"; 
        Brand brand = bao.getBrandById(testBrandId);

        if (bao != null) {
            System.out.println("Category found: " + brand);
        } else {
            System.out.println("No category found with ID: " + testBrandId);
        }
    }
}
