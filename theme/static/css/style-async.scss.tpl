{#/*============================================================================
style.css

    -This file contains all the theme non critical styles wich will be loaded asynchronously
    -Rest of styling can be found in:
      --static/css/style-colors.scss.tpl --> For color and font styles related to config/settings.txt
      --static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/#}

{#/*============================================================================
  Table of Contents

  #Components
    // Margin and Padding
    // Mixins
    // Animations
    // Buttons
    // Forms
    // Icons
    // Alerts and Notifications
    // Modals
    // Tabs
    // Cards
    // Captcha
  #Header and nav
    // Nav
    // Search
  #Footer
    // Nav
    // Newsletter
  #Home page
    // Instafeed
    // Banners
    // Placeholder
  #Product grid
    // Filters
  #Product detail
  	// Image
  	// Form and info
  #Media queries

    // Min width 768px
      //// Components
      //// Footer
  #Critical path utilities

==============================================================================*/#}

{#/*============================================================================
  #Components
==============================================================================*/#}

{# /* // Margin and Padding */ #}

%section-margin {
  margin-bottom: 70px;
}
%element-margin {
  margin-bottom: 35px;
}
%element-margin-small {
  margin-bottom: 20px;
}

{# /* // Mixins */ #}

{# This mixin adds browser prefixes to a CSS property #}

@mixin prefix($property, $value, $prefixes: ()) {
  @each $prefix in $prefixes {
    #{'-' + $prefix + '-' + $property}: $value;
  }
  #{$property}: $value;
}


{# /* // Animations */ #}

.transition-soft {
  @include prefix(transition, all 0.3s ease, webkit ms moz o);
}

.transition-up {
  position: relative;
  top: -8px;
  z-index: 10;
  @include prefix(transition, all 0.5s ease, webkit ms moz o);
  pointer-events: none; 
  &-active {
    top: 0;
    opacity: 1; 
    z-index: 100;
    pointer-events: all; 
  }
}

.beat {
  animation: .8s 2 beat;
}
@keyframes beat {
  0% {
    @include prefix(transform, scale(1), webkit ms moz o);
  }
  25% {
    @include prefix(transform, scale(1.3), webkit ms moz o);
  }
  40% {
    @include prefix(transform, scale(1), webkit ms moz o);
  }
  60% {
    @include prefix(transform, scale(1.3), webkit ms moz o);
  }
  100% {
    @include prefix(transform, scale(1), webkit ms moz o);
  }
}

@keyframes bounceIn{
  0%{
    transform: scale(1) translate3d(0,0,0);
  }
  50%{
    transform: scale(1.2);
  }
  80%{
    transform: scale(0.89);
  }
  100%{
    transform: scale(1) translate3d(0,0,0);
  }
}

{# /* // Buttons */ #}

.btn-transition {
  position: relative;
  overflow: hidden;
  .transition-container {
    position: absolute;
    top: 50%;
    left: 0;
    width: 100%;
    margin-top: -7px;
    opacity: 0;
    text-align: center;
    @include prefix(transition, all 0.5s ease, webkit ms moz o);
    cursor: not-allowed;
    pointer-events: none;
    &.active {
      opacity: 1;
    }
  }
} 

{# /* // Forms */ #}

.form-group{
  @extend %element-margin;
  .form-label{
    float: left;
    width: 100%;
    margin-bottom: 10px;
  }
  .alert{
    margin: 10px 0 0 0;
  }
}

.checkbox-container{
  .checkbox {
    position: relative;
    display: block;
    margin-bottom: 15px;
    padding-left: 30px;
    line-height: 20px;
    cursor: pointer;
    @include prefix(user-select, none, webkit ms moz o);

    &-color {
      display: inline-block;
      width: 10px;
      height: 10px;
      margin: 0 0 2px 5px;
      vertical-align: middle;
      border-radius: 100%;
    }

    input {
      display: none;
      &:checked ~ .checkbox-icon:after {
        display: block;
      }
    }

    &-icon {
      position: absolute;
      top: -1px;
      left: 0;
      width: 20px;
      height: 20px;

      &:after {
        position: absolute;
        top: 1px;
        left: 6px;
        display: none;
        width: 7px;
        height: 12px;
        content: '';
        @include prefix(transform, rotate(45deg), webkit ms moz o);
      }
    }
  }
}

.input-clear-content {
  position: absolute;
  right: 0;
  bottom: 7px;
  width: 22px;
  height: 30px;
  padding: 1px;
  cursor: pointer;
  &:before {
    display: block;
    margin: 9px 0 0 5px;
  }
}

.form-select {
  display: block;
  width: 100%;
  &:focus{
    outline:0;
  }
  &::-ms-expand {
    display: none;
  }
  .form-select-icon {
    @include prefix(transition, all 0.2s ease, webkit ms moz o);
  }

  &.open .form-select-icon {
    @include prefix(transform, translateY(-50%) rotate(180deg), webkit ms moz o);
  }
}

.form-select-options {
  position: absolute;
  top: 100%;
  left: 0;
  z-index: 200;
  width: 100%;
  max-height: 200px;
  margin-top: 5px;
  list-style: none;
  overflow-y: auto;
  @include prefix(transition, all 0.2s ease, webkit ms moz o);
  opacity: 0;
  &.open {
    opacity: 1;
  }
}

.form-select-option {
  padding: 12px;
  font-size: var(--font-small);
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  cursor: pointer;
}

{# /* // Newsletter */ #}

.newsletter form {
  position: relative;
  .newsletter-btn {
    position: absolute;
    top: 0;
    right: 0;
    padding: 10px;
  }
}

{# /* Lists */ #}

.list-readonly{
  .radio-button-label{
    width: 100%;
    padding-left: 0;
    cursor: default;
  }
  .list-item{
    position: relative;
    width: 100%;
    float: left;
    padding: 15px;
    clear: both;
    cursor: default;
    .radio-button-content{
      padding: 0;
    }
  }
}

{# /* Disabled controls */ #}

input,
select,
textarea{
  &[disabled],
  &[disabled]:hover,
  &[readonly],
  &[readonly]:hover{
    background-color: #DDD;
    cursor: not-allowed; 
  }
}

{# /* // Icons */ #}

.social-icon {
  display: inline-block;
  padding: 8px;
  font-size: 22px;
}

{# /* // Alerts and notifications */ #}

.alert {
  clear: both;
  padding: 8px;
  border: 1px solid;
  text-align: center;
  @extend %element-margin;
}

.subscription-btn-alert {
  margin-top: -15px;
}

.notification-hidden{
  transition: all .1s cubic-bezier(.16,.68,.43,.99);
  @include prefix(transform, rotatex(90deg), webkit ms moz o);
  pointer-events: none;
}
.notification-visible{
  transition: all .5s cubic-bezier(.16,.68,.43,.99);
  @include prefix(transform, rotatex(0deg), webkit ms moz o);
}
.notification-close {
  position: absolute;
  top: 5px;
  right: 10px;
  z-index: 1;
  font-size: 20px; 
  cursor: pointer;
}

/* // Progress bar */

.bar-progress {
  position: relative;
  height: 7px;
  .bar-progress-active {
    width: 0%;
    height: 7px;
  }
}

.ship-free-rest-message {
  position: relative;
  height: 45px;
  .ship-free-rest-text {
    position: absolute;
    top: -5px;
    width: 100%;
    text-align: center;  
    line-height: 36px;
    opacity: 0;
  }
  &.success .bar-progress-success,
  &.amount .bar-progress-amount,
  &.condition .bar-progress-condition {
    top: 0;
    opacity: 1;
  }
}

{# /* // Modals */ #}

.modal {
  position: fixed;
  top: 0;
  display: block;
  width: 80%;
  height: 100%;
  padding: 10px;
  -webkit-overflow-scrolling: touch;
  overflow-y: auto;
  transition: all .2s cubic-bezier(.16,.68,.43,.99);
  z-index: 20000;
  &-img-full{
    max-width: 100%;
    max-height: 190px;
  }
  &-header{
    width: calc(100% + 20px);
    margin: -10px 0 10px -20px;
    padding: 10px 15px 10px 25px;
    font-size: 20px;
  }
  &-footer{
    padding: 10px 0;
    clear: both;
  }
  &-with-fixed-footer {
    display: flex;
    flex-direction: column;
    height: 100%;
    .modal-scrollable-area {
      height: 100%;
      overflow: auto;
    }
  }
  &-full {
    width: 100%;
  }
  &-docked-md{
    width: 100%;
  }
  &-docked-small{
    width: 80%;
  }
  &-top{
    top: -100%;
    left: 0;
  }
  &-bottom{
    top: 100%;
    left: 0;
  }
  &-left{
    left: -100%;
  }
  &-right{
    right: -100%;
  }
  &-centered{
    height: 100%;
    width: 100%;
    &-small{
      left: 50%;
      width: 80%;
      height: auto;
      @include prefix(transform, translate(-50%, 0), webkit ms moz o);
      .modal-body{
        min-height: 150px;
        max-height: 400px;
        overflow: auto;
      }
    }
    &-md.modal-show {
        left: 50%;
        transform: translateX(-50%);
        &.modal-bottom-md,
        &.modal-bottom {
          top: 50%;
          bottom: auto;
          left: 50%;
          height: fit-content;
          transform: translate(-50%, -50%);
        }
      }
  }
  &-top.modal-show,
  &-bottom.modal-show {
    top: 0;
    &.modal-centered-small{
      top: 50%;
      @include prefix(transform, translate(-50%, -50%), webkit ms moz o);
    }
  }
  &-bottom-sheet {
    top: initial;
    bottom: -100%;
    height: auto;
    &.modal-show {
      top: initial;
      bottom: 0;
      height: auto;
    }
  }
  &-left.modal-show {
    left: 0;
  }
  &-right.modal-show {
    right: 0;
  }
  &-close { 
    display: inline-block;
    padding: 1px 5px 5px 0;
    margin-right: 5px;
    font-size: 20px;
    vertical-align: middle;
    cursor: pointer;
    border: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background: none;
  }
  .tab-group{
    margin:  0 -10px 20px -10px;
  }
}

.modal-overlay{
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: #00000047;
  z-index: 10000;
  &.modal-zindex-top{
    z-index: 20000;
  }
}

{# /* // Tabs */ #}


.tab-group{
  width: 100vw;
  padding: 0;
  overflow-x: scroll;
  white-space: nowrap;
  .tab{
    display: inline-flex;
    float: none;
    &-link{
      float: left;
      padding: 10px;
      text-align: center;
      text-transform: uppercase;
    }
  }
}

.tab-panel:not(.active){
  display: none;
}
.tab-panel.active{
  display: block;
}

{# /* // Cards */ #}

.card {
	position: relative;
	display: -ms-flexbox;
	display: flex;
	margin-bottom: 20px;
	-ms-flex-direction: column;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-clip: border-box;
}

.card-body {
	-ms-flex: 1 1 auto;
	flex: 1 1 auto;
	padding: 15px;
}

.card-header {
	padding: 15px 15px 0 15px;
	margin-bottom: 0;
}

.card-footer {
	padding: 0 15px 15px 15px;
}

{# /* // Captcha */ #}

.g-recaptcha {
  margin-bottom: 24px;
}

.g-recaptcha > div {
  margin: 0 auto;
}

.grecaptcha-badge {
  bottom: 100px !important;
}

{#/*============================================================================
  #Header and nav
==============================================================================*/#}

{# /* // Nav */ #}

.modal-full-width {
  width: 100%;
  max-width: 100%;
}
.modal-body-scrollable-auto .modal-body {
  max-height: calc(100vh - 100px);
  overflow-y: auto;
}

.modal-nav-hamburger {
  text-align: center;
  .modal-header {
      width: 100%;
      margin: 25px 0 -10px 0;
      .modal-close {
        margin: 0;
        padding: 5px;
      }
  }
}

.nav-primary {
  padding: 0 0 80px;
  .nav-list {
    padding: 10px 0 10px;
    list-style: none;
    .item-with-subitems {
      position: relative;
    }
    .nav-list-link {
      display: block;
      padding: 15px;
      font-family: var(--julia-font-heading, sans-serif);
      font-size: clamp(14px, 0.35vw + 12.5px, 15px);
      font-weight: 700;
      border-bottom: 0;
      }
    &-arrow {
      position: absolute;
      top: 15px;
      right: 20px;
      font-size: 14px;
      cursor: pointer;
    }
    .selected .nav-list-arrow  {
      transform: rotate(90deg);
    }
    .list-subitems {
      padding: 0;
      list-style: none;
      .nav-list-link {
        font-weight: 400;
      }
    }
  }

}

.nav-account {
  margin: 10px -15px -10px -15px;
  padding: 0;
  list-style: none;
  .nav-accounts-item {
    display: inline-block;
    margin: 10px;
    font-size: 14px;
  } 
}

.hamburger-panel{
    box-shadow: none;
    .btn-hamburger-close {
        right: 15px;
        top: 6px;
        font-size: 18px;
    }
    .list-items {
        padding: 45px 0 10px;
        .hamburger-panel-link {
            display: block;
            padding: 20px;
            font-family: var(--julia-font-heading, sans-serif);
            font-size: clamp(14px, 0.35vw + 12.5px, 15px);
            letter-spacing: 1px;
            font-weight: 700;
            border-bottom: 0;
        }
        .list-subitems { 
            padding: 0;
        }
    }
    .hamburger-panel-arrow {
        font-size: 12px;
        &.selected {
            transform: rotate(90deg);
        }
    }
    .hamburger-panel-first-row {
        background: none;
        .mobile-accounts{
            padding: 0 12px;
            .mobile-accounts-item {
                width: auto;
                display: inline-block;
                .mobile-accounts-link {
                    padding: 10px 5px;
                    font-size: 12px;
                    opacity: 0.6;
                }
                &:first-child a:after {
                position: relative;
                right: -7px;
                content: "|";
                }
            }
        }
    }
  &-arrow{
    top: 15px;
    right: 10px;
    margin-top: -10px;
    &.selected svg{
      transform-origin: center;
      transform: rotate(180deg);
      -webkit-transform: rotate(180deg);
      -moz-transform: rotate(180deg);
      -ms-transform: rotate(180deg);
      -o-transform: rotate(180deg);
    }
  }
}

.nav-dropdown-content:hover,
.nav-dropdown:hover .nav-dropdown-content {
  visibility: visible;
  opacity: 1;
  transition-delay: 0s;
}

.desktop-dropdown-small {
  top: calc(100% - 10px);
  left: -10px;
  z-index: 9;
  width: 150px;
  padding: 15px;
}

{# /* Julia Design — comportamientos de encabezado por plantilla (ver prototype/) */ #}

.julia-head-bar {
  transition: transform 0.45s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.45s ease, background-color 0.4s ease,
    backdrop-filter 0.4s ease;
}

{# Geometría hero/nav compartida: html (documentElement para JS) + body (layout). Sin duplicar media queries #}
html.julia-html-home,
body.julia-head-mode--home {
  --julia-nav-h: 60px;
  --julia-hero-strip: 120px;
  --julia-img-col: 56%;
}

@media (max-width: 991px) {
  html.julia-html-home,
  body.julia-head-mode--home {
    --julia-img-col: 52%;
  }
}

@media (max-width: 767px) {
  html.julia-html-home,
  body.julia-head-mode--home {
    --julia-nav-h: 56px;
    --julia-hero-strip: 120px;
    --julia-img-col: 100%;
  }
}

{# Solo en body: scroll, logo strip interno, padding del wrap #}
body.julia-head-mode--home {
  --julia-hero-scroll-dock: 120px;
  --julia-hero-logo-top: 32px;
  --julia-header-pad: clamp(16px, 3.5vw, 44px);
}

@media (max-width: 767px) {
  body.julia-head-mode--home {
    --julia-hero-logo-top: 24px;
  }
}

{# Home: arriba del todo barra transparente; tras scroll sólida (prototype .nav / .nav.solid) #}
body.julia-head-mode--home:not(.julia-head-home-solid) .julia-head-bar {
  background-color: transparent !important;
  border-bottom: none;
  box-shadow: none;
}

body.julia-head-mode--home.julia-head-home-solid .julia-head-bar {
  background-color: rgba(36, 28, 23, 0.96) !important;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}

{# Home: mismo mapa z que prototype (nav 500, logo 300/600, mega 490) #}
body.julia-head-mode--home .head-main {
  z-index: 500;
}

{# Navbar: base --cream; hover / foco / ruta actual --white (iconos + enlaces + carrito en página carrito) #}
body.julia-head-mode--home .julia-head-bar .svg-icon-text,
body.julia-head-mode--home .julia-head-bar .logo-text,
body.julia-head-mode--home .julia-head-bar .cart-widget-amount,
body.julia-head-mode--catalog .julia-head-bar .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .logo-text,
body.julia-head-mode--catalog .julia-head-bar .cart-widget-amount,
body.julia-head-mode--static .julia-head-bar .svg-icon-text,
body.julia-head-mode--static .julia-head-bar .logo-text,
body.julia-head-mode--static .julia-head-bar .cart-widget-amount,
header.julia-head-bar.head-dark .svg-icon-text,
header.julia-head-bar.head-dark .logo-text,
header.julia-head-bar.head-dark .cart-widget-amount {
  color: var(--cream, #ece8e4);
  fill: var(--cream, #ece8e4);
}

body.julia-head-mode--home .julia-head-bar .utilities-item a:hover .svg-icon-text,
body.julia-head-mode--home .julia-head-bar .utilities-item a:hover .cart-widget-amount,
body.julia-head-mode--home .julia-head-bar .utilities-item a:focus-visible .svg-icon-text,
body.julia-head-mode--home .julia-head-bar .utilities-item a:focus-visible .cart-widget-amount,
body.julia-head-mode--catalog .julia-head-bar .utilities-item a:hover .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .utilities-item a:hover .cart-widget-amount,
body.julia-head-mode--catalog .julia-head-bar .utilities-item a:focus-visible .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .utilities-item a:focus-visible .cart-widget-amount,
body.julia-head-mode--static .julia-head-bar .utilities-item a:hover .svg-icon-text,
body.julia-head-mode--static .julia-head-bar .utilities-item a:hover .cart-widget-amount,
body.julia-head-mode--static .julia-head-bar .utilities-item a:focus-visible .svg-icon-text,
body.julia-head-mode--static .julia-head-bar .utilities-item a:focus-visible .cart-widget-amount,
header.julia-head-bar.head-dark .utilities-item a:hover .svg-icon-text,
header.julia-head-bar.head-dark .utilities-item a:hover .cart-widget-amount,
header.julia-head-bar.head-dark .utilities-item a:focus-visible .svg-icon-text,
header.julia-head-bar.head-dark .utilities-item a:focus-visible .cart-widget-amount {
  color: var(--white, #ffffff);
  fill: var(--white, #ffffff);
}

.julia-header-wrap {
  width: 100%;
  max-width: none;
  margin: 0 auto;
  padding-left: var(--julia-header-pad, 44px);
  padding-right: var(--julia-header-pad, 44px);
  box-sizing: border-box;
}

{# /* Hero principal (prototype home.html §1) */ #}
.julia-home-hero.hero {
  --ease: cubic-bezier(0.4, 0, 0.2, 1);
  display: grid;
  grid-template-columns: var(--julia-img-col, 56%) 1fr;
  background: #54463d;
  color: #fff;
  overflow: hidden;
}

.julia-home-hero .hero-left {
  display: flex;
  flex-direction: column;
  min-height: calc(100vh - var(--julia-nav-h, 60px));
}

.julia-home-hero__strip {
  flex-shrink: 0;
  width: 100%;
  height: var(--julia-hero-strip, 120px);
  background: #54463d;
}

.julia-home-hero .hero-img {
  flex: 1;
  position: relative;
  overflow: hidden;
  min-height: calc(100vh - var(--julia-nav-h, 60px) - var(--julia-hero-strip, 120px));
}

.julia-home-hero .julia-home-hero__img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center top;
  display: block;
  filter: brightness(0.88);
  transition: transform 10s var(--ease);
}

.julia-home-hero .hero-left:hover .julia-home-hero__img {
  transform: scale(1.025);
}

.julia-home-hero .hero-img-ph {
  width: 100%;
  height: 100%;
  min-height: calc(100vh - var(--julia-nav-h, 60px) - var(--julia-hero-strip, 120px));
  background: radial-gradient(ellipse at 40% 55%, #6b5438, #3a2e25 50%, #1a1410);
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 1rem;
}

.julia-home-hero .hero-img-ph span {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.7rem;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: rgba(255, 255, 255, 0.25);
  max-width: 16rem;
}

.julia-home-hero .hero-copy {
  position: sticky;
  top: var(--julia-nav-h, 60px);
  height: calc(100vh - var(--julia-nav-h, 60px));
  background: #54463d;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 0 64px 0 72px;
  box-sizing: border-box;
}

.julia-home-hero .hero-copy-inner {
  opacity: 0;
  transform: translateY(20px);
  animation: julia-hero-fade-up 0.9s 0.3s var(--ease) forwards;
}

@keyframes julia-hero-fade-up {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.julia-home-hero .hero-tagline {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(1.4rem, 2.5vw, 2.1rem);
  font-weight: 600;
  line-height: 1.3;
  color: #fff;
  margin: 0 0 20px;
}

.julia-home-hero .hero-sub {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(0.9rem, 1.3vw, 1.15rem);
  font-weight: 300;
  line-height: 1.65;
  color: #d2d0d0;
  opacity: 0.85;
  margin: 0 0 48px;
}

.julia-home-hero .hero-cta {
  display: flex;
  align-items: center;
  gap: 28px;
  flex-wrap: wrap;
}

.julia-home-hero .btn-primary {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.73rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: #54463d;
  background: #fff;
  border: none;
  border-radius: 100px;
  padding: 14px 32px;
  cursor: pointer;
  transition: background 0.25s ease, transform 0.2s ease;
  display: inline-block;
  text-decoration: none;
  text-align: center;
}

.julia-home-hero .btn-primary:hover {
  background: #d2d0d0;
  color: #54463d;
  transform: translateY(-1px);
}

.julia-home-hero .hero-cta-secondary {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.73rem;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: rgba(255, 255, 255, 0.88);
  text-decoration: none;
  padding: 12px 8px;
  border: none;
  background: none;
  cursor: pointer;
  transition: color 0.2s ease, opacity 0.2s ease;
  white-space: nowrap;
}

.julia-home-hero .hero-cta-secondary:hover {
  color: #fff;
  opacity: 1;
}

@media (max-width: 1200px) {
  .julia-home-hero .hero-copy {
    padding: 0 44px 0 48px;
  }
}

@media (max-width: 991px) {
  .julia-home-hero .hero-copy {
    padding: 0 28px 0 28px;
  }

  .julia-home-hero .hero-sub {
    margin-bottom: 36px;
  }
}

@media (max-width: 767px) {
  .julia-home-hero.hero {
    grid-template-columns: 1fr;
  }

  .julia-home-hero .hero-left {
    min-height: auto;
  }

  .julia-home-hero .hero-img,
  .julia-home-hero .hero-img-ph {
    min-height: calc(58dvh - var(--julia-nav-h, 56px) - var(--julia-hero-strip, 120px));
  }

  .julia-home-hero .hero-copy {
    position: relative;
    top: auto;
    height: auto;
    padding: 34px 24px 44px;
  }

  .julia-home-hero .hero-tagline {
    font-size: clamp(1.55rem, 7.8vw, 2rem);
  }

  .julia-home-hero .hero-sub {
    font-size: 0.98rem;
    margin-bottom: 28px;
  }

  .julia-home-hero .hero-cta {
    flex-direction: column;
    align-items: stretch;
    gap: 14px;
  }

  .julia-home-hero .btn-primary {
    width: 100%;
    text-align: center;
  }
}

{# /* Sección info (prototype home.html §2) — fondo visón / --mink */ #}
.julia-home-info.info {
  --ease: cubic-bezier(0.4, 0, 0.2, 1);
  display: grid;
  grid-template-columns: var(--julia-img-col, 56%) 1fr;
  background: var(--mink, #81756c);
  color: var(--white, #ffffff);
  min-height: 100vh;
}

.julia-home-info .info-left {
  padding: 96px 64px 80px 56px;
  display: flex;
  flex-direction: column;
}

.julia-home-info .info-headline {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(2.4rem, 4.5vw, 4rem);
  font-weight: 700;
  line-height: 1.1;
  letter-spacing: -0.02em;
  color: var(--white, #ffffff);
  margin: 0 0 32px;
}

.julia-home-info .info-lead {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(0.88rem, 1.2vw, 1.05rem);
  font-weight: 300;
  line-height: 1.75;
  color: rgba(255, 255, 255, 0.65);
  margin: 0 0 52px;
  max-width: 340px;
}

.julia-home-info .btn-catalog-sage {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.73rem;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--white, #ffffff);
  background: none;
  border: none;
  cursor: pointer;
  text-decoration: underline;
  text-underline-offset: 5px;
  opacity: 0.65;
  transition: opacity 0.2s;
  align-self: flex-start;
  display: inline-block;
}

.julia-home-info .btn-catalog-sage:hover {
  opacity: 1;
}

.julia-home-info .info-right {
  padding: 96px 56px 80px 52px;
  display: flex;
  flex-direction: column;
}

.julia-home-info .info-intro {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(0.82rem, 1.05vw, 0.95rem);
  font-weight: 400;
  line-height: 1.8;
  color: rgba(255, 255, 255, 0.7);
  margin: 0 0 52px;
  max-width: 460px;
}

.julia-home-info .accordion {
  border-top: 1px solid rgba(255, 255, 255, 0.2);
}

.julia-home-info .acc-item {
  border-bottom: 1px solid rgba(255, 255, 255, 0.2);
}

.julia-home-info .acc-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px 0;
  cursor: pointer;
  user-select: none;
}

.julia-home-info .acc-title {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(0.92rem, 1.2vw, 1.1rem);
  font-weight: 400;
  color: var(--white, #ffffff);
  transition: opacity 0.2s;
}

.julia-home-info .acc-header:hover .acc-title {
  opacity: 0.6;
}

.julia-home-info .acc-icon {
  width: 18px;
  height: 18px;
  flex-shrink: 0;
  transition: transform 0.35s var(--ease, cubic-bezier(0.4, 0, 0.2, 1));
}

.julia-home-info .acc-icon line {
  stroke: var(--white, #ffffff);
  stroke-width: 1.5;
}

.julia-home-info .acc-item.open .acc-icon {
  transform: rotate(45deg);
}

.julia-home-info .acc-body {
  overflow: hidden;
  max-height: 0;
  transition: max-height 0.42s var(--ease, cubic-bezier(0.4, 0, 0.2, 1));
}

.julia-home-info .acc-item.open .acc-body {
  max-height: 260px;
}

.julia-home-info .acc-body p {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.86rem;
  font-weight: 300;
  line-height: 1.8;
  color: rgba(255, 255, 255, 0.65);
  padding-bottom: 22px;
  max-width: 420px;
  margin: 0;
}

@media (max-width: 1200px) {
  .julia-home-info .info-left {
    padding: 72px 44px 64px 40px;
  }

  .julia-home-info .info-right {
    padding: 72px 40px 64px 40px;
  }
}

@media (max-width: 767px) {
  .julia-home-info.info {
    grid-template-columns: 1fr;
    min-height: auto;
  }

  .julia-home-info .info-left {
    padding: 48px 24px 26px;
  }

  .julia-home-info .info-right {
    padding: 18px 24px 46px;
  }

  .julia-home-info .info-headline {
    font-size: clamp(2rem, 10vw, 2.9rem);
    margin-bottom: 20px;
  }

  .julia-home-info .info-lead,
  .julia-home-info .info-intro {
    max-width: none;
  }

  .julia-home-info .accordion {
    margin-top: 8px;
  }

  .julia-home-info .acc-item.open .acc-body {
    max-height: 360px;
  }
}

@media (max-width: 480px) {
  .julia-home-info .info-left {
    padding: 40px 18px 20px;
  }

  .julia-home-info .info-right {
    padding: 16px 18px 38px;
  }
}

{# Home — exhibidor #}
:root {
  --julia-ex-gap: 56px;
  --julia-logo-show: clamp(120px, 14vw, 220px);
  --julia-exhibitor-logo-opacity: 0.8;
}

.julia-home-exhibitor.exhibitor {
  position: relative;
  background: var(--cream, #ece8e4);
  overflow: hidden;
  padding-top: calc(var(--julia-ex-gap) + var(--julia-logo-show));
  padding-bottom: clamp(72px, 14vw, 120px);
}

.julia-home-exhibitor__bg-logo {
  position: absolute;
  top: var(--julia-ex-gap);
  left: 0;
  right: 0;
  height: calc(var(--julia-logo-show) * 2.45);
  z-index: 0;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  pointer-events: none;
  user-select: none;
  overflow: visible;
}

.julia-home-exhibitor__bg-img {
  width: min(74%, 1120px);
  max-width: 1120px;
  display: block;
  height: auto;
  max-height: none;
  opacity: var(--julia-exhibitor-logo-opacity, 0.8);
}

.julia-home-exhibitor__bg-img--light {
  opacity: calc(var(--julia-exhibitor-logo-opacity, 0.8) * 0.95);
  filter: drop-shadow(0 1px 2px rgba(28, 26, 22, 0.12)) drop-shadow(0 4px 12px rgba(28, 26, 22, 0.08));
}

.julia-home-exhibitor__bg-fallback {
  font-family: var(--font-headings, "Hanken Grotesk", sans-serif);
  font-size: calc(var(--julia-logo-show) * 1.75);
  font-weight: 700;
  letter-spacing: -0.04em;
  color: rgba(28, 26, 22, 0.2);
  line-height: 1;
  white-space: nowrap;
}

.julia-home-exhibitor__bg-fallback--hidden {
  display: none;
}

.julia-home-exhibitor__heading-wrap {
  position: relative;
  z-index: 2;
  text-align: center;
  padding: 0 clamp(20px, 4vw, 48px) clamp(12px, 3vw, 24px);
}

.julia-home-exhibitor__heading {
  font-family: var(--font-headings, "Hanken Grotesk", sans-serif);
  font-size: clamp(1.15rem, 2.5vw, 1.35rem);
  font-weight: 600;
  letter-spacing: -0.02em;
  color: var(--dark-text, #1c1a16);
  margin: 0;
}

.julia-home-exhibitor__carousel-wrap {
  position: relative;
  z-index: 2;
  overflow: hidden;
  cursor: grab;
  margin-top: calc(var(--julia-logo-show) * -0.55);
}

.julia-home-exhibitor__carousel-wrap:active {
  cursor: grabbing;
}

.julia-home-exhibitor__track {
  display: flex;
  gap: 32px;
  padding: 0 clamp(20px, 5vw, 60px) 40px;
  will-change: transform;
  animation: julia-exhibitor-marquee 40s linear infinite;
}

.julia-home-exhibitor__track.paused {
  animation-play-state: paused;
}

@keyframes julia-exhibitor-marquee {
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(-50%);
  }
}

.julia-exhibitor-card {
  flex-shrink: 0;
  width: clamp(200px, 20vw, 300px);
  display: flex;
  flex-direction: column;
  text-decoration: none;
  color: inherit;
  background: transparent;
  border: none;
  box-shadow: none;
  margin: 0;
  padding: 0;
}

.julia-exhibitor-card__media {
  width: 100%;
  aspect-ratio: 4 / 5;
  background: transparent;
  border-radius: 0;
  overflow: hidden;
  margin-bottom: 14px;
  border: none;
  position: relative;
}

.julia-exhibitor-card__img {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: contain;
  object-position: center center;
  display: block;
  padding: 10%;
  margin: 0;
  background: transparent;
}

.julia-exhibitor-card__ph {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  color: rgba(28, 26, 22, 0.15);
  background: transparent;
}

.julia-exhibitor-card__ph svg {
  width: 36px;
  height: 36px;
}

.julia-exhibitor-card__title {
  font-family: var(--font-headings, "Hanken Grotesk", sans-serif);
  font-size: 0.92rem;
  font-weight: 600;
  color: var(--dark-text, #1c1a16);
  margin-bottom: 4px;
  line-height: 1.35;
}

.julia-exhibitor-card__subtitle {
  font-family: var(--font-rest, "Montserrat", sans-serif);
  font-size: 0.7rem;
  font-weight: 400;
  color: var(--mink, #81756c);
  letter-spacing: 0.06em;
  text-transform: uppercase;
  margin-bottom: 6px;
  line-height: 1.3;
}

.julia-exhibitor-card__price {
  font-family: var(--font-headings, "Hanken Grotesk", sans-serif);
  font-size: 0.8rem;
  font-weight: 500;
  color: var(--dark-text, #1c1a16);
  opacity: 0.85;
}

.julia-home-exhibitor__footer {
  display: flex;
  justify-content: center;
  padding: clamp(20px, 4vw, 32px) 16px 8px;
  position: relative;
  z-index: 2;
}

.julia-home-exhibitor__catalog-btn {
  font-family: var(--font-headings, "Hanken Grotesk", sans-serif);
  font-size: 0.73rem;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--dark-text, #1c1a16);
  background: transparent;
  border: 1.5px solid var(--dark-text, #1c1a16);
  border-radius: 100px;
  padding: 14px 40px;
  cursor: pointer;
  text-decoration: none;
  display: inline-block;
  transition: background 0.25s, color 0.25s, transform 0.2s;
}

.julia-home-exhibitor__catalog-btn:hover {
  background: var(--dark-text, #1c1a16);
  color: var(--cream, #ece8e4);
  transform: translateY(-1px);
}

@media (prefers-reduced-motion: reduce) {
  .julia-home-exhibitor__track {
    animation: none;
    transform: none;
    flex-wrap: wrap;
    justify-content: center;
    row-gap: 24px;
  }
}

@media (max-width: 1200px) {
  .julia-home-exhibitor__track {
    padding: 0 36px 34px;
    gap: 24px;
  }
}

@media (max-width: 991px) {
  .julia-exhibitor-card {
    width: clamp(180px, 28vw, 250px);
  }
}

@media (max-width: 768px) {
  :root {
    --julia-ex-gap: 22px;
    --julia-logo-show: clamp(100px, 22vw, 180px);
  }

  .julia-home-exhibitor.exhibitor {
    padding-top: calc(var(--julia-ex-gap) + var(--julia-logo-show));
    padding-bottom: clamp(64px, 18vw, 100px);
  }

  .julia-home-exhibitor__carousel-wrap {
    margin-top: calc(var(--julia-logo-show) * -0.42);
  }

  .julia-home-exhibitor__bg-img {
    width: min(88vw, 1120px);
    max-width: 100%;
    height: auto;
  }

  .julia-home-exhibitor__track {
    gap: 16px;
    padding: 0 20px 24px;
    animation-duration: 28s;
  }

  .julia-exhibitor-card {
    width: clamp(170px, 62vw, 230px);
  }

  .julia-exhibitor-card__title {
    font-size: 0.86rem;
  }

  .julia-exhibitor-card__subtitle {
    font-size: 0.66rem;
  }

  .julia-exhibitor-card__price {
    font-size: 0.75rem;
  }
}

@media (max-width: 480px) {
  .julia-home-exhibitor__track {
    padding: 0 14px 20px;
  }
}

{# Header Julia: móvil logo izquierda + utilidades derecha · desktop nav izquierda + logo centro + utilidades #}

.julia-header-grid {
  display: grid;
  grid-template-columns: auto 1fr auto;
  align-items: center;
  gap: 8px 12px;
  width: 100%;
}

.julia-header-nav-desktop {
  display: none;
  min-width: 0;
}

.julia-header-logo-cell {
  grid-column: 1;
  grid-row: 1;
  justify-self: start;
}

.julia-header-utilities-cell {
  grid-column: 3;
  grid-row: 1;
  justify-self: end;
}

@media (min-width: 768px) {
  .julia-header-grid {
    grid-template-columns: 1fr auto 1fr;
    gap: 12px 20px;
  }

  .julia-header-nav-desktop {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    grid-column: 1;
    grid-row: 1;
    justify-self: stretch;
  }

  .julia-header-logo-cell {
    grid-column: 2;
    justify-self: center;
  }

  .julia-header-utilities-cell {
    grid-column: 3;
    justify-self: end;
  }
}

.julia-header-logo {
  .logo-img-container {
    max-width: 200px;
    margin-left: 0;
    margin-right: auto;
    text-align: left;
  }

  @media (min-width: 768px) {
    .logo-img-container {
      margin-left: auto;
      margin-right: auto;
      text-align: center;
    }
  }

  .logo-img {
    margin-top: 8px;
    margin-bottom: 8px;
    max-height: 32px;
    max-width: 160px;
    width: auto;
  }

  {# Misma escala que el logo dock de la home (≈28px alto) — sin saltos entre páginas #}
  .logo-text,
  h1.logo-text,
  h1 {
    font-size: clamp(0.78rem, 1.15vw, 1rem) !important;
    font-weight: 700 !important;
    line-height: 1.1 !important;
    margin: 0 !important;
    letter-spacing: -0.02em;
  }
}

.julia-header-utilities {
  gap: 4px;
}

.julia-nav-desktop-list {
  display: flex;
  flex-wrap: nowrap;
  align-items: center;
  justify-content: flex-start;
  gap: clamp(10px, 2vw, 26px);
  list-style: none;
  margin: 0;
  padding: 0;
}

.julia-nav-desktop-link,
.julia-nav-desktop-summary {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.72rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: inherit;
  text-decoration: none;
  list-style: none;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 8px 0;
  transition: color 0.2s ease, opacity 0.2s ease;
}

.julia-nav-desktop-details {
  position: relative;
}

.julia-nav-desktop-details > summary {
  list-style: none;
}

.julia-nav-desktop-details > summary::-webkit-details-marker {
  display: none;
}

.julia-nav-desktop-chevron {
  transition: transform 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.julia-nav-desktop-details[open] .julia-nav-desktop-chevron {
  transform: rotate(180deg);
}

.julia-nav-desktop-panel {
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  min-width: 220px;
  padding: 8px 0;
  margin-top: 4px;
  background: rgba(36, 28, 23, 0.98);
  border: 1px solid rgba(255, 255, 255, 0.08);
  box-shadow: 0 14px 40px rgba(0, 0, 0, 0.22);
  z-index: 1200;
}

.julia-nav-desktop-sub {
  list-style: none;
  margin: 0;
  padding: 0;
}

.julia-nav-desktop-sub-link {
  display: block;
  padding: 10px 18px;
  color: #d2d0d0;
  font-size: 0.8125rem;
  text-decoration: none;
  transition: background 0.2s ease, color 0.2s ease;
}

.julia-nav-desktop-sub-link:hover {
  color: #ffffff;
  background: rgba(255, 255, 255, 0.06);
}

body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-link,
body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-summary,
body.julia-head-mode--home .julia-head-bar .julia-nav-plain-link,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-plain-link,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-link,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-summary,
body.julia-head-mode--static .julia-head-bar .julia-nav-plain-link,
header.julia-head-bar.head-dark .julia-nav-desktop-link,
header.julia-head-bar.head-dark .julia-nav-desktop-summary,
header.julia-head-bar.head-dark .julia-nav-plain-link {
  color: var(--cream, #ece8e4);
}

body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-link:hover,
body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-summary:hover,
body.julia-head-mode--home .julia-head-bar .julia-nav-plain-link:hover,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link:hover,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary:hover,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-plain-link:hover,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-link:hover,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-summary:hover,
body.julia-head-mode--static .julia-head-bar .julia-nav-plain-link:hover,
header.julia-head-bar.head-dark .julia-nav-desktop-link:hover,
header.julia-head-bar.head-dark .julia-nav-desktop-summary:hover,
header.julia-head-bar.head-dark .julia-nav-plain-link:hover,
body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-link:focus-visible,
body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-summary:focus-visible,
body.julia-head-mode--home .julia-head-bar .julia-nav-plain-link:focus-visible,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link:focus-visible,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary:focus-visible,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-plain-link:focus-visible,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-link:focus-visible,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-summary:focus-visible,
body.julia-head-mode--static .julia-head-bar .julia-nav-plain-link:focus-visible,
header.julia-head-bar.head-dark .julia-nav-desktop-link:focus-visible,
header.julia-head-bar.head-dark .julia-nav-desktop-summary:focus-visible,
header.julia-head-bar.head-dark .julia-nav-plain-link:focus-visible,
body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-link--current,
body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-summary.julia-nav-desktop-link--current,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link--current,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary.julia-nav-desktop-link--current,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-link--current,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-summary.julia-nav-desktop-link--current,
header.julia-head-bar.head-dark .julia-nav-desktop-link--current,
header.julia-head-bar.head-dark .julia-nav-desktop-summary.julia-nav-desktop-link--current,
body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-link[aria-current="page"],
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link[aria-current="page"],
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-link[aria-current="page"],
header.julia-head-bar.head-dark .julia-nav-desktop-link[aria-current="page"] {
  color: var(--white, #ffffff);
}

body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-summary:hover .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary:hover .svg-icon-text,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-summary:hover .svg-icon-text,
header.julia-head-bar.head-dark .julia-nav-desktop-summary:hover .svg-icon-text,
body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-details[open] .julia-nav-desktop-summary .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-details[open] .julia-nav-desktop-summary .svg-icon-text,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-details[open] .julia-nav-desktop-summary .svg-icon-text,
header.julia-head-bar.head-dark .julia-nav-desktop-details[open] .julia-nav-desktop-summary .svg-icon-text {
  color: var(--white, #ffffff);
  fill: var(--white, #ffffff);
}

body.julia-head-mode--home .julia-head-bar .julia-nav-desktop-summary.julia-nav-desktop-link--current .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary.julia-nav-desktop-link--current .svg-icon-text,
body.julia-head-mode--static .julia-head-bar .julia-nav-desktop-summary.julia-nav-desktop-link--current .svg-icon-text,
header.julia-head-bar.head-dark .julia-nav-desktop-summary.julia-nav-desktop-link--current .svg-icon-text {
  color: var(--white, #ffffff);
  fill: var(--white, #ffffff);
}

{# Home: logo solo flotante (#juliaLogoEl); la celda del header queda reservada #}
body.julia-head-mode--home .js-julia-header-logo {
  opacity: 0 !important;
  visibility: hidden !important;
  pointer-events: none !important;
}

{# Logo flotante: JS ancla el centro al borde superior de .hero-img (translate -50% -50%) #}
.julia-logo-el {
  position: fixed;
  z-index: 310;
  pointer-events: auto;
  white-space: nowrap;
  text-decoration: none;
  color: inherit;
  cursor: pointer;
  transition: opacity 0.35s cubic-bezier(0.4, 0, 0.2, 1);
}

.julia-logo-el:not(.julia-logo-el--docked) {
  display: inline-flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  filter: drop-shadow(0 2px 14px rgba(0, 0, 0, 0.35));
}

.julia-logo-el.fade-out {
  opacity: 0;
  pointer-events: none;
}

{# Altura del PNG: la ajusta store.js como prototype/js/home.js (72→28px al dock) #}
.julia-logo-el__img {
  display: block;
  width: auto;
  height: 72px;
  max-width: min(70vw, 320px);
  object-fit: contain;
  transition: height 0.45s cubic-bezier(0.4, 0, 0.2, 1);
}

.julia-logo-el--docked .julia-logo-el__img {
  height: 28px;
  max-width: 160px;
}

.julia-logo-el--docked {
  filter: none;
}

.julia-logo-el__tn-component {
  display: contents;
}

.julia-logo-el__wordmark {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-weight: 700;
  letter-spacing: -0.04em;
  color: #fff;
  line-height: 1.05;
  display: block;
  font-size: clamp(2rem, 5.2vw, 3.85rem);
  transition: font-size 0.45s cubic-bezier(0.4, 0, 0.2, 1), letter-spacing 0.35s ease, font-weight 0.35s ease;
}

{# Sobre el hero: wordmark fino como la maqueta #}
.julia-logo-el:not(.julia-logo-el--docked) .julia-logo-el__wordmark {
  font-weight: 300;
  letter-spacing: -0.02em;
}

{# Tras scroll: logo pequeño centrado en barra (maqueta) #}
.julia-logo-el--docked .julia-logo-el__wordmark {
  font-size: clamp(0.75rem, 1.2vw, 1rem);
  letter-spacing: 0.04em;
  text-transform: lowercase;
}

{# Mega menú (prototype .mega-menu) #}
.nav-muebles-btn {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.73rem;
  font-weight: 400;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: inherit;
  background: none;
  border: none;
  cursor: pointer;
  transition: color 0.2s ease, opacity 0.2s ease;
  display: inline-flex;
  align-items: center;
  gap: 5px;
  padding: 8px 0;
}

body.julia-head-mode--home .julia-head-bar .nav-muebles-btn,
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn,
body.julia-head-mode--static .julia-head-bar .nav-muebles-btn,
header.julia-head-bar.head-dark .nav-muebles-btn {
  color: var(--cream, #ece8e4);
}

body.julia-head-mode--home .julia-head-bar .nav-muebles-btn:hover,
body.julia-head-mode--home .julia-head-bar .nav-muebles-btn:focus-visible,
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn:hover,
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn:focus-visible,
body.julia-head-mode--static .julia-head-bar .nav-muebles-btn:hover,
body.julia-head-mode--static .julia-head-bar .nav-muebles-btn:focus-visible,
header.julia-head-bar.head-dark .nav-muebles-btn:hover,
header.julia-head-bar.head-dark .nav-muebles-btn:focus-visible,
li.menu-open .nav-muebles-btn,
body.julia-head-mode--home .julia-head-bar .nav-muebles-btn--current,
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn--current,
body.julia-head-mode--static .julia-head-bar .nav-muebles-btn--current,
header.julia-head-bar.head-dark .nav-muebles-btn--current,
body.julia-head-mode--home .julia-head-bar .nav-muebles-btn[aria-current="page"],
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn[aria-current="page"],
body.julia-head-mode--static .julia-head-bar .nav-muebles-btn[aria-current="page"],
header.julia-head-bar.head-dark .nav-muebles-btn[aria-current="page"] {
  color: var(--white, #ffffff);
}

.nav-arrow {
  width: 10px;
  height: 10px;
  stroke: currentColor;
  fill: none;
  stroke-width: 2;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  flex-shrink: 0;
}

li.menu-open .nav-arrow {
  transform: rotate(180deg);
}

.julia-nav-mega-trigger {
  position: static;
}

:root {
  --julia-nav-h: 60px;
}

{# Mega: ancho completo del viewport #}
.julia-mega-menu.mega-menu {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  width: 100%;
  max-width: none;
  height: 100dvh;
  margin: 0;
  padding: 64px 20px 26px;
  list-style: none;
  display: block;
  background: #121212;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  opacity: 0;
  visibility: hidden;
  transform: translateY(-14px);
  transition: opacity 0.35s cubic-bezier(0.4, 0, 0.2, 1), transform 0.35s cubic-bezier(0.4, 0, 0.2, 1),
    visibility 0.35s;
  pointer-events: none;
  z-index: 1050;
  overflow: hidden;
  box-sizing: border-box;
}

@media (min-width: 768px) {
  .julia-mega-menu.mega-menu {
    top: var(--julia-nav-h, 60px);
    left: 0;
    right: 0;
    width: 100%;
    height: calc(100vh - var(--julia-nav-h, 60px));
    padding: 0;
    z-index: 490;
    overflow: hidden;
  }
}

.julia-mega-menu.mega-menu.open {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
  pointer-events: auto;
}

.julia-mega-menu.mega-menu::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: rgba(255, 255, 255, 0.08);
}

{# Wordmark: prototipo — ocupa ~cuadrante inferior derecho, muy sutil, recortado por el borde #}
.julia-mega-menu.mega-menu::before {
  content: "julia";
  display: block;
  position: absolute;
  bottom: clamp(-1rem, -2vh, 5.5rem);
  right: -3vw;
  font-family: Georgia, "Times New Roman", Times, serif;
  font-size: clamp(7rem, 32vw, 22rem);
  font-weight: 400;
  letter-spacing: -0.045em;
  color: rgba(255, 255, 255, 0.048);
  line-height: 0.78;
  pointer-events: none;
  user-select: none;
  z-index: 0;
  text-transform: lowercase;
  white-space: nowrap;
  text-align: right;
  max-width: none;
}

{# Carril derecho: cerrar + Ver todo (solo desktop visible el segundo) #}
.julia-mega-desktop-rail {
  position: absolute;
  top: 0;
  right: 0;
  z-index: 4;
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 18px;
  padding: 28px clamp(16px, 3.5vw, 44px) 16px;
  box-sizing: border-box;
}

.julia-mega-desktop-rail .mega-close {
  position: static;
  background: none;
  border: none;
  cursor: pointer;
  color: #d2d0d0;
  opacity: 0.55;
  transition: opacity 0.2s ease, transform 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  padding: 8px;
  margin: 0;
}

.julia-mega-desktop-rail .mega-close:hover {
  opacity: 1;
  transform: rotate(90deg);
}

.julia-mega-desktop-rail .mega-close svg {
  width: 22px;
  height: 22px;
  stroke: currentColor;
  fill: none;
  stroke-width: 1.8;
}

.mega-view-all--desktop {
  display: none;
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.72rem;
  font-weight: 600;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: rgba(210, 208, 208, 0.82);
  opacity: 1;
  text-decoration: none;
  align-items: center;
  gap: 8px;
  transition: opacity 0.2s ease;
}

.mega-view-all--desktop:hover {
  color: rgba(255, 255, 255, 0.95);
}

.mega-view-all--desktop svg {
  width: 14px;
  height: 14px;
  stroke: currentColor;
  fill: none;
  stroke-width: 2;
}

@media (min-width: 768px) {
  .mega-view-all--desktop {
    display: inline-flex;
  }
}

.mega-view-all--mobile {
  margin-top: 1.5rem;
}

.mega-view-all--mobile a {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.72rem;
  font-weight: 600;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: rgba(210, 208, 208, 0.82);
  opacity: 1;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  transition: opacity 0.2s ease;
}

.mega-view-all--mobile a:hover {
  color: rgba(255, 255, 255, 0.95);
}

.mega-view-all--mobile svg {
  width: 14px;
  height: 14px;
  stroke: currentColor;
  fill: none;
  stroke-width: 2;
}

@media (min-width: 768px) {
  .mega-view-all--mobile {
    display: none;
  }
}

.julia-mega-categories-block {
  position: relative;
  z-index: 2;
  width: 100%;
  max-width: 42rem;
  box-sizing: border-box;
  padding: 48px clamp(20px, 4vw, 48px) 40px;
  padding-right: clamp(56px, 12vw, 140px);
}

@media (max-width: 767px) {
  .julia-mega-categories-block {
    max-width: none;
    padding: 8px 0 0;
    padding-right: 0;
  }
}

.mega-col-title {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 0.62rem;
  font-weight: 600;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: rgba(210, 208, 208, 0.72);
  margin: 0 0 22px;
  display: block;
  text-align: left;
}

.julia-mega-cat-links {
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  justify-content: flex-start;
  align-items: flex-start;
  gap: 0;
  width: 100%;
  max-width: none;
}

{# Prototipo: categorías más chicas, bloque compacto (interlineado cerrado) #}
.julia-mega-menu.mega-menu .julia-mega-cat-links a.mega-link {
  display: block;
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(1.2rem, 2.15vw, 1.95rem);
  font-weight: 700;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: rgba(236, 232, 228, 0.92);
  text-decoration: none;
  opacity: 1;
  line-height: 1.05;
  margin: 0;
  padding: 0;
  transition: color 0.2s ease, transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.julia-mega-menu.mega-menu .julia-mega-cat-links a.mega-link:hover {
  color: rgba(255, 255, 255, 0.98);
}

@media (min-width: 768px) {
  .julia-mega-menu.mega-menu .julia-mega-cat-links a.mega-link:hover {
    transform: translateX(12px);
  }
}

.mega-mobile-links .mega-link {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(1.15rem, 5.5vw, 1.65rem);
  font-weight: 700;
  line-height: 1.08;
  color: rgba(236, 232, 228, 0.92);
  text-decoration: none;
  display: block;
  padding: 2px 0;
  transition: opacity 0.2s ease, color 0.2s ease;
}

.mega-mobile-links .mega-link:hover {
  color: #fff;
}

.mega-mobile-top {
  display: none;
}

.mega-mobile-brand-text {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-weight: 700;
  font-size: 1.1rem;
  color: #fff;
}

.mega-mobile-cart {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #d2d0d0;
  text-decoration: none;
}

.mega-mobile-cart .mega-mobile-cart-svg {
  width: 20px;
  height: 20px;
  fill: currentColor;
}

body.julia-no-scroll-mega {
  overflow: hidden;
}

@media (max-width: 767px) {
  .julia-mega-desktop-rail {
    padding: 12px 16px 8px;
  }

  .mega-mobile-top {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding-right: 64px;
    margin-top: 18px;
    margin-bottom: 8px;
  }

  .mega-mobile-links {
    display: grid;
    gap: 2px;
    margin: 6px 0 10px;
  }

  .mega-mobile-links .mega-link {
    margin-bottom: 0;
  }

  .mega-mobile-brand img {
    width: 78px;
    height: auto;
    display: block;
  }

  .mega-mobile-cart {
    background: rgba(255, 255, 255, 0.06);
    border: 1px solid rgba(255, 255, 255, 0.14);
    width: 40px;
    height: 40px;
    border-radius: 999px;
  }

  .mega-col-title {
    margin-bottom: 16px;
  }

  .julia-mega-menu.mega-menu .julia-mega-cat-links a.mega-link {
    font-size: clamp(1.1rem, 5.2vw, 1.75rem);
    line-height: 1.06;
    color: rgba(236, 232, 228, 0.92);
  }

  .julia-mega-menu.mega-menu::before {
    font-size: clamp(5rem, 38vw, 14rem);
    right: -8vw;
    bottom: clamp(1.5rem, 5vh, 3.5rem);
    max-width: none;
    text-transform: lowercase;
  }

  {# En mobile el panel es el mega: ocultamos enlaces sueltos del navbar y el botón categoría #}
  .julia-header-nav-desktop .julia-nav-links > li:not(#julia-mega-trigger) {
    display: none;
  }

  .julia-header-nav-desktop .nav-muebles-btn {
    display: none;
  }

  .julia-header-nav-desktop .julia-nav-links {
    display: flex;
    flex-direction: row;
    gap: 0;
    padding: 0;
    margin: 0;
  }
}

body.julia-head-mode--home .julia-head-bar.julia-head-hidden {
  transform: translateY(-100%);
  opacity: 0;
  pointer-events: none;
}

body.julia-head-mode--catalog .head-main {
  background: transparent !important;
  border-bottom: 0;
  box-shadow: none;
  backdrop-filter: none !important;
  -webkit-backdrop-filter: none !important;
}

@media (max-width: 767px) {
  {# Mobile catálogo: navbar fija + sólida (cremita) #}
  body.julia-head-mode--catalog .head-main {
    position: fixed !important;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1040;
    background: rgba(236, 232, 228, 0.97) !important;
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-bottom: 1px solid rgba(28, 26, 22, 0.07);
    box-shadow: 0 6px 24px rgba(28, 26, 22, 0.05);
  }
}

@media (min-width: 768px) {
  body.julia-catalog-compact .julia-head-bar {
    transform: translateY(-100%);
    opacity: 0;
    pointer-events: none;
  }

  body.julia-catalog-compact .julia-category-toolbar {
    position: fixed;
    left: 0;
    right: 0;
    top: 0;
    z-index: 480;
    margin-bottom: 0 !important;
    padding: 10px clamp(16px, 3.5vw, 44px) 14px;
    background: rgba(236, 232, 228, 0.96);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-bottom: 1px solid rgba(28, 26, 22, 0.07);
    box-shadow: 0 6px 24px rgba(28, 26, 22, 0.05);
  }

  body.julia-catalog-compact .nav-hamburger.modal-open {
    z-index: 500;
  }
}

.category-controls-spacer {
  height: 0;
  overflow: hidden;
  pointer-events: none;
  transition: height 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

{# /* Catálogo: fondo cream; barra superior transparente sin velo; texto marrón legible sobre cream */ #}
body.julia-head-mode--catalog {
  background-color: var(--cream, #ece8e4);
}

body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-plain-link,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary,
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn {
  color: rgba(84, 70, 61, 0.88) !important;
}

body.julia-head-mode--catalog .julia-head-bar .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .cart-widget-amount,
body.julia-head-mode--catalog .julia-head-bar .nav-arrow {
  color: rgba(84, 70, 61, 0.88) !important;
  fill: rgba(84, 70, 61, 0.88) !important;
  stroke: rgba(84, 70, 61, 0.88);
}

body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link:hover,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-plain-link:hover,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary:hover,
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn:hover,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link:focus-visible,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-plain-link:focus-visible,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary:focus-visible,
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn:focus-visible {
  color: rgba(84, 70, 61, 0.98) !important;
}

body.julia-head-mode--catalog .julia-head-bar .utilities-item a:hover .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .utilities-item a:focus-visible .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .utilities-item a:hover .cart-widget-amount,
body.julia-head-mode--catalog .julia-head-bar .utilities-item a:focus-visible .cart-widget-amount {
  color: rgba(84, 70, 61, 0.98) !important;
  fill: rgba(84, 70, 61, 0.98) !important;
}

body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link--current,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary.julia-nav-desktop-link--current,
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn--current,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-link[aria-current="page"],
body.julia-head-mode--catalog .julia-head-bar .nav-muebles-btn[aria-current="page"] {
  color: rgba(84, 70, 61, 1) !important;
}

body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-details[open] .julia-nav-desktop-summary .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary.julia-nav-desktop-link--current .svg-icon-text,
body.julia-head-mode--catalog .julia-head-bar .julia-nav-desktop-summary:hover .svg-icon-text {
  color: rgba(84, 70, 61, 0.96) !important;
  fill: rgba(84, 70, 61, 0.96) !important;
}

{# Catálogo: aire bajo navbar = nav-h + como máximo 24px (--julia-catalog-top-extra) #}
.julia-catalog-page {
  --julia-catalog-top-extra: 24px;
  color: var(--dark-text, #1c1a16);
  min-height: 100dvh;
  box-sizing: border-box;
  padding: calc(var(--julia-nav-h, 60px) + var(--julia-catalog-top-extra)) 28px 52px;
}

{# /* Página carrito: mismo fondo crema y aire que catálogo */ #}
.julia-cart-page {
  --julia-cart-top-extra: 24px;
  background: var(--cream, #ece8e4);
  color: var(--dark-text, #1c1a16);
  min-height: 100dvh;
  box-sizing: border-box;
  padding: calc(var(--julia-nav-h, 60px) + var(--julia-cart-top-extra)) 28px 52px;
  font-family: var(--julia-font-body, "Montserrat", sans-serif);
}

.julia-cart-page .page-header {
  margin-top: 0 !important;
  margin-bottom: clamp(1.25rem, 3vw, 2rem);
}

.julia-cart-page .page-header h1 {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-weight: 600;
  letter-spacing: -0.02em;
  color: var(--dark-text, #1c1a16);
  font-size: clamp(1.75rem, 4vw, 2.75rem);
}

.julia-cart-page .breadcrumbs {
  margin-bottom: 0.75rem;
}

.julia-cart-page .breadcrumbs .crumb,
.julia-cart-page .breadcrumbs .divider {
  color: var(--mink, #81756c);
  font-family: var(--julia-font-body, "Montserrat", sans-serif);
  font-size: clamp(0.8rem, 0.35vw + 0.75rem, 0.9rem);
  font-weight: 300;
}

.julia-cart-page .breadcrumbs a.crumb:hover {
  color: var(--brown, #54463d);
}

.julia-cart-page .breadcrumbs .crumb.active {
  color: var(--dark-text, #1c1a16);
  font-weight: 500;
}

.julia-cart-page__inner.container {
  max-width: 1140px;
}

{# /* Ítems y totales en página (cart_page: true) — alineados con modal carrito Julia */ #}
body.template-cart .cart-body,
body.template-cart #shoppingCartPage {
  color: var(--dark-text, #1c1a16);
}

body.template-cart .cart-item-name a,
body.template-cart .cart-item-name {
  color: var(--dark-text, #1c1a16) !important;
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-weight: 600;
  letter-spacing: -0.02em;
  text-decoration: none;
}

body.template-cart .cart-item-name a:hover {
  color: var(--brown, #54463d) !important;
}

body.template-cart .cart-item-name small {
  color: var(--mink, #81756c);
  font-weight: 300;
  font-family: var(--julia-font-body, "Montserrat", sans-serif);
}

body.template-cart .cart-item-subtotal {
  color: var(--dark-text, #1c1a16) !important;
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-weight: 600;
  letter-spacing: -0.02em;
}

body.template-cart .cart-item-input,
body.template-cart .form-control.cart-item-input {
  background: var(--white, #ffffff);
  border: 1px solid var(--gray-light, #d2d0d0);
  color: var(--dark-text, #1c1a16);
  border-radius: 0;
}

body.template-cart .cart-item-btn {
  background: transparent;
  border: 1px solid var(--gray-light, #d2d0d0);
  color: var(--dark-text, #1c1a16);
  border-radius: 0;
}

{# Cantidad en página carrito: alinear - [input] + #}
body.template-cart .form-quantity {
  display: inline-flex !important;
  align-items: stretch !important;
  gap: 0 !important;
}

body.template-cart .form-quantity .row.m-0 {
  display: inline-flex !important;
  align-items: stretch !important;
  gap: 0 !important;
  margin: 0 !important;
}

body.template-cart .form-quantity .js-cart-quantity-btn,
body.template-cart .form-quantity .cart-item-btn {
  width: 42px;
  height: 38px;
  padding: 0 !important;
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  background: var(--white, #ffffff);
  border: 1px solid var(--gray-light, #d2d0d0) !important;
  color: var(--dark-text, #1c1a16) !important;
  opacity: 1;
}

body.template-cart .form-quantity .cart-item-input,
body.template-cart .form-quantity .form-control.cart-item-input {
  width: 46px !important;
  height: 38px !important;
  padding: 0 !important;
  margin: 0 !important;
  text-align: center !important;
  border-left: 0 !important;
  border-right: 0 !important;
  border-top: 1px solid var(--gray-light, #d2d0d0) !important;
  border-bottom: 1px solid var(--gray-light, #d2d0d0) !important;
  border-radius: 0 !important;
  background: var(--white, #ffffff) !important;
  color: var(--dark-text, #1c1a16) !important;
  font-variant-numeric: tabular-nums;
}

body.template-cart .form-quantity .js-cart-quantity-btn svg {
  width: 14px;
  height: 14px;
  fill: currentColor;
}

body.template-cart .cart-item-btn:hover {
  border-color: var(--brown, #54463d);
  color: var(--brown, #54463d);
}

body.template-cart .cart-item-delete .btn {
  color: var(--mink, #81756c) !important;
}

body.template-cart .cart-item-delete .btn:hover {
  color: var(--brown, #54463d) !important;
}

body.template-cart .divider {
  border-color: var(--gray-light, #d2d0d0) !important;
}

body.template-cart .alert-info {
  background: var(--white, #ffffff);
  border: 1px solid var(--gray-light, #d2d0d0);
  color: var(--dark-text, #1c1a16);
  border-radius: 0;
}

body.template-cart .alert-warning {
  background: rgba(255, 255, 255, 0.65);
  border: 1px solid var(--mink, #81756c);
  color: var(--dark-text, #1c1a16);
  border-radius: 0;
}

body.template-cart .alert-warning a {
  color: var(--brown, #54463d);
  font-weight: 600;
}

body.template-cart .js-visible-on-cart-filled.h5,
body.template-cart .js-cart-total-container .h2 {
  color: var(--dark-text, #1c1a16);
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  letter-spacing: -0.02em;
}

body.template-cart .js-cart-total-container .text-primary,
body.template-cart #shoppingCartPage .text-primary {
  color: var(--brown, #54463d) !important;
}

body.template-cart #shoppingCartPage .btn-primary,
body.template-cart .cart-body .btn-primary {
  background: var(--dark-text, #1c1a16) !important;
  border: 1.5px solid var(--dark-text, #1c1a16) !important;
  color: var(--cream, #ece8e4) !important;
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-weight: 600;
  letter-spacing: -0.02em;
  border-radius: 0;
  text-transform: none;
  padding: 0.85rem 1.25rem;
}

body.template-cart #shoppingCartPage .btn-primary:hover,
body.template-cart .cart-body .btn-primary:hover {
  background: var(--brown, #54463d) !important;
  border-color: var(--brown, #54463d) !important;
  color: var(--cream, #ece8e4) !important;
}

body.template-cart #shoppingCartPage .btn-link,
body.template-cart .cart-body .btn-link {
  color: var(--brown, #54463d) !important;
  font-weight: 500;
  text-decoration: underline;
  text-underline-offset: 3px;
  text-transform: none;
  letter-spacing: 0;
}

body.template-cart #shoppingCartPage .btn-link:hover,
body.template-cart .cart-body .btn-link:hover {
  color: var(--dark-text, #1c1a16) !important;
}

body.template-cart #go-to-checkout {
  text-transform: none;
}

body.template-cart .js-shipping-calculator-container,
body.template-cart .shipping-calculator-head,
body.template-cart #cart-shipping-container {
  color: var(--dark-text, #1c1a16);
}

body.template-cart .js-total-promotions {
  color: var(--brown, #54463d);
  font-size: 0.9rem;
}

@media (max-width: 768px) {
  .julia-cart-page {
    padding: calc(var(--julia-nav-h, 56px) + var(--julia-cart-top-extra)) 16px 42px;
  }
}

body.template-cart .julia-mega-menu .mega-col-title,
body.template-cart .julia-mega-menu .mega-link,
body.template-cart .julia-mega-menu .mega-view-all a,
body.template-cart .julia-mega-menu a.mega-view-all {
  color: var(--dark-text, #1c1a16);
}

body.template-cart .julia-mega-menu .mega-link:hover,
body.template-cart .julia-mega-menu .mega-view-all a:hover,
body.template-cart .julia-mega-menu a.mega-view-all:hover {
  color: var(--brown, #54463d);
}

.julia-catalog-page__inner {
  width: 100%;
  max-width: none;
  padding-left: 0;
  padding-right: 0;
  box-sizing: border-box;
}

@media (max-width: 768px) {
  .julia-catalog-page {
    padding: calc(var(--julia-nav-h, 56px) + var(--julia-catalog-top-extra)) 16px 42px;
  }
}

.julia-catalog-title {
  font-family: var(--julia-font-heading);
  font-size: clamp(2rem, 4vw, 3.2rem);
  font-weight: 700;
  letter-spacing: -0.02em;
  line-height: 1.1;
  margin: 0 0 clamp(14px, 2.5vw, 22px);
  text-align: left;
}

.julia-catalog-lead {
  font-family: var(--julia-font-heading);
  font-size: clamp(0.88rem, 1.2vw, 1rem);
  font-weight: 300;
  line-height: 1.6;
  color: rgba(28, 26, 22, 0.72);
  max-width: 62ch;
  margin: 0 0 clamp(20px, 3vw, 28px);
}

.julia-catalog-toolbar-main {
  display: flex;
  flex-wrap: wrap;
  align-items: flex-start;
  justify-content: space-between;
  gap: 18px 24px;
  width: 100%;
}

.julia-catalog-tabs {
  display: flex;
  flex-wrap: wrap;
  gap: 8px 14px;
  align-items: center;
}

.julia-catalog-tab {
  font-family: var(--julia-font-heading);
  font-size: 0.84rem;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: rgba(28, 26, 22, 0.72);
  text-decoration: none;
  padding: 2px 0;
  border-bottom: 1px solid transparent;
  transition: color 0.2s, border-color 0.2s, opacity 0.2s;
  opacity: 0.85;
}

.julia-catalog-tab:hover,
.julia-catalog-tab:focus-visible {
  color: var(--dark-text, #1c1a16);
  opacity: 1;
}

.julia-catalog-tab--active {
  color: var(--dark-text, #1c1a16);
  border-bottom-color: var(--dark-text, #1c1a16);
  opacity: 1;
}

.julia-catalog-controls {
  margin-left: auto;
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  align-items: stretch;
  justify-content: flex-end;
  overflow: visible;
}

{# Ordenar y Filtros: mismo ancho y altura (pastilla) #}
.julia-catalog-pill,
.julia-catalog-dropdown--filters {
  flex: 0 0 228px;
  width: 228px;
  max-width: 100%;
  box-sizing: border-box;
}

.julia-catalog-pill {
  display: flex;
  align-items: center;
  gap: 10px;
  min-height: 44px;
  height: 44px;
  padding: 0 12px;
  border: 1px solid rgba(28, 26, 22, 0.2);
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.92);
  overflow: visible;
}

.julia-catalog-pill__label {
  font-family: var(--julia-font-heading);
  font-size: 0.72rem;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: rgba(28, 26, 22, 0.75);
  white-space: nowrap;
  flex-shrink: 0;
}

.julia-catalog-pill__field {
  flex: 1 1 auto;
  min-width: 0;
}

{# Ordenar: select TN oculto; UI = details + radios (sin chevron) #}
.julia-catalog-sort {
  position: relative;
}

.julia-catalog-sort-ui {
  flex: 1 1 auto;
  min-width: 0;
}

.julia-catalog-sort-native {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
  pointer-events: none;
}

.julia-catalog-sort-native .form-select-icon {
  display: none !important;
}

.julia-catalog-sort-details {
  position: static;
  width: 100%;
}

.julia-catalog-sort-summary {
  list-style: none;
  cursor: pointer;
  margin: 0;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  min-height: 24px;
  font-family: var(--julia-font-heading);
  font-size: 0.72rem;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: rgba(28, 26, 22, 0.92);
}

.julia-catalog-sort-summary::-webkit-details-marker {
  display: none;
}

.julia-catalog-sort-summary__value {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 118px;
  text-align: right;
}

.julia-catalog-sort-dropdown {
  position: absolute;
  top: calc(100% + 8px);
  left: 0;
  right: 0;
  z-index: 60;
  width: 100%;
  min-width: 0;
  max-width: none;
  max-height: min(70vh, 420px);
  overflow: auto;
  padding: 18px 16px;
  border: 1px solid rgba(28, 26, 22, 0.14);
  border-radius: 10px;
  background: #f4f3f1;
  box-shadow: 0 14px 32px rgba(0, 0, 0, 0.1);
}

.julia-catalog-sort-dropdown label,
.julia-catalog-sort-dropdown a {
  text-decoration: none;
  color: inherit;
}

.julia-catalog-sort-opt {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  margin: 0;
  padding: 8px 4px;
  font-family: var(--julia-font-heading);
  font-size: 0.8rem;
  color: rgba(28, 26, 22, 0.88);
  cursor: pointer;
}

.julia-catalog-sort-opt + .julia-catalog-sort-opt {
  border-top: 1px solid rgba(28, 26, 22, 0.08);
}

.julia-catalog-sort-opt input {
  margin-top: 3px;
  accent-color: var(--brown, #54463d);
}

{# Filtros por propiedad: misma lectura visual que el panel Ordenar #}
.julia-catalog-dropdown__body .julia-catalog-filter-opt {
  display: block;
  padding: 8px 4px;
  font-family: var(--julia-font-heading);
  font-size: 0.8rem;
  font-weight: 400;
  color: rgba(28, 26, 22, 0.88);
  cursor: pointer;
  text-decoration: none;
}

.julia-catalog-dropdown__body .julia-catalog-filter-opt + .julia-catalog-filter-opt {
  border-top: 1px solid rgba(28, 26, 22, 0.08);
}

.julia-catalog-dropdown__body .js-accordion-container .julia-catalog-filter-opt:first-child {
  border-top: 1px solid rgba(28, 26, 22, 0.08);
}

.julia-catalog-dropdown__body .julia-catalog-filter-opt .checkbox {
  align-items: flex-start;
  gap: 10px;
}

.julia-catalog-dropdown__body .julia-catalog-filter-opt .checkbox-icon {
  margin-top: 3px;
}

.julia-catalog-dropdown {
  position: relative;
}

.julia-catalog-dropdown__summary {
  list-style: none;
  cursor: pointer;
  border: 1px solid rgba(28, 26, 22, 0.2);
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.92);
  box-sizing: border-box;
  height: 44px;
  min-height: 44px;
  padding: 0 12px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  font-family: var(--julia-font-heading);
  font-size: 0.72rem;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: rgba(28, 26, 22, 0.88);
}

.julia-catalog-dropdown__summary::-webkit-details-marker {
  display: none;
}

.julia-catalog-dropdown[open] .julia-catalog-dropdown__summary {
  border-color: rgba(28, 26, 22, 0.35);
}

.julia-catalog-dropdown__action {
  opacity: 0.45;
  transition: opacity 0.15s ease;
}

.julia-catalog-dropdown__action--active {
  opacity: 1;
  color: var(--brown, #54463d);
}

.julia-catalog-dropdown__body {
  position: absolute;
  top: calc(100% + 8px);
  right: 0;
  width: min(100vw - 32px, 320px);
  max-height: min(70vh, 420px);
  overflow: auto;
  border: 1px solid rgba(28, 26, 22, 0.14);
  border-radius: 10px;
  background: #f4f3f1;
  box-shadow: 0 14px 32px rgba(0, 0, 0, 0.1);
  padding: 18px 16px;
  z-index: 50;
}

.julia-catalog-dropdown__body #filters {
  margin: 0;
}

.julia-catalog-dropdown__body .filters-container {
  margin-bottom: 1.25rem !important;
}

.julia-catalog-dropdown__body .filters-container:last-child {
  margin-bottom: 0 !important;
}

{# Bloque precio: título + slider + Aplicar (sin colapsable) #}
.julia-catalog-dropdown__body .julia-catalog-filter-price {
  padding-bottom: 8px;
  margin-bottom: 1.25rem !important;
  border-bottom: 1px solid rgba(28, 26, 22, 0.08);
}

.julia-catalog-dropdown__body .julia-catalog-filter-price:last-child {
  margin-bottom: 0 !important;
  border-bottom: 0;
}

{# Grupos de filtro colapsables (solo propiedades) #}
.julia-catalog-dropdown__body .julia-catalog-filter-group {
  margin-bottom: 1.25rem !important;
}

.julia-catalog-dropdown__body .julia-catalog-filter-group:last-child {
  margin-bottom: 0 !important;
}

.julia-catalog-filter-group__summary {
  list-style: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  padding: 10px 4px 10px 0;
  font-family: var(--julia-font-heading);
  font-size: 0.72rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: rgba(84, 70, 61, 0.88);
  user-select: none;
}

.julia-catalog-filter-group__summary::-webkit-details-marker {
  display: none;
}

.julia-catalog-filter-group__summary::after {
  content: "";
  display: block;
  width: 0.45rem;
  height: 0.45rem;
  border-right: 2px solid rgba(28, 26, 22, 0.4);
  border-bottom: 2px solid rgba(28, 26, 22, 0.4);
  transform: rotate(45deg);
  margin-top: -2px;
  transition: transform 0.2s ease;
  flex-shrink: 0;
}

.julia-catalog-filter-group[open] .julia-catalog-filter-group__summary::after {
  transform: rotate(-135deg);
  margin-top: 4px;
}

.julia-catalog-filter-group__body {
  padding-top: 2px;
  padding-bottom: 4px;
}

.julia-catalog-filter-group__body .filters-container {
  margin-bottom: 0 !important;
}

{# Filtro precio: inputs nativos ocultos; UI = slider (JS) #}
.julia-catalog-dropdown__body .filter-input-price-container.julia-catalog-price-native-hidden {
  position: absolute !important;
  width: 1px !important;
  height: 1px !important;
  padding: 0 !important;
  margin: -1px !important;
  overflow: hidden !important;
  clip: rect(0, 0, 0, 0) !important;
  white-space: nowrap !important;
  border: 0 !important;
}

.julia-catalog-price-range-wrap {
  margin-bottom: 18px;
}

.julia-catalog-price-range-hints {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 12px;
  font-family: var(--julia-font-heading);
  font-size: 0.68rem;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: rgba(84, 70, 61, 0.55);
}

.julia-catalog-price-range-hint {
  max-width: 48%;
  line-height: 1.35;
}

.julia-catalog-price-range-hint--max {
  text-align: right;
}

.julia-catalog-price-range-slider {
  display: block;
  width: 100%;
  height: 28px;
  margin: 0;
  padding: 0;
  cursor: pointer;
  accent-color: var(--brown, #54463d);
  background: transparent;
}

.julia-catalog-price-range-slider::-webkit-slider-runnable-track {
  height: 5px;
  border-radius: 3px;
  background: rgba(84, 70, 61, 0.35);
}

.julia-catalog-price-range-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: var(--brown, #54463d);
  border: 2px solid #ffffff;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.2);
  margin-top: -5px;
}

.julia-catalog-price-range-slider::-moz-range-track {
  height: 5px;
  border-radius: 3px;
  background: rgba(84, 70, 61, 0.35);
}

.julia-catalog-price-range-slider::-moz-range-thumb {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: var(--brown, #54463d);
  border: 2px solid #ffffff;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.2);
}

.julia-catalog-price-range-value {
  margin-top: 10px;
  font-family: var(--julia-font-heading);
  font-size: 0.8rem;
  color: rgba(28, 26, 22, 0.72);
}

{# Sección colores: título como precio #}
.julia-catalog-dropdown__body .filters-container .h6,
.julia-catalog-dropdown__body .filters-container h6 {
  font-family: var(--julia-font-heading);
  font-size: 0.72rem !important;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: rgba(84, 70, 61, 0.65) !important;
  margin-bottom: 12px !important;
}

.julia-catalog-dropdown__body .filters-container .btn,
.julia-catalog-dropdown__body .filters-container .btn-default {
  width: 100% !important;
  margin-top: 14px !important;
  margin-bottom: 0 !important;
  display: block !important;
  box-sizing: border-box !important;
  padding: 10px 14px !important;
  font-family: var(--julia-font-heading);
  font-size: 0.72rem !important;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--dark-text, #1c1a16) !important;
  background: #ffffff !important;
  border: 1px solid rgba(28, 26, 22, 0.28) !important;
  border-radius: 8px !important;
}

{# En catálogo, el filtro precio se aplica reactivo: ocultar botón nativo #}
.julia-catalog-dropdown__body .julia-catalog-filter-price .btn,
.julia-catalog-dropdown__body .julia-catalog-filter-price .btn-default {
  position: absolute !important;
  width: 1px !important;
  height: 1px !important;
  padding: 0 !important;
  margin: -1px !important;
  overflow: hidden !important;
  clip: rect(0, 0, 0, 0) !important;
  white-space: nowrap !important;
  border: 0 !important;
}

.julia-catalog-dropdown__body .checkbox-container .checkbox {
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  align-items: center;
  gap: 0;
}

{# Orden: casilla → franja de color → nombre (maqueta) #}
.julia-catalog-dropdown__body .checkbox-container .checkbox-icon {
  order: 1;
  flex-shrink: 0;
  border-color: rgba(28, 26, 22, 0.35) !important;
}

.julia-catalog-dropdown__body .checkbox-container .checkbox-color {
  order: 2;
  width: 3px !important;
  min-width: 3px;
  height: 14px !important;
  border-radius: 1px;
  margin: 0 8px 0 8px !important;
  flex-shrink: 0;
}

.julia-catalog-dropdown__body .checkbox-container .checkbox-text {
  order: 3;
  color: rgba(28, 26, 22, 0.82) !important;
}

.julia-catalog-empty {
  padding: 2rem 0;
}

{# Rejilla a ancho completo con calles finas (alineado a maqueta) #}
.julia-catalog-page .julia-catalog-grid.row {
  margin-left: -6px;
  margin-right: -6px;
}

.julia-catalog-page .julia-catalog-grid.row > [class*="col"] {
  padding-left: 6px;
  padding-right: 6px;
}

.template-category .julia-catalog-grid .item-product {
  transition: transform 0.25s cubic-bezier(0.4, 0, 0.2, 1), box-shadow 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  border-radius: 6px;
}

{# Cards catálogo: título negro · categoría visón 75% · precio negro negrita #}
.template-category .julia-catalog-grid .item-name {
  color: var(--dark-text, #1c1a16) !important;
}

.template-category .julia-catalog-grid .item-category-label {
  font-family: var(--julia-font-heading);
  font-size: 0.72rem;
  letter-spacing: 0.06em;
  color: var(--mink, #81756c);
  opacity: 0.75;
}

.template-category .julia-catalog-grid .item-price-container .item-price,
.template-category .julia-catalog-grid .item-price-container .item-price-prefix {
  color: var(--dark-text, #1c1a16) !important;
  font-weight: 700;
}

.template-category .julia-catalog-grid .item-product:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 28px rgba(28, 26, 22, 0.12);
}

@media (min-width: 768px) and (max-width: 1199px) {
  .template-category .julia-catalog-grid > .item-product[class*="col"] {
    flex: 0 0 33.333333% !important;
    max-width: 33.333333% !important;
  }
}

@media (min-width: 1200px) {
  .template-category .julia-catalog-grid > .item-product[class*="col"] {
    flex: 0 0 25% !important;
    max-width: 25% !important;
  }
}

@media (max-width: 767px) {
  .julia-catalog-controls {
    margin-left: 0;
    width: 100%;
    justify-content: stretch;
  }

  .julia-catalog-tabs {
    display: none !important;
  }

  .julia-category-toolbar {
    margin-bottom: 12px;
  }

  .julia-catalog-pill,
  .julia-catalog-dropdown--filters {
    flex: 1 1 calc(50% - 5px);
    width: auto;
    min-width: 0;
    max-width: none;
  }

  .julia-catalog-dropdown {
    flex: 1 1 calc(50% - 5px);
    min-width: 0;
  }

  .julia-catalog-dropdown__body {
    left: 0;
    right: 0;
    width: auto;
  }

  .julia-catalog-sort-dropdown {
    left: 0;
    right: 0;
    width: 100%;
    max-width: none;
    min-width: 0;
  }

  body.julia-catalog-compact .julia-category-toolbar {
    position: fixed;
    left: 0;
    right: 0;
    top: var(--julia-nav-h, 60px);
    z-index: 480;
    margin-bottom: 0 !important;
    padding: 10px clamp(16px, 3.5vw, 44px) 12px;
    background: rgba(236, 232, 228, 0.97);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-bottom: 1px solid rgba(28, 26, 22, 0.07);
    box-shadow: 0 6px 24px rgba(28, 26, 22, 0.05);
  }
}

.julia-applied-filters {
  margin-top: 6px;
  margin-bottom: 14px;
}

.julia-applied-filters__clear {
  font-family: var(--julia-font-heading);
  font-size: 0.72rem;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: rgba(28, 26, 22, 0.82);
  opacity: 0.85;
  text-decoration: none;
}

.julia-applied-filters__clear:hover,
.julia-applied-filters__clear:focus-visible {
  opacity: 1;
  text-decoration: none;
}

{# Institucionales: barra transparente sobre el split (misma lectura que home sin scroll sólido) #}
body.julia-head-mode--static {
  padding-top: 0;
}

body.julia-head-mode--static .head-main {
  position: fixed !important;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1040;
  background: transparent !important;
  border-bottom: none;
  box-shadow: none;
  backdrop-filter: none;
  -webkit-backdrop-filter: none;
}

{# Institucionales: logo claro si solo hay logo oscuro disponible (invertir imagen). #}
body.julia-head-mode--static .julia-logo-invert {
  filter: brightness(0) invert(1);
}

{# No anular padding-top del .julia-inst-split: el offset --julia-nav-h evita que el contenido quede bajo la barra fija #}

{# /* Páginas institucionales: quienes-somos / como-trabajamos (prototype split + FAQ) */ #}

.julia-inst-split {
  --julia-inst-ease: cubic-bezier(0.4, 0, 0.2, 1);
  width: 100%;
  padding-top: var(--julia-nav-h, 60px);
  display: grid;
  grid-template-columns: 1fr 1fr;
  min-height: 100dvh;
  background: var(--julia-inst-panel-bg, #54463d);
  color: var(--white, #ffffff);
}

.julia-inst-split__media {
  min-height: calc(100dvh - var(--julia-nav-h, 60px));
  overflow: hidden;
  background: var(--julia-inst-media-bg, #d2d0d0);
}

.julia-inst-split__img {
  width: 100%;
  height: 100%;
  min-height: calc(100dvh - var(--julia-nav-h, 60px));
  object-fit: cover;
  object-position: center;
  display: block;
  filter: brightness(0.92);
}

.julia-inst-split__media-ph {
  width: 100%;
  min-height: calc(100dvh - var(--julia-nav-h, 60px));
  height: 100%;
  background: linear-gradient(145deg, rgba(212, 208, 204, 1) 0%, #c4bdb5 45%, #a69f96 100%);
}

.julia-inst-split__panel {
  padding: clamp(24px, 4vw, 56px);
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  gap: 18px;
  background: var(--julia-inst-panel-bg, #54463d);
}

.julia-inst-split__title {
  font-family: var(--julia-font-heading);
  font-size: clamp(2rem, 5vw, 4rem);
  font-weight: 700;
  letter-spacing: -0.02em;
  line-height: 1.05;
  margin: 0 0 clamp(16px, 3vw, 28px);
  color: var(--white, #ffffff);
}

.julia-inst-split__body--about {
  display: flex;
  flex-direction: column;
  gap: 18px;
}

{# Contenido desde el editor de páginas (HTML) #}
.julia-inst-split__body--about.julia-inst-user-html {
  display: block;
  max-width: 62ch;
}

.julia-inst-split__body--about.julia-inst-user-html > *:first-child {
  margin-top: 0;
}

.julia-inst-split__body--about.julia-inst-user-html p,
.julia-inst-split__body--about.julia-inst-user-html li {
  font-family: var(--julia-font-heading);
  font-size: clamp(0.88rem, 1.2vw, 1.05rem);
  font-weight: 300;
  line-height: 1.65;
  color: rgba(255, 255, 255, 0.72);
}

.julia-inst-split__body--about.julia-inst-user-html a {
  color: var(--cream, #ece8e4);
  text-decoration: underline;
}

.julia-inst-split__body--about.julia-inst-user-html ul,
.julia-inst-split__body--about.julia-inst-user-html ol {
  margin: 0 0 1em;
  padding-left: 1.25em;
}

.julia-inst-split__body--about.julia-inst-user-html h2,
.julia-inst-split__body--about.julia-inst-user-html h3 {
  font-family: var(--julia-font-heading);
  color: var(--white, #ffffff);
  font-weight: 600;
  margin: 1.25em 0 0.5em;
  letter-spacing: -0.02em;
}

.julia-inst-split__p {
  font-family: var(--julia-font-heading);
  font-size: clamp(0.88rem, 1.2vw, 1.05rem);
  font-weight: 300;
  line-height: 1.65;
  color: rgba(255, 255, 255, 0.72);
  margin: 0;
  max-width: 62ch;
}

.julia-inst-faq-list {
  display: flex;
  flex-direction: column;
  gap: clamp(20px, 3vw, 32px);
}

.julia-inst-faq-group {
  font-family: var(--julia-font-heading);
  font-size: clamp(0.68rem, 0.95vw, 0.82rem);
  font-weight: 700;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: rgba(255, 255, 255, 0.48);
  margin: clamp(12px, 2vw, 22px) 0 0;
  padding: 0;
  line-height: 1.3;
}

.julia-inst-faq-group:first-child {
  margin-top: 0;
}

.julia-inst-faq-item {
  border-top: 1px solid rgba(255, 255, 255, 0.14);
  padding-top: clamp(16px, 2.2vw, 22px);
  margin: 0;
}

.julia-inst-faq-item:last-of-type {
  border-bottom: 1px solid rgba(255, 255, 255, 0.14);
  padding-bottom: clamp(16px, 2.2vw, 22px);
}

.julia-inst-faq-trigger {
  width: 100%;
  background: none;
  border: none;
  color: inherit;
  text-align: left;
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 12px;
  cursor: pointer;
  padding: 0;
}

.julia-inst-faq-q {
  display: block;
  font-family: var(--julia-font-heading);
  font-size: clamp(1.02rem, 1.5vw, 1.24rem);
  font-weight: 600;
  color: var(--white, #ffffff);
  line-height: 1.35;
  margin: 0;
  text-align: left;
}

.julia-inst-faq-plus {
  width: 18px;
  height: 18px;
  flex-shrink: 0;
  margin-top: 2px;
  position: relative;
  opacity: 0.7;
  transition: opacity 0.2s;
}

.julia-inst-faq-plus::before,
.julia-inst-faq-plus::after {
  content: "";
  position: absolute;
  left: 50%;
  top: 50%;
  background: var(--white, #ffffff);
  transform: translate(-50%, -50%);
  transition: transform 0.28s var(--julia-inst-ease), opacity 0.28s var(--julia-inst-ease);
}

.julia-inst-faq-plus::before {
  width: 14px;
  height: 1.5px;
}

.julia-inst-faq-plus::after {
  width: 1.5px;
  height: 14px;
}

.julia-inst-faq-item--open .julia-inst-faq-plus::after {
  transform: translate(-50%, -50%) rotate(90deg);
  opacity: 0;
}

.julia-inst-faq-item--open .julia-inst-faq-plus {
  opacity: 1;
}

.julia-inst-faq-content {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.35s var(--julia-inst-ease);
}

.julia-inst-faq-answer {
  font-family: var(--julia-font-heading);
  font-size: clamp(0.88rem, 1.2vw, 1.05rem);
  font-weight: 300;
  line-height: 1.65;
  color: rgba(255, 255, 255, 0.65);
  padding-top: 10px;
  max-width: 62ch;
}

@media (max-width: 900px) {
  .julia-inst-split {
    grid-template-columns: 1fr;
  }

  .julia-inst-split__media {
    min-height: 48dvh;
  }

  .julia-inst-split__img {
    min-height: 48dvh;
  }

  .julia-inst-split__media-ph {
    min-height: 48dvh;
  }

  .julia-inst-split__panel {
    padding-top: 22px;
    padding-bottom: 42px;
  }
}

{# /* // Search */ #}

.search-input {
  padding-right: 30px;
}

.search-input[type="search"]::-webkit-search-cancel-button {
  -webkit-appearance:none
}

.search-input-submit {
  position: absolute;
  top: 5px;
  right: 0;
  font-size: 18px;
  background: none;
  border: 0;
}

.search-suggest-list {
  margin: 0 0 10px 0;
  padding: 0;
}

.search-suggest-item {
  padding: 10px 15px;
  list-style: none;
}

.search-suggest-text,
.search-suggest-name {
  margin-bottom: 5px;
  line-height: 18px;
}
.search-suggest-icon {
  margin: 0 10px;
  font-size: 14px;
}

{#/*============================================================================
  #Footer
==============================================================================*/#}

footer {
  margin-top: 20px;
  padding: 30px 0; 
}

{# /* // Nav */ #}

.footer-menu {
  list-style: none;
  .footer-menu-item{
  }
}

{# /* // Newsletter */ #}

.newsletter {
  form {
    position: relative;
    .newsletter-btn {
      position: absolute;
      top: 0;
      right: 0px;
      padding: 10px;
    }
  } 
}

.footer-payments-shipping-logos{
  img {
    width: auto;
    max-height: 35px;
    margin: 2px;
    padding: 5px;
    border: 1px solid #eaeaea;
  }
}

.powered-by-text {
  display: inline-block; }

.powered-by-logo {
  display: inline-block;
  width: 160px;
}

.footer-logo {
  img {
    max-width: 100px;
    margin: 2px;
    padding: 5px;
  }
}

{# /* Julia — pie editorial (footer-julia.tpl) */ #}
.julia-footer {
  width: 100%;
  box-sizing: border-box;
  margin-top: 0;
  padding: clamp(2.5rem, 4vw, 4rem) clamp(1.25rem, 4vw, 3rem) clamp(1.75rem, 3vw, 2.5rem);
  background-color: var(--brown);
  color: var(--gray-light);
  font-family: var(--julia-font-body);
  font-size: var(--julia-text-body);
  a {
    color: var(--gray-light);
    text-decoration: none;
    transition: opacity 0.2s ease, color 0.2s ease;
    &:hover,
    &:focus-visible {
      color: var(--cream);
      opacity: 1;
    }
  }
}
.julia-footer__inner {
  width: 100%;
  max-width: none;
  margin: 0;
  box-sizing: border-box;
}
.julia-footer .footer-cols {
  display: grid;
  grid-template-columns: 1fr;
  gap: clamp(2rem, 4vw, 3.5rem);
  padding-bottom: clamp(1.75rem, 3vw, 2.5rem);
  @media (min-width: 768px) {
    grid-template-columns: 1fr 1fr;
    gap: 3rem;
  }
}
.julia-footer .footer-col-label {
  display: block;
  font-family: var(--julia-font-heading);
  font-size: var(--julia-text-btn);
  font-weight: 700;
  letter-spacing: -0.02em;
  text-transform: uppercase;
  color: var(--cream);
  margin-bottom: 1rem;
  opacity: 0.95;
}
.julia-footer .footer-nav,
.julia-footer .footer-info-nav {
  list-style: none;
  margin: 0;
  padding: 0;
  li {
    margin: 0 0 0.65rem;
    &:last-child {
      margin-bottom: 0;
    }
  }
  a {
    font-family: var(--julia-font-body);
    font-size: var(--julia-text-body);
    font-weight: 400;
    line-height: 1.5;
    letter-spacing: normal;
    text-transform: none;
    display: inline;
  }
}
.julia-footer .footer-social {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  margin-top: 1.25rem;
  align-items: center;
  a {
    display: inline-flex;
    color: var(--cream);
    opacity: 0.9;
    &:hover,
    &:focus-visible {
      opacity: 1;
    }
  }
  svg {
    width: 22px;
    height: 22px;
    display: block;
  }
}
.julia-footer .footer-logo-row {
  display: flex;
  justify-content: center;
  padding: clamp(1.75rem, 3vw, 2.5rem) 0;
}
.julia-footer .footer-stamp {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 48px;
}
.julia-footer .footer-stamp__img {
  max-width: min(200px, 40vw);
  max-height: 64px;
  width: auto;
  height: auto;
  object-fit: contain;
  &--header-logo {
    max-height: 48px;
  }
}
.julia-footer .footer-stamp__wordmark {
  font-family: var(--julia-font-heading);
  font-weight: 700;
  font-size: clamp(2rem, 4vw, 2.75rem);
  letter-spacing: -0.04em;
  line-height: 1;
  color: var(--cream);
  opacity: 0.85;
}
.julia-footer .footer-legal-row {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
  padding-top: 0.5rem;
  @media (min-width: 768px) {
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-between;
    align-items: center;
  }
}
.julia-footer .footer-legal-row--copy-only {
  padding-top: 1rem;
}
.julia-footer .footer-legal {
  list-style: none;
  margin: 0;
  padding: 0;
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem 1.25rem;
  justify-content: center;
  @media (min-width: 768px) {
    justify-content: flex-start;
  }
  a {
    font-size: var(--julia-text-legal);
    font-weight: 400;
    opacity: 0.9;
  }
}
.julia-footer .footer-copy {
  font-size: var(--julia-text-legal);
  opacity: 0.75;
  text-align: center;
  @media (min-width: 768px) {
    text-align: right;
    margin-left: auto;
  }
}
.julia-footer .footer-legal-row--copy-only .footer-copy {
  margin-left: 0;
  width: 100%;
  text-align: center;
  @media (min-width: 768px) {
    text-align: right;
  }
}
.julia-footer__powered {
  margin-top: 1.5rem;
  padding-top: 1.25rem;
  font-size: var(--julia-text-legal);
  text-align: center;
  opacity: 0.85;
  a {
    color: var(--gray-light);
    text-decoration: underline;
    text-underline-offset: 2px;
    &:hover,
    &:focus-visible {
      color: var(--cream);
    }
  }
  .powered-by-logo svg {
    opacity: 0.9;
  }
}
   
{#/*============================================================================
  #Home Page
==============================================================================*/#}

.section-slider-home,
.section-banners-home,
.section-video-home,
.section-home-modules,
.section-featured-home,
.section-welcome-home {
  @extend %section-margin;
}

{# /* // Instafeed */ #}

.instafeed-user {
	display: inline-block;
	margin: 0 0 0 5px;
  line-height: 24px;
  vertical-align: top;
}

.instafeed-link {
  position: relative;
  display: block;
  padding-top: 100%;
  overflow: hidden;
  &:hover,
  &:focus {
    .instafeed-img {
      @include prefix(transform, scale(1.03), webkit ms moz o);
    }
    .instafeed-info {
      opacity: 1;
    }
  }
  .instafeed-img {
    position: absolute;
    top: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
  }
  .instafeed-info {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding: 0;
    text-align: center;
    opacity: 0;
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
    .instafeed-info-item {
      display: inline-block;
      margin-top: 45%;
    }
  }
}

{# /* // Banners */ #}

.textbanner {
  .textbanner-image.overlay {
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
  }
  &:hover .textbanner-image.overlay,
  &:focus .textbanner-image.overlay {
    @include prefix(transform, scale(1.03), webkit ms moz o);
  }
}

{# /* // Placeholder */ #}

.placeholder-overlay {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 9;
  width: 100%;
  height: 100%;  
}

.placeholder-info {
  position: relative;
  top: 50%;
  left: 50%;
  width: 330px;
  padding: 30px 25px;
  text-align: center;
  line-height: 18px;
  transform: translate(-50%, -50%);
  box-sizing: border-box;
  .placeholder-description {
    margin: 20px 0;
  }
}

{#/*============================================================================
  #Product grid
==============================================================================*/#}

{# /* // Filters */ #}

.filters-overlay {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 30000;
  width: 100%;
  height: 100%;
  .filters-updating-message {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 80%;
    text-align: center;
    @include prefix(transform, translate(-50%, -50%), webkit ms moz o);
    * {
      font-size: 24px;
      font-weight: normal;
    }
  }
}

.filter-input-price-container {
  position: relative;
  display: inline-block;
  width: 85px;
  margin-right: 5px;
  .filter-input-price {
    padding: 10px 25px 10px 10px;
  }
}

{#/*============================================================================
  #Product detail
==============================================================================*/#}

{# /* // Image */ #}

.fancybox__container .has-inline .fancybox__content {
  width: 100%;
  height: calc(100% - 20px);
  padding: 0;
  @include prefix(transform, translateY(20px), webkit ms moz o);
  background: transparent;
  .fancybox-close-small {
    {# Hardcoded neutral color to match non iframe fancybox modal #}
    color: #ccc!important;
  }
}

.fancybox__container .fancybox__slide.has-inline::before {
  display: none
}

.fancybox-toolbar {
  opacity: 1!important;
  visibility: visible!important;
  .fancybox-button {
    display: none!important;
    &.fancybox-button--close{
      display: block!important;
    }
  }
}

.fancybox-close-small {
  display: none!important;
}

.carousel{position:relative;box-sizing:border-box}.carousel *,.carousel *:before,.carousel *:after{box-sizing:inherit}.carousel.is-draggable{cursor:move;cursor:grab}.carousel.is-dragging{cursor:move;cursor:grabbing}.carousel__viewport{position:relative;overflow:hidden;max-width:100%;max-height:100%}.carousel__track{display:flex}.carousel__slide{flex:0 0 auto;width:var(--carousel-slide-width, 60%);max-width:100%;padding:1rem;position:relative;overflow-x:hidden;overflow-y:auto;overscroll-behavior:contain}.has-dots{margin-bottom:calc(0.5rem + 22px)}.carousel__dots{margin:0 auto;padding:0;position:absolute;top:calc(100% + 0.5rem);left:0;right:0;display:flex;justify-content:center;list-style:none;user-select:none}.carousel__dots .carousel__dot{margin:0;padding:0;display:block;position:relative;width:22px;height:22px;cursor:pointer}.carousel__dots .carousel__dot:after{content:"";width:8px;height:8px;border-radius:50%;position:absolute;top:50%;left:50%;transform:translate(-50%, -50%);background-color:currentColor;opacity:.25;transition:opacity .15s ease-in-out}.carousel__dots .carousel__dot.is-selected:after{opacity:1}.carousel__button{width:var(--carousel-button-width, 48px);height:var(--carousel-button-height, 48px);padding:0;border:0;display:flex;justify-content:center;align-items:center;pointer-events:all;cursor:pointer;color:var(--carousel-button-color, currentColor);background:var(--carousel-button-bg, transparent);border-radius:var(--carousel-button-border-radius, 50%);box-shadow:var(--carousel-button-shadow, none);transition:opacity .15s ease}.carousel__button.is-prev,.carousel__button.is-next{position:absolute;top:50%;transform:translateY(-50%)}.carousel__button.is-prev{left:10px}.carousel__button.is-next{right:10px}.carousel__button[disabled]{cursor:default;opacity:.3}.carousel__button svg{width:var(--carousel-button-svg-width, 50%);height:var(--carousel-button-svg-height, 50%);fill:none;stroke:currentColor;stroke-width:var(--carousel-button-svg-stroke-width, 1.5);stroke-linejoin:bevel;stroke-linecap:round;filter:var(--carousel-button-svg-filter, none);pointer-events:none}html.with-fancybox{scroll-behavior:auto}body.compensate-for-scrollbar{overflow:hidden !important;touch-action:none}.fancybox__container{position:fixed;top:0;left:0;bottom:0;right:0;direction:ltr;margin:0;padding:env(safe-area-inset-top, 0px) env(safe-area-inset-right, 0px) env(safe-area-inset-bottom, 0px) env(safe-area-inset-left, 0px);box-sizing:border-box;display:flex;flex-direction:column;color:var(--fancybox-color, #fff);-webkit-tap-highlight-color:rgba(0,0,0,0);overflow:hidden;z-index:1050;outline:none;transform-origin:top left;--carousel-button-width: 48px;--carousel-button-height: 48px;--carousel-button-svg-width: 24px;--carousel-button-svg-height: 24px;--carousel-button-svg-stroke-width: 2.5;--carousel-button-svg-filter: drop-shadow(1px 1px 1px rgba(0, 0, 0, 0.4))}.fancybox__container *,.fancybox__container *::before,.fancybox__container *::after{box-sizing:inherit}.fancybox__container :focus{outline:none}body:not(.is-using-mouse) .fancybox__container :focus{box-shadow:0 0 0 1px #fff,0 0 0 2px var(--fancybox-accent-color, rgba(1, 210, 232, 0.94))}@media all and (min-width: 1024px){.fancybox__container{--carousel-button-width:48px;--carousel-button-height:48px;--carousel-button-svg-width:27px;--carousel-button-svg-height:27px}}.fancybox__backdrop{position:absolute;top:0;right:0;bottom:0;left:0;z-index:-1;background:var(--fancybox-bg, rgba(24, 24, 27, 0.92))}.fancybox__carousel{position:relative;flex:1 1 auto;min-height:0;height:100%;z-index:10}.fancybox__carousel.has-dots{margin-bottom:calc(0.5rem + 22px)}.fancybox__viewport{position:relative;width:100%;height:100%;overflow:visible;cursor:default}.fancybox__track{display:flex;height:100%}.fancybox__slide{flex:0 0 auto;width:100%;max-width:100%;margin:0;padding:48px 8px 8px 8px;position:relative;overscroll-behavior:contain;display:flex;flex-direction:column;outline:0;overflow:auto;--carousel-button-width: 36px;--carousel-button-height: 36px;--carousel-button-svg-width: 22px;--carousel-button-svg-height: 22px}.fancybox__slide::before,.fancybox__slide::after{content:"";flex:0 0 0;margin:auto}@media all and (min-width: 1024px){.fancybox__slide{padding:64px 100px}}.fancybox__content{margin:0 env(safe-area-inset-right, 0px) 0 env(safe-area-inset-left, 0px);padding:36px;color:var(--fancybox-content-color, #374151);background:var(--fancybox-content-bg, #fff);position:relative;align-self:center;display:flex;flex-direction:column;z-index:20}.fancybox__content :focus:not(.carousel__button.is-close){outline:thin dotted;box-shadow:none}.fancybox__caption{align-self:center;max-width:100%;margin:0;padding:1rem 0 0 0;line-height:1.375;color:var(--fancybox-color, currentColor);visibility:visible;cursor:auto;flex-shrink:0;overflow-wrap:anywhere}.is-loading .fancybox__caption{visibility:hidden}.fancybox__container>.carousel__dots{top:100%;color:var(--fancybox-color, #fff)}.fancybox__nav .carousel__button{z-index:40}.fancybox__nav .carousel__button.is-next{right:8px}@media all and (min-width: 1024px){.fancybox__nav .carousel__button.is-next{right:40px}}.fancybox__nav .carousel__button.is-prev{left:8px}@media all and (min-width: 1024px){.fancybox__nav .carousel__button.is-prev{left:40px}}.carousel__button.is-close{position:absolute;top:8px;right:8px;top:calc(env(safe-area-inset-top, 0px) + 8px);right:calc(env(safe-area-inset-right, 0px) + 8px);z-index:40}@media all and (min-width: 1024px){.carousel__button.is-close{right:40px}}.fancybox__content>.carousel__button.is-close{position:absolute;top:-40px;right:0;color:var(--fancybox-color, #fff)}.fancybox__no-click,.fancybox__no-click button{pointer-events:none}.fancybox__spinner{position:absolute;top:50%;left:50%;transform:translate(-50%, -50%);width:50px;height:50px;color:var(--fancybox-color, currentColor)}.fancybox__slide .fancybox__spinner{cursor:pointer;z-index:1053}.fancybox__spinner svg{animation:fancybox-rotate 2s linear infinite;transform-origin:center center;position:absolute;top:0;right:0;bottom:0;left:0;margin:auto;width:100%;height:100%}.fancybox__spinner svg circle{fill:none;stroke-width:2.75;stroke-miterlimit:10;stroke-dasharray:1,200;stroke-dashoffset:0;animation:fancybox-dash 1.5s ease-in-out infinite;stroke-linecap:round;stroke:currentColor}@keyframes fancybox-rotate{100%{transform:rotate(360deg)}}@keyframes fancybox-dash{0%{stroke-dasharray:1,200;stroke-dashoffset:0}50%{stroke-dasharray:89,200;stroke-dashoffset:-35px}100%{stroke-dasharray:89,200;stroke-dashoffset:-124px}}.fancybox__backdrop,.fancybox__caption,.fancybox__nav,.carousel__dots,.carousel__button.is-close{opacity:var(--fancybox-opacity, 1)}.fancybox__container.is-animated[aria-hidden=false] .fancybox__backdrop,.fancybox__container.is-animated[aria-hidden=false] .fancybox__caption,.fancybox__container.is-animated[aria-hidden=false] .fancybox__nav,.fancybox__container.is-animated[aria-hidden=false] .carousel__dots,.fancybox__container.is-animated[aria-hidden=false] .carousel__button.is-close{animation:.15s ease backwards fancybox-fadeIn}.fancybox__container.is-animated.is-closing .fancybox__backdrop,.fancybox__container.is-animated.is-closing .fancybox__caption,.fancybox__container.is-animated.is-closing .fancybox__nav,.fancybox__container.is-animated.is-closing .carousel__dots,.fancybox__container.is-animated.is-closing .carousel__button.is-close{animation:.15s ease both fancybox-fadeOut}.fancybox-fadeIn{animation:.15s ease both fancybox-fadeIn}.fancybox-fadeOut{animation:.1s ease both fancybox-fadeOut}.fancybox-zoomInUp{animation:.2s ease both fancybox-zoomInUp}.fancybox-zoomOutDown{animation:.15s ease both fancybox-zoomOutDown}.fancybox-throwOutUp{animation:.15s ease both fancybox-throwOutUp}.fancybox-throwOutDown{animation:.15s ease both fancybox-throwOutDown}@keyframes fancybox-fadeIn{from{opacity:0}to{opacity:1}}@keyframes fancybox-fadeOut{to{opacity:0}}@keyframes fancybox-zoomInUp{from{transform:scale(0.97) translate3d(0, 16px, 0);opacity:0}to{transform:scale(1) translate3d(0, 0, 0);opacity:1}}@keyframes fancybox-zoomOutDown{to{transform:scale(0.97) translate3d(0, 16px, 0);opacity:0}}@keyframes fancybox-throwOutUp{to{transform:translate3d(0, -30%, 0);opacity:0}}@keyframes fancybox-throwOutDown{to{transform:translate3d(0, 30%, 0);opacity:0}}.fancybox__carousel .carousel__slide{scrollbar-width:thin;scrollbar-color:#ccc rgba(255,255,255,.1)}.fancybox__carousel .carousel__slide::-webkit-scrollbar{width:8px;height:8px}.fancybox__carousel .carousel__slide::-webkit-scrollbar-track{background-color:rgba(255,255,255,.1)}.fancybox__carousel .carousel__slide::-webkit-scrollbar-thumb{background-color:#ccc;border-radius:2px;box-shadow:inset 0 0 4px rgba(0,0,0,.2)}.fancybox__carousel.is-draggable .fancybox__slide,.fancybox__carousel.is-draggable .fancybox__slide .fancybox__content{cursor:move;cursor:grab}.fancybox__carousel.is-dragging .fancybox__slide,.fancybox__carousel.is-dragging .fancybox__slide .fancybox__content{cursor:move;cursor:grabbing}.fancybox__carousel .fancybox__slide .fancybox__content{cursor:auto}.fancybox__carousel .fancybox__slide.can-zoom_in .fancybox__content{cursor:zoom-in}.fancybox__carousel .fancybox__slide.can-zoom_out .fancybox__content{cursor:zoom-out}.fancybox__carousel .fancybox__slide.is-draggable .fancybox__content{cursor:move;cursor:grab}.fancybox__carousel .fancybox__slide.is-dragging .fancybox__content{cursor:move;cursor:grabbing}.fancybox__image{transform-origin:0 0;user-select:none;transition:none}.has-image .fancybox__content{padding:0;background:rgba(0,0,0,0);min-height:1px}.is-closing .has-image .fancybox__content{overflow:visible}.has-image[data-image-fit=contain]{overflow:visible;touch-action:none}.has-image[data-image-fit=contain] .fancybox__content{flex-direction:row;flex-wrap:wrap}.has-image[data-image-fit=contain] .fancybox__image{max-width:100%;max-height:100%;object-fit:contain}.has-image[data-image-fit=contain-w]{overflow-x:hidden;overflow-y:auto}.has-image[data-image-fit=contain-w] .fancybox__content{min-height:auto}.has-image[data-image-fit=contain-w] .fancybox__image{max-width:100%;height:auto}.has-image[data-image-fit=cover]{overflow:visible;touch-action:none}.has-image[data-image-fit=cover] .fancybox__content{width:100%;height:100%}.has-image[data-image-fit=cover] .fancybox__image{width:100%;height:100%;object-fit:cover}.fancybox__carousel .fancybox__slide.has-iframe .fancybox__content,.fancybox__carousel .fancybox__slide.has-map .fancybox__content,.fancybox__carousel .fancybox__slide.has-pdf .fancybox__content,.fancybox__carousel .fancybox__slide.has-video .fancybox__content,.fancybox__carousel .fancybox__slide.has-html5video .fancybox__content{max-width:100%;flex-shrink:1;min-height:1px;overflow:visible}.fancybox__carousel .fancybox__slide.has-iframe .fancybox__content,.fancybox__carousel .fancybox__slide.has-map .fancybox__content,.fancybox__carousel .fancybox__slide.has-pdf .fancybox__content{width:100%;height:80%}.fancybox__carousel .fancybox__slide.has-video .fancybox__content,.fancybox__carousel .fancybox__slide.has-html5video .fancybox__content{width:960px;height:540px;max-width:100%;max-height:100%}.fancybox__carousel .fancybox__slide.has-map .fancybox__content,.fancybox__carousel .fancybox__slide.has-pdf .fancybox__content,.fancybox__carousel .fancybox__slide.has-video .fancybox__content,.fancybox__carousel .fancybox__slide.has-html5video .fancybox__content{padding:0;background:rgba(24,24,27,.9);color:#fff}.fancybox__carousel .fancybox__slide.has-map .fancybox__content{background:#e5e3df}.fancybox__html5video,.fancybox__iframe{border:0;display:block;height:100%;width:100%;background:rgba(0,0,0,0)}.fancybox-placeholder{position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0, 0, 0, 0);white-space:nowrap;border-width:0}.fancybox__thumbs{flex:0 0 auto;position:relative;padding:0px 3px;opacity:var(--fancybox-opacity, 1)}.fancybox__container.is-animated[aria-hidden=false] .fancybox__thumbs{animation:.15s ease-in backwards fancybox-fadeIn}.fancybox__container.is-animated.is-closing .fancybox__thumbs{opacity:0}.fancybox__thumbs .carousel__slide{flex:0 0 auto;width:var(--fancybox-thumbs-width, 96px);margin:0;padding:8px 3px;box-sizing:content-box;display:flex;align-items:center;justify-content:center;overflow:visible;cursor:pointer}.fancybox__thumbs .carousel__slide .fancybox__thumb::after{content:"";position:absolute;top:0;left:0;right:0;bottom:0;border-width:5px;border-style:solid;border-color:var(--fancybox-accent-color, rgba(34, 213, 233, 0.96));opacity:0;transition:opacity .15s ease;border-radius:var(--fancybox-thumbs-border-radius, 4px)}.fancybox__thumbs .carousel__slide.is-nav-selected .fancybox__thumb::after{opacity:.92}.fancybox__thumbs .carousel__slide>*{pointer-events:none;user-select:none}.fancybox__thumb{position:relative;width:100%;padding-top:calc(100%/(var(--fancybox-thumbs-ratio, 1.5)));background-size:cover;background-position:center center;background-color:rgba(255,255,255,.1);background-repeat:no-repeat;border-radius:var(--fancybox-thumbs-border-radius, 4px)}.fancybox__toolbar{position:absolute;top:0;right:0;left:0;z-index:20;background:linear-gradient(to top, hsla(0deg, 0%, 0%, 0) 0%, hsla(0deg, 0%, 0%, 0.006) 8.1%, hsla(0deg, 0%, 0%, 0.021) 15.5%, hsla(0deg, 0%, 0%, 0.046) 22.5%, hsla(0deg, 0%, 0%, 0.077) 29%, hsla(0deg, 0%, 0%, 0.114) 35.3%, hsla(0deg, 0%, 0%, 0.155) 41.2%, hsla(0deg, 0%, 0%, 0.198) 47.1%, hsla(0deg, 0%, 0%, 0.242) 52.9%, hsla(0deg, 0%, 0%, 0.285) 58.8%, hsla(0deg, 0%, 0%, 0.326) 64.7%, hsla(0deg, 0%, 0%, 0.363) 71%, hsla(0deg, 0%, 0%, 0.394) 77.5%, hsla(0deg, 0%, 0%, 0.419) 84.5%, hsla(0deg, 0%, 0%, 0.434) 91.9%, hsla(0deg, 0%, 0%, 0.44) 100%);padding:0;touch-action:none;display:flex;justify-content:space-between;--carousel-button-svg-width: 20px;--carousel-button-svg-height: 20px;opacity:var(--fancybox-opacity, 1);text-shadow:var(--fancybox-toolbar-text-shadow, 1px 1px 1px rgba(0, 0, 0, 0.4))}@media all and (min-width: 1024px){.fancybox__toolbar{padding:8px}}.fancybox__container.is-animated[aria-hidden=false] .fancybox__toolbar{animation:.15s ease-in backwards fancybox-fadeIn}.fancybox__container.is-animated.is-closing .fancybox__toolbar{opacity:0}.fancybox__toolbar__items{display:flex}.fancybox__toolbar__items--left{margin-right:auto}.fancybox__toolbar__items--center{position:absolute;left:50%;transform:translateX(-50%)}.fancybox__toolbar__items--right{margin-left:auto}@media(max-width: 640px){.fancybox__toolbar__items--center:not(:last-child){display:none}}.fancybox__counter{min-width:72px;padding:0 10px;line-height:var(--carousel-button-height, 48px);text-align:center;font-size:17px;font-variant-numeric:tabular-nums;-webkit-font-smoothing:subpixel-antialiased}.fancybox__progress{background:var(--fancybox-accent-color, rgba(34, 213, 233, 0.96));height:3px;left:0;position:absolute;right:0;top:0;transform:scaleX(0);transform-origin:0;transition-property:transform;transition-timing-function:linear;z-index:30;user-select:none}.fancybox__container:fullscreen::backdrop{opacity:0}.fancybox__button--fullscreen g:nth-child(2){display:none}.fancybox__container:fullscreen .fancybox__button--fullscreen g:nth-child(1){display:none}.fancybox__container:fullscreen .fancybox__button--fullscreen g:nth-child(2){display:block}.fancybox__button--slideshow g:nth-child(2){display:none}.fancybox__container.has-slideshow .fancybox__button--slideshow g:nth-child(1){display:none}.fancybox__container.has-slideshow .fancybox__button--slideshow g:nth-child(2){display:block}

.user-content img {
	max-width: 100%;
	height: auto !important;
}

{# /* // Form and info */ #}

.social-share-button {
  display: inline-block;
  padding: 8px;
  font-size: 22px;
  &:hover,
  &:focus{
    opacity: 0.8;
  }
}

.section-single-product,
.section-fb-comments,
.section-products-related {
  @extend %section-margin;
}

.label-top-left {
  top: 25px;
  left: 25px;
  z-index: 2;
}

.product-image-limited {
  max-height: 320px;
  max-width: 100%;
  object-fit: contain;
}

{#/*============================================================================
  #Cart detail
==============================================================================*/#}


{# /* Table */ #}

.cart-table-row{
  padding: 10px 0;
}

.cart-item{
  position: relative;
  @extend %element-margin;
  &-name{
    float: left;
    width: 100%;
    padding: 0 40px 10px 0;
  }
  &-subtotal{
    float: right;
    margin: 10px 0;
    text-align: right;
    font-weight: normal;
  }
  &-btn{
    padding: 6px;
    display: inline-block;
    background: transparent;
    font-size: 16px;
    opacity: 0.8;
    &:hover{
      opacity: 0.6;
    }
  }
  &-input{
    display: inline-block;
    width: 40px;
    height: 30px;
    font-size: 16px;
    text-align: center;
    -moz-appearance:textfield;
    &::-webkit-outer-spin-button,
    &::-webkit-inner-spin-button{
      -webkit-appearance: none;
    }
  }
  .fa-cog{
    display: none;
  }
  &-spinner{
    display: inline-block;
    width: 40px;
    text-align: center;
  }
  &-delete{
    position: absolute;
    right: 0;
    .btn{
      padding-right:0; 
    }
  }
}

.cart-quantity-input-container svg{
  padding: 6px 14px;
}

.cart-unit-price{
  float: left;
  width: 100%;
  margin: 5px 0 2px 0;
}

.cart-promotion-detail{
  float: left;
  width: 65%;
  text-align: left;
} 
.cart-promotion-number{
  position: absolute;
  right: 0;
  bottom: 0;
  float: right;
  text-align: right;
  font-weight: bold;
} 


{# /* // Totals */ #}

.cart-subtotal{
  float: right;
  clear: both;
  margin: 0 0 10px 0;
}
.total-promotions-row{
  float: right;
  width: 100%;
  margin-bottom: 10px;
  position: relative;
  .cart-promotion-number{
    margin-left: 5px;
  }
}
.cart-total{
  clear: both;
  margin: 10px 0;
  font-weight: bold;
}

{# /* Totals */ #}

.cart-promotion-detail{
  width: 65%;
  float: left;
}
.cart-promotion-number{
  position: absolute;
  right: 0;
  bottom: 0;
  width: 35%;
  float: right;
  margin: 0;
  text-align: right;
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Max width 767px */ #}
@media (max-width: 767px) {
  .product-image-limited {
    max-height: 210px;
  }
}

{# /* // Min width 768px */ #}

@media (min-width: 768px) { 

  {# /* //// Components */ #}

  {# /* Header */ #}

  .desktop-dropdown-small {
    left: 50%;
    transform: translateX(-50%);
    -webkit-transform: translateX(-50%);
    -ms-transform: translateX(-50%);
  }

  {# /* Modals */ #}

  .modal{
    &-centered{
      height: 80%;
      width: 80%;
      left: 10%;
      margin: 5% auto;
      &-small{
        left: 50%;
        width: 30%;
        height: auto;
        max-height: 80%;
        margin: 0;
      }
      &-md-600px {
        left: 50%;
        width: 600px;
        transform: translateX(-50%);
      }
    }
    &-centered-md.modal-show {
      left: initial;
      transform: none;
      &.modal-bottom {
        top: 50%;
      }
    }
    &-docked-md{
      width: 500px;
      overflow-x: hidden;
      &-centered{
        left: calc(50% - 250px);
        bottom: auto;
        height: auto;
      }
    }
    &-bottom-sheet {
      top: 100%;
      &.modal-show {
        top: 0;
        bottom: auto;
      }
    }
    &-docked-small{
      width: 350px;
    }
    &-md-width-400px {
      width: 400px;
      max-width: 90vw;
    }
  }

  .fancybox__container .has-inline .fancybox__content{
    width: 85%;
    height: auto;
    padding: 44px;
  }

  {# /*  Navigation */ #}

  .nav-secondary .nav-account {
    margin: 10px -5px -10px -5px;
  }

  {# /*  Notifications */ #}

  .notification-floating .notification{
    width: 350px;
  }

  {# /* Filters */ #}

  .filter-input-price-container {
    width: 90px;
    .filter-input-price {
      padding: 10px;
    }
  }

  {# /* Tabs */ #}

  .tab-group{
    width: calc(100% + 20px);
    overflow-x: auto;
    white-space: normal;
    .tab{
      float: left;
    }
  }

  {# /* //// Footer */ #}

  .footer-menu {
    list-style: none;
    .footer-menu-item{  
      display: inline-block;
      padding: 0 15px;
    }
  }
}

{#/*============================================================================
  #Critical path utilities
==============================================================================*/#}

.visible-when-content-ready{
  visibility: visible!important;
}
.display-when-content-ready{
  display: block!important;
}

{#/*============================================================================
  #Julia Design — estilos del prototipo estáticos integrados arriba (sin hoja aparte)
==============================================================================*/#}

{#/*============================================================================
  #Lusano PDP — layout editorial 3 columnas (100vh desktop, stack mobile)
==============================================================================*/#}

{# ── Header PDP: fondo sólido crema + tipografía oscura #}

body.template-product {
  overflow: hidden !important;
}

body.template-product .head-main,
body.template-product header.julia-head-bar {
  position: fixed !important;
  top: 0;
  left: 0;
  right: 0;
  background: var(--cream, #ece8e4) !important;
  border-bottom: 0 !important;
  box-shadow: none !important;
  backdrop-filter: none !important;
  -webkit-backdrop-filter: none !important;
}

{# Navegación y categorías del mega: tono más oscuro que --brown #}
body.template-product .julia-head-bar .svg-icon-text,
body.template-product .julia-head-bar .logo-text,
body.template-product .julia-head-bar .cart-widget-amount,
body.template-product .julia-head-bar .julia-nav-desktop-link,
body.template-product .julia-head-bar .julia-nav-desktop-summary,
body.template-product .julia-head-bar .julia-nav-plain-link,
body.template-product .julia-head-bar .nav-muebles-btn {
  color: var(--dark-text, #1c1a16) !important;
  fill: var(--dark-text, #1c1a16) !important;
}

body.template-product .julia-head-bar .julia-nav-desktop-link:hover,
body.template-product .julia-head-bar .julia-nav-desktop-summary:hover,
body.template-product .julia-head-bar .julia-nav-plain-link:hover,
body.template-product .julia-head-bar .nav-muebles-btn:hover,
body.template-product .julia-head-bar .utilities-item a:hover .svg-icon-text,
body.template-product .julia-head-bar .utilities-item a:hover .cart-widget-amount {
  color: var(--brown, #54463d) !important;
  fill: var(--brown, #54463d) !important;
}

body.template-product .julia-head-bar .nav-arrow {
  stroke: var(--dark-text, #1c1a16);
}

body.template-product .julia-head-bar .nav-muebles-btn:hover .nav-arrow {
  stroke: var(--brown, #54463d);
}

body.template-product .julia-mega-menu .mega-col-title,
body.template-product .julia-mega-menu .mega-link,
body.template-product .julia-mega-menu .mega-view-all a,
body.template-product .julia-mega-menu a.mega-view-all {
  color: var(--dark-text, #1c1a16);
}

body.template-product .julia-mega-menu .mega-link:hover,
body.template-product .julia-mega-menu .mega-view-all a:hover,
body.template-product .julia-mega-menu a.mega-view-all:hover {
  color: var(--brown, #54463d);
}

body.template-product .section-advertising {
  display: none !important;
}

.lusano-wrap {
  position: fixed;
  inset: 0;
  z-index: 50;
  background: var(--cream, #ece8e4);
  font-family: 'Cormorant Garamond', Georgia, 'Times New Roman', serif;
  color: var(--brown, #54463D);
}

.lusano {
  display: grid;
  grid-template-columns: 22% 52% 26%;
  height: 100vh;
  width: 100%;
  overflow: hidden;
}

{# ── Columna izquierda ── #}

.lusano__col--left {
  padding: 5rem 1.8rem 2rem;
  display: flex;
  flex-direction: column;
  height: 100vh;
  overflow: hidden;
}

.lusano__close {
  font-family: 'Cormorant Garamond', Georgia, serif;
  font-size: 0.85rem;
  cursor: pointer;
  text-decoration: underline;
  text-underline-offset: 3px;
  background: none;
  border: none;
  color: var(--brown, #54463D);
  padding: 0;
  margin-bottom: 2.5rem;
  text-align: left;
  width: fit-content;
  letter-spacing: 0.02em;
}

.lusano__notes {
  flex: 1;
  overflow-y: auto;
  scrollbar-width: none;
  -ms-overflow-style: none;
  &::-webkit-scrollbar { display: none; }
}

.lusano__note {
  margin-bottom: 2rem;
}

.lusano__note-ix {
  display: block;
  font-style: italic;
  font-size: 0.88rem;
  opacity: 0.65;
  margin-bottom: 0.35rem;
}

.lusano__note-body {
  font-size: clamp(1rem, 0.2vw + 0.95rem, 1.08rem);
  line-height: 1.65;
  font-weight: 400;
  color: var(--dark-text, #1c1a16);
  margin: 0;
}

.lusano__note-body--em {
  font-style: italic;
  font-weight: 500;
}

.lusano__detail {
  margin-top: auto;
  padding-top: 1.5rem;
}

.lusano__detail-label {
  display: block;
  font-style: italic;
  font-size: 0.75rem;
  opacity: 0.65;
  margin-bottom: 0.5rem;
}

.lusano__detail-thumb {
  width: 90px;
  height: 70px;
  object-fit: cover;
  cursor: crosshair;
  transition: opacity 0.2s ease;
  &:hover { opacity: 0.78; }
}

{# ── Columna central — galería (cada imagen ≈ alto de ventana, separación entre slides) ── #}

.lusano__col--center {
  overflow-y: scroll;
  overflow-x: hidden;
  height: 100vh;
  cursor: crosshair;
  scrollbar-width: none;
  -ms-overflow-style: none;
  padding-top: 4.5rem;
  padding-bottom: 2rem;
  display: flex;
  flex-direction: column;
  gap: clamp(1rem, 2.5vw, 2rem);
  &::-webkit-scrollbar { display: none; }
}

.lusano__gallery-img {
  display: block;
  flex-shrink: 0;
  width: 100%;
  height: calc(100vh - 4.5rem);
  min-height: calc(100vh - 4.5rem);
  max-height: calc(100vh - 4.5rem);
  object-fit: contain;
  object-position: center;
  background: transparent;
}

@media (max-width: 767px) {
  {# PDP: en mobile la galería scrollea horizontalmente #}
  .lusano__col--center {
    overflow-x: scroll;
    overflow-y: hidden;
    display: flex;
    flex-direction: row;
    gap: 0;
    scroll-snap-type: x mandatory;
    scroll-padding-left: 0;
    scroll-behavior: smooth;
    -webkit-overflow-scrolling: touch;
    touch-action: pan-x;
  }

  .lusano__gallery-img {
    flex: 0 0 100%;
    width: 100%;
    scroll-snap-align: start;
    scroll-snap-stop: always;
  }
}

{# ── Columna derecha — info + compra ── #}

.lusano__col--right {
  padding: 5rem 1.8rem 2rem;
  height: 100vh;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
  scrollbar-width: none;
  -ms-overflow-style: none;
  &::-webkit-scrollbar { display: none; }
}

{# Contador de imagen #}

.lusano__counter {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 1.5rem;
}

.lusano__counter-num {
  font-size: clamp(2.75rem, 4.4vw, 3.85rem);
  font-weight: 400;
  line-height: 1;
  transition: opacity 0.25s ease;
}

.lusano__counter-meta {
  text-align: right;
  font-size: 0.7rem;
  line-height: 1.4;
}

.lusano__counter-hint {
  display: block;
  font-style: italic;
  margin-top: 0.2rem;
  opacity: 0.6;
}

{# Título #}

.lusano__title {
  font-family: 'Cormorant Garamond', Georgia, serif;
  font-size: clamp(2rem, 3.5vw, 3.2rem);
  font-weight: 400;
  line-height: 1.08;
  letter-spacing: -0.02em;
  margin: 0 0 2rem;
}

{# Specs / variantes #}

.lusano__specs {
  flex: 1;
  margin-bottom: 1rem;
}

.lusano__row {
  border-bottom: 1px solid rgba(129, 117, 108, 0.35);
}

.lusano__row-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 0;
  font-size: clamp(0.94rem, 0.15vw + 0.9rem, 1.02rem);
}

.lusano__row-label {
  font-style: normal;
  font-weight: 500;
  color: var(--dark-text, #1c1a16);
  opacity: 1;
}

.lusano__row-value {
  text-align: right;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--dark-text, #1c1a16);
  font-weight: 500;
}

.lusano__row-value--price {
  font-weight: 500;
  font-style: normal;
  font-size: 0.95rem;
}

.lusano__price-old {
  text-decoration: line-through;
  opacity: 0.5;
  margin-right: 0.4rem;
}

.lusano__row-toggle {
  font-family: 'Cormorant Garamond', Georgia, serif;
  font-size: 1rem;
  background: none;
  border: none;
  color: var(--brown, #54463D);
  cursor: pointer;
  padding: 0 0 0 0.3rem;
  line-height: 1;
  transition: transform 0.2s ease;
}

.lusano__row-opts {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.35s cubic-bezier(0.4, 0, 0.2, 1),
              padding 0.35s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  padding: 0;
}

.lusano__row-opts.open {
  max-height: 75vh;
  padding: 0 0 0.75rem;
}

.lusano__opt {
  font-family: 'Cormorant Garamond', Georgia, serif;
  font-size: 0.78rem;
  padding: 0.4rem 0.9rem;
  background: transparent;
  border: 1px solid rgba(129, 117, 108, 0.45);
  color: var(--brown, #54463D);
  cursor: pointer;
  transition: background 0.2s ease, color 0.2s ease, border-color 0.2s ease;
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
}

.lusano__opt:hover,
.lusano__opt.active {
  background: var(--brown, #54463D);
  color: var(--white, #fff);
  border-color: var(--brown, #54463D);
}

.lusano__opt-swatch {
  display: inline-block;
  width: 14px;
  height: 14px;
  border-radius: 50%;
  border: 1px solid rgba(0, 0, 0, 0.15);
  flex-shrink: 0;
}

.lusano__opt-swatch--neutral {
  background: linear-gradient(135deg, var(--gray-light, #d2d0d0) 0%, var(--mink, #81756c) 100%);
  opacity: 0.85;
}

{# ── Formulario / Compra ── #}

.lusano__form {
  margin-top: auto;
}

.lusano__form .js-lusano-hidden-select {
  position: absolute;
  width: 1px;
  height: 1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  padding: 0;
}

.lusano__qty {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 0;
  border-top: 1px solid rgba(129, 117, 108, 0.35);
  font-size: clamp(0.95rem, 0.15vw + 0.92rem, 1.02rem);
  font-style: normal;
}

.lusano__qty-label {
  opacity: 1;
  color: var(--dark-text, #1c1a16);
  font-weight: 500;
}

.lusano__qty-ctrl {
  display: flex;
  align-items: center;
  gap: 0.8rem;
}

.lusano__qty-btn {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: 1.2rem;
  font-weight: 600;
  background: none;
  border: none;
  color: var(--dark-text, #1c1a16);
  cursor: pointer;
  padding: 0;
  line-height: 1;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.lusano__qty-input {
  font-family: var(--julia-font-body, "Montserrat", sans-serif);
  font-size: 1rem;
  font-weight: 500;
  width: 42px;
  text-align: center;
  border: none;
  background: transparent;
  color: var(--dark-text, #1c1a16);
  -moz-appearance: textfield;
  &::-webkit-inner-spin-button,
  &::-webkit-outer-spin-button {
    -webkit-appearance: none;
    margin: 0;
  }
}

.lusano__payments {
  padding: 0.5rem 0 0.75rem;
  font-size: clamp(0.95rem, 0.12vw + 0.92rem, 1rem);
}

.lusano__payments-text {
  font-style: normal;
  opacity: 1;
  color: var(--dark-text, #1c1a16);
  font-weight: 500;
  margin-right: 0.5rem;
}

.lusano__payments-link {
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(0.92rem, 0.1vw + 0.9rem, 0.98rem);
  font-weight: 600;
  letter-spacing: -0.02em;
  color: var(--dark-text, #1c1a16);
  text-decoration: underline;
  text-underline-offset: 3px;
  cursor: pointer;
}

.lusano__cta {
  display: block;
  width: 100%;
  background: var(--brown, #54463D);
  color: var(--cream, #ece8e4);
  border: none;
  padding: 1.1rem 1rem;
  font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
  font-size: clamp(0.96rem, 0.12vw + 0.94rem, 1.02rem);
  font-weight: 600;
  letter-spacing: -0.02em;
  cursor: pointer;
  transition: opacity 0.2s ease;
  margin-top: 0.75rem;
  text-transform: none;
  &:hover { opacity: 0.85; }
  &:disabled,
  &.nostock {
    opacity: 0.4;
    cursor: not-allowed;
  }
}

.lusano__cta-ph {
  display: none;
}

.lusano__added-msg {
  font-size: 0.78rem;
  text-align: center;
  margin-top: 0.75rem;
  line-height: 1.5;
}

.lusano__added-link {
  color: var(--brown, #54463D);
  text-decoration: underline;
}

{# ── Lightbox ── #}

.lusano__lightbox {
  position: fixed;
  inset: 0;
  background: rgba(28, 26, 22, 0.92);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.3s ease;
}

.lusano__lightbox.active {
  opacity: 1;
  pointer-events: all;
}

.lusano__lightbox-close {
  position: absolute;
  top: 1.5rem;
  right: 2rem;
  font-family: 'Cormorant Garamond', Georgia, serif;
  color: var(--cream, #ece8e4);
  font-size: 0.85rem;
  font-style: italic;
  cursor: crosshair;
  text-decoration: underline;
  text-underline-offset: 3px;
  background: none;
  border: none;
}

.lusano__lightbox-img {
  max-width: 88vw;
  max-height: 88vh;
  object-fit: contain;
}

{# ── Responsive ── #}

@media (max-width: 1024px) {
  body.template-product {
    overflow: auto !important;
  }

  .lusano-wrap {
    position: relative;
    height: auto;
    overflow-y: auto;
  }

  .lusano {
    grid-template-columns: 1fr;
    grid-template-rows: auto 1fr auto;
    height: auto;
    overflow: visible;
  }

  .lusano__col--left {
    height: auto;
    padding: 4.5rem 1.2rem 0;
    order: 1;
  }

  .lusano__col--center {
    overflow-x: scroll;
    overflow-y: visible;
    height: auto;
    padding-top: 0;
    padding-bottom: 0;
    order: 2;
    display: flex;
    flex-direction: row;
    gap: 0;
    scroll-snap-type: x mandatory;
    scroll-behavior: smooth;
    -webkit-overflow-scrolling: touch;
    touch-action: auto;
  }

  .lusano__col--right {
    height: auto;
    padding: 1.2rem;
    order: 3;
  }

  .lusano__notes {
    display: none;
  }

  .lusano__detail {
    display: none;
  }

  .lusano__counter {
    margin-bottom: 1rem;
  }

  .lusano__title {
    font-size: clamp(1.6rem, 5vw, 2.4rem);
    margin-bottom: 1.2rem;
  }

  .lusano__gallery-img {
    flex: 0 0 100%;
    width: 100%;
    scroll-snap-align: start;
    scroll-snap-stop: always;
    height: 78vh;
    min-height: 78vh;
    max-height: 78vh;
  }

  {# En tablet/mobile: botón Volver fijo arriba a la izquierda sobre la galería #}
  .lusano__close {
    position: fixed;
    top: calc(var(--julia-nav-h, 56px) + 10px);
    left: 14px;
    z-index: 1200;
    padding: 8px 12px;
    border-radius: 999px;
    background: rgba(236, 232, 228, 0.92);
    border: 1px solid rgba(28, 26, 22, 0.12);
    box-shadow: 0 10px 24px rgba(28, 26, 22, 0.08);
    text-decoration: none;
  }
}

@media (max-width: 600px) {
  .lusano__col--left {
    padding: 1rem 1rem 0;
  }

  .lusano__col--right {
    padding: 1rem;
  }

  .lusano__close {
    margin-bottom: 1.5rem;
  }
}

{#/*============================================================================
  Julia Design — carrito AJAX y modal medios de pago (alineación sistema visual)
==============================================================================*/#}

$julia-overlay-cart: rgba(28, 26, 22, 0.42);
$julia-overlay-payments: rgba(28, 26, 22, 0.38);

.js-modal-overlay[data-modal-id="#modal-cart"],
.js-fullscreen-overlay[data-modal-id="#modal-cart"] {
  background: $julia-overlay-cart !important;
  backdrop-filter: blur(2px);
  -webkit-backdrop-filter: blur(2px);
}

.js-modal-overlay[data-modal-id="#installments-modal"],
.js-fullscreen-overlay[data-modal-id="#installments-modal"] {
  background: $julia-overlay-payments !important;
  backdrop-filter: blur(2px);
  -webkit-backdrop-filter: blur(2px);
}

#modal-cart.modal-julia-cart {
  background: var(--cream, #ece8e4) !important;
  color: var(--dark-text, #1c1a16);
  font-family: var(--julia-font-body, "Montserrat", sans-serif);
  -webkit-font-smoothing: antialiased;

  .modal-header.julia-modal-head,
  .modal-header {
    background: var(--cream, #ece8e4);
    border-bottom: 1px solid var(--gray-light, #d2d0d0);
    color: var(--dark-text, #1c1a16);
    font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
    font-weight: 600;
    font-size: clamp(1.05rem, 1.5vw, 1.2rem);
    letter-spacing: -0.02em;
    padding-top: 14px;
    padding-bottom: 14px;
  }

  .modal-close .svg-icon-text {
    color: var(--dark-text, #1c1a16);
    fill: var(--dark-text, #1c1a16);
  }

  .modal-body {
    background: var(--cream, #ece8e4);
    color: var(--dark-text, #1c1a16);
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
    font-size: clamp(0.875rem, 0.4vw + 0.8rem, 0.95rem);
    font-weight: 300;
    line-height: 1.55;
  }

  .cart-item-name a,
  .cart-item-name {
    color: var(--dark-text, #1c1a16) !important;
    font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
    font-weight: 600;
    letter-spacing: -0.02em;
    text-decoration: none;
    &:hover {
      color: var(--brown, #54463d) !important;
    }
  }

  .cart-item-name small {
    display: block;
    margin-top: 0.15rem;
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
    font-weight: 300;
    color: var(--mink, #81756c);
    font-size: 0.85em;
  }

  .cart-item-subtotal {
    color: var(--dark-text, #1c1a16) !important;
    font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
    font-weight: 600;
    letter-spacing: -0.02em;
  }

  .cart-item-input,
  .form-control.cart-item-input {
    background: var(--white, #ffffff);
    border: 1px solid var(--gray-light, #d2d0d0);
    color: var(--dark-text, #1c1a16);
    border-radius: 0;
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
  }

  {# Cantidad: alinear - [input] + en una sola línea y mismo tamaño #}
  .form-quantity {
    display: inline-flex !important;
    align-items: stretch !important;
    justify-content: flex-start;
    gap: 0 !important;
    border-radius: 0;
  }

  .form-quantity .row.m-0 {
    display: inline-flex !important;
    align-items: stretch !important;
    gap: 0 !important;
    margin: 0 !important;
  }

  .form-quantity .js-cart-quantity-btn,
  .form-quantity .cart-item-btn {
    width: 42px;
    height: 38px;
    padding: 0 !important;
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;
    background: var(--white, #ffffff);
    border: 1px solid var(--gray-light, #d2d0d0) !important;
    color: var(--dark-text, #1c1a16) !important;
    opacity: 1;
  }

  .form-quantity .js-cart-quantity-btn:hover,
  .form-quantity .js-cart-quantity-btn:focus-visible {
    border-color: var(--brown, #54463d) !important;
    color: var(--brown, #54463d) !important;
    outline: none;
  }

  .form-quantity .cart-item-input,
  .form-quantity .form-control.cart-item-input {
    width: 46px !important;
    height: 38px !important;
    padding: 0 !important;
    margin: 0 !important;
    text-align: center !important;
    border-left: 0 !important;
    border-right: 0 !important;
    border-top: 1px solid var(--gray-light, #d2d0d0) !important;
    border-bottom: 1px solid var(--gray-light, #d2d0d0) !important;
    border-radius: 0 !important;
    background: var(--white, #ffffff) !important;
    color: var(--dark-text, #1c1a16) !important;
    font-variant-numeric: tabular-nums;
  }

  .form-quantity .js-cart-quantity-btn svg {
    width: 14px;
    height: 14px;
    fill: currentColor;
  }

  .cart-item-btn {
    background: transparent;
    border: 1px solid var(--gray-light, #d2d0d0);
    color: var(--dark-text, #1c1a16);
    border-radius: 0;
    &:hover {
      border-color: var(--brown, #54463d);
      color: var(--brown, #54463d);
    }
  }

  .cart-item-delete .btn {
    color: var(--mink, #81756c) !important;
    &:hover {
      color: var(--brown, #54463d) !important;
    }
  }

  .divider {
    border-color: var(--gray-light, #d2d0d0) !important;
  }

  .alert-info {
    background: var(--white, #ffffff);
    border: 1px solid var(--gray-light, #d2d0d0);
    color: var(--dark-text, #1c1a16);
    border-radius: 0;
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
  }

  .alert-warning {
    background: rgba(236, 232, 228, 0.95);
    border: 1px solid var(--mink, #81756c);
    color: var(--dark-text, #1c1a16);
    border-radius: 0;
    a {
      color: var(--brown, #54463d);
      font-weight: 600;
    }
  }

  .js-visible-on-cart-filled.h5,
  .js-cart-total-container .h2 {
    color: var(--dark-text, #1c1a16);
    font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
    letter-spacing: -0.02em;
  }

  .js-cart-total-container .text-primary,
  .text-primary {
    color: var(--brown, #54463d) !important;
  }

  .js-total-promotions {
    color: var(--brown, #54463d);
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
    font-size: 0.9rem;
  }

  .bar-progress {
    background: var(--gray-light, #d2d0d0);
    border-radius: 0;
  }
  .bar-progress-active {
    background: var(--brown, #54463d) !important;
  }
  .ship-free-rest-text {
    color: var(--dark-text, #1c1a16);
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
    font-size: 0.8rem;
  }

  .btn-primary {
    background: var(--dark-text, #1c1a16) !important;
    border: 1.5px solid var(--dark-text, #1c1a16) !important;
    color: var(--cream, #ece8e4) !important;
    font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
    font-weight: 600;
    letter-spacing: -0.02em;
    border-radius: 0;
    text-transform: none;
    padding: 0.85rem 1.25rem;
    transition: opacity 0.2s ease, background 0.2s ease;
    &:hover {
      opacity: 0.88;
      background: var(--brown, #54463d) !important;
      border-color: var(--brown, #54463d) !important;
      color: var(--cream, #ece8e4) !important;
    }
  }

  .btn-link {
    color: var(--brown, #54463d) !important;
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
    font-weight: 500;
    text-decoration: underline;
    text-underline-offset: 3px;
    &:hover {
      color: var(--dark-text, #1c1a16) !important;
    }
  }

  .label.label-secondary,
  .label.label-accent {
    border-radius: 0;
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
    font-size: 0.7rem;
  }
}

#installments-modal.modal-julia-payments {
  background: var(--cream, #ece8e4) !important;
  color: var(--dark-text, #1c1a16);
  font-family: var(--julia-font-body, "Montserrat", sans-serif);

  .modal-header.julia-modal-head,
  .modal-header {
    background: var(--cream, #ece8e4);
    border-bottom: 1px solid var(--gray-light, #d2d0d0);
    color: var(--dark-text, #1c1a16);
    font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
    font-weight: 600;
    font-size: clamp(1.05rem, 1.5vw, 1.2rem);
    letter-spacing: -0.02em;
  }

  .modal-close .svg-icon-text {
    color: var(--dark-text, #1c1a16);
    fill: var(--dark-text, #1c1a16);
  }

  .modal-body {
    background: var(--cream, #ece8e4);
    color: var(--dark-text, #1c1a16);
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
    font-weight: 300;
    line-height: 1.55;
  }

  .modal-footer.julia-modal-foot,
  .modal-footer {
    background: var(--cream, #ece8e4);
    border-top: 1px solid var(--gray-light, #d2d0d0);
    padding-top: 1rem;
    padding-bottom: 1rem;
  }

  .julia-payments-foot-actions {
    width: 100%;
  }

  .julia-payments-back {
    appearance: none;
    -webkit-appearance: none;
    background: none;
    border: none;
    padding: 0.35rem 0;
    cursor: pointer;
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
    font-size: 0.9rem;
    font-weight: 500;
    color: var(--brown, #54463d);
    text-decoration: underline;
    text-underline-offset: 3px;
    &:hover {
      color: var(--dark-text, #1c1a16);
    }
  }

  .tab-group {
    margin-left: 0;
    margin-right: 0;
    border-bottom: 1px solid var(--gray-light, #d2d0d0);
  }

  .tab .tab-link,
  .tab-link {
    font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
    font-weight: 600;
    letter-spacing: -0.02em;
    text-transform: none;
    color: var(--mink, #81756c);
    border-bottom: 2px solid transparent;
  }

  .tab.active .tab-link,
  .tab-link.active,
  .tab-link:hover {
    color: var(--dark-text, #1c1a16);
  }

  .tab.active .tab-link {
    border-bottom-color: var(--dark-text, #1c1a16);
  }

  .julia-payments-method,
  .julia-payments-method.card {
    background: var(--white, #ffffff) !important;
    border: 1px solid var(--gray-light, #d2d0d0) !important;
    border-radius: 0 !important;
    box-shadow: none !important;
  }

  .julia-payments-subtitle.h6,
  .julia-payments-subtitle {
    font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif) !important;
    font-weight: 600 !important;
    letter-spacing: -0.02em !important;
    color: var(--dark-text, #1c1a16) !important;
    text-transform: none;
  }

  .julia-payments-lead.font-big {
    font-family: var(--julia-font-heading, "Hanken Grotesk", sans-serif);
    font-weight: 600;
    letter-spacing: -0.02em;
    color: var(--dark-text, #1c1a16);
  }

  .julia-payments-small.font-small {
    color: var(--mink, #81756c);
    font-weight: 400;
  }

  .julia-payments-muted {
    color: var(--mink, #81756c) !important;
  }

  .julia-payments-accent.label-accent {
    background: transparent !important;
    border: 1px solid var(--brown, #54463d) !important;
    color: var(--brown, #54463d) !important;
    font-family: var(--julia-font-body, "Montserrat", sans-serif);
    font-weight: 500;
  }

  a {
    color: var(--brown, #54463d);
    &:hover {
      color: var(--dark-text, #1c1a16);
    }
  }
}
