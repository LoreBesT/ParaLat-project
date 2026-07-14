import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termini e condizioni d\'uso'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Parte 1.0: Il progetto ParaLat',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
              ),
              Text(
                  'Il progetto ParaLat è stato creato, ideato e realizzato da Lorenzo Della Bona. Tutti i diritti sono riservati su ogni aspetto dell’applicazione e dei servizi offerti. Sono inclusi: loghi, nomi, icone, contenuti multimediali(anche caricati dagli utenti) ed ogni altro aspetto esclusivo dell’applicazione non esplicitamente indicato. Il progetto è a scopo di lucro. Al momento della stesura di tali termini, aggiornati al giorno 11/09/2024, ParaLat App non ha alcuna forma di guadagno attiva, né alcuna spesa da sostenere. In futuro ci si riserva il diritto di inserire pubblicità, inserire un piano di abbonamento Premium, limitare le funzionalità disponibili ad un utente. Non è ammesso, né accettata alcuna forma di vendita dei dati personali degli utenti per fini di lucro. I dati raccolti, necessari per il corretto funzionamento dell’app, rimarranno sempre nei server di ParaLat e non saranno mai ceduti o venduti a terzi(n.d.r. per ulteriori informazioni sul trattamento dei lati leggi il paragrafo dedicato).'),
              Text(
                'Parte 1.1: Proprietà intellettuale ParaLat App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'ParaLat App è un progetto ideato e realizzato da Lorenzo Della Bona. Tutti i diritti sono pertanto riservati ed esclusivi del creatore. Ogni rivendicazione di proprietà, anche parziale, del progetto ParaLat App è illegittima e priva di alcun valore legale. Ogni contenuto multimediale presente e/o caricato sull’app è di proprietà esclusiva di ParaLat. Il caricamento di versioni e/o altri contenti sul sito conferisce a ParaLat la proprietà esclusiva di queste ultime, conferendo a ParaLat i diritti di leggerle, modificarle, revisionarle. L’utente conserva il diritto di poter chiedere la rimozione di un contenuto da lui caricato in qualsiasi momento. La rimozione avverrà entro un massimo di 72h.'),
              Text(
                'Parte 1.2: Condizioni d\'uso ParaLat App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'Come specificato nel comma precedente il progetto ParaLat, nella sua interezza, è a scopo di lucro. Pertanto potrebbero essere disponibili nell\'app delle inserzioni pubblicitarie o delle funzionalità disponibili solo attraverso pagamento. L\'utente di ParaLat App può usare liberamente le funzionalità gratuite dell\'app. Per le funzionalità a pagamento è invece previsto un pagamaneto/abbonamento strettamente personale e non condivisibile con altri dispositivi od altri utenti. E\' assolutamente proibita qualsiasi forma di reverse engineering volta ad ottenere delle copie pirata dell\'app. Le copie ufficiali dell\'app sono distribuite solo attraverso: AppStore, Playstore, Microsoft Store, Sito ufficiale del progetto. E\' altresì proibita ogni forma di uso di ParaLat app in forma piratata. E\' assolutamente proibito ed illegittimo: la manomissione dei server di ParaLat app, l\'invio di software dannosi sulla mail del progetto, il caricamento di foto non inerenti tematiche esclusivamente scolastiche, attacchi Ddos, tentativi di SQL injection o qualsiasi altra forma di manomissione. In caso di violazioni oltre al ban perenne dall\'app si rischia una denuncia alle autorità competenti ed una relativa pena in base a quanto stabilito dalla legge. Si ricorda infine di rispettare la community nel caricamento di contenuti multimediali nel servizio ‘Archivio Versioni’. Il caricamento di contenuti non inerenti, volti a danneggiare l’utente o volti a danneggiare ParaLat stessa comportano il PermaBan del tuo account e, se necessario, la segnalazione alle autorità di legittima competenza.'),
              Text(
                'Parte 1.3: Servizi Offerti',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'Il progetto ParaLat offre ed è concentrato su 2 funzionalità principali. ParaLat AI, un servizio di generazione di analisi logica per testi esclusivamente in lingua latina. Il servizio in questione si affida ad una AI di terzi non sviluppata internamente. Il trattamento dei dati è pertanto differente e non dipendente da ParaLat. Si invita per ulteriori informazioni sul trattamento dei dati a fare riferimento alla documentazione di Google. Il secondo servizio offerto all’utente è Archivio Versioni. Questo è un hub di sharing per le analisi logiche di versioni latine. L’utente può cercare versioni o caricarle. Ogni azione è da svolgere sempre e solo coerentemente con quanto messo a disposizione dell’utente stesso. E’ proibita ogni forma di accesso ai File o ad informazioni non sfruttando i canali ufficiali di ParaLat. '),
              Text(
                'Parte 1.4: Privacy e trattamento dei dati',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'ParaLat app ha accesso ad alcuni tuoi dati personali(elencati seguentemete). Questi dati rimarranno sempre ed esclusivamente sui server ParaLat o sulle piattaforme di hosting a cui il progetto si appoggia. I dati a cui ParaLat app ha accesso sono: Nome Utente, indirizzo email, ID account, Ultimo Sign In, Data della crezione dell\'account, lingua e regione impostati sul telefono, numero di processori presenti sul telefono. In futuro a questi potrebbero essere aggiunti per necessità degli altri dati. Non c\'è bisogno di preoccuparsi sarai sempre debitamente e tempestivamente informato in caso di modifiche ai termini di servizio e , più nello specifico, ai tuoi dati su cui abbiamo accesso.'),
              Text(
                'Parte 1.5: A cosa servono questi dati',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'I dati a cui ha accesso ParaLat app sono strettamente necessarie al corretto funzionamento dell\'app. Nello specifico email ed ID utente hanno lo scopo di contribuire alla targettizzazione dell\'utente con personalizzazione della GUI dell\'app. Ultimo sign in e data creazione account servono per monitorare eventuali problemi di sicurezza relativi al tuo account. Questi ultimi due dati hanno anche un fine statistico utile per contribuire a sviluppare il progetto ParaLat. Infine età e sesso saranno dei dati probabilmente richiesti in futuro; il primo al fine di garantire che l\'utente ha l\'età minima per l\'uso dei servizi digitali(in base a quanto previsto dalla legge). Il secondo ha il fine di esser utile alla personalizzazione dell\'interfaccia utente(banalmente se rivolgersi all\'utente al maschile o femminile). I dati quali numero processori e lingua e regione impostati sul telefono sono raccolti da noi solo in casa di una tua segnalazione nell\'app attraverso l\'apposito form. Queste informazioni ci sono utili per meglio localizzare e comprendere il tuo problema, aiutandoti il prima possibile a risolverlo.'),
              Text(
                'Parte 1.6: Algoritmo Reputazione e sanzioni',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              Text(
                  'In merito all\'algoritmo di gestione della reputazione e delle sanzioni ai collaboratori del progetto ne sarà spiegato in questo paragrafo il funzionamento per trasparenza. L\'algoritmo valuta ogni membro di Primo livello in base ad i seguenti parametri: ultimo sign in, data creazione account, celle vuote lasciate nella propria analisi, qualità analisi di 3 parole campione della propria parte, assiduità svolgimento ed analisi versioni.\nL\'algoritmo assegnarà dei richiami debitamente motivati nella sezione sanzioni. I richiami saranno di due tipi: qualitativi e quantitativi. I richiami qualitativi hanno peso inferiore e riguardano strettamente la qualità dell versioni svolte. I richiami quantitativi hanno invece un peso elevato e riguardo il mancato svolgimento di una versione in parte o nella totalità. Si possono accumulare fino a massimo: 3 richiami qualitativi o 1 richiamo quantitativo. In caso di superamento di queste soglie è prevista una sanzione. L\'algoritmo toglierà la parte di versione a colui/colei che ha il punteggio di reputazione più elevato e la assegnerà a colui/colei che ha superato i limiti di richiami. I richiami e l\'indice di valutazione si resetteranno dopo 2 mesi. In caso entro 2 mesi si verificasse una seconda condizione di inadempienza quantitativa con una precedente sanzione già riscattata, è prevista l\'espulsione dal gruppo. E\' altresì prevista l\'espulsione in tronco dal gruppo nel caso in cui si divulghi qualsiasi tipologia di contenuto, senza un esplicito consenso, all\'esterno del gruppo. E\' doveroso specificare infine che al momento tale algoritmo è ancora in versione beta. Pertanto al fine di evitare errori di valutazione al momento sarà lo sviluppatore ad assegnare le sanzioni secondo quanto stabilto ed indicato precedentemente.'),
              Text(
                'Parte 2: ParaLat Premium',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              Text('ParaLat Premium è il servizio a pagamento di ParaLat App. Tale servizio è da considerarsi un\'estensione del servizio gratuito garantente un\'esperienza più completa. L\'abbonamento può essere sia mensile al prezzo di 2,99€ al mese che annuale al prezzo di 24,96€ l\'anno. L\'abbonamento annuale è suggerito poichè maggiormente conveniente con un sconto del 30,43%. I prezzi dell\'abbonamento sono rivedibili in ogni circostanza sia con incrementi che con decrementi dei prezzi. L\'utente finale sarà debitamente informato prima del successivo rinnovo dell\'abbonamento. Il pagamento sarà da effettuarsi solo ed esclusivamente attraverso i metodi supportati e per mezzo dei canali ufficiali. Allo stato attuali sono accettati solo pagamenti tramite Google Play ed Apple Pay. Per ulteriori informazioni su tali servizi recarsi sui relativi siti e trovare la voce condizioni di licenza.'),
              Text(
                'Parte 2.1: Vantaggi ParaLat Premium',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              Text('ParaLat Premium allo stato attuale garantisce i vantaggi successivamente elencati. Questi sono rivedibili e modificabili in qualsiasi condizioni. L\'utente sarà debitamente avvisato prima di ogni modifica al servizio.\nVantaggi:\nAccesso al servizio \'Archivio Versioni\':\nServizio di accesso a molteplici versioni già analizzate e revisionate da esperti(ndr Vedi 2.3).\nDownload Versioni:\nPossibilità di scaricare le versioni analizzate da Archivio Versioni(ndr Vedi 2.3)\nModelli Pro ParaLat AI:\nAccesso ai modelli più potenti e performanti di ParaLat AI. Essendo ParaLat AI basato su Gemini i modelli avanzati avranno come base la versioni più potente e recente di Gemini(ndr Vedi 2.5).\nBadge Unlimited:\nAccesso illimitato al servizio ParaLat Cards(ndr Vedi 2.4) senza alcun vincolo e limite\nNiente inserzioni:\nNon vedrai mai alcun tipo di inserzione in app(ndr Vedi 2.6).\nAccesso al canale Discord esclusivo:(ndr Vedi 2.7)\nBadge sul profilo:(ndr Vedi 2.8)'),
              // Text(
              //   'Parte 2.3: Condizioni e modalità d\'uso Archivio Versioni',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
              //   textAlign: TextAlign.center,
              // ),
              // Text('bla bla bla bla bla bla'),
              // Text(
              //   'Parte 2.4: Condizioni e modalità d\'uso ParaLat Cards',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
              //   textAlign: TextAlign.center,
              // ),
              // Text('bla bla bla'),
              // Text(
              //   'Parte 2.5: Condizioni e modalità d\'uso ParaLat AI',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
              //   textAlign: TextAlign.center,
              // ),
              // Text('bla bla bla'),
              
            
            
            ],
          ),
        ),
      ),
    );
  }
}
