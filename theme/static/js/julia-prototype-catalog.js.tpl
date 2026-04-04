/* Julia Design — prototipo estático (incluir desde layout o página de prueba) */
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
    const catalogSubnav = document.getElementById('catalogSubnav');
    const catalogSubnavSpacer = document.getElementById('catalogSubnavSpacer');
    const CATALOG_COMPACT_Y = 72;

    function refreshCatalogSubnav() {
      const y = window.scrollY;
      navbar.classList.toggle('solid', y > 40);
      if (!catalogSubnav || !catalogSubnavSpacer) return;
      if (megaMenu.classList.contains('open')) {
        document.body.classList.remove('is-compact-catalog');
        catalogSubnavSpacer.style.height = '0px';
        return;
      }
      const compact = y > CATALOG_COMPACT_Y;
      document.body.classList.toggle('is-compact-catalog', compact);
      if (compact) {
        requestAnimationFrame(() => {
          if (catalogSubnav && catalogSubnavSpacer && document.body.classList.contains('is-compact-catalog')) {
            catalogSubnavSpacer.style.height = catalogSubnav.offsetHeight + 'px';
          }
        });
      } else {
        catalogSubnavSpacer.style.height = '0px';
      }
    }

    function openMenu() {
      trigger.classList.add('menu-open');
      megaMenu.classList.add('open');
      mueblesBtn.setAttribute('aria-expanded', 'true');
      refreshCatalogSubnav();
    }
    function closeMenu() {
      trigger.classList.remove('menu-open');
      megaMenu.classList.remove('open');
      mueblesBtn.setAttribute('aria-expanded', 'false');
      if (isMobileViewport()) setMobileMenu(false);
      refreshCatalogSubnav();
    }

    mueblesBtn.addEventListener('click', (e) => {
      e.stopPropagation();
      megaMenu.classList.contains('open') ? closeMenu() : openMenu();
    });
    megaClose.addEventListener('click', closeMenu);
    navToggle.addEventListener('click', (e) => {
      e.preventDefault();
      e.stopPropagation();
      if (megaMenu.classList.contains('open')) closeMenu(); else openMenu();
    });
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
    window.addEventListener('resize', () => {
      if (!isMobileViewport()) setMobileMenu(false);
      refreshCatalogSubnav();
    });

    window.addEventListener('scroll', refreshCatalogSubnav, { passive: true });
    refreshCatalogSubnav();

    document.querySelectorAll('#catalogSubnav details').forEach((d) => {
      d.addEventListener('toggle', () => {
        if (document.body.classList.contains('is-compact-catalog')) refreshCatalogSubnav();
      });
    });

    const tabs = document.querySelectorAll('.tab-link');
    const productsGrid = document.getElementById('productsGrid');
    const cards = Array.from(productsGrid.querySelectorAll('.product-card'));
    const emptyState = document.getElementById('emptyState');
    const priceRange = document.getElementById('priceRange');
    const priceRangeValue = document.getElementById('priceRangeValue');
    const colorInputs = document.querySelectorAll('#colorFilterList input[type="checkbox"]');
    const sortInputs = document.querySelectorAll('input[name="sort"]');
    const sortLabel = document.getElementById('sortLabel');

    let currentCategory = 'all';
    let currentSort = 'featured';

    const VALID_CATS = ['all', 'sillas', 'mesas', 'sillones', 'exterior'];

    function syncTabActive() {
      tabs.forEach((t) => t.classList.toggle('active', t.dataset.category === currentCategory));
    }

    function readCategoryFromUrl() {
      const cat = new URLSearchParams(window.location.search).get('cat');
      if (cat && VALID_CATS.includes(cat)) {
        currentCategory = cat;
      } else {
        currentCategory = 'all';
      }
      syncTabActive();
    }

    function writeCategoryToUrl() {
      const url = new URL(window.location.href);
      if (currentCategory === 'all') {
        url.searchParams.delete('cat');
      } else {
        url.searchParams.set('cat', currentCategory);
      }
      const qs = url.searchParams.toString();
      history.replaceState(null, '', url.pathname + (qs ? '?' + qs : '') + url.hash);
    }

    function formatPrice(value) {
      return '$' + Number(value).toLocaleString('es-AR');
    }

    function applyFilters() {
      const maxPrice = Number(priceRange.value);
      const selectedColors = Array.from(colorInputs).filter(i => i.checked).map(i => i.value);

      let filtered = cards.filter(card => {
        const category = card.dataset.category;
        const price = Number(card.dataset.price);
        const colors = card.dataset.colors.split(',');

        const passCategory = currentCategory === 'all' || category === currentCategory;
        const passPrice = price <= maxPrice;
        const passColor = selectedColors.length === 0 || selectedColors.some(c => colors.includes(c));

        return passCategory && passPrice && passColor;
      });

      filtered.sort((a, b) => {
        if (currentSort === 'price-asc') return Number(a.dataset.price) - Number(b.dataset.price);
        if (currentSort === 'price-desc') return Number(b.dataset.price) - Number(a.dataset.price);
        if (currentSort === 'name-asc') return a.querySelector('.product-name').textContent.localeCompare(b.querySelector('.product-name').textContent, 'es');
        return Number(a.dataset.featured) - Number(b.dataset.featured);
      });

      cards.forEach(card => { card.style.display = 'none'; });
      filtered.forEach(card => {
        card.style.display = '';
        productsGrid.appendChild(card);
      });

      emptyState.style.display = filtered.length ? 'none' : 'block';
    }

    tabs.forEach((tab) => {
      tab.addEventListener('click', (e) => {
        e.preventDefault();
        currentCategory = tab.dataset.category;
        syncTabActive();
        writeCategoryToUrl();
        applyFilters();
      });
    });

    sortInputs.forEach(input => {
      input.addEventListener('change', () => {
        if (!input.checked) return;
        currentSort = input.value;
        sortLabel.textContent = input.parentElement.textContent.trim();
        applyFilters();
      });
    });

    priceRange.addEventListener('input', () => {
      priceRangeValue.textContent = 'Hasta ' + formatPrice(priceRange.value);
      applyFilters();
    });

    colorInputs.forEach(input => input.addEventListener('change', applyFilters));
    readCategoryFromUrl();
    applyFilters();