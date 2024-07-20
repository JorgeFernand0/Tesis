package Modelo;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.Desktop;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.swing.filechooser.FileSystemView;

public class VentaDao {
    Connection con;
    Conexion cn = new Conexion();
    PreparedStatement ps;
    ResultSet rs;
    int r;

    public int IdVenta(){
        int id = 0;
        String sql = "SELECT MAX(id) FROM ventas";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return id;
    }

    public int RegistrarVenta(Venta v){
        String sql = "INSERT INTO ventas (cliente, vendedor, total, fecha) VALUES (?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, v.getCliente());
            ps.setString(2, v.getVendedor());
            ps.setDouble(3, v.getTotal());
            ps.setString(4, v.getFecha());
            ps.execute();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }finally{
            try {
                con.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
        }
        return r;
    }

    public int RegistrarDetalle(Detalle Dv){
        String sql = "INSERT INTO detalle (id_pro, cantidad, precio, id_venta) VALUES (?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, Dv.getId_pro());
            ps.setInt(2, Dv.getCantidad());
            ps.setDouble(3, Dv.getPrecio());
            ps.setInt(4, Dv.getId());
            ps.execute();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }finally{
            try {
                con.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
        }
        return r;
    }

    public boolean ActualizarStock(int cant, int id){
        String sql = "UPDATE productos SET stock = ? WHERE id = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1,cant);
            ps.setInt(2, id);
            ps.execute();
            return true;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return false;
        }
    }

    public List Listarventas(){
        List<Venta> ListaVenta = new ArrayList();
        String sql = "SELECT c.id AS id_cli, c.nombre, v.* FROM clientes c INNER JOIN ventas v ON c.id = v.cliente";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Venta vent = new Venta();
                vent.setId(rs.getInt("id"));
                vent.setNombre_cli(rs.getString("nombre"));
                vent.setVendedor(rs.getString("vendedor"));
                vent.setTotal(rs.getDouble("total"));
                ListaVenta.add(vent);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return ListaVenta;
    }

    public Venta BuscarVenta(int id){
        Venta cl = new Venta();
        String sql = "SELECT * FROM ventas WHERE id = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                cl.setId(rs.getInt("id"));
                cl.setCliente(rs.getInt("cliente"));
                cl.setTotal(rs.getDouble("total"));
                cl.setVendedor(rs.getString("vendedor"));
                cl.setFecha(rs.getString("fecha"));
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return cl;
    }

    public void pdfV(int idventa, int Cliente, double total, String usuario) {
        try {
            Date date = new Date();
            FileOutputStream archivo;
            String url = FileSystemView.getFileSystemView().getDefaultDirectory().getPath();
            File salida = new File(url + "/venta.pdf");
            archivo = new FileOutputStream(salida);
            Document doc = new Document();
            PdfWriter.getInstance(doc, archivo);
            doc.open();
            Image img = Image.getInstance(getClass().getResource("/Img/HTLog.png"));
            
            // Configuración de fuente
            Font negrita = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);
            Font normal = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.BLACK);

            // Fecha y detalles del vendedor
            Paragraph fecha = new Paragraph();
            fecha.add(Chunk.NEWLINE);
            fecha.add(new Phrase("Vendedor: " + usuario + "\n", normal));
            fecha.add(new Phrase("Folio: " + idventa + "\n", normal));
            fecha.add(new Phrase("Fecha: " + new SimpleDateFormat("dd/MM/yyyy").format(date) + "\n\n", normal));
            
            PdfPTable encabezado = new PdfPTable(4);
            encabezado.setWidthPercentage(100);
            encabezado.getDefaultCell().setBorder(0);
            float[] columnWidthsEncabezado = new float[]{20f, 30f, 70f, 40f};
            encabezado.setWidths(columnWidthsEncabezado);
            encabezado.setHorizontalAlignment(Element.ALIGN_LEFT);
            encabezado.addCell(img);
            encabezado.addCell("");
            
            // Información de la empresa
            String config = "SELECT * FROM config";
            String mensaje = "";
            try {
                con = cn.getConnection();
                ps = con.prepareStatement(config);
                rs = ps.executeQuery();
                if (rs.next()) {
                    mensaje = rs.getString("mensaje");
                    encabezado.addCell(new Phrase("Rfc: " + rs.getString("rfc") + "\nNombre: " + rs.getString("nombre") + "\nTeléfono: " + rs.getString("telefono") + "\nDirección: " + rs.getString("direccion") + "\n\n", normal));
                }
            } catch (SQLException e) {
                System.out.println(e.toString());
            }

            encabezado.addCell(fecha);
            doc.add(encabezado);

            // Datos del cliente
            Paragraph cli = new Paragraph();
            cli.add(Chunk.NEWLINE);
            cli.add(new Phrase("DATOS DEL CLIENTE" + "\n\n", negrita));
            doc.add(cli);

            PdfPTable proveedor = new PdfPTable(3);
            proveedor.setWidthPercentage(100);
            proveedor.getDefaultCell().setBorder(0);
            float[] columnWidthsCliente = new float[]{50f, 25f, 25f};
            proveedor.setWidths(columnWidthsCliente);
            proveedor.setHorizontalAlignment(Element.ALIGN_LEFT);
            PdfPCell cliNom = new PdfPCell(new Phrase("Nombre", negrita));
            PdfPCell cliTel = new PdfPCell(new Phrase("Teléfono", negrita));
            PdfPCell cliDir = new PdfPCell(new Phrase("Dirección", negrita));
            cliNom.setBorder(Rectangle.NO_BORDER);
            cliTel.setBorder(Rectangle.NO_BORDER);
            cliDir.setBorder(Rectangle.NO_BORDER);
            proveedor.addCell(cliNom);
            proveedor.addCell(cliTel);
            proveedor.addCell(cliDir);

            String prove = "SELECT * FROM clientes WHERE id = ?";
            try {
                ps = con.prepareStatement(prove);
                ps.setInt(1, Cliente);
                rs = ps.executeQuery();
                if (rs.next()) {
                    proveedor.addCell(new Phrase(rs.getString("nombre"), normal));
                    proveedor.addCell(new Phrase(rs.getString("telefono"), normal));
                    proveedor.addCell(new Phrase(rs.getString("direccion") + "\n\n", normal));
                } else {
                    proveedor.addCell(new Phrase("Publico en General", normal));
                    proveedor.addCell(new Phrase("S/N", normal));
                    proveedor.addCell(new Phrase("S/N" + "\n\n", normal));
                }
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
            doc.add(proveedor);

            // Detalle de la venta
            PdfPTable tabla = new PdfPTable(4);
            tabla.setWidthPercentage(100);
            tabla.getDefaultCell().setBorder(0);
            float[] columnWidths = new float[]{10f, 50f, 15f, 15f};
            tabla.setWidths(columnWidths);
            tabla.setHorizontalAlignment(Element.ALIGN_LEFT);
            PdfPCell c1 = new PdfPCell(new Phrase("Cantidad", negrita));
            PdfPCell c2 = new PdfPCell(new Phrase("Descripción", negrita));
            PdfPCell c3 = new PdfPCell(new Phrase("Precio Unidad", negrita));
            PdfPCell c4 = new PdfPCell(new Phrase("Precio Total", negrita));
            c1.setBorder(Rectangle.NO_BORDER);
            c2.setBorder(Rectangle.NO_BORDER);
            c3.setBorder(Rectangle.NO_BORDER);
            c4.setBorder(Rectangle.NO_BORDER);
            c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
            c2.setBackgroundColor(BaseColor.LIGHT_GRAY);
            c3.setBackgroundColor(BaseColor.LIGHT_GRAY);
            c4.setBackgroundColor(BaseColor.LIGHT_GRAY);
            tabla.addCell(c1);
            tabla.addCell(c2);
            tabla.addCell(c3);
            tabla.addCell(c4);

            String product = "SELECT d.id, d.id_pro, d.id_venta, d.precio, d.cantidad, p.id, p.nombre FROM detalle d INNER JOIN productos p ON d.id_pro = p.id WHERE d.id_venta = ?";
            try {
                ps = con.prepareStatement(product);
                ps.setInt(1, idventa);
                rs = ps.executeQuery();
                while (rs.next()) {
                    double subTotal = rs.getInt("cantidad") * rs.getDouble("precio");
                    tabla.addCell(new Phrase(rs.getString("cantidad"), normal));
                    tabla.addCell(new Phrase(rs.getString("nombre"), normal));
                    tabla.addCell(new Phrase(rs.getString("precio"), normal));
                    tabla.addCell(new Phrase(String.valueOf(subTotal), normal));
                }
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
            doc.add(tabla);

            // Total a pagar
            Paragraph info = new Paragraph();
            info.add(Chunk.NEWLINE);
            info.add(new Phrase("Total a pagar: " + total, negrita));
            info.setAlignment(Element.ALIGN_RIGHT);
            doc.add(info);

            // Firmas
            PdfPTable firmaTable = new PdfPTable(3);
            firmaTable.setWidthPercentage(100);
            firmaTable.setWidths(new float[]{2, 1, 2});

            // Añadir espacio vertical adicional antes de las firmas
            Paragraph emptyParagraph = new Paragraph();
            emptyParagraph.add(new Chunk(Chunk.NEWLINE));
            emptyParagraph.add(new Chunk(Chunk.NEWLINE));
            
            PdfPCell emptyCell1 = new PdfPCell(emptyParagraph);
            emptyCell1.setBorder(Rectangle.NO_BORDER);
            firmaTable.addCell(emptyCell1);

            PdfPCell emptyCell2 = new PdfPCell(emptyParagraph);
            emptyCell2.setBorder(Rectangle.NO_BORDER);
            firmaTable.addCell(emptyCell2);

            PdfPCell emptyCell3 = new PdfPCell(emptyParagraph);
            emptyCell3.setBorder(Rectangle.NO_BORDER);
            firmaTable.addCell(emptyCell3);

            PdfPCell cellVendedor = new PdfPCell();
            cellVendedor.setBorder(Rectangle.NO_BORDER);
            cellVendedor.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellVendedor.addElement(new Paragraph("------------------------------------", normal));
            cellVendedor.addElement(new Paragraph("Firma Vendedor", normal));
            firmaTable.addCell(cellVendedor);

            PdfPCell cellCancelacion = new PdfPCell();
            cellCancelacion.setBorder(Rectangle.NO_BORDER);
            cellCancelacion.setHorizontalAlignment(Element.ALIGN_CENTER);
            cellCancelacion.addElement(new Paragraph("Cancelación", normal));
            firmaTable.addCell(cellCancelacion);

            PdfPCell cellCliente = new PdfPCell();
            cellCliente.setBorder(Rectangle.NO_BORDER);
            cellCliente.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cellCliente.setPaddingLeft(20f);
            cellCliente.addElement(new Paragraph("------------------------------------", normal));
            cellCliente.addElement(new Paragraph("Firma Cliente", normal));
            firmaTable.addCell(cellCliente);

            doc.add(firmaTable);

            // Mensaje final
            Paragraph gr = new Paragraph();
            gr.add(Chunk.NEWLINE);
            gr.add(new Phrase(mensaje, normal));
            gr.setAlignment(Element.ALIGN_CENTER);
            doc.add(gr);

            doc.close();
            archivo.close();
            Desktop.getDesktop().open(salida);
        } catch (DocumentException | IOException e) {
            System.out.println(e.toString());
        }
    }
}
