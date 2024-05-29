using FacturacionPru.Models;
using Microsoft.EntityFrameworkCore;

namespace FacturacionPru.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
             : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Persona>().HasKey(p => p.Id);
            modelBuilder.Entity<Producto>().HasKey(p => p.Id);
            modelBuilder.Entity<Factura>().HasKey(f => f.Id);
            modelBuilder.Entity<DetalleFactura>().HasKey(d => d.Id);

            modelBuilder.Entity<Factura>()
                .HasOne(f => f.Persona)
                .WithMany(p => p.Facturas)
                .HasForeignKey(f => f.PersonaId);

            //modelBuilder.Entity<DetalleFactura>()
            //    .HasKey(d => new { d.Id, d.FacturaId, d.ProductoId });

            modelBuilder.Entity<DetalleFactura>()
                .HasOne(df => df.Producto)
                .WithMany(p => p.DetallesFactura)
                .HasForeignKey(df => df.ProductoId);

            modelBuilder.Entity<DetalleFactura>()
                .HasOne(df => df.Factura)
                .WithMany(f => f.DetallesFactura)
                .HasForeignKey(df => df.FacturaId);

            modelBuilder.Entity<Persona>()
                .HasMany(p => p.Facturas)
                .WithOne(f => f.Persona)
                .HasForeignKey(f => f.PersonaId)
                .OnDelete(DeleteBehavior.Cascade);

        }

        public DbSet<Persona> Personas { get; set; }
        public DbSet<Factura> Facturas { get; set; }
        public DbSet<DetalleFactura> DetallesFactura { get; set; } // Cambio de nombre aquí
        public DbSet<Producto> Productos { get; set; }
    }
}
