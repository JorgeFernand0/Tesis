
package Reportes;

import Modelo.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartFrame;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormatSymbols;
import java.util.HashMap;
import java.util.Map;

public class Grafico {
    public static void GraficarPorMes(int mes, int año) {
        Connection con;
        Conexion cn = new Conexion();
        PreparedStatement ps;
        ResultSet rs;
        try {
            String sql = "SELECT p.nombre, SUM(d.cantidad) AS cantidad_vendida, SUM(d.precio * d.cantidad) AS total_ganado, c.nombre AS cliente " +
                         "FROM ventas v " +
                         "JOIN detalle d ON v.id = d.id_venta " +
                         "JOIN productos p ON d.id_pro = p.id " +
                         "JOIN clientes c ON v.cliente = c.id " +
                         "WHERE MONTH(v.fecha) = ? AND YEAR(v.fecha) = ? " +
                         "GROUP BY p.nombre, c.nombre";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, mes);
            ps.setInt(2, año);
            rs = ps.executeQuery();
            
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            Map<String, Double> totalGanadoPorProducto = new HashMap<>();
            Map<String, Integer> cantidadVendidaPorProducto = new HashMap<>();
            Map<String, String> clientePorProducto = new HashMap<>();
            
            while (rs.next()) {
                String producto = rs.getString("nombre");
                int cantidadVendida = rs.getInt("cantidad_vendida");
                double totalGanado = rs.getDouble("total_ganado");
                String cliente = rs.getString("cliente");
                
                dataset.addValue(cantidadVendida, "Cantidad Vendida", producto);
                totalGanadoPorProducto.put(producto, totalGanado);
                cantidadVendidaPorProducto.put(producto, cantidadVendida);
                clientePorProducto.put(producto, cliente);
            }
            
            // Crear gráfico de barras
            JFreeChart barChart = ChartFactory.createBarChart(
                    "Productos más Vendidos - " + getMonthName(mes) + " " + año,
                    "Producto",
                    "Cantidad Vendida",
                    dataset,
                    PlotOrientation.VERTICAL,
                    true, true, false);
            
            ChartFrame frame = new ChartFrame("Reporte de Ventas", barChart);
            frame.setSize(1000, 500);
            frame.setLocationRelativeTo(null);
            frame.setVisible(true);
            
            // Crear reporte
            generarReporte(totalGanadoPorProducto, cantidadVendidaPorProducto, clientePorProducto, mes, año);
            
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }

    private static String getMonthName(int month) {
        return new DateFormatSymbols().getMonths()[month - 1];
    }

    private static void generarReporte(Map<String, Double> totalGanadoPorProducto, Map<String, Integer> cantidadVendidaPorProducto, Map<String, String> clientePorProducto, int mes, int año) {
        System.out.println("Reporte de Ventas - " + getMonthName(mes) + " " + año);
        System.out.println("----------------------------------------------------");
        for (String producto : totalGanadoPorProducto.keySet()) {
            System.out.println("Producto: " + producto);
            System.out.println("Cantidad Vendida: " + cantidadVendidaPorProducto.get(producto));
            System.out.println("Total Ganado: " + totalGanadoPorProducto.get(producto));
            System.out.println("Cliente: " + clientePorProducto.get(producto));
            System.out.println("----------------------------------------------------");
        }
    }

    public static void Graficar(String fechaReporte) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
