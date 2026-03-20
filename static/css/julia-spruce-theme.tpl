{# Julia Design — estilos Spruce Simple (header + home). Incluir desde layouts/layout.tpl #}
<style id="julia-spruce-theme">
/* --- Tokens marca --- */
.julia-theme-spruce {
    --julia-gray: #D2D0D0;
    --julia-white: #FFFFFF;
    --julia-mink: #81756C;
    --julia-brown: #54463D;
    --julia-font-title: "Hanken Grotesk", "HK Grotesk", system-ui, sans-serif;
    --julia-font-body: "Montserrat", system-ui, sans-serif;
}

.julia-theme-spruce .julia-spruce-header.head-main {
    background: var(--julia-brown);
    border-bottom: 1px solid rgba(129, 117, 108, 0.35);
    z-index: 1030;
}

.julia-theme-spruce .julia-spruce-header .head-logo-row {
    background: var(--julia-brown);
    padding-top: 0.75rem;
    padding-bottom: 0.75rem;
}

.julia-theme-spruce .julia-spruce-header__grid {
    gap: 1rem;
    min-height: 3.5rem;
}

.julia-theme-spruce .julia-spruce-header__nav-desktop {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem 1.5rem;
    justify-content: flex-start;
}

@media (max-width: 767px) {
    .julia-theme-spruce .julia-spruce-header__logo-wrap {
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        z-index: 1;
    }
}

.julia-theme-spruce .julia-spruce-header__link {
    font-family: var(--julia-font-title);
    font-size: 0.8125rem;
    font-weight: 700;
    letter-spacing: 0.02em;
    color: var(--julia-white);
    text-decoration: none;
    opacity: 0.92;
    transition: opacity 0.2s ease;
}

.julia-theme-spruce .julia-spruce-header__link:hover,
.julia-theme-spruce .julia-spruce-header__link:focus {
    opacity: 0.65;
    outline: none;
}

.julia-theme-spruce .julia-spruce-header__link--current {
    opacity: 1;
    text-decoration: underline;
    text-underline-offset: 4px;
}

.julia-theme-spruce .julia-spruce-header .js-logo-container {
    text-align: center;
}

@media (min-width: 768px) {
    .julia-theme-spruce .julia-spruce-header .js-logo-container {
        margin: 0 auto;
    }
}

.julia-theme-spruce .julia-spruce-header .js-logo-container img {
    max-height: 1.75rem;
    max-width: 7.25rem;
    width: auto;
}

@media (min-width: 768px) {
    .julia-theme-spruce .julia-spruce-header .js-logo-container img {
        max-height: 1.9rem;
        max-width: 8rem;
    }
}

.julia-theme-spruce .julia-spruce-header__utils {
    gap: 0.35rem;
}

@media (min-width: 768px) {
    .julia-theme-spruce .julia-spruce-header__utils {
        gap: 0.5rem;
    }
}

/* Iconos utilitarios: contraste sobre marrón */
.julia-theme-spruce .julia-spruce-header .btn-utility {
    color: var(--julia-white);
    border: none;
    padding: 0.35rem;
}

.julia-theme-spruce .julia-spruce-header .utilities-icon {
    fill: currentColor;
}

.julia-theme-spruce .julia-spruce-header .js-cart-widget-amount.badge {
    background: var(--julia-white);
    color: var(--julia-brown);
    font-size: 9px;
    font-weight: 700;
    min-width: 1rem;
    height: 1rem;
    line-height: 1rem;
    padding: 0 4px;
    border-radius: 999px;
    top: -4px;
    right: -6px;
}

/* --- Home Julia --- */
.julia-home {
    font-family: var(--julia-font-body);
    color: var(--julia-white);
    background: var(--julia-brown);
    overflow-x: hidden;
}

.julia-home__hero {
    display: flex;
    flex-direction: column;
    min-height: 85vh;
}

@media (min-width: 1024px) {
    .julia-home__hero {
        flex-direction: row;
    }
}

.julia-home__hero-media {
    position: relative;
    height: 50vh;
    overflow: hidden;
    background: var(--julia-gray);
}

@media (min-width: 1024px) {
    .julia-home__hero-media {
        width: 50%;
        height: auto;
        min-height: 85vh;
    }
}

.julia-home__hero-media img {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.julia-home__hero-content {
    position: relative;
    overflow: hidden;
    background: var(--julia-brown);
    padding: 2.5rem 1.5rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

@media (min-width: 768px) {
    .julia-home__hero-content {
        padding: 3.5rem 3rem;
    }
}

@media (min-width: 1024px) {
    .julia-home__hero-content {
        width: 50%;
        padding: 4rem 6rem;
    }
}

.julia-home__hero-logo-bg {
    position: absolute;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    pointer-events: none;
    user-select: none;
    opacity: 0.2;
}

.julia-home__hero-logo-bg img {
    width: 120%;
    max-width: none;
    height: auto;
    object-fit: contain;
}

.julia-home__title {
    position: relative;
    font-family: var(--julia-font-title);
    font-weight: 700;
    font-size: clamp(2rem, 6vw, 4.5rem);
    line-height: 0.95;
    margin-bottom: 2rem;
    color: var(--julia-white);
}

.julia-home__lead {
    position: relative;
    max-width: 28rem;
    font-size: 1rem;
    line-height: 1.6;
    color: rgba(255, 255, 255, 0.82);
    margin-bottom: 3rem;
}

@media (min-width: 768px) {
    .julia-home__lead {
        font-size: 1.125rem;
    }
}

.julia-home__actions {
    position: relative;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 1.25rem;
}

.julia-btn-outline {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.75rem 2rem;
    border-radius: 999px;
    border: 1px solid var(--julia-white);
    color: var(--julia-white);
    font-size: 0.875rem;
    font-weight: 500;
    text-decoration: none;
    transition: background 0.25s ease, color 0.25s ease;
}

.julia-btn-outline:hover {
    background: var(--julia-white);
    color: var(--julia-brown);
}

.julia-link-underline {
    position: relative;
    font-size: 0.875rem;
    font-weight: 500;
    color: var(--julia-white);
    text-decoration: none;
    padding-bottom: 2px;
}

.julia-link-underline::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: 0;
    width: 100%;
    height: 1px;
    background: currentColor;
    transform-origin: left;
    transition: transform 0.25s ease;
}

.julia-link-underline:hover::after {
    transform: scaleX(0);
    transform-origin: right;
}

/* Beneficios split */
.julia-home__benefits {
    display: flex;
    flex-direction: column;
    background: var(--julia-gray);
    color: var(--julia-brown);
}

@media (min-width: 1024px) {
    .julia-home__benefits {
        flex-direction: row;
    }
}

.julia-home__benefits-sticky {
    padding: 2rem;
}

@media (min-width: 1024px) {
    .julia-home__benefits-sticky {
        width: 50%;
        padding: 6rem;
        position: sticky;
        top: 5rem;
        align-self: flex-start;
    }
}

.julia-home__benefits-title {
    font-family: var(--julia-font-title);
    font-weight: 700;
    font-size: clamp(2.25rem, 5vw, 3.75rem);
    line-height: 1;
    letter-spacing: -0.02em;
    margin-bottom: 1.5rem;
}

.julia-home__benefits-lead {
    max-width: 28rem;
    font-size: 1.125rem;
    line-height: 1.5;
}

.julia-home__benefits-list-wrap {
    padding: 2rem;
}

@media (min-width: 1024px) {
    .julia-home__benefits-list-wrap {
        width: 50%;
        padding: 6rem;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
}

.julia-home__benefits-intro {
    font-size: 0.875rem;
    max-width: 28rem;
    margin-bottom: 3rem;
}

.julia-home__benefits-list {
    border-top: 1px solid rgba(84, 70, 61, 0.3);
}

.julia-home__benefits-row {
    padding: 1.5rem 0;
    border-bottom: 1px solid rgba(84, 70, 61, 0.3);
    cursor: default;
}

.julia-home__benefits-row h3 {
    font-family: var(--julia-font-title);
    font-size: clamp(1.125rem, 2vw, 1.5rem);
    font-weight: 700;
    margin: 0;
    transition: color 0.2s ease;
}

.julia-home__benefits-row:hover h3 {
    color: var(--julia-mink);
}

/* Carrusel productos */
.julia-home__catalog {
    position: relative;
    background: var(--julia-white);
    color: var(--julia-brown);
    padding: 3rem 0;
    overflow: hidden;
}

@media (min-width: 768px) {
    .julia-home__catalog {
        padding: 5rem 0;
    }
}

@media (min-width: 1024px) {
    .julia-home__catalog {
        padding: 6rem 0;
        min-height: 80vh;
    }
}

.julia-home__catalog-section-bg {
    position: absolute;
    inset: 0;
    z-index: 0;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    opacity: 0.14;
    pointer-events: none;
}

.julia-home__catalog-highlights {
    position: absolute;
    inset: 0;
    z-index: 0;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-around;
    gap: 1rem 2rem;
    padding: 2rem;
    pointer-events: none;
    overflow: hidden;
    /* clip-path evita que los items rotados escapen el bounding-box en Safari */
    clip-path: inset(0);
}

.julia-home__catalog-highlight-item {
    font-family: var(--julia-font-title);
    font-weight: 700;
    font-size: clamp(2rem, 10vw, 7rem);
    line-height: 0.95;
    color: var(--julia-brown);
    opacity: 0.06;
    white-space: nowrap;
    user-select: none;
    transform: rotate(-8deg);
}

.julia-home__catalog-deco-extra {
    position: absolute;
    right: -5%;
    bottom: 5%;
    width: min(45%, 420px);
    z-index: 1;
    pointer-events: none;
    opacity: 0.18;
    user-select: none;
}

.julia-home__catalog-deco-extra img {
    width: 100%;
    height: auto;
    display: block;
}

.julia-home__catalog-logo-bg {
    position: absolute;
    inset: 0;
    z-index: 2;
    display: flex;
    align-items: flex-end;
    justify-content: center;
    pointer-events: none;
    user-select: none;
    opacity: 0.2;
    overflow: hidden;
    padding-top: 2rem;
}

.julia-home__catalog-logo-bg img {
    width: 180%;
    max-width: none;
}

@media (min-width: 768px) {
    .julia-home__catalog-logo-bg img {
        width: 110%;
    }
}

.julia-home__catalog-inner {
    position: relative;
    z-index: 3;
}

.spruce-carousel-track {
    transform: translate3d(0, 0, 0);
    /* will-change se aplica/libera dinámicamente por spruce-carousel.js */
}

.spruce-carousel-item {
    user-select: none;
}

.julia-home__product-card {
    flex-shrink: 0;
    width: 280px;
    margin-right: 2rem;
}

@media (min-width: 768px) {
    .julia-home__product-card {
        width: 350px;
    }
}

.julia-home__product-media {
    height: 350px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 1.5rem;
}

@media (min-width: 768px) {
    .julia-home__product-media {
        height: 450px;
    }
}

.julia-home__product-media img {
    max-height: 100%;
    max-width: 100%;
    object-fit: contain;
    transition: transform 0.45s ease;
}

.julia-home__product-card:hover .julia-home__product-media img {
    transform: scale(1.05);
}

.julia-home__product-card,
.julia-home__product-card:hover {
    color: var(--julia-brown);
    text-decoration: none;
}

.julia-home__product-name {
    font-family: var(--julia-font-title);
    font-weight: 700;
    font-size: 1.25rem;
    margin: 0 0 0.25rem;
    color: var(--julia-brown);
}

.julia-home__product-meta {
    font-size: 0.875rem;
    color: var(--julia-mink);
    margin: 0 0 0.5rem;
}

.julia-home__product-price {
    font-size: 0.875rem;
    margin: 0;
    color: var(--julia-brown);
}

.julia-btn-solid {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.75rem 2rem;
    border-radius: 999px;
    background: var(--julia-brown);
    color: var(--julia-white);
    border: 1px solid var(--julia-brown);
    font-size: 0.875rem;
    font-weight: 500;
    text-decoration: none;
    transition: background 0.25s ease, color 0.25s ease;
}

.julia-btn-solid:hover {
    background: var(--julia-white);
    color: var(--julia-brown);
}

/* Editorial */
.julia-home__editorial {
    background: var(--julia-brown);
    color: var(--julia-white);
    border-top: 1px solid rgba(129, 117, 108, 0.35);
}

.julia-home__editorial-grid {
    display: flex;
    flex-direction: column;
}

@media (min-width: 1024px) {
    .julia-home__editorial-grid {
        flex-direction: row;
    }
}

.julia-home__editorial-col {
    padding: 2.5rem 1.5rem;
    border-bottom: 1px solid rgba(129, 117, 108, 0.35);
}

@media (min-width: 768px) {
    .julia-home__editorial-col {
        padding: 3.5rem 3rem;
    }
}

@media (min-width: 1024px) {
    .julia-home__editorial-col {
        width: 50%;
        padding: 6rem;
        border-bottom: none;
        border-right: 1px solid rgba(129, 117, 108, 0.35);
    }
    .julia-home__editorial-col:last-child {
        border-right: none;
    }
}

.julia-home__editorial-col h3 {
    font-family: var(--julia-font-title);
    font-size: 1.75rem;
    margin: 0 0 1.5rem;
}

.julia-home__editorial-col p {
    font-size: 0.875rem;
    line-height: 1.7;
    color: rgba(255, 255, 255, 0.8);
    max-width: 28rem;
    margin: 0 0 3rem;
}

.julia-home__editorial-media {
    aspect-ratio: 16 / 9;
    overflow: hidden;
    background: rgba(210, 208, 208, 0.15);
}

.julia-home__editorial-media img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    mix-blend-mode: luminosity;
    opacity: 0.85;
    transition: opacity 0.4s ease;
}

.julia-home__editorial-media:hover img {
    opacity: 1;
}

/* Pie de página — layout Julia */
footer.julia-footer .julia-footer__body {
    text-align: left;
    max-width: 1200px;
    margin-left: auto;
    margin-right: auto;
    padding: 0 1rem 2rem;
}

footer.julia-footer .julia-footer__heading {
    font-family: var(--julia-font-title);
    font-size: 1rem;
    font-weight: 700;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    margin: 0 0 1.25rem;
    opacity: 0.95;
}

footer.julia-footer .julia-footer__columns {
    margin-top: 0.5rem;
}

footer.julia-footer .julia-footer__map {
    border-radius: 4px;
    overflow: hidden;
    background: rgba(0, 0, 0, 0.06);
    min-height: 200px;
}

footer.julia-footer .julia-footer__map iframe {
    display: block;
    width: 100% !important;
    min-height: 220px;
    border: 0;
}

footer.julia-footer .footer-menu-link {
    text-decoration: none;
    opacity: 0.9;
}

footer.julia-footer .footer-menu-link:hover {
    opacity: 1;
    text-decoration: underline;
}

footer.julia-footer .julia-footer__legal {
    text-align: center;
    margin-top: 2rem;
    padding-top: 1.5rem;
    border-top: 1px solid rgba(255, 255, 255, 0.12);
}

footer.julia-footer:not(.footer-colors) .julia-footer__legal {
    border-top-color: rgba(84, 70, 61, 0.15);
}
</style>
