﻿namespace FacturacionPru.Models
{
    public class Persona
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string? Apellido { get; set; }
        public string? TipoDocumento { get; set; }
        public string? Documento { get; set; }
        public ICollection<Factura>? Facturas { get; set; }
    }
}
