import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termini e condizioni d\'uso'),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                  'Il progetto ParaLat include al suo interno due sottoprogetti distinti e separati. Il primo ParaLat App realizzato interamente(esclusi dei contenuti multimediali) da Lorenzo Della Bona. Questo progetto ha il fine di creare un\'app per l\'analisi e la lettura di versioni di latino. Il secondo ramo del progetto denominato \'ParaLat on YT\' prevede la gestione di un canale YT e tik tok(potrebbero essere aggiunti altri social) di insegnamento e divulgazione scientifica. I diritti di proprietà intettuale su quest\'ultimo sono di proprietà del 60% di Lorenzo Della Bona e 40% degli altri collaboratori. La percentuale di proprietà intellettuale di quest\'ultimo progetto può essere rivista tra i 4 membri collaboratori purchè non si scenda sotto il 25% a testa. La modifica dei diritti di proprietà di quest\'ultimo progetto deve essere strettamente collegata all\'incremento del numero di contenuti pubblicati ed alla fiducia nel progetto.\nIl progetto ParaLat è un progetto a scopo di lucro. L\'eventuale ricavo/guadagno da parte di uno dei due rami del progetto deve rimanere ed essere reinvestito in quel ramo. Non è tollerata alcuna forma di spostamento di capitali da un ramo all\'altro del progetto. Il pagamento dei collaboratori è previsto o proporzionale solo in caso di disponibilità finanziarie nel ramo in cui si trovano. E\' vietato pagare dei collaboratori di un ramo del progetto con i guadagni di un ramo diverso da quello in cui si trovano. \n*E\' accettato l\'investimento di capitale a beneficio di entrambe le parti del progetto purchè i guadagni siano comunitari ed equi ad entrambe le parti.'),
              Text(
                'Parte 1.1: Proprietà intellettuale ParaLat App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'ParaLat App è un progetto ideato e realizzato da Lorenzo Della Bona. Tutti i diritti sono pertanto riservati ed esclusivi del creatore. Ogni rivendicazione di proprietà, anche parziale, del progetto ParaLat App è illegittima e priva di alcun valore legale. A completezza di quanto specificato precedentemente è previsto che il suddetto progetto comprenda dei collaborati non contribuenti allo sviluppo dell\'app bensì ad alcuni contenuti offerti. Tali avranno garantito, e potranno reclamare in caso di violazione, il diritto di proprietà intellettuale sui contenuti realizzati. Potranno altresì chiederne la rimozione dall\'app entro 7 giorni dalla pubblicazione di questi ultimi, previa motivazione valida. Qualora il ramo in cui si trovano tali contenuti multimediali dovesse riscuotere successo i collaboratori riceveranno un apposito compenso. Il numero di collaboratori è rivedibile a pura discrezione di Lorenzo Della Bona. Quest\'ultimo si riserva il diritto di selezionare i migliori collaboratori ai fini di una buona riuscita del progetto od a espellere gli inadempienti e le risorse umane non strettamente necessarie.'),
              Text(
                'Parte 1.2: Condizioni d\'uso ParaLat App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'Come specificato nel comma precedente il progetto ParaLat, nella sua interezza, è a scopo di lucro. Pertanto potrebbero essere disponibili nell\'app delle inserzioni pubblicitarie o delle funzionalità disponibili solo attraverso pagamento. L\'utente di ParaLat App può usare liberamente le funzionalità gratuite dell\'app.Per le funzionalità a pagamento è invece previsto un pagamaneto/abbonamento strettamente personale e non condivisibile con altri dispositivi. E\' assolutamente proibita qualsiasi forma di reverse engineering volta ad ottenere delle copie pirata dell\'app. Le copie ufficiali dell\'app sono distribuite solo attraverso: AppStore, Playstore, Microsoft Store, Sito ufficiale del progetto. E\' altresì proibita ogni forma di uso di ParaLat app in forma piratata. E\' assolutamente proibito ed illegittimo: la manomissione dei server di ParaLat app, l\'invio di software dannosi sulla mail del progetto, il caricamento di foto non inerenti tematiche esclusivamente scolastiche, attacchi Ddos, tentativi di SQL injection o qualsiasi altra forma di manomissione. In caso di violazioni oltre al ban perenne dall\'app si rischia una denuncia alle autorità competenti ed una relativa pena in base a quanto stabilito dalla legge.'),
              Text(
                'Parte 1.3: Servizi Offerti',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'Il progetto ParaLat è strutturato su 3 diversi livelli di accesso e responsabilità. Il livello più alto è accessibile solo ed esclusivamente ai collaboratori ed include tutte le funzionalità dei livelli inferiori a cui si aggiungono: Scadenze, Reputazione, Sanzione, Chat, FotoBook. Il secondo livello è destinato a tutti gli utenti che si registreranno con email e password(o altro provider se disponibile). In questo livello sono disponibili le funzionalità: ParaLat AI, Notizie, Archivio Versioni, Impostazioni. N.B. Alcune di queste funzionalità possono essere limitate e sbloccabili interamente attraverso pagamento una tantum o abbonamento mensile/annuale. L\'ultimo livello comprende gli utenti che accederanno come Guest. Le funzionalità disponibili a questi ultimi sono: Notizie, Archivio Versioni(limitato) e impostazioni'),
              Text(
                'Parte 1.4: Privacy e trattamento dei dati',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'ParaLat app ha accesso ad alcuni tuoi dati personali(elencati seguentemete). Questi dati rimarranno sempre ed esclusivamente sui server ParaLat o sulle piattaforme di hosting a cui il progetto si appoggia. I dati a cui ParaLat app ha accesso sono: Nome Utente, indirizzo email, ID account, Ultimo Sign In, Data della crezione dell\'account. In futuro a questi potrebbero essere aggiunti per completezza anche: età e sesso.'),
              Text(
                'Parte 1.5: A cosa servono questi dati',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'I dati a cui ha accesso ParaLat app sono strettamente necessarie al corretto funzionamento dell\'app. Nello specifico email ed ID utente hanno lo scopo di contribuire alla targettizzazione dell\'utente con personalizzazione della GUI dell\'app. Ultimo sign in e data creazione account servono per monitorare eventuali problemi di sicurezza relativi al tuo account. Questi ultimi due dati hanno anche un fine statistico utile per contribuire a sviluppare il progetto ParaLat. Infine età e sesso saranno dei dati probabilmente richiesti in futuro; il primo al fine di garantire che l\'utente ha l\'età minima per l\'uso dei servizi digitali(in base a quanto previsto dalla legge). Il secondo ha il fine di esser utile alla personalizzazione dell\'interfaccia utente(banalmente se rivolgersi all\'utente al maschile o femminile)'),
              Text(
                'Parte 1.6: ParaLat on YT ed autopromozione',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                  'Essendo il progetto ParaLat costituito da due rami distinti e possibile che al fine di incrementare l\'utenza in dei due rami o entrambi si svolga un\'attività di autopromozione. Nell\'app questo sarà possibile attraverso: notifiche push o notifiche in app. Le campagne di autopromozione si tradurranno mai in spamming. Saranno tollerate massimo 2/3 campagne di autopromozione in app al mese. L\'autopromozione su YouTube, Tik Tok od altri social è invece illimitata purchè non interferisca ed entri in conflitto con la qualità dei contenuti'),
              Text(
                'Parte 1.7: Algoritmo Reputazione e sanzioni',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              Text(
                  'In merito all\'algoritmo di gestione della reputazione e delle sanzioni ai collaboratori del progetto ne sarà spiegato in questo paragrafo il funzionamento per trasparenza. L\'algoritmo valuta ogni membro di Primo livello in base ad i seguenti parametri: ultimo sign in, data creazione account, celle vuote lasciate nella propria analisi, qualità analisi di 3 parole campione della propria parte, assiduità svolgimento ed analisi versioni.\nL\'algoritmo assegnarà dei richiami debitamente motivati nella sezione sanzioni. I richiami saranno di due tipi: qualitativi e quantitativi. I richiami qualitativi hanno peso inferiore e riguardano strettamente la qualità dell versioni svolte. I richiami quantitativi hanno invece un peso elevato e riguardo il mancato svolgimento di una versione in parte o nella totalità. Si possono accumulare fino a massimo: 3 richiami qualitativi o 1 richiamo quantitativo. In caso di superamento di queste soglie è prevista una sanzione. L\'algoritmo toglierà la parte di versione a colui/colei che ha il punteggio di reputazione più elevato e la assegnerà a colui/colei che ha superato i limiti di richiami. I richiami e l\'indice di valutazione si resetteranno dopo 2 mesi. In caso entro 2 mesi si verificasse una seconda condizione di inadempienza quantitativa con una precedente sanzione già riscattata, è prevista l\'espulsione dal gruppo. E\' altresì prevista l\'espulsione in tronco dal gruppo nel caso in cui si divulghi qualsiasi tipologia di contenuto, senza un esplicito consenso, all\'esterno del gruppo'),
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
              Text('ParaLat Premium allo stato attuale garantisce i vantaggi successivamente elencati. Questi sono rivedibili e modificabili in qualsiasi condizioni. L\'utente sarà debitamente avvisato prima di ogni modifica al servizio.\nVantaggi:\nAccesso al servizio \'Archivio Versioni\':\nServizio di accesso a molteplici versioni già analizzate e revisionate da esperti(ndr Vedi 2.3).\nDownload Versioni:\nPossibilità di scaricare le versioni analizzate da Archivio Versioni(ndr Vedi 2.3)\nModelli Pro ParaLat AI:\nAccesso ai modelli più potenti e performanti di ParaLat AI. Essendo ParaLat AI basato su Gemini i modelli avanzati avranno come base la versioni più potente e recente di Gemini(ndr Vedi 2.5).\nBadge Unlimited:\nAccesso illimitato al servizio ParaLat Cards(ndr Vedi 2.4) senza alcun vincolo e limite\nNiente inserzioni:\nNon vedrai mai alcun tipo di inserzione in app(ndr Vedi 2.6).\nAccesso al canale Discord esclusivo:\nbla bla(ndr Vedi 2.7)\nBadge sul profilo:\nBla bla(ndr Vedi 2.8)'),
              Text(
                'Parte 2.3: Condizioni e modalità d\'uso Archivio Versioni',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              Text('bla bla bla bla bla bla'),
              Text(
                'Parte 2.4: Condizioni e modalità d\'uso ParaLat Cards',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              Text('bla bla bla'),
              Text(
                'Parte 2.5: Condizioni e modalità d\'uso ParaLat AI',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              Text('bla bla bla'),
              
            
            
            ],
          ),
        ),
      ),
    );
  }
}
