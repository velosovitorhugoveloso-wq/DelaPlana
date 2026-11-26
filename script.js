/* Dados editáveis do estabelecimento. Horários, produtos e imagens abaixo são exemplos. */
const CONFIG = {
  whatsapp: "", // Exemplo: "5531999999999". Vazio usa o telefone fixo.
  telefone: "553125720765",
  instagram: "", // Exemplo: "https://www.instagram.com/perfil_oficial/"
  mensagem: "Olá! Vi o site da Della Panna e gostaria de saber mais.",
  // Exemplo: 0 = domingo; cada horário é [abertura, fechamento], em formato 24h; null = fechado.
  horarios: {
    0: [13, 21],
    1: [12, 21],
    2: [12, 21],
    3: [12, 21],
    4: [12, 21],
    5: [12, 22],
    6: [12, 22]
  }
};

const PRODUTOS = [
  // Sabores ilustrativos de exemplo: substitua pelos itens reais do cardápio.
  { nome: "Chocolate belga", categoria: "Sorvetes", emoji: "🍫", descricao: "Cremoso, intenso e cheio de sabor." },
  { nome: "Doce de leite", categoria: "Sorvetes", emoji: "🍯", descricao: "Um clássico que abraça a gente." },
  { nome: "Baunilha", categoria: "Sorvetes", emoji: "🌼", descricao: "Leve, delicada e superversátil." },
  { nome: "Morango", categoria: "Frutas", emoji: "🍓", descricao: "Frutado, docinho e refrescante." },
  { nome: "Limão", categoria: "Frutas", emoji: "🍋", descricao: "Um toque cítrico para refrescar." },
  { nome: "Maracujá", categoria: "Frutas", emoji: "🥭", descricao: "Azedinho na medida certa." },
  { nome: "Casquinha crocante", categoria: "Extras", emoji: "🍦", descricao: "Para deixar seu sorvete especial." },
  { nome: "Milk-shake", categoria: "Extras", emoji: "🥤", descricao: "Gelado, cremoso e irresistível." }
];

const FOTOS = [
  // Ilustrações locais de exemplo; troque o caminho e o texto alternativo por fotos autorizadas.
  { src: "img/gelato-casquinha.svg", alt: "Ilustração de uma casquinha de gelato artesanal", legenda: "Uma pausa bem docinha" },
  { src: "img/sorvete-frutas.svg", alt: "Ilustração de sorvete com frutas frescas", legenda: "Cores e sabores da fruta" },
  { src: "img/sundae-artesanal.svg", alt: "Ilustração de uma taça de sorvete com calda", legenda: "Um clássico para compartilhar" },
  { src: "img/momento-feliz.svg", alt: "Ilustração de duas casquinhas de sorvete", legenda: "Alegria em dose dupla" }
];

document.documentElement.classList.add("js");

const diasDaSemana = ["Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira", "Sábado"];

function atualizarSchemaHorarios() {
  const scriptSchema = document.querySelector('script[type="application/ld+json"]');
  const schema = JSON.parse(scriptSchema.textContent);
  const grupos = new Map();
  const nomesDias = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

  diasDaSemana.forEach((dia, indice) => {
    const horario = CONFIG.horarios[indice];
    if (!horario) return;
    const chave = `${horario[0]}-${horario[1]}`;
    if (!grupos.has(chave)) grupos.set(chave, { horario, dias: [] });
    grupos.get(chave).dias.push(`https://schema.org/${nomesDias[indice]}`);
  });

  schema.openingHoursSpecification = [...grupos.values()].map(({ horario, dias }) => ({
    "@type": "OpeningHoursSpecification",
    dayOfWeek: dias.length === 1 ? dias[0] : dias,
    opens: `${String(horario[0]).padStart(2, "0")}:00`,
    closes: `${String(horario[1]).padStart(2, "0")}:00`
  }));
  scriptSchema.textContent = JSON.stringify(schema);
}

atualizarSchemaHorarios();

/* Menu responsivo: fecha ao navegar, apertar Escape ou voltar ao layout desktop. */
const menuToggle = document.getElementById("menuToggle");
const primaryMenu = document.getElementById("primaryMenu");

function definirMenu(aberto) {
  menuToggle.setAttribute("aria-expanded", String(aberto));
  menuToggle.setAttribute("aria-label", aberto ? "Fechar menu" : "Abrir menu");
  primaryMenu.classList.toggle("is-open", aberto);
  document.body.classList.toggle("menu-open", aberto && window.matchMedia("(max-width: 650px)").matches);
}

