# Della Panna – Sorveteria Artesanal

Site institucional responsivo de página única para uma sorveteria artesanal em Betim – MG.

## Estrutura

- `index.html`: conteúdo semântico, SEO, Open Graph, dados estruturados e seções.
- `style.css`: tema visual, variáveis CSS, tipografia, responsividade e animações.
- `script.js`: dados editáveis, menu, filtros, galeria, horários e interações.
- `img/`: ilustrações locais de exemplo da galeria.
- `favicon.svg`: favicon da aba do navegador.
- `robots.txt` e `sitemap.xml`: orientação de rastreamento e sitemap para mecanismos de busca.

## Dados editáveis

Edite no topo de `script.js`:

- `CONFIG`: WhatsApp, telefone, Instagram, mensagem padrão e horários por dia.
- `PRODUTOS`: sabores, categorias, emojis e descrições.
- `FOTOS`: imagens, texto alternativo e legendas da galeria.

Horários, sabores, depoimentos, perfil do Instagram e imagens são exemplos claramente identificados na página. Use dados reais somente após confirmar com o estabelecimento.

O horário também é refletido no JSON-LD a partir de `CONFIG.horarios`. A programação inicial é exemplo; confirme-a antes de publicar. O sitemap e a referência de sitemap em `robots.txt` usam `example.com` porque o domínio definitivo não foi fornecido: substitua esse domínio antes do deploy.

## Contato

Para usar WhatsApp, informe em `CONFIG.whatsapp` o DDI e DDD, somente números. Exemplo: `5531999999999`. Quando o campo ficar vazio, os botões de WhatsApp usam ligação telefônica para o número configurado em `telefone`.

## Executar

Não requer instalação de dependências ou framework:

```powershell
python -m http.server 8000
```

Acesse `http://localhost:8000`.

## Melhorias desta rodada

- Imagens da galeria carregam sob demanda, usam decodificação assíncrona, dimensões explícitas e efeito blur-up.
- Fontes Google são pré-conectadas/pré-carregadas e usam `display=swap`; não há bibliotecas de interface.
- O diálogo da galeria mantém o foco por teclado, fecha com `Esc` e devolve o foco ao item que abriu a imagem.
- Cada sabor ganhou um link de pedido: abre uma mensagem pré-preenchida no WhatsApp quando configurado; sem WhatsApp, liga para o telefone.
- Preferência de tema escuro segue `prefers-color-scheme`; animações respeitam `prefers-reduced-motion`.
- JSON-LD inclui endereço, telefone e horários. Ajuste os horários de exemplo no `CONFIG` antes da publicação.
- Os arquivos de SEO incluem `sitemap.xml` e `robots.txt`; atualize o domínio de exemplo para o endereço final do site.

## Validação de desempenho

Medição local com Lighthouse (perfil padrão): Performance 69, Acessibilidade 100, Boas práticas 100 e SEO 100. Métricas observadas: FCP 3,4 s, LCP 3,4 s, TBT 480 ms e CLS 0,109. Os resultados podem variar conforme a máquina, rede e servidor. Não foi registrada uma medição Lighthouse anterior a esta rodada, portanto não há nota “antes” confiável para comparação.
