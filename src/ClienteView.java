import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;
import java.util.ArrayList;
import Modelo.Cliente;
import Modelo.ClienteDao;

public class ClienteView extends JFrame {

    private JTextField BuscarCliente;
    private JButton buscarcliente;
    private JTable tablaClientes;
    private ClienteDao clienteDao;

    public ClienteView() {
        setTitle("Gestión de Clientes");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(null);

        clienteDao = new ClienteDao();

        JLabel lblBuscar = new JLabel("Buscar Cliente:");
        lblBuscar.setBounds(20, 20, 100, 30);
        add(lblBuscar);

        BuscarCliente = new JTextField();
        BuscarCliente.setBounds(130, 20, 200, 30);
        add(BuscarCliente);

        buscarcliente = new JButton("Buscar");
        buscarcliente.setBounds(340, 20, 100, 30);
        add(buscarcliente);

        tablaClientes = new JTable();
        JScrollPane scrollPane = new JScrollPane(tablaClientes);
        scrollPane.setBounds(20, 60, 740, 480);
        add(scrollPane);

        buscarcliente.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String input = BuscarCliente.getText().trim();
                if (!input.isEmpty()) {
                    Cliente cliente = clienteDao.BuscarCliente(input);
                    if (cliente.getId() != 0) {
                        mostrarClienteEnTabla(cliente);
                    } else {
                        JOptionPane.showMessageDialog(null, "Cliente no encontrado");
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Por favor, ingrese un DNI o nombre");
                }
            }
        });

        cargarClientes();
    }

    private void cargarClientes() {
        List<Cliente> clientes = clienteDao.ListarCliente();
        mostrarClientesEnTabla(clientes);
    }

    private void mostrarClientesEnTabla(List<Cliente> clientes) {
        String[] columnas = {"ID", "DNI", "Nombre", "Teléfono", "Dirección"};
        String[][] datos = new String[clientes.size()][5];
        for (int i = 0; i < clientes.size(); i++) {
            Cliente cliente = clientes.get(i);
            datos[i][0] = String.valueOf(cliente.getId());
            datos[i][1] = cliente.getDni();
            datos[i][2] = cliente.getNombre();
            datos[i][3] = cliente.getTelefono();
            datos[i][4] = cliente.getDireccion();
        }
        tablaClientes.setModel(new javax.swing.table.DefaultTableModel(datos, columnas));
    }

    private void mostrarClienteEnTabla(Cliente cliente) {
        List<Cliente> clientes = new ArrayList<>();
        clientes.add(cliente);
        mostrarClientesEnTabla(clientes);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new ClienteView().setVisible(true);
        });
    }
}
