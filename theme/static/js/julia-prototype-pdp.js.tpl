/* Julia Design — prototipo estático (incluir desde layout o página de prueba) */
(function () {
      const navbar = document.getElementById('navbar');
      const trigger = document.getElementById('mueblesTrigger');
      const mueblesBtn = document.getElementById('mueblesBtn');
      const megaMenu = document.getElementById('megaMenu');
      const megaClose = document.getElementById('megaClose');
      const navToggle = document.getElementById('navToggle');
      const isMobileViewport = () => window.matchMedia('(max-width: 768px)').matches;

      function setMobileMenu(open) {
        navbar.classList.toggle('mobile-menu-open', open);
        navToggle.setAttribute('aria-expanded', open ? 'true' : 'false');
        document.body.classList.toggle('no-scroll', open);
      }
      function openMenu() {
        trigger.classList.add('menu-open');
        megaMenu.classList.add('open');
        mueblesBtn.setAttribute('aria-expanded', 'true');
      }
      function closeMenu() {
        trigger.classList.remove('menu-open');
        megaMenu.classList.remove('open');
        mueblesBtn.setAttribute('aria-expanded', 'false');
        if (isMobileViewport()) setMobileMenu(false);
      }

      mueblesBtn.addEventListener('click', (e) => { e.stopPropagation(); megaMenu.classList.contains('open') ? closeMenu() : openMenu(); });
      megaClose.addEventListener('click', closeMenu);
      navToggle.addEventListener('click', (e) => { e.preventDefault(); e.stopPropagation(); megaMenu.classList.contains('open') ? closeMenu() : openMenu(); });
      document.addEventListener('click', (e) => {
        const clickedInsideDesktopMenu = trigger.contains(e.target);
        const clickedMobileToggle = navToggle.contains(e.target);
        const clickedInsideMobilePanel = navbar.querySelector('.nav-links').contains(e.target);
        const clickedInsideMegaMenu = megaMenu.contains(e.target);
        if (!clickedInsideDesktopMenu && !clickedMobileToggle && !clickedInsideMobilePanel && !clickedInsideMegaMenu) closeMenu();
      });
      document.addEventListener('keydown', (e) => { if (e.key === 'Escape') closeMenu(); });
      navbar.querySelectorAll('.nav-links a').forEach((link) => {
        link.addEventListener('click', () => { if (isMobileViewport()) setMobileMenu(false); });
      });
      window.addEventListener('resize', () => { if (!isMobileViewport()) setMobileMenu(false); });

      const priceEl = document.getElementById('pdpPrice');
      const colorLabel = document.getElementById('colorLabel');
      document.querySelectorAll('.pdp-swatch').forEach((input) => {
        input.addEventListener('change', () => {
          if (!input.checked) return;
          colorLabel.textContent = input.dataset.label || '';
          const cents = Number(input.dataset.price);
          if (!Number.isNaN(cents)) priceEl.textContent = 'Desde $' + cents.toLocaleString('es-AR');
        });
      });

      const pdpGallery = document.getElementById('pdpGallery');

      function pdpDesktopScrollStep() {
        const navH = parseInt(getComputedStyle(document.documentElement).getPropertyValue('--nav-h'), 10) || 60;
        return Math.max(240, Math.round(window.innerHeight - navH - 16));
      }

      if (pdpGallery) {
        pdpGallery.addEventListener('keydown', (e) => {
          const mobile = window.matchMedia('(max-width: 768px)').matches;
          if (mobile) {
            const stepX = pdpGallery.clientWidth;
            if (e.key === 'ArrowRight' || e.key === 'PageDown') { pdpGallery.scrollBy({ left: stepX, behavior: 'smooth' }); e.preventDefault(); }
            if (e.key === 'ArrowLeft' || e.key === 'PageUp') { pdpGallery.scrollBy({ left: -stepX, behavior: 'smooth' }); e.preventDefault(); }
          } else if (window.matchMedia('(min-width: 1024px)').matches) {
            const stepY = pdpDesktopScrollStep();
            if (e.key === 'ArrowDown' || e.key === 'PageDown') { window.scrollBy({ top: stepY, behavior: 'smooth' }); e.preventDefault(); }
            if (e.key === 'ArrowUp' || e.key === 'PageUp') { window.scrollBy({ top: -stepY, behavior: 'smooth' }); e.preventDefault(); }
          }
        });
      }

      document.getElementById('pdpBuy').addEventListener('click', () => {
        alert('Flujo de compra (prototipo).');
      });
    })();