menuToggle.addEventListener("click", () => {
  definirMenu(menuToggle.getAttribute("aria-expanded") !== "true");
});
primaryMenu.querySelectorAll("a").forEach((link) => {
  link.addEventListener("click", () => definirMenu(false));
});
document.addEventListener("keydown", (event) => {
  if (event.key === "Escape" && menuToggle.getAttribute("aria-expanded") === "true") {
    definirMenu(false);
    menuToggle.focus();
  }
});
document.addEventListener("pointerdown", (event) => {
  const menuAberto = menuToggle.getAttribute("aria-expanded") === "true";
  const menuMobile = window.matchMedia("(max-width: 650px)").matches;
  if (menuAberto && menuMobile && !primaryMenu.contains(event.target) && !menuToggle.contains(event.target)) {
    definirMenu(false);
  }
});
document.addEventListener("focusin", (event) => {
  const menuAberto = menuToggle.getAttribute("aria-expanded") === "true";
  const menuMobile = window.matchMedia("(max-width: 650px)").matches;
  if (menuAberto && menuMobile && !primaryMenu.contains(event.target) && !menuToggle.contains(event.target)) {
    definirMenu(false);
  }
});
window.matchMedia("(min-width: 651px)").addEventListener("change", () => definirMenu(false));

/* Cards de sabores e filtros de categoria. */
const productFilters = document.getElementById("productFilters");
const productList = document.getElementById("productList");
const categorias = ["Todos", "Sorvetes", "Frutas", "Extras"];

function exibirProdutos(categoriaSelecionada) {
  productList.replaceChildren();
  PRODUTOS
    .filter((produto) => categoriaSelecionada === "Todos" || produto.categoria === categoriaSelecionada)
    .forEach((produto) => {
      const card = document.createElement("article");
      card.className = "product-card";
      card.dataset.category = produto.categoria;

      const emoji = document.createElement("span");
      emoji.className = "product-emoji";
      emoji.setAttribute("aria-hidden", "true");
      emoji.textContent = produto.emoji;

      const categoria = document.createElement("p");
      categoria.className = "product-category";
      categoria.textContent = produto.categoria;

      const titulo = document.createElement("h3");
      titulo.textContent = produto.nome;

      const descricao = document.createElement("p");
      descricao.className = "product-description";
      descricao.textContent = produto.descricao;

      const pedido = document.createElement("a");
      pedido.className = "product-order";
      pedido.href = criarLinkPedido(produto);
      pedido.setAttribute("aria-label", `Pedir ${produto.nome}`);
      if (CONFIG.whatsapp.replace(/\D/g, "")) {
        pedido.target = "_blank";
        pedido.rel = "noopener noreferrer";
      }
      pedido.textContent = CONFIG.whatsapp.replace(/\D/g, "") ? "Pedir este sabor" : "Ligar para pedir";

      card.append(emoji, categoria, titulo, descricao, pedido);
      card.classList.add("is-entering");
      productList.append(card);
    });

  window.requestAnimationFrame(() => {
    productList.querySelectorAll(".product-card").forEach((card, indice) => {
      window.setTimeout(() => card.classList.remove("is-entering"), indice * 45);
    });
  });

  productFilters.querySelectorAll("button").forEach((botao) => {
    botao.setAttribute("aria-pressed", String(botao.dataset.category === categoriaSelecionada));
  });
}

function criarLinkPedido(produto) {
  const numeroWhatsApp = CONFIG.whatsapp.replace(/\D/g, "");
  const numeroTelefone = CONFIG.telefone.replace(/\D/g, "");
  if (!numeroWhatsApp) return `tel:+${numeroTelefone}`;
  const mensagem = `${CONFIG.mensagem} Tenho interesse em pedir: ${produto.nome}.`;
  return `https://wa.me/${numeroWhatsApp}?text=${encodeURIComponent(mensagem)}`;
}

categorias.forEach((categoria) => {
  const botao = document.createElement("button");
  botao.className = "filter-button";
  botao.type = "button";
  botao.dataset.category = categoria;
  botao.textContent = categoria;
  botao.setAttribute("aria-pressed", "false");
  botao.addEventListener("click", () => exibirProdutos(categoria));
  productFilters.append(botao);
});
exibirProdutos("Todos");

/* Galeria local com ampliação por clique, botão de fechar e tecla Escape. */
const galleryGrid = document.getElementById("galleryGrid");
const lightbox = document.getElementById("lightbox");
const lightboxImage = document.getElementById("lightboxImage");
const lightboxClose = document.getElementById("lightboxClose");
let ultimoGatilhoLightbox = null;

