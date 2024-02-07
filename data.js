var data = {
  "climateForm": [{
      "text" : "Maturité climat",
      "questions": [{
        "type" : "radio",
        "text" : "Sauriez-vous expliquer dans votre entreprise ce qu'est le changement climatique et comment votre entreprise impacte le climat avec des exemples ?",
        "options" : [{
          "id" : "canexplain/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "canexplain/no", "text" : "Non", "score" : 0, "feedback" : "La connaissance du changement climatique et la capacité à l'expliquer en précisant le rôle de l'entreprise est le commencement de la démarche."
        }]
      },{
        "type" : "radio",
        "text" : "Connaissez-vous les obligations réglementaires auxquelles vous êtes soumis en matière d'émissions de GES ?",
        "options" : [{
          "id" : "knowlaw/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "knowlaw/no", "text" : "Non", "score" : 0, "feedback" : "La réglementation BEGES (https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000048246757) impose notamment l'établissement d'un bilan d'émissions de gaz à effet de serre pour toute entreprise de plus de 500 salariés."
        }]
      },{
        "type" : "radio",
        "text" : "Avez-vous identifié les risques & opportunités liés au changement climatique sur l'activité de votre entreprise ?",
        "options" : [{
          "id" : "knowrisksandoppo/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "knowrisksandoppo/no", "text" : "Non/Ne sait pas", "score" : 0, "feedback" : "Vous n'avez pas encore identifé les risques et opportunités liés au changement climatique L'identification des risques et opportunités liés au changement climatique fait partie intégrante de la mise en place d'une stratégie climat."
        }]
      },{
        "type" : "radio",
        "text" : "Est-ce qu’un bilan d'émissions de gaz à effet de serre ou bilan carbone a déjà été réalisé dans votre entreprise ?",
        "options" : [{
          "id" : "didAssess/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "didAssess/no", "text" : "Non", "score" : 0, "feedback" : "Connaitre les principaux postes d'émissions de GES de votre entreprise est le premier pas d'une stratégie climat efficace."
        }]
      },{
        "showIf" : "didAssess/yes",
        "type" : "radio",
        "text" : "Il y a combien de temps ?",
        "options" : [{
          "id" : "dateAssess/between13y", "text" : "Entre 1 et 3 ans", "score" : 1, "feedback" : "Mettre à jour votre Bilan GES est important pour s'assurer des évolutions de votre stratégie climat dans le temps."
        },{
          "id" : "dateAssess/more3y", "text" : "Il y a plus de 3 ans", "score" : 0, "feedback" : "Mettre à jour votre Bilan GES est important pour s'assurer des évolutions de votre stratégie climat dans le temps."
        }]
      },{
        "showIf" : "didAssess/yes",
        "type" : "radio",
        "text" : "Sur quel périmètre portait-il ? ",
        "options" : [{
          "id" : "assessScopes/oneTwo", "text" : "**Scopes 1 et 2**\n* Émissions directes\n* Émissions indirectes liées à l'électricité\n\n ⇨ Les **consommations d'énergie** de votre entreprise et **autres émissions directes**", "score" : 1, "feedback" : "Connaitre les principaux postes d'émissions de GES de votre entreprise est le premier pas d'une stratégie climat efficace."
        },{
          "id" : "assessScopes/oneTwoThree", "text" : "**Scopes 1, 2 et 3**\n* Émissions directes\n* Émissions indirectes liées à l'électricité\n* Émissions indirectes de votre chaîne de valeur (fournisseurs, clients, salariés)\n\n ⇨ Les **consommations d'énergie** de votre entreprise, les **autres émissions directes** et **les achats, le fret, les déplacements, les immobilisations matérielles et immatérielles**, etc...", "score" : 2, "feedback" : "Limiter l'évaluation des vos émissions de gaz à effet de serre de votre entreprise isolément de votre chaine de valeur n'est pas suffisant pour agir sur l'ensemble de votre impact sur le climat."
       
        }]
      },{
        "type" : "radio",
        "text" : "Est-ce que vous prévoyez de faire un bilan cette année ?",
        "options" : [{
          "id" : "willAssess/yes", "text" : "Oui", "score" : 3, "feedback" : "La réalisation d'un BEGES est simplifiée par le passage via un prestataire extérieur. Eco CO2 peut vous accompagner."
        },{
          "id" : "willAssess/no", "text" : "Non", "score" : 0
        }]
      },{
        "type" : "radio",
        "text" : "Votre entreprise a-t-elle fixé des objectifs de décarbonation ?",
        "options" : [{
          "id" : "hasObj/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "hasObj/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Bien que calculer ses émissions de GES soit un premier pas, se fixer des objectifs de réduction des émissions à court, moyen et long terme est nécessaire."
        }]
      },{
        "showIf" : "hasObj/yes",
        "type" : "checkbox",
        "text" : "À quelle échéance ?",
        "options" : [{
          "id" : "objTerm/short", "text" : "Court terme (1 - 3ans)", "score" : 1
        },{
          "id" : "objTerm/medium", "text" : "Moyen terme  (3 - 10 ans)", "score" : 1
        },{
          "id" : "objTerm/long", "text" : "Long terme (10 - 30 ans)", "score" : 1
        }]
      },{
        "showIf" : "hasObj/yes",
        "type" : "radio",
        "text" : "Ces objectifs sont-ils compatibles avec les accords de Paris et une trajectoire à +1,5°C ou 2°C ?",
        "options" : [{
          "id" : "parisCompat/yes", "text" : "Oui", "score" : 2
        },{
          "id" : "parisCompat/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Les accord internationaux et leur déclinaison politique française (SNBC) sont ambitieux et peuvent constituer un cadre intéressant à suivre pour vos objectifs."
        }]
      },{
        "type" : "radio",
        "text" : "Y’a-t-il une réflexion marketing/produit/service bas-carbone dans la stratégie de votre entreprise ?",
        "options" : [{
          "id" : "goodThinking/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "goodThinking/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Aujourd'hui, avoir des offres bas carbone ont un avantage commercial intéressant."
        }]
      },{
        "type" : "radio",
        "text" : "Est-ce que vous orientez vos investissements vers la transition écologique ?",
        "options" : [{
          "id" : "investGreen/yes", "text" : "Oui, c'est un critère essentiel", "score" : 2
        },{
          "id" : "investGreen/justabit", "text" : "Oui, à la marge", "score" : 1
        },{
          "id" : "investGreen/no", "text" : "Non / Ne sait pas", "score" : 0
        }]
      }]
    },{
      "text" : "Pilotage climat",
      "questions": [{
        "type" : "radio",
        "text" : "Y’a-t-il une équipe ou des personnes qui ont cette mission climat/carbone dans leur fiche de poste ?",
        "options" : [{
          "id" : "anyoneInCharge/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "anyoneInCharge/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Responsabiliser dans les fonctions d'une ou plusieurs personnes permet de stabiliser dans le temps les progrès et le suivi dans le temps de la stratégie climat."
        }]
      },{
        "showIf" : "anyoneInCharge/yes",
        "type" : "checkbox",
        "text" : "De qui s'agit-il ?",
        "options" : [{
          "id" : "whoInCharge/looseteam", "text" : "Une équipe composée de représentants de différentes fonctions/métiers dans l'entreprise (ex: maintenance, achats, commercial,...)", "score" : 0
        },{
          "id" : "whoInCharge/looseone", "text" : "La mission est une composante d'un poste d'une personne", "score" : 1
        },{
          "id" : "whoInCharge/fullone", "text" : "Un poste à temps plein est présent", "score" : 2
        },{
          "id" : "whoInCharge/fullteam", "text" : "Une équipe est dédiée à ces sujets (minimum 2 personnes)", "score" : 3
       
        }]
      },{
        "type" : "radio",
        "text" : "Avez-vous mis en place un plan de transition ?",
        "options" : [{
          "id" : "hasPlan/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "hasPlan/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Bien que calculer ses émissions de GES soit un premier pas, que se fixer des objectifs est nécessire, l'étape cruciale est la mise en place d'un plan de transition."
        }]
      },{
        "showIf" : "hasPlan/yes",
        "type" : "checkbox",
        "text" : "À quelle échéance ?",
        "options" : [{
          "id" : "planTerm/short", "text" : "Court terme (1 - 3ans)", "score" : 1
        },{
          "id" : "planTerm/medium", "text" : "Moyen terme  (3 - 10 ans)", "score" : 1
        },{
          "id" : "planTerm/long", "text" : "Long terme (10 - 30 ans)", "score" : 1
        }]
      },{
        "showIf" : "hasPlan/yes",
        "type" : "radio",
        "text" : "Y'a-t-il eu une quantification du potentiel de gain des actions identifiées ?",
        "options" : [{
          "id" : "gainEval/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "gainEval/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Aller au-delà de l'établissement d'une liste d'actions en quantifiant les gains potentiels permet à l'organisation de pouvoir prioriser les actions à fort gain potentiel, et de comparer ce gain au coût économique de mise en place de l'action"
        }]
      },{
        "showIf" : "hasPlan/yes",
        "type" : "radio",
        "text" : "Le plan de transition vit-il à travers un comité \"carbone\" ou équivalent : suivi, mise en œuvre, responsabiltés, ajustements, etc. ?",
        "options" : [{
          "id" : "committee/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "committee/no", "text" : "Non / Ne sait pas", "score" : 0
        }]
      }]
    },{
      "text" : "Passage à l'action",
      "questions": [{
        "type" : "radio",
        "text" : "Avez-vous déjà organisé des ateliers de formation/sensibilisation de vos équipes au développement durable ?",
        "options" : [{
          "id" : "workshops/yes", "text" : "Oui", "score" : 1, "feedback" : "Concernant la sensibilisation, n'hésitez pas à aller plus loin en effectuant des formations ciblées aux types de profilss/métiers."
        },{
          "id" : "workshops/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Mettre en place des formations ou sensibilisations permet une compréhension accrue des enjeux climatiques et un passage à l'action facilitée."
        }]
      },{
        "type" : "checkbox",
        "text" : "Fournissez-vous des produits physiques, des services ou les deux  ?",
        "options" : [{
          "id" : "activity/products", "text" : "Produits physiques", "score" : 0
        },{
          "id" : "activity/services", "text" : "Services", "score" : 0
        }]
      },{
        "showIf" : "activity/products",
        "type" : "checkbox",
        "text" : "Quelles matières premières sont utilisées dans le cadre de la fabrication/vente de vos produits ?",
        "options" : [{
          "id" : "materials/plastics", "text" : "Plastique", "score" : 0
        },{
          "id" : "materials/metals", "text" : "Métal (aluminium, fer, or, argent, etc...)", "score" : 0
        },{
          "id" : "materials/organic", "text" : "Animal/végétal (alimentation, textile, etc...)", "score" : 0
        },{
          "id" : "materials/mineral", "text" : "Minéral (sable, gravier, argile, etc...)", "score" : 0
        },{
          "id" : "materials/chemical", "text" : "Chimiques", "score" : 0
        }]
      },{
        "showIf" : "activity/products",
        "type" : "radio",
        "text" : "Vos produits physiques sont-ils éco-concus ?",
        "options" : [{
          "id" : "ecodesign/yes", "text" : "Oui, tous", "score" : 2
        },{
          "id" : "ecodesign/justabit", "text" : "Oui, en partie", "score" : 1
        },{
          "id" : "ecodesign/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "La réflexion amont dans la conception d'un produit ou service permet la réduction à la source des émissions de l'activité de l'entreprise."
        }]
      },{
        "type" : "radio",
        "text" : "Les consommations d'énergie font-elles l'objet d'un suivi (hors facturation) ?",
        "options" : [{
          "id" : "energy/yes", "text" : "Oui et un plan d'action a été mis en place", "score" : 2
        },{
          "id" : "energy/justabit", "text" : "Oui, un suivi est effectué", "score" : 1, "feedback" : "Associer votre suivi des consommations énergétiques à un plan d'actions vous permettra de mesurer les progrès réalisés."
        },{
          "id" : "energy/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Le suivi des factures en données financières globales n'est pas suffisante pour s'assurer de traiter de ce poste d'émission."
        }]
      },{
        "type" : "radio",
        "text" : "Le suivi des déchets de votre activité est-il réalisé ?",
        "options" : [{
          "id" : "trash/yes", "text" : "Oui et un plan d'actions de réduction et revalorisation a été mis en place", "score" : 2
        },{
          "id" : "trash/justabit", "text" : "Oui, un suivi est effectué", "score" : 1
        },{
          "id" : "trash/no", "text" : "Non / Ne sait pas", "score" : 0
        }]
      },{
        "type" : "radio",
        "text" : "Vous êtes-vous déjà questionné sur votre politique de déplacements professionnels d'un point de vue carbone ?",
        "options" : [{
          "id" : "mobility/yes", "text" : "Oui et un plan d'action a été mis en place", "score" : 2
        },{
          "id" : "mobility/justabit", "text" : "Oui, une réflexion a été engagée", "score" : 1
        },{
          "id" : "mobility/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Si entreprise de service : Les déplacements professionnels peuvent représenter une partie importante des émissions de votre entreprise, surtout pour une entreprise de services."
        }]
      },{
        "type" : "radio",
        "text" : "Avez-vous engagé une réflexion sur vos approvisionnements et expéditions responsables ? (Ex : programme EVE)",
        "options" : [{
          "id" : "transport/yes", "text" : "Oui et un plan d'action a été mis en place", "score" : 2
        },{
          "id" : "transport/justabit", "text" : "Oui, une réflexion a été engagée", "score" : 1
        },{
          "id" : "transport/no", "text" : "Non / Ne sait pas", "score" : 0, "feedback" : "Si entreprise de produits : Les émissions du transport font souvent partie des émissions dites significatives d'une entreprise commercialisant des produits."
        }]
      },{
        "type" : "radio",
        "text" : "Avez-vous initié une politique d'achats responsables et de sélection de vos fournisseurs sur leur performance carbone ?",
        "options" : [{
          "id" : "supply/yes", "text" : "Oui", "score" : 1
        },{
          "id" : "supply/no", "text" : "Non", "score" : 0, "feedback" : "La dépendance à la chaine de valeur fait que le poste d'émissions des achats de produits ou services est très souvent un des postes d'émissions prépondérants d'une entreprise. La démarche d'acahts responsables sera déterminante dans la réussite de votre stratégie climat !"
        }]
      },{
        "type" : "radio",
        "text" : "Est-ce que vous avez évalué l’impact du dérèglement climatique sur votre activité ? ",
        "options" : [{
          "id" : "assessImpact/yes", "text" : "Oui et une stratégie d'adaptation au dérèglement climatique a été mise en place", "score" : 2
        },{
          "id" : "assessImpact/justabit", "text" : "Oui, une évaluation des risques a été effectuée", "score" : 1
        },{
          "id" : "assessImpact/no", "text" : "Non / Ne sait pas", "score" : 0
        }]
      },{
        "type" : "radio",
        "text" : "Contribuez vous au développement de puits de carbone ?",
        "options" : [{
          "id" : "sinks/yes", "text" : "Oui, c'est réalisé", "score" : 2
        },{
          "id" : "sinks/justabit", "text" : "Oui, c'est envisagé", "score" : 1
        },{
          "id" : "sinks/no", "text" : "Non / Ne sait pas", "score" : 0 }]
      }]
    }]
  }