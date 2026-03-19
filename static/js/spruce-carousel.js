// Julia Design - Spruce Simple
// Carrusel infinito (marquee) con seam imperceptible usando JS vanilla.
// Objetivo: que el track se deslice de forma continua moviendo el primer item al final.

(function () {
  "use strict";

  function prefersReducedMotion() {
    try {
      return (
        window.matchMedia &&
        window.matchMedia("(prefers-reduced-motion: reduce)").matches
      );
    } catch (e) {
      return false;
    }
  }

  function initOne(root) {
    var viewport = root.querySelector(".spruce-carousel-viewport");
    var track = root.querySelector("[data-track]");
    if (!viewport || !track) return;

    var speedPxPerSec = parseFloat(root.getAttribute("data-speed") || "65");
    if (!speedPxPerSec || Number.isNaN(speedPxPerSec)) speedPxPerSec = 65;

    if (prefersReducedMotion()) return;

    var rafId = null;
    var lastTs = null;
    var paused = false;
    var offsetPx = 0;

    var originalHTML = track.innerHTML;
    var originalCount = track.children.length;

    function stepForFirstItem() {
      var first = track.children[0];
      if (!first) return 0;

      var computed = window.getComputedStyle(first);
      var mr = parseFloat(computed.marginRight || "0") || 0;
      return first.offsetWidth + mr;
    }

    function ensureCoverage() {
      var viewportWidth = viewport.getBoundingClientRect().width;
      var safetyIterations = 0;

      // Clonamos hasta que haya suficiente contenido para que no aparezcan huecos.
      while (track.scrollWidth < viewportWidth * 2 && safetyIterations < 20) {
        safetyIterations++;
        for (var i = 0; i < originalCount; i++) {
          var child = track.children[i];
          if (!child) break;
          track.appendChild(child.cloneNode(true));
        }
      }
    }

    function reset() {
      track.innerHTML = originalHTML;
      offsetPx = 0;
      lastTs = null;
      track.style.transform = "translate3d(0,0,0)";
      paused = false;
      ensureCoverage();
    }

    function tick(ts) {
      if (paused) {
        rafId = null;
        return;
      }

      if (lastTs === null) lastTs = ts;
      var dt = (ts - lastTs) / 1000;
      lastTs = ts;

      offsetPx += speedPxPerSec * dt;

      while (!paused) {
        var step = stepForFirstItem();
        if (!step || offsetPx < step) break;
        offsetPx -= step;
        // La "pieza" que sale por la izquierda pasa al final.
        track.appendChild(track.firstElementChild);
      }

      track.style.transform = "translate3d(" + -offsetPx + "px, 0, 0)";
      rafId = window.requestAnimationFrame(tick);
    }

    function start() {
      if (rafId !== null) return;
      lastTs = null;
      paused = false;
      rafId = window.requestAnimationFrame(tick);
    }

    function stop() {
      paused = true;
      if (rafId !== null) window.cancelAnimationFrame(rafId);
      rafId = null;
    }

    function resume() {
      paused = false;
      start();
    }

    // Inicial: asegurar cobertura inicial y arrancar.
    reset();
    start();

    // Pausa al hover (desktop) y al foco/teclado.
    root.addEventListener("mouseenter", stop);
    root.addEventListener("mouseleave", resume);
    root.addEventListener("focusin", stop);
    root.addEventListener("focusout", resume);

    // Recalcular en resize (los anchos cambian en responsive).
    var resizeTimer = null;
    window.addEventListener("resize", function () {
      window.clearTimeout(resizeTimer);
      resizeTimer = window.setTimeout(function () {
        reset();
        resume();
      }, 150);
    });
  }

  function init() {
    var roots = document.querySelectorAll("[data-spruce-carousel]");
    if (!roots || roots.length === 0) return;

    roots.forEach(initOne);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();

