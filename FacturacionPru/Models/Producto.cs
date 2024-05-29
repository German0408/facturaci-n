namespace FacturacionPru.Models
{
    public class Producto
    {
        public int Id { get; set; }
        public string Descripcion { get; set; }
        public decimal? Precio { get; set; }
        public decimal? Costo { get; set; }
        public string? UnidadMedida { get; set; }

        // Relación con DetalleFactura
        public ICollection<DetalleFactura>? DetallesFactura { get; set; }

    }
}
