# form-links

Páginas de passagem para os formulários do Fillout, servidas em `form.drheliobarros.com.br` (GitHub Pages).

Cada pasta tem imagem, título e descrição próprios para o card do WhatsApp. A página repassa os parâmetros do link (`?nome=…&tipo=…`, `?codigo=…`) e leva ao formulário. O Fillout só personaliza o card no plano Pro, por isso esta página existe.

| Pasta | Formulário Fillout | Onde o link é usado |
|---|---|---|
| `acompanhamento/` | `uZwKCpZacUus` | `SUITABILITY_FORM_URL` no `.env` do twenty-followup-sync |
| `diagnostico/` | `6GscXdWSVyus` | `ONBOARDING_LINK_QUESTIONARIO` (com `?tipo=primeira`) |
| `pgbl/` | `51aPuW2AN1us` | `PGBL_RENDA_FORM_URL` |
| `nps/` | `aC6EaNd51Xus` | `meeting-day-reminder.js` + `claud.md/execution/nps_reminders.py` |
| `essencial-entrevista/` | `5sgiDf7R2Tus` | `claud.md/execution/essencial_watcher.py` (Msg 1 da venda) |
| `essencial-checkin/` | `6AmTCYAukDus` | envio manual |
| `quiz/` | `vR3RjRe7sQus` | envio manual (bio, DM). Anúncios seguem no link direto do Fillout. |

Ficam de fora, de propósito: o CTA da newsletter (`qyMsDjro6kus`) vive em e-mail, onde não há card, e o `click-audit` do beehiiv procura o domínio do Fillout; o Estudo de Alocação (`jMJQg14vTUus`) vai embutido em iframe na página do estudo.

**Formulário novo:** uma linha `form` no fim de `forms.sh`, `./forms.sh <slug>`, conferir a imagem em `<slug>/card.jpg`, commit e push. Imagens renderizadas com Chrome headless em 1200×630 (o Jekyll ignora `_src/`).
Card em cache no WhatsApp: cada link leva parâmetros diferentes, então a imagem nova aparece no próximo envio.
