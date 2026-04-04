{# CSS inline mínimo para evitar inyectar todo style-colors.scss.tpl en el HTML #}

:root{
  /* Julia Design — paleta base (no depende de settings) */
  --gray-light:#D2D0D0;
  --white:#FFFFFF;
  --mink:#81756C;
  --brown:#54463D;
  --cream:#ece8e4;
  --dark-text:#1c1a16;

  /* Tipografías desde settings */
  --julia-font-heading: {{ settings.font_headings | raw }};
  --julia-font-body: {{ settings.font_rest | raw }};

  /* Escalas fluidas */
  --julia-text-h1: clamp(2rem, 2.4vw + 1.2rem, 3.75rem);
  --julia-text-h2: clamp(1.5rem, 1.4vw + 0.85rem, 2.5rem);
  --julia-text-h3: clamp(1rem, 0.55vw + 0.82rem, 1.375rem);
  --julia-text-body: clamp(0.875rem, 0.22vw + 0.8rem, 1rem);
  --julia-text-legal: clamp(0.75rem, 0.12vw + 0.72rem, 0.875rem);
  --julia-text-btn: clamp(0.875rem, 0.2vw + 0.78rem, 0.9375rem);
}

body{
  color: {{ settings.text_color }};
  background-color: {{ settings.background_color }};
  font-family: var(--julia-font-body);
  font-size: var(--julia-text-body);
  font-weight: 400;
  line-height: 1.5;
}

h1,.h1,
h2,.h2,
h3,.h3,
h4,.h4,
h5,.h5,
h6,.h6{
  margin-top: 0;
  font-family: var(--julia-font-heading);
}

h1, .h1 { font-size: var(--julia-text-h1); line-height: 1.15; font-weight: 700; }
h2, .h2 { font-size: var(--julia-text-h2); line-height: 1.2; letter-spacing: -0.02em; font-weight: 700; }
h3, .h3 { font-size: var(--julia-text-h3); line-height: 1.25; font-weight: 700; }

.btn{
  font-family: var(--julia-font-heading);
  font-size: var(--julia-text-btn);
  font-weight: 700;
  letter-spacing: 0.06em;
  text-transform: uppercase;
}
