/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.edu.um.mateo.contabilidad.dao;

import mx.edu.um.mateo.contabilidad.dao.CuentaMayorDao;
import java.util.List;
import java.util.Map;
import mx.edu.um.mateo.general.model.Empresa;
import mx.edu.um.mateo.general.test.BaseTest;
import mx.edu.um.mateo.general.utils.UltimoException;
import mx.edu.um.mateo.contabilidad.model.CuentaMayor;
import mx.edu.um.mateo.contabilidad.model.Ejercicio;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import static org.junit.Assert.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author nujev
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:mateo.xml", "classpath:security.xml"})
@Transactional
public class CuentaMayorDaoTest extends BaseTest {

    private static final Logger log = LoggerFactory.getLogger(CuentaMayorDaoTest.class);
    @Autowired
    private CuentaMayorDao instance;
    @Autowired
    private SessionFactory sessionFactory;

    private Session currentSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * Test of lista method, of class CuentaMayorDao.
     */
    @Test
    public void deberiaMostrarListaDeCtaMayor() {
        log.debug("Debiera mostrar lista de ctaMayor");
        Ejercicio ejercicio = new Ejercicio("test", "A");
        currentSession().save(ejercicio);
        assertNotNull(ejercicio);
        log.debug("ejercicio >>" + ejercicio);
        for (int i = 0; i < 20; i++) {
            CuentaMayor ctaMayor = new CuentaMayor("test" + i, "test");
            currentSession().save(ctaMayor);
            assertNotNull(ctaMayor);
            log.debug("ctaMayor>>" + ctaMayor);
        }

        Map<String, Object> params = null;
        Map result = instance.lista(params);
        assertNotNull(result.get("ctaMayores"));
        assertNotNull(result.get("cantidad"));

        assertEquals(10, ((List<Empresa>) result.get("ctaMayores")).size());
        assertEquals(20, ((Long) result.get("cantidad")).intValue());
    }

    @Test
    public void debieraObtenerCtaMayor() {
        log.debug("Debiera obtener ctaMayor");
        CuentaMayor ctaMayor = new CuentaMayor("test", "test");
        currentSession().save(ctaMayor);
        assertNotNull(ctaMayor.getId());
        Long id = ctaMayor.getId();

        CuentaMayor result = instance.obtiene(id);
        assertNotNull(result);
        assertEquals("test", result.getNombre());
    }

    @Test
    public void deberiaCrearCtaMayor() {
        log.debug("Deberia crear CtaMayor");
        CuentaMayor ctaMayor = new CuentaMayor("test", "test");
        assertNotNull(ctaMayor);
        log.debug("ctaMayor >> " + ctaMayor);
        ctaMayor = instance.crea(ctaMayor);
        assertNotNull(ctaMayor.getId());
    }
    
    @Test
    public void deberiaActualizarCtaMayor() {
        log.debug("Deberia actualizar CtaMayor");
        CuentaMayor ctaMayor = new CuentaMayor("test", "test");
        assertNotNull(ctaMayor);
        currentSession().save(ctaMayor);
        
        ctaMayor.setNombre("test1");

        ctaMayor = instance.actualiza(ctaMayor);
        log.debug("ctaMayor >>" + ctaMayor);
        assertEquals("test1", ctaMayor.getNombre());
    }
    

    @Test
    public void deberiaEliminarCtaMayor() throws UltimoException {
        log.debug("Debiera eliminar Ejercicio");

        CuentaMayor ctaMayor = new CuentaMayor("test", "A");
        currentSession().save(ctaMayor);
        assertNotNull(ctaMayor);
        String nombre = instance.elimina(ctaMayor.getId());
        assertEquals("test", nombre);

        CuentaMayor prueba = instance.obtiene(ctaMayor.getId());
        assertNull(prueba);
    }
}
