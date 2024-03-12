# Fonte de bancada 
## Projeto de fonte de bancada ajustável de 1,2V até 30V com corrente de carga contínua de 2A e fonte fixa de 12V com corrente de carga de até 1A.

## Introdução
Este projeto de fonte de bancada handmade tem o objetivo de ser uma opção de baixo custo e boa qualidade para bancada de hobbystas em eletrônica. Foi insparado no projeto de fonte de bancada presente na Revista Mecatrônica Fácil nº 20 de Janeiro/Fevereiro de 2005, com o nome "Fonte para bancada FMF-2" de autoria de Marcio José Soares o Arne, seu projeto original pode ser encontrado [aqui](https://www.arnerobotics.com.br/eletronica/Fonte_bancada_2.htm).
Para o desenvolvimento desse projeto hobbysta foram utilizados:
- Proteus 8.9
- SolidWorks 2019
- Altium 20.0.13
- MikroC 7.2.0

Todas os softwares utilizados com verões trial que possuem limitações de tamanho de placas, número de layers, tamanho de código etc.
Por razões de nostalgia todas as placas foram confecionadas com métodos manuais.
Devido a essas motivações as placas possuem apenas face simples.
A opção por valores de compoenetes e/ou uso de determinado dispisitivo se deve única e exclusivamente a razão de ser  o que havia disponível no momento, a maioria do que foi usado ou já existia na bancada ou foi retirado de eletrônicos velhos. Sinta-se a vontade para modificar quaisqer que sejam os dispositivos e técncias aplicadas. 

## Histórico

Quando era estudante, acho que o ano era 2007, precisava de uma fonte de bancada de baixo ruído para poder realizar meus experimentos com eletrônica e microcontroladores. Foi então que tive acesso a esse artigo da revista Mecatrônica fácil. Na internet na época não tinha encontrado projetos simples que atendessem minha demanda e o baixo conhecimento do idioma inglês dificultava ainda mais rs. 
Dito isso, montei  primeira a versão usando uma carcaça de fonte ATX e alguns componentes que já estavam naquela fonte queimada que encotrei num cemitério de eletrônicos, como conector de rede AC, chave H-H, e mais uns cacarecos. Usei essa montagem por alguns anos até que me mudei de cidade e a fonte ficou abandonada na minha casa antiga. 
Em 2018 resolvi retomar e dar um tapa na minha velha companheira, refiz os esquemáticos e layout e na prensa térmica refiz a placa. Nessa época, aproveitei e já mandei bala em uma fonte fixa de +12 -12 para usar em circuitos com ampOps.
Fiz mais uma mudança e organizando minhas coisas encontrei display de LDC 16x2 que tinha tirado de equipamentos velhos que foram dispensados no meu trabalho e também um PIC18F1220 de saudosos 8 bits que usava para estudar. Como tinha alguns LM358 e um sensor ACS712 que usei para testar umas coisas e depois ficou parado, resolvi fazer um circuito de monitor, porque não neh?
Nessa altura já estavamos mais ou menos na época da pandemia e em meu horário livre aprovetei pra fazer um curso de Altium online e usei o circuito de monitor como objeto de estudo, ao invés do proposto no curso. 
Ai então, a pandemia acabou, voltamos ao normal e minha fonte ainda estava lá parada e desmontada porque não tava rolando uma brecha pra poder mexer. Quando a brecha surgiu optei pela nostalgia em fazer tudo com minhas proprias mãos literalmente. Bem, não tão literal, para prensar a placa do monitor usei um velho ferro de passar roupa e para usinar a caixa usei uma micro retifica de mão (essa altura eu já possuia uma).
E assim foi, montagem, testes, mais uns ajutes ténicos não planejados rs e voalá.

## Conteúdo do repositório

- Cad_mecanico: nesta pasta encontram-se arquivos CAD de partes, montagem e pdf's com as medidas.
- prints_fotos_videos: esta pasta contém material gráfico do processo de confecção montagem e etc.
- monitor_fonte: arquivos Altium do circuito monitor de corrente, tensão, temperatura e potência, arquivos Proteus de simulação desse circuito, arquivo MikroC de firmware.
- fontes: pdf's dos circuitos esquemáticos das fontes variável e fixa, o arquivo fonte do projeto em Proteus sumiu entre backup's e mudanças. Quando for localizado subo no repositório.

```shell
.
├── cad_mecanico
│   ├── COMPONENTES
│   │   ├── 10A 250VAC Fuse Holder.SLDASM
│   │   ├── 16x2 LCD Display.SLDPRT
│   │   ├── 80 FanCooler-A.SLDASM
│   │   ├── 80 FanCooler-Fan.sldprt
│   │   ├── 80 FanCooler-Frame.sldprt
│   │   ├── 80FanCooler-Guard.sldprt
│   │   ├── Banana Connector - 4.00mm - Short - Black.SLDPRT
│   │   ├── Banana Connector - 4.00mm - Short - Blue.SLDPRT
│   │   ├── Banana Connector - 4.00mm - Short - Green.SLDPRT
│   │   ├── Banana Connector - 4.00mm - Short - Red.SLDPRT
│   │   ├── Banana Connector - 4.00mm - Short - Yellow.SLDPRT
│   │   ├── Chave HH.SLDPRT
│   │   ├── DIN EN ISO 10511 - M4 - N.sldprt
│   │   ├── DIN EN ISO 7045 - M4 x 35 - Z - 35N.sldprt
│   │   ├── EC11_rotary_encoder_knob.SLDPRT
│   │   ├── Frontal.SLDPRT
│   │   ├── Knob 05 v3.SLDASM
│   │   ├── led holder.SLDPRT
│   │   ├── LED_THT_3D_GREEN.SLDPRT
│   │   ├── LED_THT_3D_RED.SLDPRT
│   │   ├── LED_THT_3D_YELLOW.SLDPRT
│   │   ├── Orelha.SLDPRT
│   │   ├── placa_F_fix.SLDPRT
│   │   ├── placa_F_var.SLDPRT
│   │   ├── reforco Interno.SLDPRT
│   │   ├── sapata.SLDPRT
│   │   ├── Switch.SLDPRT
│   │   ├── Tampa.SLDPRT
│   │   ├── TOMADA FÊMEA.SLDPRT
│   │   ├── trafo 1A.SLDPRT
│   │   └── trafo 3A.SLDPRT
│   ├── DESENHOS
│   │   ├── FONTE_montada_1 - Folha1.pdf
│   │   ├── tampa_frontal_1 - Folha1.pdf
│   │   ├── tampa_frontal_2 - Folha1.pdf
│   │   ├── tampa_inferior - Folha1.pdf
│   │   ├── tampa_superior - Folha1.pdf
│   │   ├── tampa_traseira_1 - Folha1.pdf
│   │   └── tampa_traseira_2 - Folha1.pdf
│   └── MONTAGEM
│       └── FONTE.SLDASM
├── fontes
│   ├── esquematicos_placas
│   │   ├── fonte_simetrica_esquema.pdsprj.pdf
│   │   ├── fonte_simetrica.pdsprj.pdf
│   │   ├── fonte_variavel_esquema.pdsprj.pdf
│   │   └── fonte_variavel.pdsprj.pdf
│   └── simulacao_fontes
│       └── Fonte_V1.pdsprj
├── LICENSE
├── monitor_fonte
│   ├── Firmware
│   │   ├── Device.asm
│   │   ├── Device.c
│   │   ├── Device.c.ini
│   │   ├── Device.cp
│   │   ├── Device.h
│   │   ├── Device.h.ini
│   │   ├── Device.mcl
│   │   ├── firmware_monitor.asm
│   │   ├── firmware_monitor.bmk
│   │   ├── firmware_monitor.brk
│   │   ├── firmware_monitor.c
│   │   ├── firmware_monitor.cfg
│   │   ├── firmware_monitor.c.ini
│   │   ├── firmware_monitor.cof
│   │   ├── firmware_monitor.cp
│   │   ├── firmware_monitor.dbg
│   │   ├── firmware_monitor.dct
│   │   ├── firmware_monitor.dlt
│   │   ├── firmware_monitor.hex
│   │   ├── firmware_monitor.log
│   │   ├── firmware_monitor.lst
│   │   ├── firmware_monitor.lst.ini
│   │   ├── firmware_monitor.mcl
│   │   ├── firmware_monitor.mcppi
│   │   ├── firmware_monitor.mcppi_callertable.txt
│   │   ├── firmware_monitor.user.dic
│   │   └── firmware_monitor.wch
│   ├── PCB_Altium
│   │   └── PCB_INSTRUMENTATION_VSOURCE
│   │       ├── main.SchDoc
│   │       ├── PCB_INST_FONTE.PcbDoc
│   │       ├── PCB_INSTRUMENTATION_VSOURCE.PrjPcb
│   │       ├── __Previews
│   │       │   ├── main.SchDocPreview
│   │       │   ├── Sheet1.SchDocPreview
│   │       │   └── Sheet2.SchDocPreview
│   │       ├── Producao
│   │       │   ├── Geber_Placa.Cam
│   │       │   ├── NC_Drill_Placa.Cam
│   │       │   ├── Schematic Prints 1.pdf
│   │       │   ├── Schematic Prints 2.pdf
│   │       │   ├── Schematic Prints.pdf
│   │       │   └── Thermal_transfer
│   │       │       ├── Mask_Impressao_TermoCAM.pdf
│   │       │       ├── Mask_Print_Term_Transfer.pdf
│   │       │       └── Print_Fab_Home_Thermal.pdf
│   │       ├── Project Outputs for PCB_INSTRUMENTATION_VSOURCE
│   │       │   ├── Design Rule Check - PCB_INST_FONTE.drc
│   │       │   ├── Design Rule Check - PCB_INST_FONTE.html
│   │       │   ├── PCB_INST_FONTE.apr
│   │       │   ├── PCB_INST_FONTE.DRR
│   │       │   ├── PCB_INST_FONTE.EXTREP
│   │       │   ├── PCB_INST_FONTE.GBL
│   │       │   ├── PCB_INST_FONTE.GBO
│   │       │   ├── PCB_INST_FONTE.GBS
│   │       │   ├── PCB_INST_FONTE.GG1
│   │       │   ├── PCB_INST_FONTE.GM1
│   │       │   ├── PCB_INST_FONTE.GM13
│   │       │   ├── PCB_INST_FONTE.GM15
│   │       │   ├── PCB_INST_FONTE.GPB
│   │       │   ├── PCB_INST_FONTE.GPT
│   │       │   ├── PCB_INST_FONTE.GTL
│   │       │   ├── PCB_INST_FONTE.GTO
│   │       │   ├── PCB_INST_FONTE.GTS
│   │       │   ├── PCB_INST_FONTE.LDP
│   │       │   ├── PCB_INST_FONTE-macro.APR_LIB
│   │       │   ├── PCB_INST_FONTE.REP
│   │       │   ├── PCB_INST_FONTE.RUL
│   │       │   ├── PCB_INST_FONTE.TXT
│   │       │   ├── PCB_INSTRUMENTATION_VSOURCE_BOM.xlsx
│   │       │   ├── __Previews
│   │       │   │   └── Design Rule Check - PCB_INST_FONTE.drcPreview
│   │       │   └── Status Report.Txt
│   │       ├── Sheet1.SchDoc
│   │       └── Sheet2.SchDoc
│   └── Simulacao
│       └── simulacao_monitor_fonte.pdsprj
├── prints_fotos_videos
│   ├── cad_vista_monategm_1.png
│   ├── cad_vista_monategm_2.png
│   ├── cad_vista_monategm_3.png
│   ├── cad_vista_monategm_4.png
│   ├── IMG-20220224-WA0000.jpg
│   ├── IMG-20220224-WA0002.jpg
│   ├── IMG-20220224-WA0003.jpg
│   ├── IMG-20220224-WA0004.jpg
│   ├── IMG_20220310_143831.jpg
│   ├── IMG_20220310_143843.jpg
│   ├── IMG_20220315_130520.jpg
│   ├── IMG_20220315_130540.jpg
│   ├── IMG_20220921_200834.jpg
│   ├── IMG_20220921_201358.jpg
│   ├── IMG-20230129-WA0006.jpeg
│   ├── IMG_20231120_121806.jpg
│   ├── IMG_20231228_160329.jpg
│   ├── IMG_20231228_160339.jpg
│   ├── IMG_20231228_160359.jpg
│   ├── IMG_20231228_160410.jpg
│   ├── IMG_20231229_150956.jpg
│   ├── IMG_20240110_225814.jpg
│   ├── IMG_20240113_172508.jpg
│   ├── IMG_20240113_201511.jpg
│   ├── IMG_20240210_154214.jpg
│   ├── IMG-20240229-WA0002.jpeg
│   ├── IMG-20240301-WA0006.jpeg
│   ├── IMG-20240301-WA0008.jpeg
│   ├── IMG-20240301-WA0012.jpeg
│   ├── simula.PNG
│   └── VID-20240301-WA0018.mp4
└── README.md
```

## Observações

Circuito de fonte simétrica fixa.
Este circuito é extremamente simples sendo composto por um retificador em ponte completa com trasnformador de 15+15 @1A, diodos 1N4004, filtro capacitivo e reguladores LM7812 e LM7912. Seu layout pode ser bastante reduzido, sugiro colocar bons dissipadores de calor (reguladores lineares dissipam muito calor). Os leds de sinalização são totalmente dispensáveis, caso opte por eles seria interessante um trafo maior para termos um pouco mais de 15V na entrada do regulador, pois a tensão dropOut necessária para regulação fica em torno de uns 3V. 

Circuito de fonte ajustável.
Este circuito também é simples sendo composto por um transformador abaixador de 15+15V @3A, ponte retificadora com 4 diodos 1N5408, filtro capacitivo e regulador LM350. O layout que usei foi inspirado no da revista, mas o LM350 sugiro monta-lo separado com um dissipador de calor grande para poder fornecer os 3A sem acionar o circuito de proteção térmica. Com isso o layout fica bem reduzido também.  Outa sugestão é utilizar outro encapsulamento e colocar os diodos de proteção conforme o datasheet do componente encontrado [aqui](https://www.ti.com/lit/ds/symlink/lm350-n.pdf?ts=1710238548220&ref_url=https%253A%252F%252Fwww.mouser.fr%252F). No esquemático deste projeto utilizei o capacitor de redução de ripple, conforme o datasheet isso tende a melhorar a resposta para ruídos de entrada sob carga. 

Circuito monitor
Bem este circuito já não é tão simples, pois possui um mirocontrolador PIC18F1220 que precisa de um firmware para funcionar. Sua finalidade é medir a tensão, corrente, temperatura, potência de saída da fonte ajustável e medir se a tensão fixa esta dentro de limites aceitáveis (tinha espaço no LCD). Apresentando a medida em um display de LCD 16x2 vias. 
Para medir tensão são usados divisores de tensão na entreda de LM358's datasheet [aqui](https://www.ti.com/lit/ds/symlink/lm358.pdf?ts=1710219620944) como buffers de tensão que servem pra isolar e proteger o microcontrolador, também foram usados diodo zener de proteção e um filtro RC. Para a medição de tempratura foi usado o famigerado LM35  [datasheet](https://www.ti.com/lit/ds/symlink/lm35.pdf?ts=1710231519279&ref_url=https%253A%252F%252Fwww.ti.com%252Fsitesearch%252Fen-us%252Fdocs%252Funiversalsearch.tsp%253FlangPref%253Den-US%2526searchTerm%253D), foi fixado perto do LM350 no dissipador de calor usando adesivo térmico homemade vulgo pasta térmica com adesivo epóxi. Para medição de corrente foi usado um módulo do sensor ACS712 datasheet [aqui](https://www.sparkfun.com/datasheets/BreakoutBoards/0712.pdf), esse dispositivo apenas foi usado porque tinha disponível. Ele é bem ruim para baixas correntes dc. Ficando mais como um alarme do que uma medida confiável. Sugiro a substituição desse sensor ou mesmo projetar algo com compnentes discretos. 
Para o firmware do microcontrolador quiz usar o ambiente que usava [Na aurora da minha vida!](https://poemasdomundo.wordpress.com/2006/06/14/meus-oito-anos/) lá no tempo do curso técnico (o Arduino não era muito conhecido ainda...). Então foi na base do MikroC mesmo que tem umas libs que facilitam trabalhar com display. Hoje em dia compensa muito mais usar as ferramentas da Microchip, Mplab, Harmony e etc. 
Por último, sugiro usar um circuitinho de referência externa de tensão para o ADC, mesmo em outros microocntroladores. Neste projeto foi usado o TL431 datasheet [aqui](https://www.ti.com/lit/ds/symlink/tl431.pdf?ts=1710220283391&ref_url=https%253A%252F%252Fwww.mouser.com%252F).
Sinceramente, da pra dispensar esse circuito com traqnuilidade, caso queira economizar dinheiro e mão de obra pode optar por um monitor pronto com voltimetro e amperimetro Dc (desses que vende barato em sites amarelos da rede mundial de computadores) [como exemplo](https://www.4hobby.com.br/produto/voltimetro-amperimetro-digital-dc-100v-10a-para-painel.html).

Montagem
Para montagem foi utilizado uma caixa metálica de  300x180x80 mm tem algumas opções na internet por [ai](https://www.soldafria.com.br/componentes-eletronicos/caixa/caixa-de-ferro) (de longe a caixa foi o componente mais caro). Outra opção pode ser caixas padrão plásticas, reaproveitar alguma coisa, fazer de madeira, opções existem e a imaginação é o limite. Recomendo fortemente o uso de ventilação forçada a famosa ventoinha e o uso de bons bornes e chaves de qualidade.
Um vídeo da fonte alimentando uam lampada DC e um circuito amplificador pode ser visto [neste link](https://www.youtube.com/shorts/OysOYpLijRs).


## License

MIT

**Free Software, Hell Yeah!**


