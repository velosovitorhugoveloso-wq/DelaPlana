# Cria o projeto "Betim Digital - Della Panna" e abre no Visual Studio Code.
# Uso (PowerShell):  powershell -ExecutionPolicy Bypass -File .\criar_site.ps1
$ErrorActionPreference = "Stop"
$pasta = Join-Path ([Environment]::GetFolderPath("Desktop")) "betim-digital-della-panna"
New-Item -ItemType Directory -Force -Path $pasta | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $pasta "img") | Out-Null
$utf8 = New-Object System.Text.UTF8Encoding($false)

function Salvar($nome, $conteudo) {
  [System.IO.File]::WriteAllText((Join-Path $pasta $nome), $conteudo, $utf8)
  Write-Host "Criado: $nome"
}

Salvar "index.html" @'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Della Panna – Sorveteria Artesanal | Centro de Betim</title>
  <meta name="description" content="Sorveteria artesanal no centro de Betim – MG. Veja sabores, horário, endereço e fale pelo WhatsApp.">
  <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="topo">
  <a href="#inicio" class="logo">🍦 Della Panna</a>
  <button id="btnMenu" class="btn-menu" aria-label="Abrir menu" aria-expanded="false">☰</button>
  <nav id="menu" class="menu">
    <a href="#sobre">Sobre</a>
    <a href="#sabores">Sabores</a>
    <a href="#galeria">Galeria</a>
    <a href="#contato">Contato</a>
  </nav>
</header>

<main>
  <section id="inicio" class="hero">
    <div class="hero-conteudo">
      <p class="selo">Sorveteria Artesanal · Centro de Betim</p>
      <h1>O sabor artesanal que adoça o centro de Betim</h1>
      <p>Venha conhecer a Della Panna e escolha o seu sabor favorito.</p>
      <div class="hero-botoes">
        <a class="btn" id="btnWhatsHero" href="#contato">Falar no WhatsApp</a>
        <a class="btn btn-claro" href="#sabores">Ver sabores</a>
      </div>
      <p id="statusAberto" class="status"></p>
    </div>
  </section>

  <section id="sobre" class="secao">
    <h2>Sobre a Della Panna</h2>
    <div class="grid-2">
      <div>
        <p>A Della Panna é uma sorveteria artesanal localizada no coração de Betim, na Av. Nossa Senhora do Carmo. É conhecida pelos clientes pelo bom atendimento e pela qualidade dos sorvetes, com nota <strong>4,7</strong> em mais de <strong>740 avaliações</strong> no Google.</p>
        <p class="aviso">✏️ Texto de apresentação: complete com a história e os diferenciais contados pelo proprietário.</p>
      </div>
      <ul class="cards-mini">
        <li><span>🍨</span> Produção artesanal</li>
        <li><span>📍</span> Localização central</li>
        <li><span>⭐</span> Muito bem avaliada</li>
      </ul>
    </div>
  </section>

  <section id="sabores" class="secao alt">
    <h2>Nossos sabores</h2>
    <p class="sub">Toque em uma categoria para filtrar.</p>
    <div class="filtros" id="filtros"></div>
    <div class="grid-cards" id="listaProdutos"></div>
    <p class="aviso">✏️ Os itens acima são exemplos: edite a lista <code>PRODUTOS</code> no arquivo <code>script.js</code> com os produtos reais.</p>
  </section>

  <section id="galeria" class="secao">
    <h2>Galeria</h2>
    <div class="galeria" id="galeria-grid"></div>
    <p class="aviso">✏️ Troque os blocos coloridos por fotos reais (pasta <code>img/</code>) editando a lista <code>FOTOS</code> no <code>script.js</code>.</p>
  </section>

  <section id="contato" class="secao alt">
    <h2>Contato e localização</h2>
    <div class="grid-2">
      <div class="info">
        <p><strong>📍 Endereço</strong><br>Av. Nossa Sra. do Carmo, 271 – Centro<br>Betim – MG, CEP 32600-104</p>
        <p><strong>📞 Telefone</strong><br><a id="linkTel" href="tel:+553125720765">(31) 2572-0765</a></p>
        <p><strong>🕒 Horário</strong></p>
        <table class="horarios" id="tabelaHorarios"></table>
        <div class="hero-botoes">
          <a class="btn" id="btnWhats" href="#">Chamar no WhatsApp</a>
          <a class="btn btn-claro" id="linkInsta" href="#" target="_blank" rel="noopener">Instagram</a>
        </div>
      </div>
      <div class="mapa">
        <iframe title="Mapa da Della Panna" loading="lazy"
          src="https://www.google.com/maps?q=Av.+Nossa+Sra.+do+Carmo,+271,+Centro,+Betim+-+MG&output=embed"></iframe>
      </div>
    </div>
  </section>
