# CRF - Centralni registar faktura

Ministarstvo finansija sprovodi mere i aktivnosti u vezi sa **kontrolom preuzetih obaveza u javnom sektoru** što između ostalog podrazumeva evidentiranje, praćenje i izveštavanje o neizmirenim obavezama. Za obavljanje pomenutih aktivnosti uspostavljen je informacioni sistem pod nazivom Centralni registar faktura (CRF).

Uprava za trezor je zadužena za koordinaciju aktivnosti između organizacionih jedinica Ministarstva finansija po pitanju uspostavljanja CRF servisa, za kontrolu razvoja, održavanje kompletnog informacionog sistema i njegov operativni rad.

## Opis servisa
CRF realizuje digitalni servis koji omogućava uvid u sve fakture izdate od strane pravnih lica (PL) (privatni i javni sektor) u kojima su korisnici javnih sredstava (KJS) dužnici.

## Informacije kojima CRF raspolaže
1. pravna lica koja su registrovana u CRF
2. fizička lica koja su ovlašćena za rad u CRF
3. registrovane fakture u CRF
4. izvršena plaćanja u platnom prometu UT
## Šta CRF obezbeđuje
1. izvršavanje procesa [registracije PL](https://crf.trezor.gov.rs/docs/user/register/)
2. izvršavanje procesa [registracije faktura](https://crf.trezor.gov.rs/docs/user/register-invoice/)
3. integraciju platnih naloga u cilju upravljanja statusima faktura kroz [automatsku registraciju plaćanja](https://crf.trezor.gov.rs/docs/user/invoices/settlement/)
4. integritet podataka
5. [preglede](https://crf.trezor.gov.rs/docs/user/invoices/list/) unetih podataka i [izveštavanje](https://crf.trezor.gov.rs/docs/user/reporting/)
## Učesnici
### Pravna lica
#### Poverioci
Poverioci su **pravna lica** (PL) koji pripadaju **privatnom i javnom sektoru**, koji su u **obavezi da registruju fakturu u CRF sistemu** nakon čega mogu da ispostave ispravnu instrukciju za plaćanje dužniku.

#### Dužnici
Dužnici su korisnici javnih sredstava (KJS) **tipa 0,1,2,4,6** koji su **u obavezi da provere da li je faktura koja im je ispostavljena registrovana u CRF sistemu** i da izvrše plaćanje po zadatoj instrukciji, samo ukoliko registracija postoji u CRF.

### Fizička lica
####Lokalni administrator
Lokalni administrator je ovlašćeno lice koje ima pravo pristupa i sva ovlašćenja za rad u CRF za pravno lice koje predstavlja.

#### Lokalni korisnik
Lokalni korisnik je ovlašćeno lice kome lokalni administrator [kreira korisnički nalog](https://crf.trezor.gov.rs/docs/user/user-administration/user-create/) i dodeljuje mu željenu kombinaciju [aplikativnih ovlašćenja](https://crf.trezor.gov.rs/docs/user/user-administration/authorization/) za rad u CRF za PL koje lokalni administrator predstavlja.