function fecharLightbox() {
  if (lightbox.hidden) return;
  lightbox.hidden = true;
  document.body.classList.remove("lightbox-open");
  lightboxImage.removeAttribute("src");
  if (ultimoGatilhoLightbox) ultimoGatilhoLightbox.focus();
}

FOTOS.forEach((foto) => {
  const botao = document.createElement("button");
  botao.className = "gallery-item";
  botao.type = "button";
  botao.setAttribute("aria-label", `Ampliar imagem: ${foto.legenda}`);

  const imagem = document.createElement("img");
  imagem.src = foto.src;
  imagem.alt = foto.alt || foto.legenda || "Imagem de exemplo da sorveteria Della Panna";
  imagem.loading = "lazy";
  imagem.decoding = "async";
  imagem.width = Number(foto.width) || 600;
  imagem.height = Number(foto.height) || 600;
  imagem.addEventListener("load", () => imagem.classList.add("is-loaded"), { once: true });
  imagem.addEventListener("error", () => imagem.classList.add("is-loaded"), { once: true });

  const legenda = document.createElement("span");
  legenda.textContent = foto.legenda;
  botao.append(imagem, legenda);
  botao.addEventListener("click", () => {
    ultimoGatilhoLightbox = botao;
    lightboxImage.src = foto.src;
    lightboxImage.alt = foto.alt || foto.legenda || "Imagem de exemplo da sorveteria Della Panna";
    lightboxImage.width = Number(foto.width) || 600;
    lightboxImage.height = Number(foto.height) || 600;
    lightbox.hidden = false;
    document.body.classList.add("lightbox-open");
    lightboxClose.focus();
  });
  galleryGrid.append(botao);
});

lightboxClose.addEventListener("click", fecharLightbox);
lightbox.addEventListener("click", (event) => {
  if (event.target === lightbox) fecharLightbox();
});
document.addEventListener("keydown", (event) => {
  if (lightbox.hidden) return;
  if (event.key === "Escape") {
    fecharLightbox();
  } else if (event.key === "Tab") {
    event.preventDefault();
    lightboxClose.focus();
  }
});

/* Horários da semana e situação de funcionamento conforme o relógio local. */
function formatarHora(hora) {
  return `${String(hora).padStart(2, "0")}h`;
}

function renderizarHorarios() {
  const tabela = document.getElementById("hoursTable");
  const diaAtual = new Date().getDay();
  tabela.replaceChildren();

  diasDaSemana.forEach((dia, indice) => {
    const linha = document.createElement("tr");
    if (indice === diaAtual) {
      linha.className = "is-today";
      linha.setAttribute("aria-current", "date");
    }

    const nomeDia = document.createElement("td");
    nomeDia.textContent = dia;
    const intervalo = document.createElement("td");
    const horario = CONFIG.horarios[indice];
    intervalo.textContent = horario
      ? `${formatarHora(horario[0])} – ${formatarHora(horario[1])}`
      : "Fechado";

    linha.append(nomeDia, intervalo);
    tabela.append(linha);
  });
}

function atualizarStatus() {
  const agora = new Date();
  const horario = CONFIG.horarios[agora.getDay()];
  const horaAtual = agora.getHours() + agora.getMinutes() / 60;
  const status = document.getElementById("openStatus");
  const aberto = Boolean(horario && horaAtual >= horario[0] && horaAtual < horario[1]);

  status.classList.toggle("is-open", aberto);
  status.classList.toggle("is-closed", !aberto);
  status.textContent = aberto
    ? `Aberto agora · fechamos às ${formatarHora(horario[1])}`
    : "Fechado agora · confira nossos horários de exemplo abaixo";
}

renderizarHorarios();
atualizarStatus();
window.setInterval(atualizarStatus, 60_000);

/* WhatsApp opcional; se não houver número configurado, os botões ligam para o telefone. */
const telefoneComDDI = CONFIG.telefone.replace(/\D/g, "");
const whatsapp = CONFIG.whatsapp.replace(/\D/g, "");
const destinoContato = whatsapp
  ? `https://wa.me/${whatsapp}?text=${encodeURIComponent(CONFIG.mensagem)}`
  : `tel:+${telefoneComDDI}`;
const contatos = [
  { id: "heroContact", rotuloWhatsApp: "Chame a gente", rotuloTelefone: "Ligar para a sorveteria" },
  { id: "contactAction", rotuloWhatsApp: "Falar pelo WhatsApp", rotuloTelefone: "Ligar para a sorveteria" },
  { id: "ctaWhatsApp", rotuloWhatsApp: "Falar pelo WhatsApp", rotuloTelefone: "Ligar para a sorveteria" },
  { id: "floatingContact", rotuloWhatsApp: "Abrir conversa no WhatsApp", rotuloTelefone: "Ligar para a Della Panna" }
];

