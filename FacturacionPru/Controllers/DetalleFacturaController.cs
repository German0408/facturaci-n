using FacturacionPru.Data;
using FacturacionPru.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FacturacionPru.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetalleFacturaController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public DetalleFacturaController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/DetalleFactura
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DetalleFactura>>> GetDetalleFacturas()
        {
            return await _context.DetallesFactura.ToListAsync();
        }

        // GET: api/DetalleFactura/5
        [HttpGet("{id}")]
        public async Task<ActionResult<DetalleFactura>> GetDetalleFactura(int id)
        {
            var detallefactura = await _context.DetallesFactura.FindAsync(id);
            if (detallefactura == null)
            {
                return NotFound();
            }
            return detallefactura;
        }

        // PUT: api/DetalleFactura/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDetalleFactura(int id, DetalleFactura detalleFactura)
        {
            if (id != detalleFactura.Id)
            {
                return BadRequest();
            }

            _context.Entry(detalleFactura).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!(DetalleFacturaExists(id)))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return NoContent();
        }

        // POST: api/DetalleFactura
        [HttpPost]
        public async Task<ActionResult<DetalleFactura>> PostPersona(DetalleFactura detalleFactura)
        {
            _context.DetallesFactura.Add(detalleFactura);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetDetalleFactura), new { id = detalleFactura.Id }, detalleFactura);
        }

        // DELETE: api/DetalleFactura/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDetalleFactura(int id)
        {
            var detalleFactura = await _context.DetallesFactura.FindAsync(id);
            if (detalleFactura == null)
            {
                return NotFound();
            }

            _context.DetallesFactura.Remove(detalleFactura);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool DetalleFacturaExists(int id)
        {
            return _context.DetallesFactura.Any(e => e.Id == id);
        }
    }
}


