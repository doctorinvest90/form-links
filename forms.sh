#!/bin/bash
# Gera a imagem do card (1200x630) e a página de passagem de cada formulário.
# Fonte da verdade: as linhas `form` no fim. Formulário novo = uma linha nova.
# Uso: ./forms.sh            regera tudo
#      ./forms.sh <slug>     regera só um
# Depois: git add -A && git commit && git push (o GitHub Pages publica em ~1 min).
# Textos sem aspas duplas, sem & e sem travessão (regra da marca). No título, evite ê/ô:
# o circunflexo da Cormorant fica alto e solto em 100px ("mês" parece glitch).
set -euo pipefail
cd "$(dirname "$0")"
CH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
BASE="https://form.drheliobarros.com.br"
ONLY="${1:-}"

# fundo | texto | rótulo e fio | rodapé
theme() { case $1 in
  escuro) echo "radial-gradient(ellipse at 50% 35%,#1B3A5C 0%,#0D1B2A 70%)|#F7F5F0|#C9A84C|#C9A84C";;
  claro)  echo "#F7F5F0|#0D1B2A|#C9A84C|#1B3A5C";;
  ouro)   echo "#C9A84C|#0D1B2A|#0D1B2A|#0D1B2A";;
  azul)   echo "#1B3A5C|#F7F5F0|#C9A84C|#C9A84C";;
  *) echo "tema desconhecido: $1 (escuro|claro|ouro|azul)" >&2; exit 1;;
esac; }

# form <slug> <url fillout> <tema> <rótulo> <título> <subtítulo> <og:title> <og:description> [tamanho do título, px]
form() {
  local slug=$1 url=$2 label=$4 h1=$5 sub=$6 ogt=$7 ogd=$8 size=${9:-112}
  [[ -n "$ONLY" && "$ONLY" != "$slug" ]] && return 0
  local bg ink acc foot
  IFS='|' read -r bg ink acc foot <<<"$(theme "$3")"
  mkdir -p "$slug" _src
  cat > "_src/$slug.html" <<EOF
<!doctype html><html><head><meta charset=utf-8><link rel=stylesheet href=card.css>
<style>body{background:$bg;color:$ink}.label{color:$acc}.rule{background:$acc}.sub{opacity:.85}.foot{color:$foot}h1{font-size:${size}px}</style></head><body>
<div class=label>$label</div><h1>$h1</h1><div class=rule></div><div class=sub>$sub</div>
<div class=foot><b>DOCTOR INVEST</b> &nbsp;·&nbsp; @drheliobarros</div>
</body></html>
EOF
  "$CH" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --allow-file-access-from-files --window-size=1200,630 \
    --screenshot="$PWD/_src/$slug.png" "file://$PWD/_src/$slug.html" >/dev/null 2>&1
  sips -s format jpeg -s formatOptions 88 "_src/$slug.png" --out "$slug/card.jpg" >/dev/null
  rm -f "_src/$slug.png"
  cat > "$slug/index.html" <<EOF
<!doctype html>
<html lang="pt-BR">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex">
<title>$ogt</title>
<meta property="og:type" content="website">
<meta property="og:site_name" content="Doctor Invest">
<meta property="og:title" content="$ogt">
<meta property="og:description" content="$ogd">
<meta property="og:url" content="$BASE/$slug/">
<meta property="og:image" content="$BASE/$slug/card.jpg">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta name="twitter:card" content="summary_large_image">
<script>location.replace("$url" + location.search);</script>
</head>
<body><a href="$url">Abrir o formulário</a></body>
</html>
EOF
  echo "ok $slug -> $BASE/$slug/"
}

# Clientes de gestão
form acompanhamento https://forms.fillout.com/t/uZwKCpZacUus escuro "ACOMPANHAMENTO" "Atualize seu perfil" "5 minutos para manter seu diagnóstico em dia" "Atualize seu perfil de investidor" "Uns 5 minutos para manter seu diagnóstico em dia. Doctor Invest · Hélio Barros"
form diagnostico https://forms.fillout.com/t/6GscXdWSVyus claro "PRIMEIRA REUNIÃO" "Seu diagnóstico financeiro" "A base da nossa primeira conversa" "Seu diagnóstico financeiro" "Responda antes da primeira reunião: é dele que sai a nossa conversa. Doctor Invest · Hélio Barros" 96
form pgbl https://forms.fillout.com/t/51aPuW2AN1us ouro "PGBL 2026" "A conta do seu PGBL" "6 respostas, 2 minutos" "A conta do seu PGBL 2026" "6 respostas rápidas para eu calcular quanto vale aportar em PGBL até 31/12. Doctor Invest · Hélio Barros"
form nps https://forms.fillout.com/t/aC6EaNd51Xus azul "SUA OPINIÃO" "Sua avaliação" "1 minuto, e eu leio cada resposta" "Sua avaliação da Doctor Invest" "Leva 1 minuto e eu leio cada resposta. Doctor Invest · Hélio Barros"

# Essencial
form essencial-entrevista https://forms.fillout.com/t/5sgiDf7R2Tus escuro "DOCTOR INVEST ESSENCIAL" "Sua entrevista de entrada" "15 minutos para eu montar o seu plano" "Entrevista de entrada · Essencial" "15 minutos de respostas para eu montar o seu plano. Doctor Invest · Hélio Barros" 100
form essencial-checkin https://forms.fillout.com/t/6AmTCYAukDus claro "ESSENCIAL · CHECK-IN DO MÊS" "Seu check-in mensal" "Ordens, caixa e aporte em 2 minutos" "Check-in do mês · Essencial" "Ordens, caixa e aporte do mês. 2 minutos para eu ajustar o seu próximo passo. Doctor Invest · Hélio Barros"

# Leads
form quiz https://forms.fillout.com/t/vR3RjRe7sQus escuro "GESTÃO DE PATRIMÔNIO" "6 perguntas sobre sua carteira" "1 minuto para ver se a gestão faz sentido para você" "6 perguntas sobre o seu patrimônio" "1 minuto para ver se a gestão da Doctor Invest faz sentido para você. Hélio Barros" 88
