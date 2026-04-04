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
    window.addEventListener('resize', () => { if (!isMobileViewport()) setMobileMenu(false); });
    window.addEventListener('scroll', () => { navbar.classList.toggle('solid', window.scrollY > 40); });

    const faqItems = document.querySelectorAll('.faq-item');
    function setFaqState(item, open) {
      const triggerEl = item.querySelector('.faq-trigger');
      const content = item.querySelector('.faq-content');
      item.classList.toggle('open', open);
      triggerEl.setAttribute('aria-expanded', open ? 'true' : 'false');
      content.style.maxHeight = open ? content.scrollHeight + 'px' : '0px';
    }
    faqItems.forEach((item) => {
      const triggerEl = item.querySelector('.faq-trigger');
      setFaqState(item, false);
      triggerEl.addEventListener('click', () => {
        const willOpen = !item.classList.contains('open');
        faqItems.forEach((it) => setFaqState(it, false));
        if (willOpen) setFaqState(item, true);
      });
    });
    window.addEventListener('resize', () => {
      const openItem = document.querySelector('.faq-item.open');
      if (openItem) {
        const content = openItem.querySelector('.faq-content');
        content.style.maxHeight = content.scrollHeight + 'px';
      }
    });