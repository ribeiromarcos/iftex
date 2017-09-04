\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iftex}[2017/01/26 v2.0 Classe IF para trabalhos acadêmicos por Marcos Roberto Ribeiro]

% Repassa demais opções a abntex2
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}
\ProcessOptions\relax

% =============================================================================
% Herança da classe `abntex2' e inclusão das opções padrões
% =============================================================================
\LoadClass[12pt,a4paper]{abntex2}

% =============================================================================
% Pacotes Usados
% =============================================================================
\RequirePackage[T1]{fontenc}          % Seleção de códigos de fonte
\RequirePackage[utf8]{inputenc}       % Codificação automática de caracteres especiais
\RequirePackage{morewrites}           % Resolve o erro “No room for a new \write”
\RequirePackage[lighttt]{lmodern}     % Usa a fonte Latin Modern
\RequirePackage{lastpage}             % Contagem de páginas
\RequirePackage{indentfirst}          % Indenta primeiro parágrafo de cada seção
\RequirePackage{color, xcolor}        % Controle das cores
\RequirePackage{graphicx}             % Inclusão de gráficos
\RequirePackage{caption}              % Pacote para definição dos captions
\RequirePackage{microtype}            % Melhorias de justificação
\RequirePackage{pdfpages}             % inclusão de arquivos PDF
\RequirePackage{hyphenat}             % Retira hifenização do Preâmbulo
\RequirePackage{amsmath,amsfonts}     % Pacotes matemáticos
\RequirePackage{amssymb,amsthm}       % Pacotes matemáticos
\RequirePackage{url}                  % Tratamento correto de URL
\RequirePackage{enumerate}            % Listas numerados personalizadas
\RequirePackage{cleveref}             % Correção de links para sub-equações

\RequirePackage{tikz}                 % Pacote para desenho
\usetikzlibrary{shapes,arrows,matrix,positioning,backgrounds,calc,trees,fit}%

% Preserva comando \bibcite alterado pelo pacote abntex2cite
\let\oldbibcite\bibcite%
\RequirePackage[alf,abnt-repeated-author-omit=yes]{abntex2cite}    % Citações ABNT
\let\bibcite\oldbibcite%

% -----------------------------------------------------------------------------
% Configurações
% -----------------------------------------------------------------------------

% Unidade
\providecommand{\imprimirunidade}{Campus Bambu\'i}%
\newcommand{\unidade}[1]{%
  \renewcommand{\imprimirunidade}{#1}%
}%

% Tipo de trabalho
\providecommand{\imprimirtipotrabalho}{Monografia de Trabalho de Conclus\~ao de Curso}%
\renewcommand{\tipotrabalho}[1]{%
  \ifthenelse{\equal{#1}{monografia}}{%
    \renewcommand{\imprimirtipotrabalho}{Monografia}%
  }{}%
  \ifthenelse{\equal{#1}{dissertacao}}{%
    \renewcommand{\imprimirtipotrabalho}{Disserta\c{c}\~ao}%
  }{}%
  \ifthenelse{\equal{#1}{tese}}{%
    \renewcommand{\imprimirtipotrabalho}{Tese}%
  }{}%
}%

% Curso e Título obtido
\providecommand{\imprimircurso}{}%
\providecommand{\imprimirtitulocurso}{}%
\newcommand{\curso}[2]{%
  \renewcommand{\imprimirtitulocurso}{#1}%
  \renewcommand{\imprimircurso}{#2}%
}%

% Área de concentração
\providecommand{\imprimirareaconcentracao}{}%
\newcommand{\areaconcentracao}[1]{%
  \renewcommand{\imprimirareaconcentracao}{\'Area de concentra\c{c}\~ao: #1}%
}%

% Redefinição do comando de data
\renewcommand{\data}[3]{%
  \date{#1}{#2}{#3}%
}%

% Redefinição do comando \date do Latex
\renewcommand{\date}[3]{%
  \gdef\@day{#1}%
  \gdef\@month{#2}%
  \gdef\@year{#3}%
  \gdef\@date{\@day~de~\@month~de~\@year}%
}%

% Define a data
\date{\number\day}{\monthname}{\number\year}%

% Redefinição de Orientador
\renewcommand{\orientador}[2][Orientador]%
  {\renewcommand{\imprimirorientador}{#2}%
   \renewcommand{\imprimirorientadorRotulo}{#1}}%

% Redefinição de Coorientador
\renewcommand{\coorientador}[2][Coorientador]%
  {\renewcommand{\imprimircoorientador}{#2}%
   \renewcommand{\imprimircoorientadorRotulo}{#1}}%
\providecommand{\imprimircooriendatorinsituicao}{\imprimirinstituicao}%
\newcommand{\coorientadorinstituicao}[1]{\renewcommand{\imprimircooriendatorinsituicao}{#1}}%

% Preâmbulo
\preambulo{%
  {\imprimirtipotrabalho} apresentada ao Curso de {\imprimircurso} do {\imprimirinstituicao} - {\imprimirunidade}, como requisito parcial para obten\c{c}\~ao do t\'itulo de {\imprimirtitulocurso} em {\imprimircurso}.%
}%

% Citações explícitas
\newcommand{\citet}{\citeonline}%

% -----------------------------------------------------------------------------
% Fonte padrão section, subsection e subsubsection
% -----------------------------------------------------------------------------
\renewcommand{\ABNTEXchapterfont}{\huge\bfseries}%

% -----------------------------------------------------------------------------
% Definições de comprimento
% -----------------------------------------------------------------------------
\newlength{\titlepagewinwidth}\setlength{\titlepagewinwidth}{120mm}%
\newlength{\titlepagewinheight}\setlength{\titlepagewinheight}{64mm}%
\newlength{\titlepagewinvoffset}\setlength{\titlepagewinvoffset}{120mm}%
\setlength{\parindent}{1.25cm}%

% -----------------------------------------------------------------------------
% Contadores
% -----------------------------------------------------------------------------
% Equações com numeração contínua
\counterwithout{equation}{chapter}%
% Numerar sub-sub-seções
\setsecnumdepth{subsubsection}%
% Sumário contém apenas até as subseções
\settocdepth{subsection}%
% Figuras com numeração reiniciao nos capítulos
\newsubfloat{figure}%

% -----------------------------------------------------------------------------
% Algoritmos, Códigos e Quadros
% -----------------------------------------------------------------------------
% Cria o ambiente para algoritmos
\newcommand{\algoritmonome}{Algoritmo}%
\newcommand{\listalgoritmonome}{Lista de Algoritmos}%
\newlistof{listofalgoritmos}{loa}{\listalgoritmonome}%
\newfloat{algoritmo}{loa}{\algoritmonome}%
\newlistentry{algoritmo}{loa}{0}%
\renewcommand{\cftalgoritmoname}{\algoritmonome\space}%
\renewcommand*{\cftalgoritmoaftersnum}{\hfill\textendash\hfill}%
% Cria o ambiente para códigos
\newcommand{\codigonome}{C\'odigo}%
\newcommand{\listcodigonome}{Lista de C\'odigos}%
\newlistof{listofcodigos}{loc}{\listcodigonome}%
\newfloat{codigo}{loc}{\codigonome}%
\newlistentry{codigo}{loc}{0}%
\renewcommand{\cftcodigoname}{\codigonome\space}%
\renewcommand*{\cftcodigoaftersnum}{\hfill\textendash\hfill}%
% Cria o ambiente para quadros
\newcommand{\quadronome}{Quadro}%
\newcommand{\listquadronome}{Lista de Quadro}%
\newlistof{listofquadros}{loq}{\listquadronome}%
\newfloat{quadro}{loq}{\quadronome}%
\newlistentry{quadro}{loq}{0}%
\renewcommand{\cftquadroname}{\quadronome\space}%
\renewcommand*{\cftquadroaftersnum}{\hfill\textendash\hfill}%

% Mudança de estilo
\RequirePackage{float}%
\floatstyle{ruled}%
\restylefloat{algoritmo}%
\restylefloat{codigo}%
\captionsetup[algoritmo]{labelsep=endash}%
\captionsetup[codigo]{labelsep=endash}%
\captionsetup[quadro]{labelsep=endash}%

% -----------------------------------------------------------------------------
% Membros de banca
% -----------------------------------------------------------------------------
% Comando para definição dos membros da banca
\newcount\@membrobancaconta\@membrobancaconta0%
\newcommand\membrobanca[2]{%
  \global\@namedef{NomeMembroBanca:\expandafter\the\@membrobancaconta}{#1}%
  \global\@namedef{LocalMembroBanca:\expandafter\the\@membrobancaconta}{#2}%
  \global\advance\@membrobancaconta by 1%
}%

% -----------------------------------------------------------------------------
% Logos do IF
% -----------------------------------------------------------------------------
% Logo
\newcommand{\iflogo}{
\begin{tikzpicture}[node distance=0.1cm]
\tikzstyle{circulo}=[circle, fill={rgb:red,200;green,25;blue,30}, minimum size=1.1cm]
\tikzstyle{quadrado}=[rounded corners=0.1cm, fill={rgb:red,50;green,160;blue,65}, minimum size=1cm]
\node (q12) [quadrado] {};
\node (q13) [quadrado, right=of q12] {};
\node (q22) [quadrado, below=of q12] {};
\node (q21) [quadrado, left=of q22] {};
\node (q31) [quadrado, below=of q21] {};
\node (q32) [quadrado, right=of q31] {};
\node (q33) [quadrado, right=of q32] {};
\node (q41) [quadrado, below=of q31] {};
\node (q42) [quadrado, right=of q41] {};
\node (c) [circulo] at (q12 -| q21) {};
\end{tikzpicture}
}
% Logo com descrição
\newcommand{\iffull}{%
  {%
    \sffamily\large%
    \begin{tikzpicture}[node distance=0.05cm]%
    \tikzstyle{circulo}=[circle, fill={rgb:red,200;green,25;blue,30}, minimum size=.6cm]%
    \tikzstyle{quadrado}=[rounded corners=0.05cm, fill={rgb:red,50;green,160;blue,65}, minimum size=0.5cm, ,inner sep=0,outer sep=0,text depth=0pt]%
    \tikzstyle{texto}=[inner sep=0,outer sep=0,text depth=0pt, node distance=0.65cm]%
    \node (q12) [quadrado] {};%
    \node (q13) [quadrado, right=of q12] {};%
    \node (q22) [quadrado, below=of q12] {};%
    \node (q21) [quadrado, left=of q22] {};%
    \node (q31) [quadrado, below=of q21] {};%
    \node (q32) [quadrado, right=of q31] {};%
    \node (q33) [quadrado, right=of q32] {};%
    \node (q41) [quadrado, below=of q31] {};%
    \node (q42) [quadrado, right=of q41] {};%
    \node (c)   [circulo] at (q12 -| q21) {};%
    \node (if)  [texto, right=of q12.south east, anchor=south west] {\textbf{INSTITUTO FEDERAL}};%
    \node (edu) [texto, right=of q22.south east, anchor=south west] {\textbf{DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA}};%
    \node (mg)  [texto, right=of q32.south east, anchor=south west] {Minas Gerais};%
    \node (uni) [texto, right=of q42.south east, anchor=south west] {\itshape \imprimirunidade};%
    \end{tikzpicture}%
  }%
}%

% -----------------------------------------------------------------------------
% Ajuste de cabeçalho e rodapé
% -----------------------------------------------------------------------------
\makepagestyle{eescchaplast}%
\makeevenhead{eescchaplast}%
{\ABNTEXfontereduzida\thepage}{}{\ABNTEXfontereduzida\textit\leftmark}%
\makeoddhead{eescchaplast}%
{\ABNTEXfontereduzida\textit\rightmark}{}{\ABNTEXfontereduzida\thepage}%
\makeheadrule{eescchaplast}{\textwidth}{\normalrulethickness}%
\makepagestyle{eescpartlast}%
\makeoddhead{eescpartlast}{}{}{\ABNTEXfontereduzida\thepage}%
\makeevenhead{eescpartlast}{\ABNTEXfontereduzida\thepage}{}{}%

% -----------------------------------------------------------------------------
% Configuração de Páginas
% -----------------------------------------------------------------------------
% Configuração de páginas pré-textuais
\renewcommand{\pretextual}{%
  \aliaspagestyle{chapter}{empty}%
  \pagestyle{empty}%
  \aliaspagestyle{cleared}{empty}%
  \aliaspagestyle{part}{empty}%
}%
\renewcommand{\frontmatter}{\pretextual} %

% Configuração de páginas textuais
\renewcommand{\textual}{%
  \pagestyle{abntheadings}
  \aliaspagestyle{chapter}{abntchapfirst}%
  \aliaspagestyle{cleared}{eescchaplast}%
  \aliaspagestyle{part}{eescchaplast}%
  \nouppercaseheads%
}%

% Configuração de páginas pós-textuais
\renewcommand{\postextual}{%
  \pagestyle{abntheadings}%
  \aliaspagestyle{chapter}{abntchapfirst}%
  \aliaspagestyle{cleared}{eescchaplast}%
  \aliaspagestyle{part}{eescpartlast}%
  \aliaspagestyle{afterpart}{eescpartlast}%
}%
\renewcommand{\backmatter}{\postextual}%

% =============================================================================
% Elementos Pré-Textuais
% =============================================================================

% -----------------------------------------------------------------------------
% Ficha catalográfica
% -----------------------------------------------------------------------------
\providecommand{\arquivoficha}{}
\newcommand{\inserirfichacatalografica}[1]{\renewcommand{\arquivoficha}{#1}}%

% -----------------------------------------------------------------------------
% Folha de aprovação
% -----------------------------------------------------------------------------
\providecommand{\arquivofolhaaprovacao}{}
\newcommand{\inserirfolhaaprovacao}[1]{\renewcommand{\arquivofolhaaprovacao}{#1}}%

% Folha de aprovação impressa para assinatura
\newcommand{\folhadeaprovacaoimpressa}{%
  \begin{folhadeaprovacao}%
  \begin{center}%
    \vfill%
    {\large\textbf{\imprimirautor}}%
    \vfill%
    {\Large{\textbf{\MakeUppercase{\imprimirtitulo}}}}%
    \vfill%
    \hspace{.45\textwidth}%
    \begin{minipage}{.5\textwidth}%
        \imprimirpreambulo%
    \end{minipage}%
    \par\vspace{\onelineskip}\par%
    \vspace{\onelineskip}%
    \begin{flushright}%
    \imprimirlocal, {\@day} de {\@month} de {\@year}%
    \end{flushright}%
    \par%
    \ifthenelse{\not\equal{\imprimirorientador}{}}{%
      \assinatura{%
        \imprimirorientador\\%
        \imprimirorientadorRotulo\\%
        \imprimirinstituicao%
      }%
    }{}%
    \par
    \ifthenelse{\not\equal{\imprimircoorientador}{}}{%
      \assinatura{%
        \imprimircoorientador\\%
        \imprimircoorientadorRotulo\\%
        \imprimircooriendatorinsituicao%
      }%
    }{}%
    \count1=0%
    \@whilenum \count1<\@membrobancaconta \do {%
      \assinatura{%
        \csname NomeMembroBanca:\the\count1 \endcsname \\%
        \csname LocalMembroBanca:\the\count1 \endcsname%
      }%
      \advance\count1 by 1%
    }%
  \end{center}%
  \end{folhadeaprovacao}
}% fim da \folhadeaprovacaoimpressa

\newcommand{\folhadeaprovacaodigitalizada}{%
  \begin{folhadeaprovacao}%
    \includepdf[pages={1}]{\arquivofolhaaprovacao}%
  \end{folhadeaprovacao}%
}

\newcommand{\gerafolhaaprovacao}{%
  \ifthenelse{\not\equal{\arquivofolhaaprovacao}{}}{%
    % Versão digitalizada da folha de aprovação
    \folhadeaprovacaodigitalizada%
  }{%
    % Versão impressa da folha de aprovação (sem assinaturas)
    \folhadeaprovacaoimpressa%
  }%
}%

% -----------------------------------------------------------------------------
% Capa
% -----------------------------------------------------------------------------
\renewcommand{\imprimircapa}{%
  \pdfbookmark[0]{Capa}{}%
  \thispagestyle{empty}%
  \noindent%
  \begin{center}
    \iffull%
    \vfill%
    {\Large{\textbf{\MakeUppercase{\imprimirtitulo}}}}%
    \vfill%
    {\large\textbf{\imprimirautor}}%
    \vfill%
    \textbf{\imprimirlocal}\par%%
    \textbf{\@year}%
    \cleardoublepage%
  \end{center}
}

% -----------------------------------------------------------------------------
% Folha de Rosto
% -----------------------------------------------------------------------------
\renewcommand{\folhaderostocontent}{%
  \setcounter{page}{1}%
  \begin{center}%
    \vfill%
    {\large\textbf{\imprimirautor}}%
    \vfill%
    {\Large{\textbf{\MakeUppercase{\imprimirtitulo}}}}%
    \vfill%
    \hspace{.45\textwidth}%
    \begin{minipage}{.5\textwidth}%
        \imprimirpreambulo%
    \end{minipage}%
    \par\vspace{\onelineskip}\par%
    \imprimirareaconcentracao%
    \par\vspace{\onelineskip}\par%
    {\imprimirorientadorRotulo:~\imprimirorientador\par}%
    \abntex@ifnotempty{\imprimircoorientador}{%
      {\imprimircoorientadorRotulo:~\imprimircoorientador}%
    }%
    \vfill%
    \textbf{\imprimirlocal}\par%%
    \textbf{\@year}%
  \end{center}%
}%

\newcommand{\gerafolharosto}{%
  \ifthenelse{\not\equal{\arquivoficha}{}}%
  {%
    \imprimirfolhaderosto*{}%
    \if@twoside{%
      \begin{fichacatalografica}%
        \includepdf[pages={1}]{\arquivoficha}%
      \end{fichacatalografica}%
    }\fi%
  }%
  {%
    \imprimirfolhaderosto{}%
  }%
}%

% -----------------------------------------------------------------------------
% Dedicatória
% -----------------------------------------------------------------------------
\newcommand{\inserirdedicatoria}[1]{%
  \newcommand{\textodedicatoria}{#1}%
}

\newcommand{\geradedicatoria}{%
  \ifthenelse{\isundefined{\textodedicatoria}}
  {}{%
        \begin{dedicatoria}%
        \vspace*{\fill}%
        \centering%
        \noindent%
        \textit{\textodedicatoria}%
        \vspace*{\fill}%
    \end{dedicatoria}%
  }%
}%
% -----------------------------------------------------------------------------
% Agradecimentos
% -----------------------------------------------------------------------------
\newcommand{\inseriragradecimentos}[1]{%
  \newcommand{\textoagradecimentos}{#1}%
}

\newcommand{\geraagradecimentos}{%
  \ifthenelse{\isundefined{\textoagradecimentos}}
  {}{%
    \begin{agradecimentos}%
      \textoagradecimentos%
    \end{agradecimentos}%
  }%
}%

% -----------------------------------------------------------------------------
% Epígrafe
% -----------------------------------------------------------------------------
\newcommand{\inserirepigrafe}[1]{%
  \newcommand{\textoepigrafe}{#1}%
}

\newcommand{\geraepigrafe}{%
\ifthenelse{\isundefined{\textoepigrafe}}
  {}{%
    \begin{epigrafe}%
      \vspace*{\fill}%
      \begin{flushright}%
        \textit{\textoepigrafe}%
      \end{flushright}%
    \end{epigrafe}%
  }%
}%

% -----------------------------------------------------------------------------
% Resumo
% -----------------------------------------------------------------------------
\providecommand{\textoresumo}{}%
\providecommand{\textopalavraschave}{}%
\renewcommand{\resumo}[1]{%
  \renewcommand{\textoresumo}{#1}%
}%
\newcommand{\palavraschave}[1]{%
  \renewcommand{\textopalavraschave}{#1}%
}%

\newcommand{\geraresumo}{%
  \ifthenelse{\not\equal{\textoresumo}{}}{%
    \pretextualchapter{Resumo}%
    \textoresumo%
    \par%
    \vspace{\onelineskip}%
    \noindent\textbf{Palavras-chave:} \textopalavraschave%
    \thispagestyle{empty}%
    \cleardoublepage%
  }{}%
}%

% -----------------------------------------------------------------------------
% Abstract
% -----------------------------------------------------------------------------
\providecommand{\textoabstract}{}%
\providecommand{\textokeywords}{}%
\renewcommand{\abstract}[1]{%
  \renewcommand{\textoabstract}{#1}%
}%
\newcommand{\keywords}[1]{%
  \renewcommand{\textokeywords}{#1}%
}%

\newcommand{\geraabstract}{%
  \ifthenelse{\not\equal{\textoabstract}{}}{%
    \pretextualchapter{Abstract}%
    \textoabstract%
    \par%
    \vspace{\onelineskip}%
    \noindent\textbf{Keywords:} \textokeywords%
    \thispagestyle{empty}%
    \cleardoublepage%
  }{%
  }%
}%

% =============================================================================
% Listas e Sumário
% =============================================================================

% -----------------------------------------------------------------------------
% Lista de ilustrações
% -----------------------------------------------------------------------------
\newcommand{\incluirlistailustracoes}{FALSE}%
\newcommand{\inserirlistafiguras}{%
  \renewcommand{\incluirlistailustracoes}{TRUE}%
}%
\addto\captionsbrazil{%
  \renewcommand{\listfigurename}%
    {Lista de Figuras}%
}

\newcommand{\geralistailustracoes}{%
  \ifthenelse{\equal{\incluirlistailustracoes}{TRUE}}{%
    \pretextualchapter{\listfigurename}
    \@starttoc{lof}
    \cleardoublepage%
   }{}%
}%

% -----------------------------------------------------------------------------
% Lista de quadros
% -----------------------------------------------------------------------------
\newcommand{\incluirlistaquadros}{FALSE}%
\newcommand{\inserirlistaquadros}{%
  \renewcommand{\incluirlistaquadros}{TRUE}%
}%
\addto\captionsbrazil{%
  \renewcommand{\listquadronome}%
    {Lista de Quadros}%
}

\newcommand{\geralistaquadros}{%
  \ifthenelse{\equal{\incluirlistaquadros}{TRUE}}{%
    \pretextualchapter{\listquadronome}
    \@starttoc{loq}
    \cleardoublepage%
   }{}%
}%

% -----------------------------------------------------------------------------
% Lista de tabelas
% -----------------------------------------------------------------------------
\newcommand{\incluirlistatabelas}{FALSE}%
\newcommand{\inserirlistatabelas}{%
  \renewcommand{\incluirlistatabelas}{TRUE}%
}%
\addto\captionsbrazil{%
  \renewcommand{\listtablename}%
    {Lista de Tabelas}%
}

\newcommand{\geralistatabelas}{%
  \ifthenelse{\equal{\incluirlistatabelas}{TRUE}}{%
    \pretextualchapter{\listtablename}
    \@starttoc{lot}
    \cleardoublepage%
  }{}%
}

% -----------------------------------------------------------------------------
% Lista de siglas
% -----------------------------------------------------------------------------

\newcommand{\listacronymname}{Lista de Abreviaturas e Siglas}
\newcommand{\inserirlistasiglas}[1]{%
  \DeclareRobustCommand{\listasiglas}{#1}%
}%

\newcommand{\geralistasiglas}{%
  \ifthenelse{\isundefined{\listasiglas}}
  {}{%
    \thispagestyle{empty}
    \pagestyle{empty}
    \pretextualchapter{\listacronymname}
    \listasiglas
    \cleardoublepage
  }%
}%

% -----------------------------------------------------------------------------
% Lista de algoritmos
% -----------------------------------------------------------------------------
\newcommand{\incluirlistaalgoritmos}{FALSE}%
\newcommand{\inserirlistaalgoritmos}{%
  \renewcommand{\incluirlistaalgoritmos}{TRUE}%
}%

\newcommand{\geralistaalgoritmos}{%
  \ifthenelse{\equal{\incluirlistaalgoritmos}{TRUE}}{%
    \pretextualchapter{\listalgoritmonome}%
    \@starttoc{loa}%
    \cleardoublepage%
  }{}%
}%

% -----------------------------------------------------------------------------
% Lista de códigos
% -----------------------------------------------------------------------------
\newcommand{\incluirlistacodigos}{FALSE}%
\newcommand{\inserirlistacodigos}{%
  \renewcommand{\incluirlistacodigos}{TRUE}%
}%

\newcommand{\geralistacodigos}{%
  \ifthenelse{\equal{\incluirlistacodigos}{TRUE}}{%
    \pretextualchapter{\listcodigonome}%
    \@starttoc{loc}%
    \cleardoublepage%
  }{}%
}%

% -----------------------------------------------------------------------------
% Lista de símbolos
% -----------------------------------------------------------------------------
\newcommand{\listsymbolname}{Lista de Símbolos}%
\newcommand{\inserirlistasimbolos}[1]{%
  \DeclareRobustCommand{\listasimbolos}{#1}%
}%

\newcommand{\geralistasimbolos}{%
  \ifthenelse{\isundefined{\listasimbolos}}%
  {}%
  {%
    \pretextualchapter{\listsymbolname}%
    \listasimbolos%
  }%
}%

% -----------------------------------------------------------------------------
% Sumário
% -----------------------------------------------------------------------------
\newcommand{\sumario}{%
  \pretextualchapter{\contentsname}
  \thispagestyle{empty}
  \pagestyle{empty}
  \@starttoc{toc}
  \cleardoublepage
}

% =============================================================================
% Redefinição do \maketitle
% =============================================================================
\renewcommand{\maketitle}{%
  \pretextual
  % Capa
  \imprimircapa

  % Folha de rosto e ficha catalográfica
  \gerafolharosto

  % Folha de aprovação
  \gerafolhaaprovacao

  % Dedicatória
  \geradedicatoria

  % Agradecimentos
  \geraagradecimentos

  % Epígrafe
  \geraepigrafe

  % Resumo
  \geraresumo

  % Abstract
  \geraabstract

  % Lista de ilustrações
  \geralistailustracoes

  % Lista de quadros
  \geralistaquadros

  % Lista de tabelas
  \geralistatabelas

  % Lista de siglas
  \geralistasiglas

  % Lista de algoritmos
  \geralistaalgoritmos

  % Lista de códigos
  \geralistacodigos

  %Lista de simbolos
  \geralistasimbolos

  % Sumário
  \sumario

  % Formatação de páginas textuais
  \mainmatter
}

% -----------------------------------------------------------------------------
% Configurações de aparência do PDF final
% -----------------------------------------------------------------------------
\AtBeginDocument{%
\makeatletter%
\hypersetup{%
    pdftitle={\@title},%
    pdfauthor={\@author},%
    pdfsubject={\imprimirpreambulo},%
    pdfkeywords={\textopalavraschave},%
    pdfcreator={\@author},%
    bookmarksdepth=4,%
    breaklinks=true%
}%
\makeatother%
}%

% -----------------------------------------------------------------------------
% Ambiente baseados em teoremas
% -----------------------------------------------------------------------------
\theoremstyle{definition}%
\newtheorem{corolario}{Corolário}%
\newtheorem{definicao}{Definição}%
\newtheorem{exemplo}{Exemplo}%
\newtheorem{lema}{Lema}%
\newtheorem{observacao}{Observação}%
\newtheorem{proposicao}{Proposição}%
\newtheorem{teorema}{Teorema}%
\newenvironment{demonstracao}{\begin{proof}[Demonstração]}{\end{proof}}%

% -----------------------------------------------------------------------------
% Evita violação de margens
% -----------------------------------------------------------------------------
\sloppy%
