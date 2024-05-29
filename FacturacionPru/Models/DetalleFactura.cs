using System.ComponentModel.DataAnnotations;

namespace FacturacionPru.Models
{
    public class DetalleFactura
    {
        public int Id { get; set; }

        // Definir las demás propiedades de la entidad
        public int Cantidad { get; set; }
        public int? Linea { get; set; }
        // Otras propiedades...

        // Relación con Producto
        public int? ProductoId { get; set; }
        public Producto? Producto { get; set; }

        // Relación con Factura
        public int? FacturaId { get; set; }
        public Factura? Factura { get; set; }
    }
}