contatos.forEach(({ id, rotuloWhatsApp, rotuloTelefone }) => {
  const link = document.getElementById(id);
  link.href = destinoContato;
  if (whatsapp) {
    link.target = "_blank";
    link.rel = "noopener noreferrer";
    link.setAttribute("aria-label", rotuloWhatsApp);
  } else {
    link.removeAttribute("target");
    link.setAttribute("aria-label", rotuloTelefone);
    if (id !== "floatingContact") link.firstChild.textContent = rotuloTelefone;
  }
});

const instagramLink = document.getElementById("instagramLink");
const instagramNote = document.getElementById("instagramNote");
if (CONFIG.instagram) {
  instagramLink.href = CONFIG.instagram;
  document.getElementById("footerInstagram").href = CONFIG.instagram;
  instagramNote.hidden = true;
} else {
  instagramLink.hidden = true;
  document.getElementById("footerInstagram").hidden = true;
}

document.getElementById("phoneLink").href = `tel:+${telefoneComDDI}`;
document.getElementById("currentYear").textContent = String(new Date().getFullYear());

/* Aparência do cabeçalho, link ativo e botão voltar ao topo conforme a rolagem. */
const siteHeader = document.querySelector(".site-header");
const backToTop = document.getElementById("backToTop");

function atualizarRolagem() {
  const passouNoTopo = window.scrollY > 24;
  siteHeader.classList.toggle("is-scrolled", passouNoTopo);
  backToTop.classList.toggle("is-visible", window.scrollY > 400);
}

window.addEventListener("scroll", atualizarRolagem, { passive: true });
atualizarRolagem();

backToTop.addEventListener("click", () => {
  window.scrollTo({ top: 0, behavior: "smooth" });
});

const secoesObservaveis = ["sobre", "sabores", "galeria", "contato"]
  .map((id) => document.getElementById(id))
  .filter(Boolean);
const linksMenu = [...document.querySelectorAll(".nav-links [data-section]")];

function marcarSecaoAtiva(idAtivo) {
  linksMenu.forEach((link) => {
    const ativo = link.dataset.section === idAtivo;
    link.classList.toggle("is-active", ativo);
    if (ativo) link.setAttribute("aria-current", "page");
    else link.removeAttribute("aria-current");
  });
}

if ("IntersectionObserver" in window) {
  const observadorSecoes = new IntersectionObserver((entradas) => {
    const visiveis = entradas
      .filter((entrada) => entrada.isIntersecting)
      .sort((a, b) => b.intersectionRatio - a.intersectionRatio);
    if (visiveis.length) marcarSecaoAtiva(visiveis[0].target.id);
  }, { rootMargin: "-20% 0px -55%", threshold: [0.05, 0.25, 0.5] });

  secoesObservaveis.forEach((secao) => observadorSecoes.observe(secao));
}

/* Adia o carregamento do mapa de terceiros até a seção se aproximar da tela. */
const mapa = document.querySelector(".map-card iframe");
function carregarMapa() {
  if (!mapa.dataset.src) return;
  mapa.src = mapa.dataset.src;
  delete mapa.dataset.src;
}

if ("IntersectionObserver" in window) {
  const observadorMapa = new IntersectionObserver((entradas, observador) => {
    if (entradas.some((entrada) => entrada.isIntersecting)) {
      carregarMapa();
      observador.disconnect();
    }
  }, { rootMargin: "400px 0px" });
  observadorMapa.observe(mapa);
} else {
  carregarMapa();
}

/* Animações de entrada respeitando a preferência de movimento reduzido. */
const elementosReveal = document.querySelectorAll(".reveal");
const prefereMovimentoReduzido = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

if (!prefereMovimentoReduzido && "IntersectionObserver" in window) {
  const observadorReveal = new IntersectionObserver((entradas, observador) => {
    entradas.forEach((entrada) => {
      if (entrada.isIntersecting) {
        entrada.target.classList.add("is-visible");
        observador.unobserve(entrada.target);
      }
    });
  }, { threshold: 0.12, rootMargin: "0px 0px -40px" });

  elementosReveal.forEach((elemento) => observadorReveal.observe(elemento));
} else {
  elementosReveal.forEach((elemento) => elemento.classList.add("is-visible"));
}
