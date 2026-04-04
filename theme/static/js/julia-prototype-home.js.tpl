/* Julia Design — prototipo estático (incluir desde layout o página de prueba) */
/* ════════════════════════════════════════════════════════
     LOGO POSITIONING
     ════════════════════════════════════════════════════════
     Two distinct states:

     HERO (isInNav = false):
       - z-index: 300   → above photo/strip, below navbar (500)
       - left: center of image column
       - top: bottom of strip / top of photo
       - height: 72px

     NAV (isInNav = true):
       - z-index: 600   → above navbar (500) and mega-menu (490)
       - left: 50vw
       - top: center of navbar
       - height: 28px

     The z-index jump is intentional: while in the hero the logo
     is decorative (below the nav is fine), but once it migrates
     into the navbar row it must sit above everything.
  ════════════════════════════════════════════════════════ */
    const logoEl   = document.getElementById('logoEl');
    const logoImg  = document.getElementById('logoImg');
    const logoFb   = document.getElementById('logoFallback');
    const EASE     = 'cubic-bezier(.4,0,.2,1)';
    const TRANS    = `left .7s ${EASE}, top .7s ${EASE}`;

    function getCssPxVar(name, fallback) {
      const raw = getComputedStyle(document.documentElement).getPropertyValue(name).trim();
      const n = parseFloat(raw);
      return Number.isFinite(n) ? n : fallback;
    }

    function getCssRatioVar(name, fallback) {
      const raw = getComputedStyle(document.documentElement).getPropertyValue(name).trim();
      if (!raw) return fallback;
      if (raw.endsWith('%')) {
        const n = parseFloat(raw);
        return Number.isFinite(n) ? n / 100 : fallback;
      }
      const n = parseFloat(raw);
      return Number.isFinite(n) ? n : fallback;
    }

    function posLogo(inNav) {
      const vw = window.innerWidth;
      const navH = getCssPxVar('--nav-h', 60);
      const stripH = getCssPxVar('--strip-h', 120);
      const imgCol = getCssRatioVar('--img-col', 0.56);
      const isMobile = window.matchMedia('(max-width: 768px)').matches;

      if (inNav) {
        logoEl.style.position  = 'fixed';
        logoEl.style.zIndex    = '600';         // above navbar (500)
        logoEl.style.left      = isMobile ? '16px' : '50%';
        logoEl.style.top       = (navH / 2) + 'px';
        logoEl.style.transform = isMobile ? 'translateY(-50%)' : 'translate(-50%, -50%)';
        logoEl.style.transition = TRANS;
      } else {
        logoEl.style.position  = 'fixed';
        logoEl.style.zIndex    = '300';         // above photo, below navbar
        logoEl.style.left      = isMobile ? '50%' : (vw * imgCol / 2) + 'px';
        logoEl.style.top       = (navH + stripH) + 'px';
        logoEl.style.transform = 'translate(-50%, -50%)';
        logoEl.style.transition = TRANS;
      }
      // Resize the logo image
      const h = inNav ? (isMobile ? '22px' : '28px') : (isMobile ? '48px' : '72px');
      if (logoImg && logoImg.style.display !== 'none') logoImg.style.height = h;
      if (logoFb  && logoFb.style.display  !== 'none') logoFb.style.fontSize = inNav ? '1rem' : 'clamp(3rem,6.5vw,5.5rem)';
    }

    // Initialise without transition so there's no animation on page load
    logoEl.style.transition = 'none';
    posLogo(false);
    // Re-enable transition after a frame
    requestAnimationFrame(() => { logoEl.style.transition = TRANS; });

    /* ── Fade helpers ─────────────────────────────── */
    function hideLogo() { logoEl.classList.add('fade-out'); }
    function showLogo() { logoEl.classList.remove('fade-out'); }

    /* ── Scroll handler ──────────────────────────── */
    const navbar      = document.getElementById('navbar');
    const scrollHint  = document.getElementById('scrollHint');
    const exhibitor   = document.getElementById('exhibitor');
    let isInNav       = false;
    let ticking       = false;

    window.addEventListener('scroll', () => {
      if (!ticking) {
        requestAnimationFrame(() => {
          const scrollY = window.scrollY;
          const past = scrollY > (getCssPxVar('--nav-h', 60) + getCssPxVar('--strip-h', 120) - 20);

          // Navbar solid background
          navbar.classList.toggle('solid', past);

          // Logo state transition
          if (past !== isInNav) {
            isInNav = past;
            posLogo(past);
          }

          // Scroll hint
          scrollHint.classList.toggle('hidden', scrollY > 80);

          ticking = false;
        });
        ticking = true;
      }
    });

    window.addEventListener('resize', () => posLogo(isInNav));

    /* ── Hide navbar (and logo) over exhibitor ───── */
    const navObs = new IntersectionObserver((entries) => {
      // Si el mega-menu está abierto (mobile especialmente), no esconder la navbar.
      const mm = document.getElementById('megaMenu');
      if (mm && mm.classList.contains('open')) return;
      const visible = entries[0].isIntersecting;
      navbar.classList.toggle('hidden', visible);
      // Also fade the logo out: it looks odd floating without the navbar
      if (visible) hideLogo(); else showLogo();
    }, { threshold: 0.06 });
    navObs.observe(exhibitor);

    /* ── Mega menu ───────────────────────────────── */
    const trigger    = document.getElementById('mueblesTrigger');
    const mueblesBtn = document.getElementById('mueblesBtn');
    const megaMenu   = document.getElementById('megaMenu');
    const megaClose  = document.getElementById('megaClose');
    const navToggle  = document.getElementById('navToggle');
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
      hideLogo();   // hide logo while mega panel is open
    }
    function closeMenu() {
      trigger.classList.remove('menu-open');
      megaMenu.classList.remove('open');
      mueblesBtn.setAttribute('aria-expanded', 'false');
      if (isMobileViewport()) setMobileMenu(false);
      // Only show logo again if not over exhibitor
      if (!exhibitor.classList.contains('in-view')) showLogo();
    }

    mueblesBtn.addEventListener('click', e => {
      e.stopPropagation();
      megaMenu.classList.contains('open') ? closeMenu() : openMenu();
    });
    megaClose.addEventListener('click', closeMenu);
    document.addEventListener('click', e => {
      const clickedInsideDesktopMenu = trigger.contains(e.target);
      const clickedMobileToggle = navToggle.contains(e.target);
      const clickedInsideMobilePanel = navbar.querySelector('.nav-links').contains(e.target);
      const clickedInsideMegaMenu = megaMenu.contains(e.target);
      if (!clickedInsideDesktopMenu && !clickedMobileToggle && !clickedInsideMobilePanel && !clickedInsideMegaMenu) {
        closeMenu();
      }
    });
    document.addEventListener('keydown', e => { if (e.key === 'Escape') closeMenu(); });
    navToggle.addEventListener('click', e => {
      e.preventDefault();
      e.stopPropagation();
      // En mobile el panel correcto es el mega-menu
      if (megaMenu.classList.contains('open')) closeMenu();
      else openMenu();
    });
    navbar.querySelectorAll('.nav-links a').forEach(link => {
      link.addEventListener('click', () => {
        if (isMobileViewport()) setMobileMenu(false);
      });
    });
    window.addEventListener('resize', () => {
      if (!isMobileViewport()) {
        setMobileMenu(false);
      }
    });

    // Track exhibitor visibility for closeMenu logic
    const exObs2 = new IntersectionObserver(entries => {
      exhibitor.classList.toggle('in-view', entries[0].isIntersecting);
    }, { threshold: 0.06 });
    exObs2.observe(exhibitor);

    /* ── Accordion ───────────────────────────────── */
    document.getElementById('accordion').addEventListener('click', e => {
      const h = e.target.closest('.acc-header'); if (!h) return;
      const item = h.parentElement, was = item.classList.contains('open');
      document.querySelectorAll('.acc-item.open').forEach(i => i.classList.remove('open'));
      if (!was) item.classList.add('open');
    });

    /* ── Carousel ────────────────────────────────── */
    const track = document.getElementById('carouselTrack');
    const wrap  = document.getElementById('carouselWrap');
    Array.from(track.children).forEach(c => track.appendChild(c.cloneNode(true)));
    const pause  = () => track.classList.add('paused');
    const resume = () => track.classList.remove('paused');
    wrap.addEventListener('mouseenter', pause);
    wrap.addEventListener('mouseleave', resume);
    wrap.addEventListener('touchstart', pause, { passive: true });
    wrap.addEventListener('touchend', resume);