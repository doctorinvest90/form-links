# form-links

Páginas de passagem para os formulários do Fillout, servidas em `form.drheliobarros.com.br` (GitHub Pages).

Cada pasta tem imagem, título e descrição próprios para o card do WhatsApp. A página repassa os parâmetros do link (`?nome=…&tipo=…`, `?codigo=…`) e leva ao formulário. O Fillout só personaliza o card no plano Pro, por isso esta página existe.

| Pasta | Formulário Fillout | Variável no `.env` do twenty-followup-sync |
|---|---|---|
| `acompanhamento/` | `uZwKCpZacUus` | `SUITABILITY_FORM_URL` |
| `diagnostico/` | `6GscXdWSVyus` | `ONBOARDING_LINK_QUESTIONARIO` (com `?tipo=primeira`) |
| `pgbl/` | `51aPuW2AN1us` | `PGBL_RENDA_FORM_URL` |

Imagens: `_src/<nome>.html` + `card.css`, renderizadas com Chrome headless em 1200×630 e convertidas com `sips` (o Jekyll ignora `_src/`).
Card em cache no WhatsApp: cada link leva parâmetros diferentes, então a imagem nova aparece no próximo envio.