</main>

<footer class="rodape">
  <p>© <span id="ano"></span> Della Panna – Sorveteria Artesanal · Betim – MG</p>
  <p class="peq">Projeto escolar “Betim Digital” – proposta de site, sem vínculo oficial com o estabelecimento.</p>
</footer>

<a id="flutuante" class="flutuante" href="#contato" aria-label="WhatsApp">💬</a>

<div id="lightbox" class="lightbox" hidden><span id="lbConteudo"></span></div>

<script src="script.js"></script>
</body>
</html>
'@

Salvar "style.css" @'
:root{
  --rosa:#e0457b; --rosa-esc:#b82f60; --creme:#fff7ee; --choc:#4a2c2a; --menta:#7fd1b9; --texto:#3b2b2a;
}
*{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth;scroll-padding-top:70px}
body{font-family:'Segoe UI',Roboto,Arial,sans-serif;color:var(--texto);background:#fff;line-height:1.6}
a{color:inherit}
code{background:#f3e6da;padding:1px 6px;border-radius:4px;font-size:.9em}

/* Topo */
.topo{position:fixed;top:0;left:0;right:0;z-index:50;background:var(--choc);color:#fff;
  display:flex;align-items:center;justify-content:space-between;padding:12px 20px}
.logo{font-weight:700;font-size:1.25rem;text-decoration:none}
.btn-menu{background:none;border:0;color:#fff;font-size:1.6rem;cursor:pointer;display:none}
.menu{display:flex;gap:22px}
.menu a{text-decoration:none;font-weight:500;padding:4px 0;border-bottom:2px solid transparent}
.menu a:hover{border-color:var(--menta)}

/* Hero */
.hero{min-height:100vh;display:flex;align-items:center;padding:100px 20px 60px;
  background:linear-gradient(135deg,#ffd6e5 0%,#fff0d9 55%,#d5f3ea 100%)}
.hero-conteudo{max-width:700px;margin:0 auto;text-align:center}
.selo{display:inline-block;background:var(--choc);color:#fff;padding:4px 14px;border-radius:20px;font-size:.85rem;margin-bottom:16px}
.hero h1{font-size:clamp(2rem,6vw,3.4rem);line-height:1.15;color:var(--choc);margin-bottom:14px}
.hero-botoes{display:flex;gap:12px;flex-wrap:wrap;margin:22px 0 10px}
.hero .hero-botoes{justify-content:center}
.btn{display:inline-block;background:var(--rosa);color:#fff;padding:12px 24px;border-radius:30px;text-decoration:none;font-weight:600;transition:.2s}
.btn:hover{background:var(--rosa-esc);transform:translateY(-2px)}
.btn-claro{background:#fff;color:var(--rosa-esc);border:2px solid var(--rosa)}
.btn-claro:hover{background:var(--rosa);color:#fff}
.status{font-weight:600;margin-top:10px}
.aberto{color:#1c8a5e}.fechado{color:#b3261e}

/* Seções */
.secao{padding:70px 20px;max-width:1000px;margin:0 auto}
.secao.alt{max-width:none;background:var(--creme)}
.secao.alt>*{max-width:1000px;margin-left:auto;margin-right:auto}
h2{font-size:2rem;color:var(--choc);margin-bottom:18px;position:relative}
h2::after{content:"";display:block;width:60px;height:4px;background:var(--rosa);border-radius:4px;margin-top:6px}
.sub{margin-bottom:14px}
.grid-2{display:grid;grid-template-columns:1fr 1fr;gap:30px;align-items:start}
.cards-mini{list-style:none;display:grid;gap:12px}
.cards-mini li{background:var(--creme);border-radius:14px;padding:16px;font-weight:600;display:flex;gap:12px;align-items:center}
.cards-mini span{font-size:1.6rem}
.aviso{margin-top:14px;font-size:.85rem;background:#fff6c9;border-left:4px solid #e6b800;padding:8px 12px;border-radius:6px}

/* Sabores */
.filtros{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:20px}
.filtro{border:2px solid var(--rosa);background:#fff;color:var(--rosa-esc);padding:6px 16px;border-radius:20px;cursor:pointer;font-weight:600}
.filtro.ativo{background:var(--rosa);color:#fff}
.grid-cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(210px,1fr));gap:16px}
.card{background:#fff;border-radius:16px;padding:20px;box-shadow:0 4px 14px rgba(0,0,0,.08);text-align:center}
.card .emoji{font-size:2.6rem}
.card h3{margin:8px 0 4px;color:var(--choc)}
.card small{color:#7a6560}

/* Galeria */
.galeria{display:grid;grid-template-columns:repeat(auto-fill,minmax(180px,1fr));gap:12px}
.foto{aspect-ratio:1;border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:3rem;cursor:pointer;overflow:hidden;transition:.2s}
.foto:hover{transform:scale(1.04)}
.foto img{width:100%;height:100%;object-fit:cover}

/* Contato */
.info p{margin-bottom:14px}
.horarios{border-collapse:collapse;width:100%;max-width:340px}
.horarios td{padding:5px 8px;border-bottom:1px solid #ecd9c6}
.horarios tr.hoje{background:#ffe3ee;font-weight:700}
.mapa iframe{width:100%;height:340px;border:0;border-radius:16px}

/* Rodapé */
.rodape{background:var(--choc);color:#fff;text-align:center;padding:26px 20px}
.peq{font-size:.8rem;opacity:.7;margin-top:4px}
.flutuante{position:fixed;right:18px;bottom:18px;width:56px;height:56px;border-radius:50%;background:#25d366;
  display:flex;align-items:center;justify-content:center;font-size:1.7rem;text-decoration:none;box-shadow:0 4px 12px rgba(0,0,0,.3);z-index:40}

/* Lightbox */
.lightbox{position:fixed;inset:0;background:rgba(0,0,0,.85);display:flex;align-items:center;justify-content:center;z-index:100;cursor:pointer}
.lightbox[hidden]{display:none}
.lightbox span{font-size:10rem;max-width:90vw}
.lightbox img{max-width:90vw;max-height:85vh;border-radius:10px}

/* Responsivo */
@media(max-width:760px){
  .btn-menu{display:block}
  .menu{display:none;position:absolute;top:100%;left:0;right:0;background:var(--choc);flex-direction:column;gap:0;padding:8px 20px 14px}
  .menu.aberto{display:flex}
  .menu a{padding:12px 0}
  .grid-2{grid-template-columns:1fr}
  .secao{padding:50px 16px}
}
'@

Salvar "script.js" @'
/* ====== CONFIGURAÇÃO: edite aqui com os dados reais ====== */
const CONFIG = {
  // Número de WhatsApp com DDI+DDD, só dígitos. Ex.: "5531999999999". Vazio = botão liga para o telefone fixo.
  whatsapp: "",
  telefone: "553125720765",
  instagram: "",   // Ex.: "https://www.instagram.com/usuario"
  mensagem: "Olá! Vi o site da Della Panna e gostaria de mais informações.",
  // Horário (0 = domingo ... 6 = sábado). [abre, fecha] em horas, ou null = fechado.
  // ATENÇÃO: horários de exemplo – confirmar com o estabelecimento.
  horarios: {
    0: [13, 21], 1: [12, 21], 2: [12, 21], 3: [12, 21], 4: [12, 21], 5: [12, 22], 6: [12, 22]
  }
};

const PRODUTOS = [ // exemplos – substituir pelos reais
  { nome: "Chocolate",        cat: "Sorvetes", emoji: "🍫", desc: "Cremoso e intenso" },
  { nome: "Morango",          cat: "Sorvetes", emoji: "🍓", desc: "Com pedaços da fruta" },
  { nome: "Doce de leite",    cat: "Sorvetes", emoji: "🍯", desc: "Clássico mineiro" },
  { nome: "Limão",            cat: "Frutas",   emoji: "🍋", desc: "Refrescante" },
  { nome: "Maracujá",         cat: "Frutas",   emoji: "🥭", desc: "Azedinho na medida" },
  { nome: "Casquinha",        cat: "Extras",   emoji: "🍦", desc: "Crocante" },
  { nome: "Copinho com calda",cat: "Extras",   emoji: "🍨", desc: "Monte do seu jeito" },
  { nome: "Milk-shake",       cat: "Extras",   emoji: "🥤", desc: "Gelado e cremoso" }
];

const FOTOS = [ // para usar foto real: { img: "img/foto1.jpg", alt: "Descrição" }
  { emoji: "🍦", cor: "#ffd6e5" }, { emoji: "🍨", cor: "#d5f3ea" }, { emoji: "🍓", cor: "#ffe0c2" },
  { emoji: "🍫", cor: "#e8d3c5" }, { emoji: "🥤", cor: "#e2dcff" }, { emoji: "🏪", cor: "#fff0b8" }
];

/* ====== MENU MOBILE ====== */
const menu = document.getElementById("menu");
const btnMenu = document.getElementById("btnMenu");
btnMenu.addEventListener("click", () => {
  const aberto = menu.classList.toggle("aberto");
  btnMenu.setAttribute("aria-expanded", aberto);
});
menu.querySelectorAll("a").forEach(a => a.addEventListener("click", () => menu.classList.remove("aberto")));

/* ====== PRODUTOS + FILTRO ====== */
const filtros = document.getElementById("filtros");
const lista = document.getElementById("listaProdutos");
const categorias = ["Todos", ...new Set(PRODUTOS.map(p => p.cat))];

function mostrar(cat) {
  lista.innerHTML = "";
  PRODUTOS.filter(p => cat === "Todos" || p.cat === cat).forEach(p => {
    const el = document.createElement("div");
    el.className = "card";
    el.innerHTML = `<div class="emoji">${p.emoji}</div><h3>${p.nome}</h3><small>${p.desc}</small>`;
    lista.appendChild(el);
  });
  filtros.querySelectorAll(".filtro").forEach(b => b.classList.toggle("ativo", b.textContent === cat));
}
categorias.forEach(c => {
  const b = document.createElement("button");
  b.className = "filtro"; b.textContent = c;
  b.addEventListener("click", () => mostrar(c));
  filtros.appendChild(b);
});
mostrar("Todos");

/* ====== GALERIA + LIGHTBOX ====== */
const grid = document.getElementById("galeria-grid");
const lb = document.getElementById("lightbox");
const lbConteudo = document.getElementById("lbConteudo");
FOTOS.forEach(f => {
  const d = document.createElement("div");
  d.className = "foto";
  d.style.background = f.cor || "#eee";
  d.innerHTML = f.img ? `<img src="${f.img}" alt="${f.alt || ""}">` : f.emoji;
  d.addEventListener("click", () => {
    lbConteudo.innerHTML = f.img ? `<img src="${f.img}" alt="${f.alt || ""}">` : f.emoji;
    lb.hidden = false;
  });
  grid.appendChild(d);
});
lb.addEventListener("click", () => (lb.hidden = true));
document.addEventListener("keydown", e => { if (e.key === "Escape") lb.hidden = true; });

/* ====== HORÁRIOS ====== */
const dias = ["Domingo","Segunda","Terça","Quarta","Quinta","Sexta","Sábado"];
const fmt = h => String(h).padStart(2, "0") + "h";
const agora = new Date();
const hoje = agora.getDay();
const tabela = document.getElementById("tabelaHorarios");
dias.forEach((nome, i) => {
  const h = CONFIG.horarios[i];
  const tr = document.createElement("tr");
  if (i === hoje) tr.className = "hoje";
  tr.innerHTML = `<td>${nome}</td><td>${h ? fmt(h[0]) + " às " + fmt(h[1]) : "Fechado"}</td>`;
  tabela.appendChild(tr);
});
const hh = CONFIG.horarios[hoje];
const hora = agora.getHours() + agora.getMinutes() / 60;
const status = document.getElementById("statusAberto");
if (hh && hora >= hh[0] && hora < hh[1]) {
  status.textContent = `🟢 Aberto agora · fecha às ${fmt(hh[1])}`;
  status.className = "status aberto";
} else {
  status.textContent = "🔴 Fechado no momento";
  status.className = "status fechado";
}

/* ====== LINKS DE CONTATO ====== */
const linkWhats = CONFIG.whatsapp
  ? `https://wa.me/${CONFIG.whatsapp}?text=${encodeURIComponent(CONFIG.mensagem)}`
  : `tel:+${CONFIG.telefone}`;
["btnWhats", "btnWhatsHero", "flutuante"].forEach(id => {
  const el = document.getElementById(id);
  el.href = linkWhats;
  if (CONFIG.whatsapp) el.target = "_blank";
});
const insta = document.getElementById("linkInsta");
if (CONFIG.instagram) insta.href = CONFIG.instagram; else insta.style.display = "none";

document.getElementById("ano").textContent = agora.getFullYear();
'@

Salvar "pesquisa_e_planejamento.md" @'
# Betim Digital – Pesquisa e Planejamento

## 1. Estabelecimento escolhido
**Della Panna – Sorveteria Artesanal**

## 2. Pesquisa
| Item | Informação | Status |
|---|---|---|
| Endereço | Av. Nossa Sra. do Carmo, 271 – Centro, Betim – MG, CEP 32600-104 | Encontrado em listagem pública |
| Telefone | (31) 2572-0765 | Encontrado em listagem pública |
| Avaliação | 4,7 (mais de 740 avaliações no Google) | Encontrado |
| Site próprio | Não encontrado em listas/mapas | **Confirmar no Google antes de entregar** |
| WhatsApp | – | A confirmar com o proprietário |
| Horário | – | A confirmar (o do site é exemplo) |
| Redes sociais | – | A confirmar |
| Produtos/sabores | – | A confirmar (os do site são exemplos) |
| Público-alvo | Famílias, jovens e quem circula pelo centro | Hipótese |
| Diferenciais | Produção artesanal, localização central, boa avaliação | Parcial |

## 3. Levantamento das necessidades
- **Problema:** o cliente só encontra o básico em listas; falta cardápio, horário e contato num lugar só.
- **Informações essenciais:** sabores, horário, endereço/mapa, WhatsApp.
- **Novos clientes:** aparecer no Google, mostrar fotos, facilitar o contato em um toque.
- **Recursos:** filtro de sabores, "aberto agora", botão de WhatsApp, mapa.
- **Perguntas para o dono:** quais sabores fixos? faz encomenda/festa? tem delivery? qual WhatsApp e Instagram?

## 4. Planejamento
- **Estrutura:** página única com seções Início, Sobre, Sabores, Galeria e Contato.
- **Menu:** fixo no topo; vira botão ☰ no celular.
- **Cores:** rosa #e0457b (sorvete), chocolate #4a2c2a, creme #fff7ee, menta #7fd1b9.
- **Tipografia:** Segoe UI / Roboto / Arial (sem fonte externa, carrega rápido).
- **Imagens:** fotos reais do estabelecimento (com autorização) na galeria.
- **Organização:** do mais importante (apresentação) ao contato.
- **Funcionalidades (JavaScript):** menu mobile, filtro de produtos, galeria com ampliação, status aberto/fechado, botão de WhatsApp.

## 5. Tecnologias
HTML + CSS + JavaScript puro.

## 6. Roteiro da apresentação
1. Qual estabelecimento escolhi e por quê.
2. O que descobri na pesquisa.
3. Qual problema o site resolve.
4. Como desenvolvi (estrutura → estilo → interatividade).
5. Tecnologias usadas.
6. Como o site beneficia a sorveteria.
'@

Write-Host ""
Write-Host "Projeto criado em: $pasta"

if (Get-Command code -ErrorAction SilentlyContinue) {
  code $pasta (Join-Path $pasta "index.html")
} else {
  Write-Host "VS Code nao encontrado no PATH. Abra a pasta manualmente."
  Start-Process explorer.exe $pasta
}
