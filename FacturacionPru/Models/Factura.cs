namespace FacturacionPru.Models
{
    public class Factura
    {
        public int Id { get; set; }
        public int Numero { get; set; }
        public DateTime? Fecha { get; set; }

        // Propiedad de navegación para la persona asociada a esta factura
        public int? PersonaId { get; set; } // Clave foránea
        public Persona? Persona { get; set; } // Objeto de navegación

        // Propiedad de navegación para los detalles de factura
        public ICollection<DetalleFactura>? DetallesFactura { get; set; }
    }
}
