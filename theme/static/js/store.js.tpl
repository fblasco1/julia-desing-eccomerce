{#==========================================================================
  store.js.tpl — único archivo canónico (base TN + Julia: mega/logo + home Swiper)
  No poner etiquetas % dentro de comentarios: algunos entornos TN las parsean.
==============================================================================#}

window.urls = {
    "shippingUrl": "{{ store.shipping_calculator_url | escape('js') }}"
}

{#/* Lazy load (imágenes nativas) */#}
document.addEventListener('lazybeforeunveil', function(e){
    if ((e.target.parentElement) && (e.target.nextElementSibling)) {
        var parent = e.target.parentElement;
        var sibling = e.target.nextElementSibling;
        if (sibling.classList.contains('js-lazy-loading-preloader')) {
            sibling.style.display = 'none';
            parent.style.display = 'block';
        }
    }
});

window.lazySizesConfig = window.lazySizesConfig || {};
lazySizesConfig.hFac = 0.4;

DOMContentLoaded.addEventOrExecute(() => {

    var $notification_status_page = jQueryNuvem(".js-notification-status-page");
    var $fixed_bottom_button = jQueryNuvem(".js-btn-fixed-bottom");

    jQueryNuvem(".js-notification-close").on( "click", function(e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).closest(".js-notification").hide();
    });

    if ($notification_status_page.length > 0){
        if (LS.shouldShowOrderStatusNotification($notification_status_page.data('url'))){
            $notification_status_page.show();
        }
        jQueryNuvem(".js-notification-status-page-close").on( "click", function(e) {
            e.preventDefault();
            LS.dontShowOrderStatusNotificationAgain($notification_status_page.data('url'));
        });
    }

    jQueryNuvem(".js-cart-notification-close").on("click", function(){
        jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
        setTimeout(function(){
            jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
            jQueryNuvem(".js-alert-added-to-cart").hide();
        },2000);
    });

    {# DESACTIVADO: cookies / params — reactivar restaurando el bloque show_store_cookie_ui #}
    {% if false %}
        {% if params is not defined %}
            {% set show_store_cookie_ui = true %}
        {% elseif attribute(params, 'preview') is not defined or not attribute(params, 'preview') %}
            {% set show_store_cookie_ui = true %}
        {% else %}
            {% set show_store_cookie_ui = false %}
        {% endif %}
        {% if show_store_cookie_ui %}
            const footer = jQueryNuvem(".js-footer");
            restoreNotifications = function(){
                if (window.innerWidth < 768) {
                    $fixed_bottom_button.css("marginBottom", "10px");
                }
                if (footer.length) {
                    footer.removeAttr("style");
                }
            };
            if (!window.cookieNotificationService.isAcknowledged()) {
                jQueryNuvem(".js-notification-cookie-banner").show();
                const cookieBannerHeight = jQueryNuvem(".js-notification-cookie-banner").outerHeight();
                if (footer.length && cookieBannerHeight) {
                    footer.css("paddingBottom", cookieBannerHeight + 10 + "px");
                }
                if (window.innerWidth < 768) {
                    $fixed_bottom_button.css("marginBottom", "120px");
                } else {
                    $fixed_bottom_button.css("marginBottom", "70px");
                }
            }
            jQueryNuvem(".js-acknowledge-cookies").on( "click", function() {
                window.cookieNotificationService.acknowledge();
                restoreNotifications();
            });
        {% endif %}
    {% endif %}

    {% if false %}{# quick_shop desactivado #}

        restoreQuickshopForm = function(){
            jQueryNuvem("#quickshop-modal .js-item-product").removeClass("js-swiper-slide-visible js-item-slide");
            jQueryNuvem("#quickshop-modal .js-quickshop-container").attr( { 'data-variants' : '' , 'data-quickshop-id': '' } );
            jQueryNuvem("#quickshop-modal .js-item-product").attr('data-product-id', '');
            setTimeout(function(){
                var $quickshop_form = jQueryNuvem("#quickshop-form").find('.js-product-form');
                var $item_form_container = jQueryNuvem(".js-quickshop-opened").find(".js-item-variants");
                $quickshop_form.detach().appendTo($item_form_container);
                jQueryNuvem(".js-quickshop-opened").removeClass("js-quickshop-opened");
            },350);
        };

    {% endif %}

    if (window.innerWidth < 768) {

        cleanURLHash = function(){
            const uri = window.location.toString();
            const clean_uri = uri.substring(0, uri.indexOf("#"));
            window.history.replaceState({}, document.title, clean_uri);
        };

        goBackBrowser = function(){
            cleanURLHash();
            history.back();
        };

        if(window.location.href.indexOf("modal-fullscreen") > -1) {
            cleanURLHash();
        }

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-open", function(e) {
            e.preventDefault();
            var modal_url_hash = jQueryNuvem(this).data("modalUrl");
            window.location.hash = modal_url_hash;
        });

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-close", function(e) {
            e.preventDefault();
            goBackBrowser();
        });

        window.onhashchange = function() {
            if(window.location.href.indexOf("modal-fullscreen") <= -1) {
                if(jQueryNuvem(".js-fullscreen-modal").hasClass("modal-show")){
                    if(jQueryNuvem(".js-modal.modal-show").length == 1){
                        jQueryNuvem("body").removeClass("overflow-none");
                    }
                    var $opened_modal = jQueryNuvem(".js-fullscreen-modal.modal-show");
                    var $opened_modal_overlay = $opened_modal.prev();
                    $opened_modal.removeClass("modal-show");
                    setTimeout(() => $opened_modal.hide(), 500);
                    $opened_modal_overlay.fadeOut(500);
                    {% if false %}{# quick_shop desactivado #}
                        restoreQuickshopForm();
                    {% endif %}
                }
            }
        }
    }

    modalOpen = function(modal_id, openType){
        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="' + modal_id + '"]');
        if (jQueryNuvem(modal_id).hasClass("modal-show")) {
            let modal = jQueryNuvem(modal_id).removeClass("modal-show");
            setTimeout(() => modal.hide(), 500);
        } else {
            if(!jQueryNuvem(".js-modal.modal-show").length){
                jQueryNuvem("body").addClass("overflow-none");
            }
            $overlay_id.fadeIn(400);
            jQueryNuvem(modal_id).detach().appendTo("body");
            $overlay_id.detach().insertBefore(modal_id);
            jQueryNuvem(modal_id).show().addClass("modal-show");
        }
        if(openType == 'openFullScreenWithoutClick' && window.innerWidth < 768 && jQueryNuvem(modal_id).hasClass("js-fullscreen-modal")){
            var modal_url_hash = jQueryNuvem(modal_id).data("modalUrl");
            window.location.hash = modal_url_hash;
        }
    };

    jQueryNuvem(document).on("click", ".js-modal-open", function(e) {
        e.preventDefault();
        var modal_id = jQueryNuvem(this).data('toggle');
        modalOpen(modal_id);
    });

    jQueryNuvem(document).on("click", ".js-modal-close", function(e) {
        e.preventDefault();
        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }
        var $modal = jQueryNuvem(this).closest(".js-modal");
        var modal_id = $modal.attr('id');
        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="#' + modal_id + '"]');
        $modal.removeClass("modal-show");
        setTimeout(() => $modal.hide(), 500);
        $overlay_id.fadeOut(500);
        {% if false %}{# quick_shop desactivado #}
            restoreQuickshopForm();
        {% endif %}
        if ((window.innerWidth < 768) && (jQueryNuvem(this).hasClass("js-fullscreen-modal-close"))) {
            goBackBrowser();
        }
    });

    jQueryNuvem(document).on("click", ".js-modal-overlay", function(e) {
        e.preventDefault();
        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }
        var modal_id = jQueryNuvem(this).data('modalId');
        let modal = jQueryNuvem(modal_id).removeClass("modal-show");
        setTimeout(() => modal.hide(), 500);
        jQueryNuvem(this).fadeOut(500);
        {% if false %}{# quick_shop desactivado #}
            restoreQuickshopForm();
        {% endif %}
        if (jQueryNuvem(this).hasClass("js-fullscreen-overlay") && (window.innerWidth < 768)) {
            cleanURLHash();
        }
    });

    {% if false %}{# popup newsletter home desactivado #}

        jQueryNuvem('#news-popup-form').on("submit", function () {
            jQueryNuvem(".js-news-spinner").show();
            jQueryNuvem(".js-news-send, .js-news-popup-submit").hide();
            jQueryNuvem(".js-news-popup-submit").prop("disabled", true);
        });

        LS.newsletter('#news-popup-form-container', '#home-modal', "{{ store.contact_url | escape('js') }}", function (response) {
            jQueryNuvem(".js-news-spinner").hide();
            jQueryNuvem(".js-news-send, .js-news-popup-submit").show();
            var selector_to_use = response.success ? '.js-news-popup-success' : '.js-news-popup-failed';
            let newPopupAlert = jQueryNuvem(this).find(selector_to_use).fadeIn(100);
            setTimeout(() => newPopupAlert.fadeOut(500), 4000);
            if (jQueryNuvem(".js-news-popup-success").css("display") == "block") {
                setTimeout(function () {
                    jQueryNuvem('[data-modal-id="#home-modal"]').fadeOut(500);
                    let homeModal = jQueryNuvem("#home-modal").removeClass("modal-show");
                    setTimeout(() => homeModal.hide(), 500);
                }, 2500);
            }
            jQueryNuvem(".js-news-popup-submit").prop("disabled", false);
        });

        var callback_show = function(){
            jQueryNuvem('.js-modal-overlay[data-modal-id="#home-modal"]').fadeIn(500);
            jQueryNuvem("#home-modal").detach().appendTo("body").show().addClass("modal-show");
        }
        var callback_hide = function(){
            jQueryNuvem('.js-modal-overlay[data-modal-id="#home-modal"]').fadeOut(500);
            let homeModal = jQueryNuvem("#home-modal").removeClass("modal-show");
            setTimeout(() => homeModal.hide(), 500);
        }
        LS.homePopup({
            selector: "#home-modal",
            timeout: 10000,
            mobile_max_pixels: 0,
        }, callback_hide, callback_show);

    {% endif %}

    jQueryNuvem(document).on("click", ".js-accordion-toggle", function(e) {
        e.preventDefault();
        if(jQueryNuvem(this).hasClass("js-accordion-show-only")){
            jQueryNuvem(this).hide();
        }else{
            jQueryNuvem(this).find(".js-accordion-toggle-inactive").toggle();
            jQueryNuvem(this).find(".js-accordion-toggle-active").toggle();
        }
        jQueryNuvem(this).prev(".js-accordion-container").slideToggle();
    });

    {# Acordeón home — sección info (prototype .accordion) #}
    (function () {
        var root = document.querySelector(".julia-home-info");
        if (!root) return;
        var acc = root.querySelector(".julia-home-info__accordion");
        if (!acc) return;
        acc.addEventListener("click", function (e) {
            var h = e.target.closest(".acc-header");
            if (!h || !acc.contains(h)) return;
            e.preventDefault();
            var item = h.parentElement;
            var was = item.classList.contains("open");
            root.querySelectorAll(".acc-item.open").forEach(function (el) {
                el.classList.remove("open");
            });
            if (!was) {
                item.classList.add("open");
            }
        });
    })();

    {# Carrusel exhibidor home: duplicado para marquee + pausa en hover / touch #}
    (function () {
        var wrap = document.getElementById("juliaHomeExhibitorWrap");
        var track = document.getElementById("juliaHomeExhibitorTrack");
        if (!wrap || !track) return;
        Array.from(track.children).forEach(function (c) {
            track.appendChild(c.cloneNode(true));
        });
        function pause() {
            track.classList.add("paused");
        }
        function resume() {
            track.classList.remove("paused");
        }
        wrap.addEventListener("mouseenter", pause);
        wrap.addEventListener("mouseleave", resume);
        wrap.addEventListener("touchstart", pause, { passive: true });
        wrap.addEventListener("touchend", resume);
        wrap.addEventListener("touchcancel", resume);
    })();

    {# Julia Design: mega menú + logo flotante home #}
    (function () {
            var body = document.body;
            var isHome = body.classList.contains("julia-head-mode--home");
            var head = document.querySelector(".js-head-main");
            var megaMenu = document.getElementById("julia-mega-menu");
            var trigger = document.getElementById("julia-mega-trigger");
            var mueblesBtn = document.getElementById("julia-mega-btn");
            var megaClose = megaMenu ? megaMenu.querySelector(".js-julia-mega-close") : null;
            var navToggle = document.querySelector(".js-julia-mega-hamburger");
            var exhibitor = document.getElementById("julia-home-exhibitor");

            if (!isHome && !megaMenu) return;
            if (isHome && !head) return;

            var EASE = "cubic-bezier(.4,0,.2,1)";
            var TRANS = "left .7s " + EASE + ", top .7s " + EASE;

            function getCssPxVar(name, fallback) {
                var raw = getComputedStyle(document.documentElement).getPropertyValue(name).trim();
                var n = parseFloat(raw);
                return isFinite(n) ? n : fallback;
            }

            function getCssRatioVar(name, fallback) {
                var raw = getComputedStyle(document.documentElement).getPropertyValue(name).trim();
                if (!raw) return fallback;
                if (raw.slice(-1) === "%") {
                    var p = parseFloat(raw);
                    return isFinite(p) ? p / 100 : fallback;
                }
                var n2 = parseFloat(raw);
                return isFinite(n2) ? n2 : fallback;
            }

            function isMobileViewport() {
                return window.matchMedia("(max-width: 768px)").matches;
            }

            var homeLogoCtl = null;

            if (isHome && head) {
                var logoEl = document.getElementById("juliaLogoEl");
                var isInNav = false;
                var scrollTicking = false;

                if (logoEl) {
                    {# Igual que prototype/js/home.js: top = navH + stripH, left = vw * imgCol / 2 (no medición DOM) #}
                    function juliaReadStripH() {
                        var d = getComputedStyle(document.documentElement).getPropertyValue("--julia-hero-strip").trim();
                        var raw = d || getComputedStyle(body).getPropertyValue("--julia-hero-strip").trim();
                        var n = parseFloat(raw);
                        return isFinite(n) ? n : 120;
                    }
                    function juliaReadImgColRatio() {
                        var d = getComputedStyle(document.documentElement).getPropertyValue("--julia-img-col").trim();
                        var raw = d || getComputedStyle(body).getPropertyValue("--julia-img-col").trim();
                        if (!raw) return 0.56;
                        if (raw.slice(-1) === "%") {
                            var p = parseFloat(raw);
                            return isFinite(p) ? p / 100 : 0.56;
                        }
                        var n2 = parseFloat(raw);
                        return isFinite(n2) ? n2 : 0.56;
                    }
                    function posLogo(inNavFlag) {
                        if (head) {
                            var nh = head.offsetHeight + "px";
                            document.documentElement.style.setProperty("--julia-nav-h", nh);
                            if (body && body.style) body.style.setProperty("--julia-nav-h", nh);
                        }
                        var vw = window.innerWidth;
                        var navHCss = getCssPxVar("--julia-nav-h", head ? head.offsetHeight : 60);
                        var stripH = juliaReadStripH();
                        var imgCol = juliaReadImgColRatio();
                        var mobile = isMobileViewport();
                        var logoImg =
                            document.getElementById("juliaLogoImg") ||
                            (logoEl.querySelector && logoEl.querySelector("img.julia-logo-el__img")) ||
                            (logoEl.querySelector && logoEl.querySelector("img"));
                        var logoText =
                            document.getElementById("juliaLogoText") ||
                            (logoEl.querySelector && logoEl.querySelector(".julia-logo-el__wordmark"));

                        logoEl.classList.toggle("julia-logo-el--docked", inNavFlag);

                        if (inNavFlag) {
                            logoEl.style.position = "fixed";
                            logoEl.style.zIndex = "600";
                            logoEl.style.left = mobile ? "16px" : "50%";
                            logoEl.style.top = navHCss / 2 + "px";
                            logoEl.style.transform = mobile ? "translateY(-50%)" : "translate(-50%, -50%)";
                            logoEl.style.transition = TRANS;
                        } else {
                            logoEl.style.position = "fixed";
                            logoEl.style.zIndex = "300";
                            logoEl.style.transition = TRANS;
                            logoEl.style.left = mobile ? "50%" : vw * imgCol / 2 + "px";
                            logoEl.style.top = navHCss + stripH + "px";
                            logoEl.style.transform = "translate(-50%, -50%)";
                        }

                        var hImg = inNavFlag ? (mobile ? 22 : 28) : (mobile ? 48 : 72);
                        if (logoImg && logoImg.style.display !== "none") {
                            logoImg.style.height = hImg + "px";
                        }
                        if (logoText) {
                            logoText.style.fontSize = inNavFlag ? "1rem" : "clamp(3rem,6.5vw,5.5rem)";
                        }
                    }

                    function hideLogo() {
                        logoEl.classList.add("fade-out");
                    }
                    function showLogo() {
                        logoEl.classList.remove("fade-out");
                    }

                    homeLogoCtl = { hideLogo: hideLogo, showLogo: showLogo };

                    logoEl.style.transition = "none";
                    posLogo(false);
                    requestAnimationFrame(function () {
                        posLogo(false);
                        logoEl.style.transition = TRANS;
                    });

                    function syncHomeScroll() {
                        var y = document.documentElement.scrollTop || window.scrollY;
                        var navH = head.offsetHeight || getCssPxVar("--julia-nav-h", 60);
                        document.documentElement.style.setProperty("--julia-nav-h", navH + "px");
                        if (body && body.style) body.style.setProperty("--julia-nav-h", navH + "px");
                        var stripH = juliaReadStripH();
                        var navForPast = getCssPxVar("--julia-nav-h", navH);
                        var past = y > navForPast + stripH - 20;
                        body.classList.toggle("julia-head-home-solid", past);
                        if (past !== isInNav) {
                            isInNav = past;
                            posLogo(isInNav);
                        }
                        scrollTicking = false;
                    }

                    window.addEventListener("scroll", function () {
                        if (!scrollTicking) {
                            scrollTicking = true;
                            requestAnimationFrame(syncHomeScroll);
                        }
                    }, { passive: true });

                    window.addEventListener("resize", function () {
                        posLogo(isInNav);
                        syncHomeScroll();
                    });
                    window.addEventListener("load", function () {
                        posLogo(isInNav);
                    });
                    syncHomeScroll();
                }

                if (exhibitor && "IntersectionObserver" in window) {
                    var navObs = new IntersectionObserver(
                        function (entries) {
                            if (megaMenu && megaMenu.classList.contains("open")) return;
                            var visible = entries[0].isIntersecting;
                            if (document.querySelector(".js-modal.modal-show")) return;
                            head.classList.toggle("julia-head-hidden", visible);
                            if (homeLogoCtl) {
                                if (visible) homeLogoCtl.hideLogo();
                                else homeLogoCtl.showLogo();
                            }
                        },
                        { threshold: 0.06 }
                    );
                    navObs.observe(exhibitor);

                    var exObs2 = new IntersectionObserver(
                        function (entries) {
                            exhibitor.classList.toggle("julia-exhibitor-in-view", entries[0].isIntersecting);
                        },
                        { threshold: 0.06 }
                    );
                    exObs2.observe(exhibitor);
                }
            }

            if (!megaMenu || !trigger || !mueblesBtn) return;

            function syncJuliaNavH() {
                if (head) {
                    var nh = head.offsetHeight + "px";
                    document.documentElement.style.setProperty("--julia-nav-h", nh);
                    if (body && body.style) body.style.setProperty("--julia-nav-h", nh);
                }
            }
            syncJuliaNavH();
            window.addEventListener("resize", syncJuliaNavH);

            function setMobileMenu(open) {
                if (head) head.classList.toggle("julia-mega-mobile-open", open);
                if (navToggle) navToggle.setAttribute("aria-expanded", open ? "true" : "false");
                document.body.classList.toggle("julia-no-scroll-mega", open);
            }

            function openMenu() {
                trigger.classList.add("menu-open");
                megaMenu.classList.add("open");
                mueblesBtn.setAttribute("aria-expanded", "true");
                if (homeLogoCtl) homeLogoCtl.hideLogo();
            }

            function closeMenu() {
                trigger.classList.remove("menu-open");
                megaMenu.classList.remove("open");
                mueblesBtn.setAttribute("aria-expanded", "false");
                if (isMobileViewport()) setMobileMenu(false);
                if (!exhibitor || !exhibitor.classList.contains("julia-exhibitor-in-view")) {
                    if (homeLogoCtl) homeLogoCtl.showLogo();
                }
            }

            mueblesBtn.addEventListener("click", function (e) {
                e.stopPropagation();
                if (megaMenu.classList.contains("open")) closeMenu();
                else openMenu();
            });

            if (megaClose) megaClose.addEventListener("click", closeMenu);

            var megaCartBtns = megaMenu.querySelectorAll(".mega-mobile-cart");
            for (var c = 0; c < megaCartBtns.length; c++) {
                megaCartBtns[c].addEventListener("click", function () {
                    closeMenu();
                });
            }

            document.addEventListener("click", function (e) {
                if (!megaMenu.classList.contains("open")) return;
                var t = e.target;
                var insideTrigger = trigger.contains(t);
                var insideToggle = navToggle && navToggle.contains(t);
                var navLinks = head ? head.querySelector(".julia-nav-links") : null;
                var insideMobilePanel = navLinks && navLinks.contains(t);
                var insideMega = megaMenu.contains(t);
                if (!insideTrigger && !insideToggle && !insideMobilePanel && !insideMega) closeMenu();
            });

            document.addEventListener("keydown", function (e) {
                if (e.key === "Escape") closeMenu();
            });

            if (navToggle) {
                navToggle.addEventListener("click", function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    if (megaMenu.classList.contains("open")) closeMenu();
                    else {
                        setMobileMenu(true);
                        openMenu();
                    }
                });
            }

            if (head) {
                var plainLinks = head.querySelectorAll(".julia-nav-links a");
                for (var i = 0; i < plainLinks.length; i++) {
                    plainLinks[i].addEventListener("click", function () {
                        if (isMobileViewport()) setMobileMenu(false);
                    });
                }
            }

            window.addEventListener("resize", function () {
                if (!isMobileViewport()) setMobileMenu(false);
            });
        })();

    var $top_nav = jQueryNuvem(".js-mobile-nav");
    var $page_main_content = jQueryNuvem(".js-main-content");
    var $search_backdrop = jQueryNuvem(".js-search-backdrop");

    $top_nav.addClass("move-down").removeClass("move-up");

    jQueryNuvem(".js-toggle-page-accordion").on("click", function (e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).toggleClass("active").closest(".js-nav-list-toggle-accordion").next(".js-pages-accordion").slideToggle(300);
    });

    jQueryNuvem(".js-toggle-search").click(function (e) {
        e.preventDefault();
        jQueryNuvem(".js-search-input").each(el => el.focus());
    });

    LS.search(jQueryNuvem(".js-search-input"), function (html, count) {
        $search_suggests = jQueryNuvem(this).closest(".js-search-container").next(".js-search-suggest");
        if (count > 0) {
            $search_suggests.html(html).show();
        } else {
            $search_suggests.hide();
        }
        if (jQueryNuvem(this).val().length == 0) {
            $search_suggests.hide();
        }
    }, {
        snipplet: 'header/header-search-results.tpl'
    });

    if (window.innerWidth > 768) {
        jQueryNuvem("body").on("click", function () {
            jQueryNuvem(".js-search-suggest").hide();
        });
        jQueryNuvem(document).on("click", ".js-search-suggest a", function () {
            jQueryNuvem(".js-search-suggest").show();
        });
    }

    jQueryNuvem(".js-search-suggest").on("click", ".js-search-suggest-all-link", function (e) {
        e.preventDefault();
        $this_closest_form = jQueryNuvem(this).closest(".js-search-suggest").prev(".js-search-form");
        $this_closest_form.submit();
    });

    changeLang = function(element) {
        var selected_country_url = element.find("option").filter((el) => el.selected).attr("data-country-url");
        location.href = selected_country_url;
    };

    jQueryNuvem('.js-lang-select').on("change", function (e) {
        lang_select_option = jQueryNuvem(this);
        changeLang(lang_select_option);
    });

    {# Orden en listado: LS.urlParams + sort_by + recarga (docs TN). Radios en category-julia-sort llaman juliaSortByNavigate sin depender del <select>. #}
    {% if template == 'category' or template == 'search' %}
    var juliaSortByNavigate = function (sortValue) {
        if (typeof LS === "undefined" || !LS.urlParams) {
            return;
        }
        var params = LS.urlParams;
        params.sort_by = sortValue;
        var sort_params_array = [];
        for (var key in params) {
            if (!["results_only", "page"].includes(key)) {
                sort_params_array.push(key + "=" + params[key]);
            }
        }
        window.location = window.location.pathname + "?" + sort_params_array.join("&");
    };
    jQueryNuvem(document).on("change", ".js-sort-by", function (e) {
        juliaSortByNavigate(jQueryNuvem(e.currentTarget).val());
    });
    {% endif %}

    {# Home: config en home.tpl → window.__juliaStoreHomeConfig #}
    {% if template == 'home' %}
        var cfg = window.__juliaStoreHomeConfig;
        if (cfg) {
            var juliaHomeLoopMain = !!cfg.loopMain;
            var juliaHomeLoopMobile = !!cfg.loopMobile;
            var juliaHomeHasMobileSlider = !!cfg.hasMobileSlider;
            var juliaHomeFeatured = !!cfg.featured;
            var juliaHomeGridCols = parseInt(cfg.gridCols, 10) || 2;
            var juliaHomeCloneIds = !!cfg.cloneIds;
            var juliaHomeSliderLen = parseInt(cfg.sliderLen, 10) || 0;
            var juliaHomeSliderMobileLen = parseInt(cfg.sliderMobileLen, 10) || 0;

            var width = window.innerWidth;
            var slider_autoplay = width > 767 ? { delay: 6000 } : false;
            var preloadImagesValue = false;
            var lazyValue = true;
            var loopValue = true;
            var watchOverflowValue = true;
            var paginationClickableValue = true;

            var homeSwiper = null;
            var homeMobileSwiper = null;

            window.homeSlider = {
                getAutoRotation: function () {
                    return slider_autoplay;
                },
                updateSlides: function (slides) {
                    if (!homeSwiper) return;
                    homeSwiper.removeAllSlides();
                    slides.forEach(function (aSlide) {
                        homeSwiper.appendSlide(
                            '<div class="swiper-slide slide-container">' +
                                (aSlide.link ? '<a href="' + aSlide.link + '">' : "") +
                                    '<img src="' + aSlide.src + '" class="slider-image"/>' +
                                    '<div class="swiper-text swiper-' + aSlide.color + '">' +
                                        (aSlide.title ? '<div class="swiper-title">' + aSlide.title + "</div>" : "") +
                                        (aSlide.description ? '<div class="swiper-description mb-3">' + aSlide.description + "</div>" : "") +
                                        (aSlide.button && aSlide.link ? '<div class="btn btn-primary d-inline-block mt-3">' + aSlide.button + "</div>" : "") +
                                    "</div>" +
                                (aSlide.link ? "</a>" : "") +
                                "</div>"
                        );
                    });
                    if (!slides.length) {
                        jQueryNuvem(".js-home-main-slider-container").addClass("hidden");
                        jQueryNuvem(".js-home-empty-slider-container").removeClass("hidden");
                        jQueryNuvem(".js-home-mobile-slider-visibility").removeClass("d-md-none");
                        if (juliaHomeHasMobileSlider) {
                            jQueryNuvem(".js-home-main-slider-visibility").removeClass("d-none d-md-block");
                            if (homeMobileSwiper) homeMobileSwiper.update();
                        }
                    } else {
                        jQueryNuvem(".js-home-main-slider-container").removeClass("hidden");
                        jQueryNuvem(".js-home-empty-slider-container").addClass("hidden");
                        jQueryNuvem(".js-home-mobile-slider-visibility").addClass("d-md-none");
                        if (juliaHomeHasMobileSlider) {
                            jQueryNuvem(".js-home-main-slider-visibility").addClass("d-none d-md-block");
                        }
                    }
                },
                changeAutoRotation: function () {},
            };

            var homeSliderEl = document.querySelector(".js-home-slider");
            if (homeSliderEl && juliaHomeSliderLen > 1) {
                createSwiper(
                    ".js-home-slider",
                    {
                        lazy: lazyValue,
                        preloadImages: preloadImagesValue,
                        loop: juliaHomeLoopMain ? loopValue : false,
                        autoplay: slider_autoplay,
                        watchOverflow: watchOverflowValue,
                        pagination: {
                            el: ".js-swiper-home-pagination",
                            clickable: paginationClickableValue,
                        },
                        navigation: {
                            nextEl: ".js-swiper-home-next",
                            prevEl: ".js-swiper-home-prev",
                        },
                    },
                    function (swiperInstance) {
                        homeSwiper = swiperInstance;
                    }
                );
            }

            var homeSliderMobileEl = document.querySelector(".js-home-slider-mobile");
            if (homeSliderMobileEl && juliaHomeHasMobileSlider && juliaHomeSliderMobileLen > 1) {
                createSwiper(
                    ".js-home-slider-mobile",
                    {
                        lazy: lazyValue,
                        preloadImages: preloadImagesValue,
                        loop: juliaHomeLoopMobile ? loopValue : false,
                        autoplay: slider_autoplay,
                        watchOverflow: watchOverflowValue,
                        pagination: {
                            el: ".js-swiper-home-pagination-mobile",
                            clickable: paginationClickableValue,
                        },
                        navigation: {
                            nextEl: ".js-swiper-home-next-mobile",
                            prevEl: ".js-swiper-home-prev-mobile",
                        },
                    },
                    function (swiperInstance) {
                        homeMobileSwiper = swiperInstance;
                    }
                );
            }

            if (juliaHomeFeatured) {
                var featuredEl = document.querySelector(".js-swiper-featured");
                if (!featuredEl) {
                    return;
                }
                if (juliaHomeCloneIds) {
                    updateClonedItemsIDs = function (element) {
                        jQueryNuvem(element).each(function (el) {
                            var $this = jQueryNuvem(el);
                            var slide_index = $this.attr("data-swiper-slide-index");
                            var clone_quick_id = $this.find(".js-quickshop-container").attr("data-quickshop-id");
                            var clone_product_id = $this.attr("data-product-id");
                            $this.attr("data-product-id", clone_product_id + "-clone-" + slide_index);
                            $this.find(".js-quickshop-container").attr("data-quickshop-id", clone_quick_id + "-clone-" + slide_index);
                        });
                    };
                }
                var featuredOpts = {
                    lazy: true,
                    loop: true,
                    spaceBetween: 30,
                    threshold: 5,
                    watchSlidesVisibility: true,
                    slideVisibleClass: "js-swiper-slide-visible",
                    slidesPerView: juliaHomeGridCols === 2 ? 2 : 1,
                    pagination: {
                        el: ".js-swiper-featured-pagination",
                        clickable: true,
                    },
                    navigation: {
                        nextEl: ".js-swiper-featured-next",
                        prevEl: ".js-swiper-featured-prev",
                    },
                    breakpoints: {
                        640: {
                            slidesPerView: juliaHomeGridCols === 2 ? 4 : 3,
                        },
                    },
                };
                if (juliaHomeCloneIds) {
                    featuredOpts.on = {
                        init: function () {
                            updateClonedItemsIDs(".js-swiper-featured .js-item-slide.swiper-slide-duplicate");
                        },
                    };
                }
                createSwiper(".js-swiper-featured", featuredOpts);
            }
        }
    {% endif %}

    {# Páginas institucionales: acordeón FAQ (Cómo trabajamos) #}
    var instFaqItems = document.querySelectorAll(".julia-inst-faq-item");
    if (instFaqItems.length) {
        function juliaSetInstFaqState(item, open) {
            var triggerEl = item.querySelector(".julia-inst-faq-trigger");
            var content = item.querySelector(".julia-inst-faq-content");
            if (!triggerEl || !content) {
                return;
            }
            item.classList.toggle("julia-inst-faq-item--open", open);
            triggerEl.setAttribute("aria-expanded", open ? "true" : "false");
            content.style.maxHeight = open ? content.scrollHeight + "px" : "0px";
        }
        instFaqItems.forEach(function (item) {
            var triggerEl = item.querySelector(".julia-inst-faq-trigger");
            if (!triggerEl) {
                return;
            }
            juliaSetInstFaqState(item, false);
            triggerEl.addEventListener("click", function () {
                var willOpen = !item.classList.contains("julia-inst-faq-item--open");
                instFaqItems.forEach(function (it) {
                    juliaSetInstFaqState(it, false);
                });
                if (willOpen) {
                    juliaSetInstFaqState(item, true);
                }
            });
        });
        window.addEventListener("resize", function () {
            var openItem = document.querySelector(".julia-inst-faq-item--open");
            if (openItem) {
                var content = openItem.querySelector(".julia-inst-faq-content");
                if (content) {
                    content.style.maxHeight = content.scrollHeight + "px";
                }
            }
        });
    }

    {% if template == 'category' %}
    (function () {
        var toolbar = document.querySelector(".js-category-controls");
        var spacer = document.querySelector(".js-category-controls-spacer");
        if (toolbar && spacer) {
            var compactThreshold = 72;
            function updateCatalogCompact() {
                var y = window.scrollY || window.pageYOffset;
                var compact = y > compactThreshold;
                document.body.classList.toggle("julia-catalog-compact", compact);
                if (compact) {
                    requestAnimationFrame(function () {
                        if (document.body.classList.contains("julia-catalog-compact")) {
                            spacer.style.height = toolbar.offsetHeight + "px";
                        }
                    });
                } else {
                    spacer.style.height = "0px";
                }
            }
            window.addEventListener("scroll", updateCatalogCompact, { passive: true });
            window.addEventListener("resize", updateCatalogCompact);
            updateCatalogCompact();
        }

        var filterDetails = document.getElementById("julia-catalog-filters-panel");
        if (filterDetails) {
            document.addEventListener("click", function (e) {
                if (!filterDetails.open) {
                    return;
                }
                var t = e.target;
                if (filterDetails.contains(t)) {
                    return;
                }
                filterDetails.removeAttribute("open");
            });
        }

        var sortPanel = document.getElementById("juliaCatalogSortPanel");
        var sortSelect =
            document.querySelector(".julia-catalog-sort-native .js-sort-by") ||
            document.querySelector(".js-category-controls .js-sort-by");
        var sortLabel = document.getElementById("juliaCatalogSortLabel");
        var sortRadios = document.querySelectorAll(".julia-catalog-sort-rad-input");

        function juliaNotifySortSelectChange() {
            if (!sortSelect) {
                return;
            }
            if (typeof jQueryNuvem !== "undefined") {
                jQueryNuvem(sortSelect).trigger("input").trigger("change");
            } else {
                sortSelect.dispatchEvent(new Event("input", { bubbles: true }));
                sortSelect.dispatchEvent(new Event("change", { bubbles: true }));
            }
        }

        function juliaSyncSortLabel() {
            if (!sortSelect || !sortLabel) {
                return;
            }
            var opt = sortSelect.options[sortSelect.selectedIndex];
            sortLabel.textContent = opt ? opt.textContent.replace(/\s+/g, " ").trim() : "";
        }

        function juliaSyncSortRadios() {
            if (!sortSelect) {
                return;
            }
            for (var i = 0; i < sortRadios.length; i++) {
                sortRadios[i].checked = sortRadios[i].value === sortSelect.value;
            }
        }

        if (sortRadios.length) {
            for (var j = 0; j < sortRadios.length; j++) {
                sortRadios[j].addEventListener("change", function () {
                    if (!this.checked) {
                        return;
                    }
                    if (typeof juliaSortByNavigate === "function") {
                        juliaSortByNavigate(this.value);
                    } else if (sortSelect) {
                        if (typeof jQueryNuvem !== "undefined") {
                            jQueryNuvem(sortSelect).val(this.value);
                        } else {
                            sortSelect.value = this.value;
                        }
                        juliaNotifySortSelectChange();
                    }
                    if (sortPanel) {
                        sortPanel.removeAttribute("open");
                    }
                });
            }
        }
        if (sortSelect) {
            sortSelect.addEventListener("change", function () {
                juliaSyncSortRadios();
                juliaSyncSortLabel();
            });
            juliaSyncSortRadios();
            juliaSyncSortLabel();
        } else if (sortLabel && sortRadios.length) {
            var checkedRad = document.querySelector(".julia-catalog-sort-rad-input:checked");
            if (checkedRad) {
                var lab = checkedRad.closest("label");
                var span = lab ? lab.querySelector("span") : null;
                if (span) {
                    sortLabel.textContent = span.textContent.replace(/\s+/g, " ").trim();
                }
            }
        }

        if (sortPanel) {
            document.addEventListener("click", function (e) {
                if (!sortPanel.open) {
                    return;
                }
                var t = e.target;
                if (sortPanel.contains(t)) {
                    return;
                }
                sortPanel.removeAttribute("open");
            });
        }

        function juliaFormatMoneyAr(n) {
            try {
                return "$" + Number(n).toLocaleString("es-AR");
            } catch (e) {
                return "$" + n;
            }
        }

        /**
         * Tienda Nube enlaza el filtro de precio con jQuery; hace falta .val() + .trigger().
         */
        function juliaSetFilterPriceInput(el, rawNum) {
            if (!el) {
                return;
            }
            var s = String(rawNum);
            if (typeof jQueryNuvem !== "undefined") {
                var $el = jQueryNuvem(el);
                $el.val(s);
                $el.trigger("keyup");
                $el.trigger("input");
                $el.trigger("change");
            } else {
                el.value = s;
                el.dispatchEvent(new Event("keyup", { bubbles: true }));
                el.dispatchEvent(new Event("input", { bubbles: true }));
                el.dispatchEvent(new Event("change", { bubbles: true }));
            }
        }

        function juliaFindPriceSubmitButton(scope) {
            if (!scope) {
                return null;
            }
            return (
                scope.querySelector(".filters-container button.btn-default") ||
                scope.querySelector(".filters-container button.btn") ||
                scope.querySelector(".filters-container button[type='submit']") ||
                scope.querySelector(".filters-container input[type='submit']") ||
                scope.querySelector("button.btn-default") ||
                scope.querySelector("button.btn")
            );
        }

        function juliaEnablePriceSubmit(scope) {
            var btn = juliaFindPriceSubmitButton(scope);
            if (!btn) {
                return;
            }
            btn.removeAttribute("disabled");
            btn.disabled = false;
            if (btn.classList) {
                btn.classList.remove("disabled");
            }
        }

        function juliaCatalogInitPriceRange() {
            var filterRoot = document.getElementById("julia-catalog-filters-panel");
            if (!filterRoot) {
                return;
            }
            var body = filterRoot.querySelector(".julia-catalog-dropdown__body");
            if (!body || body.getAttribute("data-julia-price-range") === "1") {
                return;
            }
            var priceInputs = body.querySelectorAll("input.filter-input-price");
            if (!priceInputs.length) {
                return;
            }

            var minEl = priceInputs[0];
            var maxEl = priceInputs.length >= 2 ? priceInputs[1] : null;

            var maxAttr = (maxEl || minEl).getAttribute("max");
            var dataMaxRaw = filterRoot.getAttribute("data-julia-listing-price-max");
            var listingMax =
                dataMaxRaw != null && dataMaxRaw !== "" && !isNaN(parseInt(dataMaxRaw, 10))
                    ? parseInt(dataMaxRaw, 10)
                    : NaN;
            var maxFromInput =
                maxAttr != null && maxAttr !== "" && !isNaN(parseInt(maxAttr, 10))
                    ? parseInt(maxAttr, 10)
                    : NaN;
            // Prioridad: máximo real del listado (Twig) > max del input TN > fallback amplio
            var maxBound;
            if (!isNaN(listingMax) && listingMax > 0) {
                maxBound = listingMax;
            } else if (!isNaN(maxFromInput) && maxFromInput >= 0) {
                maxBound = maxFromInput;
            } else {
                maxBound = 999999999;
            }
            var minBound = 0;
            var step = parseInt(minEl.getAttribute("step") || (maxEl && maxEl.getAttribute("step")) || "5000", 10);
            if (isNaN(step) || step < 1) {
                step = 5000;
            }
            // Pasos más finos cuando el techo es el del listado (evita saltos bruscos con rangos enormes)
            if (!isNaN(listingMax) && listingMax > 0 && maxBound === listingMax) {
                var adaptive = Math.max(1, Math.ceil(maxBound / 200));
                if (adaptive < step) {
                    step = adaptive;
                }
            }

            function parseMoneyInput(el) {
                if (!el || !el.value) {
                    return null;
                }
                var n = parseInt(String(el.value).replace(/[^\d]/g, ""), 10);
                return isNaN(n) ? null : n;
            }

            var lblDesde = "Desde";
            var lblHasta = "Hasta";
            var lblMax = "Máx.";
            if (filterRoot.getAttribute("data-julia-lbl-desde")) {
                lblDesde = filterRoot.getAttribute("data-julia-lbl-desde");
            }
            if (filterRoot.getAttribute("data-julia-lbl-hasta")) {
                lblHasta = filterRoot.getAttribute("data-julia-lbl-hasta");
            }
            if (filterRoot.getAttribute("data-julia-lbl-max")) {
                lblMax = filterRoot.getAttribute("data-julia-lbl-max");
            }
            var ariaRange =
                filterRoot.getAttribute("data-julia-aria-rango-precio") ||
                "Rango de precios según productos en esta categoría";

            var wrap = document.createElement("div");
            wrap.className = "julia-catalog-price-range-wrap";
            wrap.innerHTML =
                '<div class="julia-catalog-price-range-hints" aria-hidden="true">' +
                '<span class="julia-catalog-price-range-hint julia-catalog-price-range-hint--min"></span>' +
                '<span class="julia-catalog-price-range-hint julia-catalog-price-range-hint--max"></span>' +
                "</div>" +
                '<input type="range" class="julia-catalog-price-range-slider" />' +
                '<div class="julia-catalog-price-range-value" aria-live="polite"></div>';

            var slider = wrap.querySelector(".julia-catalog-price-range-slider");
            var valueEl = wrap.querySelector(".julia-catalog-price-range-value");
            var hintMin = wrap.querySelector(".julia-catalog-price-range-hint--min");
            var hintMax = wrap.querySelector(".julia-catalog-price-range-hint--max");
            slider.setAttribute("aria-label", ariaRange);
            slider.min = String(minBound);
            slider.max = String(maxBound);
            slider.step = String(step);

            hintMin.textContent = lblDesde + " " + juliaFormatMoneyAr(0);
            hintMax.textContent = lblMax + " " + juliaFormatMoneyAr(maxBound);

            for (var pi = 0; pi < priceInputs.length; pi++) {
                var pc = priceInputs[pi].closest(".filter-input-price-container");
                if (pc) {
                    pc.classList.add("julia-catalog-price-native-hidden");
                }
            }

            var priceContainer = minEl.closest(".filters-container");
            var titleEl = null;
            if (priceContainer) {
                titleEl = priceContainer.querySelector("h6") || priceContainer.querySelector(".h6");
            }
            if (titleEl) {
                titleEl.style.display = "none";
                titleEl.after(wrap);
            } else {
                body.insertBefore(wrap, body.firstChild);
            }

            var actionSpan = filterRoot.querySelector(".julia-catalog-dropdown__action");

            function syncReadout(v) {
                valueEl.textContent = lblHasta + " " + juliaFormatMoneyAr(v);
            }

            function syncSliderFromInputs() {
                var v;
                if (maxEl) {
                    v = parseMoneyInput(maxEl);
                    if (v == null || v <= 0) {
                        v = maxBound;
                    }
                } else {
                    v = parseMoneyInput(minEl);
                    if (v == null || v <= 0) {
                        v = maxBound;
                    }
                }
                if (v < 0) {
                    v = 0;
                }
                if (v > maxBound) {
                    v = maxBound;
                }
                slider.value = String(v);
                syncReadout(v);
            }

            function onSliderMove() {
                var v = parseInt(slider.value, 10);
                if (isNaN(v)) {
                    return;
                }
                if (maxEl && minEl) {
                    juliaSetFilterPriceInput(minEl, 0);
                    juliaSetFilterPriceInput(maxEl, v);
                } else if (maxEl) {
                    juliaSetFilterPriceInput(maxEl, v);
                } else {
                    juliaSetFilterPriceInput(minEl, v);
                }
                syncReadout(v);
                juliaEnablePriceSubmit(body);
                if (actionSpan) {
                    actionSpan.classList.add("julia-catalog-dropdown__action--active");
                }
            }

            slider.addEventListener("input", onSliderMove);
            slider.addEventListener("change", onSliderMove);

            syncSliderFromInputs();
            if (minEl && maxEl) {
                juliaSetFilterPriceInput(minEl, 0);
            }

            body.setAttribute("data-julia-price-range", "1");
        }

        var filterDetailsForPrice = document.getElementById("julia-catalog-filters-panel");
        if (filterDetailsForPrice && filterDetailsForPrice.getAttribute("data-julia-filter-apply-wired") !== "1") {
            filterDetailsForPrice.setAttribute("data-julia-filter-apply-wired", "1");
            filterDetailsForPrice.addEventListener(
                "click",
                function (e) {
                    if (!filterDetailsForPrice.open) {
                        return;
                    }
                    var act = e.target.closest(".julia-catalog-dropdown__action");
                    if (!act) {
                        return;
                    }
                    e.preventDefault();
                    e.stopPropagation();
                    var bodyEl = filterDetailsForPrice.querySelector(".julia-catalog-dropdown__body");
                    var btn = juliaFindPriceSubmitButton(bodyEl);
                    if (btn) {
                        juliaEnablePriceSubmit(bodyEl);
                        btn.click();
                    }
                },
                true
            );
        }
        if (filterDetailsForPrice) {
            filterDetailsForPrice.addEventListener("toggle", function () {
                if (filterDetailsForPrice.open) {
                    setTimeout(function () {
                        juliaCatalogInitPriceRange();
                        var bodyOpen = filterDetailsForPrice.querySelector(".julia-catalog-dropdown__body");
                        if (bodyOpen) {
                            juliaEnablePriceSubmit(bodyOpen);
                        }
                    }, 0);
                }
            });
        }
        juliaCatalogInitPriceRange();
    })();
    {% endif %}

    {# Infinite scroll / Mostrar más: LS.hybridScroll (docs TN category.tpl) #}
    {% if template == 'category' or template == 'search' %}
        {% if pages is defined and pages.current == 1 and not pages.is_last %}
            if (typeof LS.hybridScroll === "function") {
                LS.hybridScroll({
                    productGridSelector: ".js-product-table",
                    spinnerSelector: "#js-infinite-scroll-spinner",
                    loadMoreButtonSelector: ".js-load-more",
                    hideWhileScrollingSelector: ".js-hide-footer-while-scrolling",
                    productsBeforeLoadMoreButton: 50,
                    productsPerPage: 12
                });
            }
        {% endif %}
    {% endif %}

});

{#/*============================================================================
  Lusano PDP — IntersectionObserver, variantes, lightbox, cantidad
==============================================================================#}

{% if template == 'product' %}
(function lusanoPDP() {
    var wrap = document.querySelector(".lusano-wrap");
    if (!wrap) return;

    var rootPDP = document.getElementById("single-product") || wrap;
    var gallery = wrap.querySelector(".js-lusano-gallery");
    var images = wrap.querySelectorAll(".js-lusano-gallery-img");
    var counterEl = wrap.querySelector(".js-lusano-counter");
    var counterTotalEl = wrap.querySelector(".js-lusano-counter-total");
    var variantLabelEl = wrap.querySelector(".js-lusano-variant-label");
    var totalImages = images.length;

    function pad(n, len) {
        var s = String(n);
        while (s.length < len) s = "0" + s;
        return s;
    }

    if (counterTotalEl) {
        counterTotalEl.textContent = pad(1, 3) + " \u2014 " + pad(totalImages, 3);
    }

    function lusanoParseVariantsJson() {
        try {
            var raw = rootPDP.getAttribute("data-variants");
            if (!raw) return null;
            return JSON.parse(raw);
        } catch (err) {
            return null;
        }
    }

    function lusanoVariantsList(data) {
        if (!data) return [];
        if (Array.isArray(data)) return data;
        if (typeof data === "object") {
            return Object.keys(data).map(function (k) {
                return data[k];
            });
        }
        return [];
    }

    function lusanoGetSelectedOptionNames() {
        var names = [];
        var selects = wrap.querySelectorAll("#product_form select.js-lusano-hidden-select");
        selects.forEach(function (sel) {
            var opt = sel.options[sel.selectedIndex];
            names.push(opt ? String(opt.textContent || "").trim() : "");
        });
        return names;
    }

    function lusanoVariantMatchesOptions(v, names, indexOffset) {
        if (!v || !names.length) return false;
        var off = indexOffset === 1 ? 1 : 0;
        for (var j = 0; j < names.length; j++) {
            var key = "option" + (j + off);
            var va = v[key] != null ? String(v[key]).trim() : "";
            var nb = names[j] != null ? String(names[j]).trim() : "";
            if (va !== nb) return false;
        }
        return true;
    }

    function lusanoFindMatchingVariant(names) {
        var list = lusanoVariantsList(lusanoParseVariantsJson());
        var offsets = [0, 1];
        for (var o = 0; o < offsets.length; o++) {
            for (var i = 0; i < list.length; i++) {
                if (lusanoVariantMatchesOptions(list[i], names, offsets[o])) return list[i];
            }
        }
        return null;
    }

    function lusanoVariantImageId(v) {
        if (!v) return null;
        var id = v.image_id != null ? v.image_id : v.image;
        if (id != null && id !== "") return id;
        return null;
    }

    function lusanoUnveilGalleryImg(img) {
        if (!img || typeof window.lazySizes === "undefined") return;
        if (img.classList.contains("lazyload") || img.getAttribute("data-src")) {
            try {
                lazySizes.loader.unveil(img);
            } catch (e1) {}
        }
    }

    function lusanoScrollGalleryToImageId(imageId) {
        if (!gallery || imageId == null || imageId === "") return;
        var idStr = String(imageId);
        var el = null;
        var imgs = gallery.querySelectorAll(".js-lusano-gallery-img[data-image]");
        for (var i = 0; i < imgs.length; i++) {
            if (String(imgs[i].getAttribute("data-image")) === idStr) {
                el = imgs[i];
                break;
            }
        }
        if (!el) return;
        lusanoUnveilGalleryImg(el);
        var gRect = gallery.getBoundingClientRect();
        var eRect = el.getBoundingClientRect();
        var nextTop = gallery.scrollTop + (eRect.top - gRect.top);
        gallery.scrollTo({ top: Math.max(0, nextTop), behavior: "smooth" });
        var idx = parseInt(el.getAttribute("data-index"), 10);
        if (!isNaN(idx) && counterEl) {
            counterEl.textContent = pad(idx, 3);
        }
        if (!isNaN(idx) && counterTotalEl && totalImages) {
            counterTotalEl.textContent = pad(idx, 3) + " \u2014 " + pad(totalImages, 3);
        }
    }

    function lusanoApplyPricesFromVariant(v) {
        if (!v) return;
        var priceEl = document.getElementById("price_display");
        var compareEl = document.getElementById("compare_price_display");
        var pText = v.price_short || v.price_long;
        if (priceEl && pText) {
            priceEl.textContent = pText;
            priceEl.style.display = "";
        }
        if (compareEl) {
            var cText = v.compare_at_price_short || v.compare_at_price_long;
            if (cText) {
                compareEl.textContent = cText;
                compareEl.style.display = "";
            } else {
                compareEl.textContent = "";
                compareEl.style.display = "none";
            }
        }
    }

    function lusanoUpdateDimensionsDisplay(v) {
        var el = wrap.querySelector(".js-lusano-dimensions-value");
        if (!el || !v) return;
        var parts = [];
        ["width", "height", "depth"].forEach(function (key) {
            var x = v[key];
            if (x != null && String(x).trim() !== "" && String(x).trim() !== "0") {
                parts.push(String(x).trim());
            }
        });
        if (parts.length) {
            el.textContent = parts.join(" \u00D7 ") + " cm";
        }
    }

    function lusanoSyncVariantUi(extraImageId) {
        var names = lusanoGetSelectedOptionNames();
        var v = lusanoFindMatchingVariant(names);
        if (v) {
            lusanoApplyPricesFromVariant(v);
            lusanoUpdateDimensionsDisplay(v);
        }
        var imgId = extraImageId != null ? extraImageId : lusanoVariantImageId(v);
        if (imgId) lusanoScrollGalleryToImageId(imgId);
    }

    if (gallery && counterEl && "IntersectionObserver" in window) {
        var imgObserver = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting && entry.intersectionRatio >= 0.5) {
                    var idx = parseInt(entry.target.dataset.index, 10);
                    counterEl.style.opacity = "0";
                    setTimeout(function () {
                        counterEl.textContent = pad(idx, 3);
                        counterEl.style.opacity = "1";
                    }, 150);
                    if (counterTotalEl) {
                        counterTotalEl.textContent = pad(idx, 3) + " \u2014 " + pad(totalImages, 3);
                    }
                }
            });
        }, {
            root: gallery,
            threshold: 0.5
        });
        images.forEach(function (img) { imgObserver.observe(img); });
    }

    var backBtn = wrap.querySelector(".js-lusano-back");
    if (backBtn) {
        backBtn.addEventListener("click", function () {
            var href = backBtn.getAttribute("data-lusano-back-href") || "/productos";
            window.location.href = href;
        });
    }

    wrap.querySelectorAll(".js-lusano-row-toggle").forEach(function (btn) {
        btn.addEventListener("click", function () {
            var row = btn.closest(".js-lusano-row");
            if (!row) return;
            var opts = row.querySelector(".js-lusano-row-opts");
            if (!opts) return;
            var isOpen = opts.classList.toggle("open");
            btn.textContent = isOpen ? "\u00D7" : "+";
        });
    });

    wrap.querySelectorAll(".js-lusano-opt").forEach(function (opt) {
        opt.addEventListener("click", function () {
            var variationId = opt.dataset.variationId;
            var optionId = opt.dataset.optionId;
            var label = opt.dataset.label;
            var row = opt.closest(".js-lusano-row");

            if (row) {
                row.querySelectorAll(".js-lusano-opt").forEach(function (o) {
                    o.classList.remove("active");
                });
                opt.classList.add("active");
                var selectedEl = row.querySelector(".js-lusano-row-selected");
                if (selectedEl) selectedEl.textContent = label;
            }

            var hiddenSelect = wrap.querySelector(
                'select.js-lusano-hidden-select[data-variation-id="' + variationId + '"]'
            );
            if (hiddenSelect) {
                hiddenSelect.value = optionId;
                var nativeEvt = new Event("change", { bubbles: true });
                hiddenSelect.dispatchEvent(nativeEvt);
                if (typeof jQueryNuvem !== "undefined") {
                    jQueryNuvem(hiddenSelect).trigger("change");
                }
            }

            lusanoUpdateVariantLabel();
            setTimeout(function () {
                lusanoSyncVariantUi(null);
            }, 0);
        });
    });

    wrap.querySelectorAll("#product_form select.js-lusano-hidden-select").forEach(function (sel) {
        sel.addEventListener("change", function () {
            setTimeout(function () {
                lusanoSyncVariantUi(null);
            }, 0);
        });
    });

    if (typeof LS !== "undefined" && typeof LS.registerOnChangeVariant === "function") {
        LS.registerOnChangeVariant(function (variant) {
            if (!variant) return;
            var imgId = variant.image_id != null ? variant.image_id : variant.image;
            if (variant.price_short || variant.price_long) {
                lusanoApplyPricesFromVariant(variant);
            }
            lusanoUpdateDimensionsDisplay(variant);
            if (imgId) {
                lusanoScrollGalleryToImageId(imgId);
            } else {
                lusanoSyncVariantUi(null);
            }
        });
    }

    setTimeout(function () {
        lusanoSyncVariantUi(null);
    }, 120);

    function lusanoUpdateVariantLabel() {
        if (!variantLabelEl) return;
        var parts = [];
        wrap.querySelectorAll(".js-lusano-row").forEach(function (row) {
            var selected = row.querySelector(".js-lusano-row-selected");
            if (selected && selected.textContent.trim()) {
                parts.push(selected.textContent.trim());
            }
        });
        variantLabelEl.textContent = parts.length ? parts.join(" \u00B7 ") : "\u2014";
    }
    lusanoUpdateVariantLabel();

    var qtyInput = wrap.querySelector(".js-quantity-input");
    var qtyDown = wrap.querySelector(".js-lusano-qty-down");
    var qtyUp = wrap.querySelector(".js-lusano-qty-up");

    if (qtyInput && qtyDown && qtyUp) {
        qtyDown.addEventListener("click", function () {
            var val = parseInt(qtyInput.value, 10) || 1;
            if (val > 1) {
                qtyInput.value = val - 1;
                qtyInput.dispatchEvent(new Event("change", { bubbles: true }));
            }
        });
        qtyUp.addEventListener("click", function () {
            var val = parseInt(qtyInput.value, 10) || 1;
            qtyInput.value = val + 1;
            qtyInput.dispatchEvent(new Event("change", { bubbles: true }));
        });
    }

    var lightbox = wrap.querySelector(".js-lusano-lightbox");
    var lightboxImg = wrap.querySelector(".js-lusano-lightbox-img");
    var lightboxClose = wrap.querySelector(".js-lusano-lightbox-close");
    var detailThumb = wrap.querySelector(".js-lusano-detail-thumb");

    if (lightbox && lightboxImg) {
        function openLightbox(src, alt) {
            lightboxImg.src = src;
            lightboxImg.alt = alt || "";
            lightbox.classList.add("active");
            lightbox.setAttribute("aria-hidden", "false");
        }
        function closeLightbox() {
            lightbox.classList.remove("active");
            lightbox.setAttribute("aria-hidden", "true");
            setTimeout(function () { lightboxImg.src = ""; }, 300);
        }

        if (detailThumb) {
            detailThumb.addEventListener("click", function () {
                openLightbox(detailThumb.dataset.full || detailThumb.src, detailThumb.alt);
            });
        }

        images.forEach(function (img) {
            img.addEventListener("click", function () {
                openLightbox(img.dataset.full || img.src, img.alt);
            });
        });

        if (lightboxClose) lightboxClose.addEventListener("click", closeLightbox);

        lightbox.addEventListener("click", function (e) {
            if (e.target === lightbox) closeLightbox();
        });

        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape" && lightbox.classList.contains("active")) closeLightbox();
        });
    }
})();
{% endif %}
