/* Julia Design — prototipo estático (incluir desde layout o página de prueba) */
const navbar = document.getElementById('navbar');
    const trigger = document.getElementById('mueblesTrigger');
    const mueblesBtn = document.getElementById('mueblesBtn');
    const megaMenu = document.getElementById('megaMenu');
    const megaClose = document.getElementById('megaClose');
    const navToggle = document.getElementById('navToggle');

    function openMenu() {
      trigger.classList.add('menu-open');
      megaMenu.classList.add('open');
      mueblesBtn.setAttribute('aria-expanded', 'true');
      navToggle.setAttribute('aria-expanded', 'true');
      document.body.classList.add('no-scroll');
    }
    function closeMenu() {
      trigger.classList.remove('menu-open');
      megaMenu.classList.remove('open');
      mueblesBtn.setAttribute('aria-expanded', 'false');
      navToggle.setAttribute('aria-expanded', 'false');
      document.body.classList.remove('no-scroll');
    }

    mueblesBtn.addEventListener('click', (e) => {
      e.stopPropagation();
      megaMenu.classList.contains('open') ? closeMenu() : openMenu();
    });
    navToggle.addEventListener('click', (e) => {
      e.preventDefault();
      e.stopPropagation();
      megaMenu.classList.contains('open') ? closeMenu() : openMenu();
    });
    megaClose.addEventListener('click', closeMenu);

    document.addEventListener('click', (e) => {
      const insideTrigger = trigger.contains(e.target);
      const insideMenu = megaMenu.contains(e.target);
      const insideToggle = navToggle.contains(e.target);
      if (!insideTrigger && !insideMenu && !insideToggle) closeMenu();
    });
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') closeMenu();
    });

    window.addEventListener('scroll', () => {
      navbar.classList.toggle('solid', window.scrollY > 40);
    });