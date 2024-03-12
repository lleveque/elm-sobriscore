var data =
{
  "title" : "Sobriscore",
  "subtitle" : "Évaluez votre maturité Climat et RSE",
  "intro" : "# Évaluez votre maturité Climat et RSE\nLa transition écologique est un enjeu majeur pour les entreprises. Face à la réglementation et aux étapes nécessaires pour réaliser sa transition, il est parfois difficile de s'y retrouver. Si vous vous sentez perdu face à ce défi, alors vous êtes au bon endroit : **évaluez votre Sobriscore** !\n\nEco CO2 a développé l’outil Sobriscore pour mesurer la maturité climat de votre entreprise, en 5 minutes chrono !\n# Pourquoi le Sobriscore ?\nSimple et rapide, le questionnaire met en lumière :\n* Votre **niveau de maturité** sur le changement climatique et votre démarche RSE\n* Des **pistes prioritaires** pour agir en faveur de la transition écologique dans votre structure\n* Les enjeux de l’action pour votre secteur d’activité, sous la forme de **risques et opportunités**\nVotre synthèse Sobriscore est un véritable outil de travail au service de votre démarche de sobriété pour accélérer votre transition écologique.\n\nLe Sobriscore est un outil développé par Eco CO2, société de conseil et de formation en transition écologique.",
  "companyForm":
  { "sections" :
    [
      {
        "text" : "Votre entreprise et vous",
        "questions":
        [
          {
            "type" : "text",
            "text" : "Quel est votre nom/prénom ?",
            "options" :
            [
              {
                "id" : "name/example", "text" : "Jean-Michel Jarre", "score" : 0
              }
            ]
          },
          {
            "type" : "text",
            "text" : "Quel est votre adresse email ?",
            "options" :
            [
              {
                "id" : "email/example", "text" : "jean-michel@jarre.fr", "score" : 0
              }
            ]
          },
          {
            "type" : "checkbox",
            "text" : "Lire notre [politique de confidentialité](https://www.ecoco2.com/politique-de-confidentialite/)",
            "options" :
            [
              {
                "id" : "privacy/agreed", "text" : "J'ai pris connaissance de la politique de confidentialité et j'autorise Eco CO2 à m'envoyer des informations.", "score" : 0
              }
            ]
          },
          {
            "type" : "text",
            "text" : "Quel est le nom de votre entreprise ?",
            "options" :
            [
              {
                "id" : "company/example", "text" : "CHEF (Compagnie des harpes électroniques françaises)", "score" : 0
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Quel est votre intitulé de poste ?",
            "options" :
            [
              {
                "id" : "job/rse", "text" : "Responsable/chargé de développement durable/RSE", "score" : 0
              },
              {
                "id" : "job/quality", "text" : "Responsable/chargé de Qualité/QSE", "score" : 0
              },
              {
                "id" : "job/corporate", "text" : "Fonctions supports : RH, Comptabilité, Commercial,...", "score" : 0
              },
              {
                "id" : "job/director", "text" : "Président/Directeur général", "score" : 0
              },
              {
                "id" : "job/other", "text" : "Autre", "score" : 0
              }
            ]
          },
          {
            "showIf" : "job/other",
            "type" : "text",
            "text" : "Votre intitulé de poste :",
            "options" :
            [
              {
                "id" : "otherJob/title", "text" : "Product designer", "score" : 0
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Quelle est la taille de votre entreprise (nombre d’employés) ?",
            "options" :
            [
              {
                "id" : "size/tpe", "text" : "TPE : moins de 10 salariés", "score" : 0
              },
              {
                "id" : "size/pme", "text" : "PME : entre 10 et 250 salariés", "score" : 0
              },
              {
                "id" : "size/eti", "text" : "ETI : entre 250 et 5 000 salariés", "score" : 0
              },
              {
                "id" : "size/large", "text" : "Grande entreprise : plus de 5 000 salariés", "score" : 0
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Êtes-vous soumis à la DPEF/ CSRD ?",
            "options" :
            [
              {
                "id" : "dpef/yes", "text" : "Oui", "score" : 0
              },
              {
                "id" : "dpef/no", "text" : "Non", "score" : 0
              },
              {
                "id" : "dpef/unknown", "text" : "Je ne sais pas", "score" : 0
              }
            ]
          },
          {
            "type" : "checkbox",
            "text" : "Comment est orienté votre business ?",
            "options" :
            [
              {
                "id" : "bizModel/b2b", "text" : "B2B : vos clients sont des professionnels", "score" : 0
              },
              {
                "id" : "bizModel/b2c", "text" : "B2C : vos clients sont des particuliers", "score" : 0
              }
            ]
          },
          {
            "type" : "checkbox",
            "text" : "Où votre/vos site(s) sont-ils géographiquement implanté(s) ?",
            "options" :
            [
              {
                "id" : "location/france", "text" : "France", "score" : 0
              },
              {
                "id" : "location/europe", "text" : "Europe", "score" : 0
              },
              {
                "id" : "location/world", "text" : "Hors Europe", "score" : 0
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Quel est le secteur d'activité principal de votre entreprise ?",
            "options" :
            [
              {
                "id" : "sector/services", "text" : "Services (études, enseignement, administratif, etc)", "score" : 0
              },
              {
                "id" : "sector/agriculture", "text" : "Agriculture, sylviculture, pêche", "score" : 0
              },
              {
                "id" : "sector/food", "text" : "Agroalimentaire", "score" : 0
              },
              {
                "id" : "sector/transport", "text" : "Transport, logistique", "score" : 0
              },
              {
                "id" : "sector/energy", "text" : "Energie", "score" : 0
              },
              {
                "id" : "sector/construction", "text" : "Construction", "score" : 0
              },
              {
                "id" : "sector/banking", "text" : "Banque, assurance, fonds d'investissements", "score" : 0
              },
              {
                "id" : "sector/tourism", "text" : "Hébergement, restauration, tourisme", "score" : 0
              },
              {
                "id" : "sector/health", "text" : "Santé et social", "score" : 0
              },
              {
                "id" : "sector/trading", "text" : "Commerce, négoce, distribution", "score" : 0
              },
              {
                "id" : "sector/chemical", "text" : "Chimie, parachimie, pétrochimie, pharmaceutique", "score" : 0
              },
              {
                "id" : "sector/software", "text" : "Informatique, télécoms", "score" : 0
              },
              {
                "id" : "sector/clothing", "text" : "Textile, habillement, chaussure", "score" : 0
              },
              {
                "id" : "sector/manufacture", "text" : "Industrie manufacturière (transformations de biens)", "score" : 0
              },
              {
                "id" : "sector/arts", "text" : "Arts, spectacles, activités culturelles", "score" : 0
              },
              {
                "id" : "sector/waste", "text" : "Gestion eau et déchet", "score" : 0
              }
            ]
          }
        ]
      },
    ]
  },
  "climateForm":
  {
    "sections" :
    [
      {
        "text" : "Votre connaissance des enjeux",
        "questions":
        [
          {
            "type" : "radio",
            "text" : "Sauriez-vous expliquer dans votre entreprise ce qu'est le changement climatique et comment votre entreprise impacte le climat avec des exemples ?",
            "options" :
            [
              {
                "id" : "canexplain/yes", "text" : "Oui", "score" : 10
              },
              {
                "id" : "canexplain/no", "text" : "Non", "score" : 0, "feedback" : "La connaissance du changement climatique et la capacité à l'expliquer en précisant le rôle de l'entreprise est le commencement de la démarche."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Connaissez-vous les obligations réglementaires auxquelles vous êtes soumis en matière d'émissions de GES ?",
            "options" :
            [
              {
                "id" : "knowlaw/yes", "text" : "Oui", "score" : 5
              },
              {
                "id" : "knowlaw/no", "text" : "Non", "score" : 0, "feedback" : "La [réglementation BEGES](https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000048246757) impose notamment l'établissement d'un bilan d'émissions de gaz à effet de serre pour toute entreprise de plus de 500 salariés."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Avez-vous identifié les risques & opportunités liés au changement climatique sur l'activité de votre entreprise ?",
            "options" :
            [
              {
                "id" : "knowrisksandoppo/yes", "text" : "Oui", "score" : 10
              },
              {
                "id" : "knowrisksandoppo/no", "text" : "Non", "score" : 0, "feedback" : "Vous n'avez pas encore identifé les risques et opportunités liés au changement climatique. L'identification des risques et opportunités liés au changement climatique fait partie intégrante de la mise en place d'une stratégie climat."
              },
              {
                "id" : "knowrisksandoppo/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Vous n'avez pas encore identifé les risques et opportunités liés au changement climatique. L'identification des risques et opportunités liés au changement climatique fait partie intégrante de la mise en place d'une stratégie climat."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Est-ce qu’un bilan d'émissions de gaz à effet de serre ou bilan carbone a déjà été réalisé dans votre entreprise ?",
            "options" :
            [
              {
                "id" : "didAssess/yes", "text" : "Oui", "score" : 10
              },
              {
                "id" : "didAssess/noButWillDo", "text" : "Non, mais il est prévu d'en faire un cette année", "score" : 5, "feedback" : "La réalisation d'un BEGES est simplifiée par le passage via un prestataire extérieur. Eco CO2 peut vous accompagner."
              },
              {
                "id" : "didAssess/no", "text" : "Non", "score" : 0, "feedback" : "Connaitre les principaux postes d'émissions de GES de votre entreprise est le premier pas d'une stratégie climat efficace."
              },
              {
                "id" : "didAssess/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Connaitre les principaux postes d'émissions de GES de votre entreprise est le premier pas d'une stratégie climat efficace."
              }
            ]
          },
          {
            "showIf" : "didAssess/yes",
            "type" : "radio",
            "text" : "Il y a combien de temps ?",
            "options" :
            [
              {
                "id" : "dateAssess/between13y", "text" : "Entre 1 et 3 ans", "score" : 10, "feedback" : "Votre dernier Bilan GES est récent, c'est bien ! Assurez-vous de le mettre régulièrement à jour pour faire évoluer votre stratégie climat dans le temps."
              },
              {
                "id" : "dateAssess/more3y", "text" : "Il y a plus de 3 ans", "score" : 5, "feedback" : "Mettre à jour votre Bilan GES est important pour s'assurer des évolutions de votre stratégie climat dans le temps."
              }
            ]
          },
          {
            "showIf" : "didAssess/yes",
            "type" : "radio",
            "text" : "Sur quel périmètre portait-il ? ",
            "options" :
            [
              {
                "id" : "assessScopes/oneTwo", "text" : "**Scopes 1 et 2**\n* Émissions directes\n* Émissions indirectes liées à l'électricité\n\n ⇨ Les **consommations d'énergie** de votre entreprise et **autres émissions directes**", "score" : 5, "feedback" : "Limiter l'évaluation des vos émissions de gaz à effet de serre de votre entreprise isolément de votre chaine de valeur n'est pas suffisant pour agir sur l'ensemble de votre impact sur le climat."
              },
              {
                "id" : "assessScopes/oneTwoThree", "text" : "**Scopes 1, 2 et 3**\n* Émissions directes\n* Émissions indirectes liées à l'électricité\n* Émissions indirectes de votre chaîne de valeur (fournisseurs, clients, salariés)\n\n ⇨ Les **consommations d'énergie** de votre entreprise, les **autres émissions directes** et **les achats, le fret, les déplacements, les immobilisations matérielles et immatérielles**, etc...", "score" : 15, "feedback" : "Connaitre les principaux postes d'émissions de GES de votre entreprise est le premier pas d'une stratégie climat efficace."
             
              },
              {
                "id" : "assessScopes/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Connaitre les principaux postes d'émissions de GES de votre entreprise est le premier pas d'une stratégie climat efficace."
             
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Votre entreprise a-t-elle fixé des objectifs de décarbonation ?",
            "options" :
            [
              {
                "id" : "hasObj/yes", "text" : "Oui", "score" : 0
              },
              {
                "id" : "hasObj/no", "text" : "Non", "score" : 0, "feedback" : "Bien que calculer ses émissions de GES soit un premier pas, se fixer des objectifs de réduction des émissions à court, moyen et long terme est nécessaire."
              },
              {
                "id" : "hasObj/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Bien que calculer ses émissions de GES soit un premier pas, se fixer des objectifs de réduction des émissions à court, moyen et long terme est nécessaire."
              }
            ]
          },
          {
            "showIf" : "hasObj/yes",
            "type" : "checkbox",
            "text" : "À quelle échéance ?",
            "options" :
            [
              {
                "id" : "objTerm/short", "text" : "Court terme (1 - 3ans)", "score" : 5
              },
              {
                "id" : "objTerm/medium", "text" : "Moyen terme  (3 - 10 ans)", "score" : 5
              },
              {
                "id" : "objTerm/long", "text" : "Long terme (10 - 30 ans)", "score" : 5
              }
            ]
          },
          {
            "showIf" : "hasObj/yes",
            "type" : "radio",
            "text" : "Ces objectifs sont-ils compatibles avec les accords de Paris et une trajectoire à +1,5°C ou 2°C ?",
            "options" :
            [
              {
                "id" : "parisCompat/yes", "text" : "Oui", "score" : 10
              },
              {
                "id" : "parisCompat/no", "text" : "Non", "score" : 0, "feedback" : "Les accord internationaux et leur déclinaison politique française (SNBC) sont ambitieux et peuvent constituer un cadre intéressant à suivre pour vos objectifs."
              },
              {
                "id" : "parisCompat/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Les accord internationaux et leur déclinaison politique française (SNBC) sont ambitieux et peuvent constituer un cadre intéressant à suivre pour vos objectifs."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Y’a-t-il une réflexion marketing/produit/service bas-carbone dans la stratégie de votre entreprise ?",
            "options" :
            [
              {
                "id" : "goodThinking/yes", "text" : "Oui", "score" : 10
              },
              {
                "id" : "goodThinking/no", "text" : "Non", "score" : 0, "feedback" : "Aujourd'hui, avoir des offres bas carbone est un avantage commercial intéressant."
              },
              {
                "id" : "goodThinking/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Aujourd'hui, avoir des offres bas carbone est un avantage commercial intéressant."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Est-ce que vous orientez vos investissements vers la transition écologique ?",
            "options" :
            [
              {
                "id" : "investGreen/yes", "text" : "Oui, c'est un critère essentiel", "score" : 5
              },
              {
                "id" : "investGreen/justabit", "text" : "Oui, à la marge", "score" : 3, "feedback" : "Investir dans la TEE c’est contribuer à lutter contre le réchauffement climatique en orientant son épargne vers les fonds qui ont mis cet objectif au cœur de leur processus d'investissement."
              },
              {
                "id" : "investGreen/no", "text" : "Non", "score" : 0
              },
              {
                "id" : "investGreen/unknown", "text" : "Je ne sais pas", "score" : 0
              }
            ]
          }
        ]
      },
      {
        "text" : "Votre pilotage de la démarche climat",
        "questions":
        [
          {
            "type" : "radio",
            "text" : "Y’a-t-il une équipe ou des personnes qui ont cette mission climat/carbone dans leur fiche de poste ?",
            "options" :
            [
              {
                "id" : "anyoneInCharge/yes", "text" : "Oui", "score" : 0
              },
              {
                "id" : "anyoneInCharge/no", "text" : "Non", "score" : 0, "feedback" : "Responsabiliser dans les fonctions d'une ou plusieurs personnes permet de stabiliser dans le temps les progrès et le suivi dans le temps de la stratégie climat."
              },
              {
                "id" : "anyoneInCharge/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Responsabiliser dans les fonctions d'une ou plusieurs personnes permet de stabiliser dans le temps les progrès et le suivi dans le temps de la stratégie climat."
              }
            ]
          },
          {
            "showIf" : "anyoneInCharge/yes",
            "type" : "radio",
            "text" : "De qui s'agit-il ?",
            "options" :
            [
              {
                "id" : "whoInCharge/looseteam", "text" : "Une équipe composée de volontaires au sein de l'entreprise (mission non incluse dans leur fiche de poste)", "score" : 5
              },
              {
                "id" : "whoInCharge/looseone", "text" : "La mission est une composante d'un poste d'une ou plusieurs personnes", "score" : 15
              },
              {
                "id" : "whoInCharge/fullone", "text" : "Un poste à temps plein est présent", "score" : 20
              },
              {
                "id" : "whoInCharge/fullteam", "text" : "Une équipe est dédiée à ces sujets (minimum 2 personnes)", "score" : 25
             
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Avez-vous mis en place un plan de transition ?",
            "options" :
            [
              {
                "id" : "hasPlan/yes", "text" : "Oui", "score" : 0, "feedback" : "Aller plus loin en s'incrivant dans une initiative comme les SBTi"
              },
              {
                "id" : "hasPlan/no", "text" : "Non", "score" : 0, "feedback" : "Bien que calculer ses émissions de GES soit un premier pas, que se fixer des objectifs est nécessaire, l'étape cruciale est la mise en place d'un plan de transition."
              },
              {
                "id" : "hasPlan/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Bien que calculer ses émissions de GES soit un premier pas, que se fixer des objectifs est nécessaire, l'étape cruciale est la mise en place d'un plan de transition."
              }
            ]
          },
          {
            "showIf" : "hasPlan/yes",
            "type" : "checkbox",
            "text" : "À quelle échéance ?",
            "options" :
            [
              {
                "id" : "planTerm/short", "text" : "Court terme (1 - 3ans)", "score" : 10
              },
              {
                "id" : "planTerm/medium", "text" : "Moyen terme  (3 - 10 ans)", "score" : 10
              },
              {
                "id" : "planTerm/long", "text" : "Long terme (10 - 30 ans)", "score" : 15
              }
            ]
          },
          {
            "showIf" : "hasPlan/yes",
            "type" : "radio",
            "text" : "Y'a-t-il eu une quantification du potentiel de gain des actions identifiées ?",
            "options" :
            [
              {
                "id" : "gainEval/yes", "text" : "Oui", "score" : 20
              },
              {
                "id" : "gainEval/no", "text" : "Non", "score" : 0, "feedback" : "Aller au-delà de l'établissement d'une liste d'actions en quantifiant les gains potentiels permet à l'organisation de pouvoir prioriser les actions à fort gain potentiel, et de comparer ce gain au coût économique de mise en place de l'action"
              },
              {
                "id" : "gainEval/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Aller au-delà de l'établissement d'une liste d'actions en quantifiant les gains potentiels permet à l'organisation de pouvoir prioriser les actions à fort gain potentiel, et de comparer ce gain au coût économique de mise en place de l'action"
              }
            ]
          },
          {
            "showIf" : "hasPlan/yes",
            "type" : "radio",
            "text" : "Le plan de transition vit-il à travers un comité \"carbone\" ou équivalent : suivi, mise en œuvre, responsabiltés, ajustements, etc. ?",
            "options" :
            [
              {
                "id" : "committee/yes", "text" : "Oui", "score" : 20
              },
              {
                "id" : "committee/no", "text" : "Non", "score" : 0
              },
              {
                "id" : "committee/unknown", "text" : "Je ne sais pas", "score" : 0
              }
            ]
          }
        ]
      },
      {
        "text" : "Votre passage à l'action",
        "questions":
        [
          {
            "type" : "radio",
            "text" : "Avez-vous déjà organisé des ateliers de formation/sensibilisation de vos équipes au développement durable ?",
            "options" :
            [
              {
                "id" : "workshops/yes", "text" : "Oui", "score" : 10, "feedback" : "Concernant la sensibilisation, n'hésitez pas à aller plus loin en effectuant des formations ciblées aux types de profilss/métiers."
              },
              {
                "id" : "workshops/no", "text" : "Non", "score" : 0, "feedback" : "Mettre en place des formations ou sensibilisations permet une compréhension accrue des enjeux climatiques et un passage à l'action facilitée."
              },
              {
                "id" : "workshops/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Mettre en place des formations ou sensibilisations permet une compréhension accrue des enjeux climatiques et un passage à l'action facilitée."
              }
            ]
          },
          {
            "type" : "checkbox",
            "text" : "Fournissez-vous des produits physiques, des services ou les deux  ?",
            "options" :
            [
              {
                "id" : "activity/products", "text" : "Produits physiques", "score" : 0
              },
              {
                "id" : "activity/services", "text" : "Services", "score" : 0
              }
            ]
          },
          {
            "showIf" : "activity/products",
            "type" : "checkbox",
            "text" : "Quelles matières premières sont utilisées dans le cadre de la fabrication/vente de vos produits ?",
            "options" :
            [
              {
                "id" : "materials/plastics", "text" : "Plastique", "score" : 0, "feedback" : "Outre le fait que le plastique est dérivé des combustibles fossiles, son élimination incorrecte a conduit à une quantité sans précédent de plastique dans notre environnement. La pression sociétale augmente et de plus en plus d'entreprises se tournent vers des alternatives à base de bioéthanol/dérivés de plantes, qui absorbe du CO2 pendant leur croissance, et se décomposent plus facilement en matériaux inoffensifs. Il est nécessaire de rechercher des solutions alternatives ou en plastique recyclés et recylables pour minimiser l'utilisation de plastique dans votre entreprise."
              },
              {
                "id" : "materials/metals", "text" : "Métal (aluminium, fer, or, argent, etc...)", "score" : 0, "feedback" : "L'extraction de minerai métallique et leur transformation consomment beaucoup d'énergie et de ressources (eau). Ces processus, s'ils ne sont pas reglementé, peuvent poser une menace pour l'environnement : dégradation et contaminiation des habitats notamment. Les prix du fer et de l'aluminium augmentent et des problèmes soci-économiques (tel que les guerres) peuvent fortement impacter votre chaine de valeur."
              },
              {
                "id" : "materials/wood", "text" : "Papier/carton/bois", "score" : 0, "feedback" : "Bien que le bois (et ses dérivés) soit un matériau renouvelable et facilement disponible, la gestion irresponsable des forêts peut entraîner une perte d'habitat et de biodiversité. Il est important de veiller à ce que les chaînes d'approvisionnement soient responsables et certifiées afin de garantir des sources durables. Bien que le papier et carton recyclables soient présentés comme des alternatives plus durable, ils impliquent des processus à forte intensité énergétique. Il est donc important de garder la sobriété comme premier levier dans la fabrication de vos produits."
              },
              {
                "id" : "materials/organic", "text" : "Animal/végétal (alimentation, textile, etc...)", "score" : 0, "feedback" : "L'élévage des animaux consomment beaucoup de ressources en terme d'eau et de nourriture (la principale cause de dégradation des forêts dans le monde est l'agriculture). L'agriculture est la deuxième source des émissions de GES en France.\n\nLes sécheresses vont probablement augmenter dans les années à venir et vont fortement impacter la répartition des zones où les plantes peuvent pousser en Europe, ce qui entraînera des problèmes dans les chaînes d'approvisionnement.\n\nLes dérivés des plantes et animaux sont utilisés dans de nombreuses industries (alimentaire, cosmétique, automobile, textile...) et la recherche d'alternatives plus durables (cuir végétal, plats végétaliens/végétariens...) sera nécessaire pour diminuer notre impact environnemental. "
              },
              {
                "id" : "materials/mineral", "text" : "Minéral (sable, gravier, argile, etc...)", "score" : 0, "feedback" : "Comme pour les métaux et les autres industries extractives, l'extraction des minéraux, bien qu'essentielle pour fournir les éléments constitutifs de nos sociétés modernes, nécessite beaucoup de ressources (eau et énergies fossiles). La destruction de l'habitat et la pollution de l'environnement sont les principales préoccupations liées à l'utilisation des minéraux. Le changement d'affectation des terres entraîne d'importantes émissions de gaz à effet de serre également."
              },
              {
                "id" : "materials/chemical", "text" : "Chimiques", "score" : 0, "feedback" : "De nombreux produits chimiques (peintures, lubrifiants industriels, solvants, produits de nettoyage...) que nous utilisons aujourd'hui sont des dérivés du pétrole et nécessitent des processus à forte intensité énergétique (chauffage et refroidissement). D'origine synthétique, ils sont souvent toxiques pour l'environnement et une grande attention doit être portée au contrôle de l'utilisation et de l'élimination de ces produits chimiques. Dans la mesure du possible, des alternatives d'origine naturelle doivent être étudiées pour limiter l'impact environnemental des produits manufacturés et diminuer les émissions de GES conséquentes."
              }
            ]
          },
          {
            "showIf" : "activity/products",
            "type" : "radio",
            "text" : "Vos produits physiques sont-ils éco-concus ?",
            "options" :
            [
              {
                "id" : "ecodesign/yes", "text" : "Oui, tous", "score" : 5
              },
              {
                "id" : "ecodesign/justabit", "text" : "Oui, en partie", "score" : 3
              },
              {
                "id" : "ecodesign/no", "text" : "Non", "score" : 0, "feedback" : "La réflexion amont dans la conception d'un produit ou service permet la réduction à la source des émissions de l'activité de l'entreprise."
              },
              {
                "id" : "ecodesign/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "La réflexion amont dans la conception d'un produit ou service permet la réduction à la source des émissions de l'activité de l'entreprise."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Les consommations d'énergie font-elles l'objet d'un suivi (hors facturation) ?",
            "options" :
            [
              {
                "id" : "energy/yes", "text" : "Oui et un plan d'action a été mis en place", "score" : 20
              },
              {
                "id" : "energy/justabit", "text" : "Oui, un suivi est effectué", "score" : 15, "feedback" : "Associer votre suivi des consommations énergétiques à un plan d'actions vous permettra de mesurer les progrès réalisés."
              },
              {
                "id" : "energy/no", "text" : "Non", "score" : 0, "feedback" : "Le suivi des factures en données financières globales n'est pas suffisante pour s'assurer de traiter de ce poste d'émission."
              },
              {
                "id" : "energy/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Le suivi des factures en données financières globales n'est pas suffisante pour s'assurer de traiter de ce poste d'émission."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Le suivi des déchets de votre activité est-il réalisé ?",
            "options" :
            [
              {
                "id" : "trash/yes", "text" : "Oui et un plan d'actions de réduction et revalorisation a été mis en place", "score" : 5, "feedback" : "Depuis juillet 2016, les professionnels ont l’obligation de trier 5 types de déchets (papier/carton, métal, plastique, verre, et bois) dans des poubelles dédiées. C’est le tri 5 flux des déchets."
              },
              {
                "id" : "trash/justabit", "text" : "Oui, un suivi est effectué", "score" : 3, "feedback" : "Depuis juillet 2016, les professionnels ont l’obligation de trier 5 types de déchets (papier/carton, métal, plastique, verre, et bois) dans des poubelles dédiées. C’est le tri 5 flux des déchets."
              },
              {
                "id" : "trash/no", "text" : "Non", "score" : 0, "feedback" : "Depuis juillet 2016, les professionnels ont l’obligation de trier 5 types de déchets (papier/carton, métal, plastique, verre, et bois) dans des poubelles dédiées. C’est le tri 5 flux des déchets."
              },
              {
                "id" : "trash/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "Depuis juillet 2016, les professionnels ont l’obligation de trier 5 types de déchets (papier/carton, métal, plastique, verre, et bois) dans des poubelles dédiées. C’est le tri 5 flux des déchets."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Vous êtes-vous déjà questionné sur votre politique de déplacements professionnels d'un point de vue carbone ?",
            "options" :
            [
              {
                "id" : "mobility/yes", "text" : "Oui et un plan d'action a été mis en place", "score" : 15
              },
              {
                "id" : "mobility/justabit", "text" : "Oui, une réflexion a été engagée", "score" : 10
              },
              {
                "id" : "mobility/no", "text" : "Non", "score" : 0, "showFeedbackIf" : "activity/services", "feedback" : "Les déplacements professionnels peuvent représenter une partie importante des émissions de votre entreprise, surtout pour une entreprise de services."
              },
              {
                "id" : "mobility/unknown", "text" : "Je ne sais pas", "score" : 0, "showFeedbackIf" : "activity/services", "feedback" : "Les déplacements professionnels peuvent représenter une partie importante des émissions de votre entreprise, surtout pour une entreprise de services."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Avez-vous engagé une réflexion sur vos approvisionnements et expéditions responsables ? (Ex : programme EVE)",
            "options" :
            [
              {
                "id" : "transport/yes", "text" : "Oui et un plan d'action a été mis en place", "score" : 20
              },
              {
                "id" : "transport/justabit", "text" : "Oui, une réflexion a été engagée", "score" : 15
              },
              {
                "id" : "transport/no", "text" : "Non", "score" : 0, "showFeedbackIf" : "activity/products", "feedback" : "Les émissions du transport font souvent partie des émissions dites significatives d'une entreprise commercialisant des produits."
              },
              {
                "id" : "transport/unknown", "text" : "Je ne sais pas", "score" : 0, "showFeedbackIf" : "activity/products", "feedback" : "Les émissions du transport font souvent partie des émissions dites significatives d'une entreprise commercialisant des produits."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Avez-vous initié une politique d'achats responsables et de sélection de vos fournisseurs sur leur performance carbone ?",
            "options" :
            [
              {
                "id" : "supply/yes", "text" : "Oui", "score" : 15, "feedback" : "Une politique d’achats responsables permet de réduire les risques et les impacts sociaux et environnementaux, réduire les coûts, notamment liés aux ruptures d’approvisionnement mais aussi de satisfaire la demande des clients, en se tournant vers des produits ou services durables."
              },
              {
                "id" : "supply/no", "text" : "Non", "score" : 0, "feedback" : "La dépendance à la chaine de valeur fait que le poste d'émissions des achats de produits ou services est très souvent un des postes d'émissions prépondérants d'une entreprise. La démarche d'acahts responsables sera déterminante dans la réussite de votre stratégie climat !"
              },
              {
                "id" : "supply/unknown", "text" : "Je ne sais pas", "score" : 0, "feedback" : "La dépendance à la chaine de valeur fait que le poste d'émissions des achats de produits ou services est très souvent un des postes d'émissions prépondérants d'une entreprise. La démarche d'acahts responsables sera déterminante dans la réussite de votre stratégie climat !"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Contribuez vous au développement de puits de carbone ?",
            "options" :
            [
              {
                "id" : "sinks/yes", "text" : "Oui, c'est réalisé", "score" : 10
              },
              {
                "id" : "sinks/justabit", "text" : "Oui, c'est envisagé", "score" : 5
              },
              {
                "id" : "sinks/no", "text" : "Non", "score" : 0
              },
              {
                "id" : "sinks/unknown", "text" : "Je ne sais pas", "score" : 0
              }
            ]
          }
        ]
      }
    ],
    "commonOpportunities" : "# Les opportunités à saisir\n\n- Commerciale : le reporting climat est de plus en plus demander pour répondre à des AO\n- Financière : pour accéder à des financements (de la part d'investisseurs, ou dans le cadre de prêts bancaires)"
  },
  "rseForm":
  {
    "sections" :
    [
      {
        "text" : "Gouvernance",
        "questions":
        [
          {
            "type" : "radio",
            "text" : "L'entreprise a-t-elle mené une reflexion sur ses valeurs, sa raison d'être ou sa mission?",
            "options" :
            [
              {
                "id": "mission/no", "score": 0, "text" : "Non", "feedback" : "Définir sa raison d'être est un premier pas vers une stratégie RSE. La raison d’être d’une entreprise est un outil stratégique, un levier de performance et un élément différenciant pour votre marque employeur."
              },
              {
                "id": "mission/inprogress", "score": 1, "text" : "En cours ", "feedback" : "Il est important de formaliser votre démarche et de définir des indicateurs pertinents pour aligner vos efforts vers des objectifs clairs et d'évaluer  vos progrès "
              },
              {
                "id": "mission/defined", "score": 2, "text" : "Formalisée ", "feedback" : "Il est important de définir des indicateurs pertinents pour aligner vos efforts vers des objectifs clairs et mesurables et d'évaluer vos progrès. Ils fournissent une boussole essentielle pour orienter efficacement les actions et mesurer l'impact des initiatives stratégiques."
              },
              {
                "id": "mission/yes", "score": 3, "text" : "Formalisée avec des objectifs et des indicateurs", "feedback" : "Félicitations votre raison d'être est un signal fort de votre engagement pour vos parties prenantes !"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise intègre-t-elle des critères sur les sujets environnementaux / sociaux dans ses choix stratégiques ?",
            "options" :
            [
              {
                "id": "strategy/no", "score": 0, "text" : "Non", "feedback" : "La mise en place d'une démarche RSE vise à introduire dans les prises de décisions la prise en compte des enjeux sociaux et environnementaux. Il est important que cela se traduise concrétement. "
              },
              {
                "id": "strategy/inprogress", "score": 1, "text" : "En cours "
              },
              {
                "id": "strategy/defined", "score": 2, "text" : "Formalisée ", "feedback" : "Il est important de définir des indicateurs pertinents pour aligner vos efforts vers des objectifs clairs et mesurables et d'évaluer vos progrès. Ils fournissent une boussole essentielle pour orienter efficacement les actions et mesurer l'impact des initiatives stratégiques."
              },
              {
                "id": "strategy/yes", "score": 3, "text" : "Formalisée avec des objectifs et des indicateurs"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Existe-t-il une politique RSE ?",
            "options" :
            [
              {
                "id": "policy/no", "score": 0, "text" : "Non", "feedback" : "La mise en place d'une politique RSE (Responsabilité Sociétale des Entreprises) est essentielle pour intégrer des pratiques durables et éthiques, répondant aux enjeux sociaux, environnementaux et éthiques, tout en renforçant la réputation et la pérennité de l'entreprise."
              },
              {
                "id": "policy/inprogress", "score": 1, "text" : "En cours "
              },
              {
                "id": "policy/defined", "score": 2, "text" : "Formalisée ", "feedback" : "Il est important de définir des indicateurs pertinents pour aligner vos efforts vers des objectifs clairs et mesurables et d'évaluer vos progrès. Ils fournissent une boussole essentielle pour orienter efficacement les actions et mesurer l'impact des initiatives stratégiques."
              },
              {
                "id": "policy/yes", "score": 3, "text" : "Formalisée avec des objectifs et des indicateurs", "feedback" : "Grace à votre politique RSE, vous avez des bases solides et une boussole pour guider vos actions ! Il est maintenant important de bien suivre vos indicateurs et de fixer des objectifs ambitieux et de tout mettre en œuvre pour les atteindre ! "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Existe-t-il une ou plusieurs personnes responsables de la politique RSE ?",
            "options" :
            [
              {
                "id": "anyoneforRSE/no", "score": 0, "text" : "Non", "feedback" : "Il est important de nommer un.e /des personnes en charge de la politique RSE pour porter le sujet et assurer sa mise en œuvre et s'assurer une intégration réussie des pratiques responsables au sein de l'entreprise."
              },
              {
                "id": "anyoneforRSE/notAMission", "score": 1, "text" : "Oui mais en dehors de sa/ leurs fiches de postes ", "feedback" : "Intégrer cette mission à la fiche de poste permet de garantir que le porteur peut avoir du temps et des ressources à sa disposition pour mener à bien sa mission et qu'il s'agit effectivement d'une priorité de l'entreprise"
              },
              {
                "id": "anyoneforRSE/partTime", "score": 2, "text" : "Oui à temps partiel "
              },
              {
                "id": "anyoneforRSE/fullTime", "score": 3, "text" : "Oui à temps plein"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Connaissez-vous et suivez-vous les évolutions réglementaires qui s'appliquent à l'entreprise en matière de RSE ?",
            "options" :
            [
              {
                "id": "followRSElaw/no", "score": 0, "text" : "Non", "feedback" : "La connaissance des obligations réglementaires est absolument nécessaire. Il vous faut mettre en place une veille pour identifier vos obligations en terme de réglementation sociale (droit du travail, convention collective), envrionnementale et économique. "
              },
              {
                "id": "followRSElaw/notApplied", "score": 1, "text" : "Les réglementations sont connues mais pas toutes appliquées ", "feedback" : "Le respect des réglementations est le premier principe de la RSE. Ne pas les appliquer vous expose à des risques importants. Il vous faut mettre en place un plan de mise en conformité. "
              },
              {
                "id": "followRSElaw/applied", "score": 2, "text" : "Oui l'ensemble des réglementations y compris environnementale sont connues et appliquées "
              },
              {
                "id": "followRSElaw/yes", "score": 3, "text" : "Oui les réglementations sont connues, appliquées et une veille est mise en place pour anticiper les évolutions réglementaires"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Avez-vous fait un travail d'identification de vos parties prenantes ?",
            "options" :
            [
              {
                "id": "knowStakeholders/no", "score": 0, "text" : "Non", "feedback" : "Connaître vos parties prenantes vous permet d'anticiper et de répondre de manière proactive aux attentes, besoins et préoccupations de ces acteurs, renforçant ainsi la confiance, la légitimité et la durabilité de vos activités. Commencez par mettre en place cette cartographie. "
              },
              {
                "id": "knowStakeholders/mainlyIdentified", "score": 1, "text" : "Oui les parties prenantes principales sont identifiées ", "feedback" : "Une fois les parties prenantes identifiées, il est important de définir quel type d'influence vous exercez/ pouvez exercer sur elle. Cela définit votre sphère d'influence, c'est-à dire votre capacité à influer sur les décision ou  les activités d'autres opganisations et donc votre périmètre étendu de responsabilité."
              },
              {
                "id": "knowStakeholders/identified", "score": 2, "text" : "Oui les parties prenantes et l'influence exercées sur elles sont identifiées ", "feedback" : "Maintenant que votre sphère d'influence est définie, mettez en place des échanges pour mieux comprendre les attentes et les intérets de vos parties prenantes et aisni identifier les opportunités d'amélioration."
              },
              {
                "id": "knowStakeholders/yes", "score": 3, "text" : "Oui les parties prenantes et l'influence exercées sur elles sont identifiées et un dialogue régulier est mis en place pour identiifer dans le temps leurs attentes, intérets et stratégies vis à vis de la RSE "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Diriez vous que les salariés et dirigeants sont sensibilisés aux enjeux de la RSE ?",
            "options" :
            [
              {
                "id": "allInformed/no", "score": 0, "text" : "Non", "feedback" : "L'implication des salariés dans la RSE est non seulement nécessaire à sa bonne mise en œuvre mais également une oportunité de créer un projet d'entreprise motivant et porteur de sens qui fidèlise et attire de nouveaux talents. "
              },
              {
                "id": "allInformed/later", "score": 1, "text" : "une sensibilisation sur au moins un sujet est envisagée ", "feedback" : "L'implication des salariés dans la RSE est non seulement nécessaire à sa bonne mise en œuvre mais également une oportunité de créer un projet d'entreprise motivant et porteur de sens qui fidèlise et attire de nouveaux talents. DE nombreux ateleirs de sensibilisation sur les suejts sociétauxe et environnementaux existent ! "
              },
              {
                "id": "allInformed/sometimes", "score": 2, "text" : "des sensibilisation sont occasionnellement menées "
              },
              {
                "id": "allInformed/regularly", "score": 3, "text" : "des sensibilisations sur tous les enjeux sont régulièrement organisées "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Les salariés sont-ils impliqués dans le management et les décisions stratégiques de l'entreprise ?",
            "options" :
            [
              {
                "id": "employeesHeard/no", "score": 0, "text" : "Non"
              },
              {
                "id": "employeesHeard/sometimes", "score": 1, "text" : "Oui des consultations sont ponctuellement réalisées "
              },
              {
                "id": "employeesHeard/regularly", "score": 2, "text" : "Oui l'avis des salariés est régulièrement sollicité "
              },
              {
                "id": "employeesHeard/yes", "score": 3, "text" : "Oui les salariés sont partie prenante de la prise de décision"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise communique t'elle de façon transparente sur ses données économiques, sociales et environnementales  (mise à disposition du rapport de développement durable, charte d’engagement,  informations sociales, sociétales et environnementales) ?",
            "options" :
            [
              {
                "id": "corpComms/no", "score": 0, "text" : "Non", "feedback" : "Il est important de communiquer pour mettre en valeur vos actions et inspirer votre chaine de valeur. Les obligations en la matière se renforce avec l'entrée en vigueur de la CSRD (voir notre article)"
              },
              {
                "id": "corpComms/later", "score": 1, "text" : "Non mais envisagé ", "feedback" : "Il est important de communiquer pour mettre en valeur vos actions et inspirer votre chaine de valeur. Les obligations en la matière se renforce avec l'entrée en vigueur de la CSRD (voir notre article)"
              },
              {
                "id": "corpComms/partly", "score": 2, "text" : "Oui une communication partielle est faite "
              },
              {
                "id": "corpComms/yes", "score": 3, "text" : "Oui uen communication complète et régulière est faite "
              }
            ]
          }
        ]
      },
      {
        "text" : "Modèle d'affaire et relations clients",
        "questions":
        [
          {
            "type" : "radio",
            "text" : "L'entreprise  propose-t-elle des offres ou produits responsables, ayant un impact social ou environnemental positif??",
            "options" :
            [
              {
                "id": "responsibleProducts/no", "score": 0, "text" : "Non", "feedback" : "L'une des façons de contribuer à la durabilité est de proposer à vos clients des services et produits qui leurs permettent d'agir sur un des pilliers du développement durable. Une reflexion peut etre menée pour adapter vos produits et services en ce sens en lien avec votre raison d'être"
              },
              {
                "id": "responsibleProducts/one", "score": 1, "text" : "Oui au moins un produit ou un service "
              },
              {
                "id": "responsibleProducts/most", "score": 2, "text" : "Oui la plupart des produits ou services contribuent aux enjeux du développement durable "
              },
              {
                "id": "responsibleProducts/all", "score": 3, "text" : "Oui les produits ou services sont exemplaires ou innovants en matière d'impact social ou environnemental"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Avez-vous intégré  une démarche d’innovation et de conception responsable pour vos produits et services ?",
            "options" :
            [
              {
                "id": "responsibleDesign/no", "score": 0, "text" : "Non", "feedback" : "l'écoconception permet de réduire la dépendance aux matières premières et aux énergies et donc de faire des écnomies. Pensez-y ! "
              },
              {
                "id": "responsibleDesign/later", "score": 1, "text" : "Non mais envisagé ", "feedback" : "La BPI aide les entreprises de moins de 250 salariés dans cette voie via le diagnostic Ecoconception"
              },
              {
                "id": "responsibleDesign/one", "score": 2, "text" : "Oui pour au moins un produit ou service "
              },
              {
                "id": "responsibleDesign/yes", "score": 3, "text" : "Oui de façon systématique "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Etes vous impliqué dans une ou plusieurs démarches de certification de l’entreprise ou des produits (Bcorp, ISO, Ecovadis) ?",
            "options" :
            [
              {
                "id": "certif/no", "score": 0, "text" : "Non", "feedback" : "Les démarches de certifications vous permettent de rejoindre une communauité d'entreprises engagées, de progresser et de valoriser ses actions. Une démarche volontaire peut être un bon point de départ"
              },
              {
                "id": "certif/one", "score": 1, "text" : "Oui, une démarche "
              },
              {
                "id": "certif/multiple", "score": 2, "text" : "Oui, plusieures démarches ", "feedback" : "Se faire certifier par un orgnisme extérieur permet de garantir la fiabilité et la qualité de vos engagements en plus de bénéficier d'un regard externe experte sur vos pratiques et de conseils personnalisés."
              },
              {
                "id": "certif/multipleAndTrusted", "score": 3, "text" : "Oui plusieurs démarches dont au moins une certifiée par un organisame de confiance "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise a't'elle un processus de collecte et traitement des réclamations et litiges ?",
            "options" :
            [
              {
                "id": "support/no", "score": 0, "text" : "Non"
              },
              {
                "id": "support/later", "score": 1, "text" : "Non mais envisagé "
              },
              {
                "id": "support/partly", "score": 2, "text" : "Oui partiellement "
              },
              {
                "id": "support/yes", "score": 3, "text" : "Oui dans le cadre d'une politique régulière suivie"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise sensibilise t'elle ses clients aux enjeux du développement durable et à l'utilisation durable et raisonnée de ses produits et ou services ?",
            "options" :
            [
              {
                "id": "teachClients/no", "score": 0, "text" : "Non", "feedback" : "Sensibiliser vos parties prenantes aux enjeux de durabilité leur permet de mieux comprendre vos engagements et de les embarquer dans votre démarche "
              },
              {
                "id": "teachClients/later", "score": 1, "text" : "Non mais envisagé "
              },
              {
                "id": "teachClients/sometimes", "score": 2, "text" : "Oui ponctuellement "
              },
              {
                "id": "teachClients/yes", "score": 3, "text" : "Oui de façon régulière et sur plusieurs enjeux "
              }
            ]
          }
        ]
      },
      {
        "text" : "Relations et conditions de travail",
        "questions":
        [
          {
            "type" : "radio",
            "text" : "L’entreprise s'assure-t-elle des bonnes conditions de santé et de sécurité des salariés ?",
            "options" :
            [
              {
                "id": "osha/no", "score": 0, "text" : "Non"
              },
              {
                "id": "osha/partly", "score": 1, "text" : "Oui partiellement "
              },
              {
                "id": "osha/yes", "score": 2, "text" : "Oui dans le cadre d'une politique régulière suivie (document unique à jour, etc.) "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise  met-elle en places des mesures pour améliorer la qualité de vie au travail (au dela des obligations réglementaires) ?",
            "options" :
            [
              {
                "id": "qualityOfLife/no", "score": 0, "text" : "Non", "feedback" : "Améliorer les conditions de travail des employés permet d'améliorer la résilience et la productivité de l'entreprise"
              },
              {
                "id": "qualityOfLife/partly", "score": 1, "text" : "Oui partiellement "
              },
              {
                "id": "qualityOfLife/yes", "score": 2, "text" : "Oui dans le cadre d'une politique régulière suivie "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Il y a-t-il un dialogue social fluide, apaisé, fréquent et de qualité dans l’entreprise ?",
            "options" :
            [
              {
                "id": "dialog/no", "score": 0, "text" : "Non"
              },
              {
                "id": "dialog/partly", "score": 1, "text" : "Oui partiellement "
              },
              {
                "id": "dialog/regularly", "score": 2, "text" : "Oui dans le cadre d'une politique régulière suivie "
              },
              {
                "id": "dialog/yes", "score": 3, "text" : "Oui dans le cadre d'une politique régulière avec des outils mis en place "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Existe-t'il dans l'entreprise une politique de formation continue ?",
            "options" :
            [
              {
                "id": "training/no", "score": 0, "text" : "Non", "feedback" : "La formation continue permet de  favoriser l'adaptabilité, la croissance des compétences et l'innovation des employés, renforçant ainsi votre compétitivité"
              },
              {
                "id": "training/minimal", "score": 1, "text" : "Oui dans la limite des obligations légales "
              },
              {
                "id": "training/yes", "score": 2, "text" : "Oui avec des actions de formation continue "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L’entreprise s'engage-t-elle et favorise-t-elle la diversité et l’inclusion des personnes sous représentées ?",
            "options" :
            [
              {
                "id": "inclusive/no", "score": 0, "text" : "Non"
              },
              {
                "id": "inclusive/minimal", "score": 1, "text" : "Oui dans la limite des obligations légales "
              },
              {
                "id": "inclusive/sometimes", "score": 2, "text" : "Oui au-delà des obligations légales par des actions ponctuelles "
              },
              {
                "id": "inclusive/yes", "score": 3, "text" : "Oui, au-delà des obligations légales par une politique suivie et outillée"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Quel est votre Index EGAPRO ?",
            "options" :
            [
              {
                "id": "egapro/no", "score": 0, "text" : "Non calculé, ne sait pas ", "feedback" : "Toutes les entreprises d’au moins 50 salariés doivent calculer et publier leur Index de l’égalité professionnelle entre les femmes et les hommes, chaque année au plus tard le 1er mars."
              },
              {
                "id": "egapro/below75", "score": 1, "text" : "Inférieur à 75 "
              },
              {
                "id": "egapro/between75and85", "score": 2, "text" : "Entre 75 et 85 "
              },
              {
                "id": "egapro/morethan85", "score": 3, "text" : "Supérieur à 85 "
              }
            ]
          }
        ]
      },
      {
        "text" : "Loyauté des pratiques",
        "questions":
        [
          {
            "type" : "radio",
            "text" : "L'entreprise maitrise t'elle les risques liés à son activités en termes de conduite éthique ?",
            "options" :
            [
              {
                "id": "ethicalRisks/no", "score": 0, "text" : "Non", "feedback" : "Faire preuve de responsabilité sociétale c’est appliquer une conduite éthique à ses transactions avec ses parties prenantes (bonnes pratiques des affaires). La loyauté des pratiques inclut la concurrence loyale, la promotion de la RS, l’obligation de vigilance, la prévention de la complicité et la lutte contre la corruption. Ne pas respecter ces principes c'est s'exposer à des risques qu'il faut bien identifier"
              },
              {
                "id": "ethicalRisks/later", "score": 1, "text" : "Non mais envisagé "
              },
              {
                "id": "ethicalRisks/identified", "score": 2, "text" : "les risques sont identifiés ", "feedback" : "Une fois les risques identifés, il convient de mettre en place des outils de prévention. "
              },
              {
                "id": "ethicalRisks/yes", "score": 3, "text" : "les risques sont identifiés et des outils de prévention sont mis en place "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "Les salariés sont -ils formés sur les enjeux de l'éthique des affaires et sur les outils et processus présents dans l'entreprise ?",
            "options" :
            [
              {
                "id": "ethicsTraining/no", "score": 0, "text" : "Non", "feedback" : "Pour plus d'efficacité dans la réduction des risques, il est important que les salariés soient formés à repérer les situations à risque et à utiliser les moyens de prévention à dipsoisiton "
              },
              {
                "id": "ethicsTraining/later", "score": 1, "text" : "Non mais envisagé "
              },
              {
                "id": "ethicsTraining/once", "score": 2, "text" : "les salariés sont formés au moins une fois "
              },
              {
                "id": "ethicsTraining/yes", "score": 3, "text" : "les salariés sont formés et des rappels sont fait au moins une fois par an "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprises s'assure t-elle du respect des droits Humains dans sa chaine de valeur ?",
            "options" :
            [
              {
                "id": "humanRights/no", "score": 0, "text" : "Non", "feedback" : "L'entreprise est responsable du respect des droits Humains sur toute sa chaien de valeur, il est impoprtant de se donner les moyens de vérifier que ces droits sont respectés "
              },
              {
                "id": "humanRights/later", "score": 1, "text" : "Non mais envisagé "
              },
              {
                "id": "humanRights/measured", "score": 2, "text" : "Oui les risques sont mesurés "
              },
              {
                "id": "humanRights/yes", "score": 3, "text" : "Oui les risques sont mesurés et des actions de prévention sont mises en place "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise vérifie t'elle les conditions de travail et les salaires de ses fournisseurs et sous-traitants  ?",
            "options" :
            [
              {
                "id": "suppliersEthics/no", "score": 0, "text" : "Non"
              },
              {
                "id": "suppliersEthics/later", "score": 1, "text" : "Non mais envisagé "
              },
              {
                "id": "suppliersEthics/partly", "score": 2, "text" : "Oui partiellement "
              },
              {
                "id": "suppliersEthics/yes", "score": 3, "text" : "Oui systématiquement"
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise intgère t'elle des critères environnementaux et sociaux dans le choix des fournisseurs ?",
            "options" :
            [
              {
                "id": "responsibleSuppliers/no", "score": 0, "text" : "Non", "feedback" : "Afin de vous assurez de l'implication de votre chaine de valeur, la mise en place de critères de choix de fournisseurs est un outils indispensable"
              },
              {
                "id": "responsibleSuppliers/partly", "score": 1, "text" : "Oui partiellement "
              },
              {
                "id": "responsibleSuppliers/mainly", "score": 2, "text" : "Oui sur les enjeux sociaux et environementaux dans le cadre d'une politique régulière suivie "
              },
              {
                "id": "responsibleSuppliers/yes", "score": 3, "text" : "Oui et un dialogue est mené sur les attentes et enjeux"
              }
            ]
          }
        ]
      },
      {
        "text" : "Communautés et développement local",
        "questions":
        [
          {
            "type" : "radio",
            "text" : "L'entreprise a t-elle des critères pour favoriser des fournisseurs ou sous-traitants locaux ?",
            "options" :
            [
              {
                "id": "localSuppliers/no", "score": 0, "text" : "Non"
              },
              {
                "id": "localSuppliers/partly", "score": 1, "text" : "Oui sur certains sujets "
              },
              {
                "id": "localSuppliers/mainly", "score": 2, "text" : "Oui sur tous les achats "
              },
              {
                "id": "localSuppliers/yes", "score": 3, "text" : "Oui sur tous les achats et d'application obligatoire "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise dialogue t-elle avec ses parties prenantes locales ?",
            "options" :
            [
              {
                "id": "localDialog/no", "score": 0, "text" : "Non", "feedback" : "Évaluez la pertinence de mener un partenariat actif avec un centre de formation ou un acteur de l'emploi local"
              },
              {
                "id": "localDialog/sometimes", "score": 1, "text" : "Oui il existe des échanges ponctuels "
              },
              {
                "id": "localDialog/regularly", "score": 2, "text" : "Oui des échanges réguliers mènent à des actions ponctuelles "
              },
              {
                "id": "localDialog/yes", "score": 3, "text" : "Oui l'entreprise est intégrée au tissu local et mène régulièrement des actions "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise est-elle investie auprès d'associations ou ONG locales ?",
            "options" :
            [
              {
                "id": "localNonProfits/no", "score": 0, "text" : "Non", "feedback" : "Évaluer la pertinence de participer à un réseau d'organisations publiques de l'ESS ou associatif "
              },
              {
                "id": "localNonProfits/sometimes", "score": 1, "text" : "Oui il existe des échanges ponctuels "
              },
              {
                "id": "localNonProfits/regularly", "score": 2, "text" : "Oui des échanges réguliers mènent à des actions ponctuelles "
              },
              {
                "id": "localNonProfits/yes", "score": 3, "text" : "Oui l'entreprise est intégrée au tissu local et mène régulièrement des actions "
              }
            ]
          }
        ]
      },
      {
        "text" : "Environnement",
        "questions" :
        [
          {
            "type" : "radio",
            "text" : "L'entreprise agit-elle les impacts environnementaux générés par son activité ?",
            "options" :
            [
              {
                "id": "environmentalImpact/no", "score": 0, "text" : "Non", "feedback" : "Mesurer ses impacts est le première étape pour pouvoir les réduire et les maitriser."
              },
              {
                "id": "environmentalImpact/measured", "score": 1, "text" : "Non mais elle mesure ses impacts "
              },
              {
                "id": "environmentalImpact/sometimes", "score": 2, "text" : "Oui elle mesure et met en place des actions soit ponctuelles soit partielles ", "feedback" : "Il est important de définir des indicateurs pertinents pour aligner vos efforts vers des objectifs clairs et mesurables et d'évaluer vos progrès. Ils fournissent une boussole essentielle pour orienter efficacement les actions et mesurer l'impact des initiatives stratégiques."
              },
              {
                "id": "environmentalImpact/yes", "score": 3, "text" : "Oui elle mesure et agit dans le cadre d'une politique régulière suivie avec des objectifs et indicateurs chiffrés "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise a-t'elle mesuré ses émissions de GES ?",
            "options" :
            [
              {
                "id": "measuresEmissions/no", "score": 0, "text" : "Non", "feedback" : "Connaitre les principaux postes d'émissions de GES de votre entreprise est le premier pas d'une stratégie climat efficace."
              },
              {
                "id": "measuresEmissions/later", "score": 1, "text" : "Non mais envisagé ", "feedback" : "La réalisation d'un BEGES est simplifiée par le passage via un prestataire extérieur. Eco CO2 peut vous accompagner."
              },
              {
                "id": "measuresEmissions/sometimes", "score": 2, "text" : "Oui ponctuellement ", "feedback" : "Mettre à jour votre Bilan GES est important pour s'assurer des évolutions de votre stratégie climat dans le temps."
              },
              {
                "id": "measuresEmissions/yes", "score": 3, "text" : "Oui dans le cadre d'une politique régulière suivie ", "feedback" : "Mettre à jour votre Bilan GES est important pour s'assurer des évolutions de votre stratégie climat dans le temps."
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L'entreprise a-t'elle mis en place des mesures pour réduire ses émissions de GES ?",
            "options" :
            [
              {
                "id": "reducesEmissions/no", "score": 0, "text" : "Non", "feedback" : "Il est urgent de réduire nos émissions de GES pour limiter le réchauffement climatique en dessous des 2°C. Cela passe également par la réduction des émissions des entreprises"
              },
              {
                "id": "reducesEmissions/partly", "score": 1, "text" : "Oui partiellement "
              },
              {
                "id": "reducesEmissions/regularly", "score": 2, "text" : "Oui dans le cadre d'une politique régulière suivie ", "feedback" : "Il est important de définir des indicateurs pertinents pour aligner vos efforts vers des objectifs clairs et mesurables et d'évaluer vos progrès. Ils fournissent une boussole essentielle pour orienter efficacement les actions et mesurer l'impact des initiatives stratégiques."
              },
              {
                "id": "reducesEmissions/yes", "score": 3, "text" : "Oui dans le cadre d'une politique régulière suivie avec des objectifs et indicateurs chiffrés "
              }
            ]
          },
          {
            "type" : "radio",
            "text" : "L’entreprise met-elle en avant des informations sur l’impact environnemental de son produit/service ?",
            "options" :
            [
              {
                "id": "showImpact/no", "score": 0, "text" : "Non"
              },
              {
                "id": "showImpact/partly", "score": 1, "text" : "Oui partiellement "
              },
              {
                "id": "showImpact/mainly", "score": 2, "text" : "Oui sur la plupart de ses produits/services à l'aide de données génériques "
              },
              {
                "id": "showImpact/yes", "score": 3, "text" : "Oui sur la plupart de ses produits/services en réalisant une ACV/ évaluation environnementale "
              }
            ]
          }
        ]
      }
    ]
  },
  "recordedAnswers" :
  [
    { "name": "Thibaud", "company": "Ubygoues", "role": "Responsable relations extérieures", "answers": [ "email/example", "name/example", "privacy/agreed", "company/example", "job/other", "otherJob/title", "size/large", "dpef/yes", "bizModel/b2b", "bizModel/b2c", "location/francesector/software", "canexplain/yes", "knowlaw/yes", "knowrisksandoppo/yes", "didAssess/yes", "dateAssess/between13y", "assessScopes/oneTwoThree", "hasObj/yes", "objTerm/medium", "objTerm/short", "parisCompat/yes", "goodThinking/yes", "investGreen/yes", "anyoneInCharge/yes", "whoInCharge/fullteam", "hasPlan/yes", "planTerm/short", "planTerm/medium", "gainEval/yes", "committee/yes", "workshops/yes", "activity/services", "activity/products", "materials/plastics", "materials/metals", "materials/wood", "ecodesign/yes", "energy/yes", "trash/justabit", "mobility/justabit", "transport/justabit", "supply/yes", "sinks/justabit" ] },
    { "name": "Sébastien", "company": "FCASM", "role": "Responsable DD/RSE", "answers": [ "name/example", "email/example", "privacy/agreed", "company/example", "job/rse", "size/eti", "dpef/unknown", "bizModel/b2b", "bizModel/b2c", "location/france", "sector/banking", "canexplain/yes", "knowlaw/yes", "knowrisksandoppo/yes", "didAssess/yes", "dateAssess/between13y", "assessScopes/oneTwoThree", "hasObj/yes", "objTerm/shortobjTerm/medium", "objTerm/long", "parisCompat/yes", "goodThinking/yes", "investGreen/yes", "anyoneInCharge/yes", "whoInCharge/fullone", "hasPlan/yes", "planTerm/short", "planTerm/medium", "planTerm/long", "gainEval/no", "committee/yes", "workshops/yes", "activity/services", "energy/yes", "trash/justabit", "mobility/no", "transport/no", "supply/yes", "sinks/no" ] },
    { "name": "Mickaël", "company": "Preenacte", "role": "Commercial", "answers":  [ "email/example", "privacy/agreed", "company/example", "job/corporate", "size/pme", "dpef/unknown", "bizModel/b2b", "location/france", "sector/energy", "name/example", "canexplain/yes", "knowlaw/yes", "knowrisksandoppo/no", "didAssess/unknown", "hasObj/yes", "objTerm/medium", "parisCompat/yes", "goodThinking/yes", "investGreen/yes", "anyoneInCharge/no", "hasPlan/yes", "planTerm/medium", "gainEval/yes", "committee/yes", "workshops/yes", "activity/services", "energy/yes", "trash/yes", "mobility/yes", "transport/unknown", "supply/yes", "sinks/unknown" ] },
    { "name": "Maëlie", "company": "Alan P", "role": "Commerciale", "answers": [ "name/example", "privacy/agreed", "email/example", "company/example", "job/corporate", "size/pme", "dpef/no", "bizModel/b2b", "location/france", "location/europe", "sector/services", "canexplain/yes", "knowlaw/yes", "knowrisksandoppo/yes", "didAssess/yes", "dateAssess/between13y", "assessScopes/oneTwoThree", "hasObj/unknown", "goodThinking/yes", "investGreen/yes", "anyoneInCharge/yeswhoInCharge/looseone", "hasPlan/unknown", "workshops/yes", "activity/services", "energy/justabit", "trash/unknown", "mobility/justabit", "transport/yes", "supply/yes", "sinks/unknown" ] },
    { "name": "Vincent", "company": "Donby", "role": "Directeur opérationnel", "answers": [ "name/example", "email/example", "privacy/agreed", "company/example", "job/other", "otherJob/title", "size/pme", "dpef/no", "bizModel/b2b", "location/world", "sector/agriculturecanexplain/yes", "knowlaw/yes", "knowrisksandoppo/yes", "didAssess/yes", "dateAssess/between13y", "assessScopes/oneTwo", "hasObj/no", "goodThinking/yes", "investGreen/yes", "anyoneInCharge/no", "hasPlan/no", "workshops/yes", "activity/services", "energy/justabit", "trash/justabit", "mobility/no", "transport/justabit", "supply/yes", "sinks/yes" ] },
    { "name": "Charles", "company": "Rotyn", "role": "Responsable du développement des projets", "answers": [ "name/example", "email/example", "privacy/agreed", "company/example", "job/other", "otherJob/title", "size/tpe", "dpef/unknown", "bizModel/b2blocation/france", "sector/energy", "canexplain/yes", "knowlaw/no", "knowrisksandoppo/yes", "didAssess/unknown", "hasObj/no", "goodThinking/yes", "investGreen/yes", "anyoneInCharge/no", "hasPlan/no", "workshops/no", "activity/products", "activity/services", "materials/organic", "ecodesign/yes", "energy/yes", "trash/yes", "mobility/justabit", "transport/yes", "supply/no", "sinks/yes" ] },
    { "name": "Pauline", "company": "Wezay", "role": "City manager", "answers": [ "name/example", "email/example", "privacy/agreed", "company/example", "job/other", "otherJob/title", "size/pme", "dpef/unknown", "bizModel/b2b", "bizModel/b2clocation/france", "sector/transport", "canexplain/yes", "knowlaw/no", "knowrisksandoppo/yes", "didAssess/unknown", "hasObj/yes", "parisCompat/unknown", "goodThinking/yes", "investGreen/yes", "anyoneInCharge/unknown", "hasPlan/unknown", "workshops/unknown", "activity/services", "energy/justabit", "trash/justabit", "mobility/yes", "transport/justabit", "supply/yes", "sinks/unknown" ] },
    { "name": "Alexander", "company": "WindWigls", "role": "PDG", "answers": [ "email/example", "privacy/agreed", "name/example", "company/example", "job/director", "size/tpe", "dpef/no", "bizModel/b2b", "bizModel/b2c", "location/france", "sector/services", "canexplain/yes", "knowlaw/yes", "knowrisksandoppo/yesdidAssess/noButWillDo", "hasObj/yes", "objTerm/short", "parisCompat/yes", "goodThinking/yes", "investGreen/justabit", "anyoneInCharge/no", "hasPlan/no", "workshops/no", "activity/services", "energy/justabit", "trash/justabit", "mobility/yes", "transport/no", "supply/yes", "sinks/justabit" ] },
    { "name": "Yoann", "company": "Expacter", "role": "Manager recrutement", "answers": [ "email/example", "name/example", "privacy/agreed", "company/example", "job/other", "otherJob/title", "size/eti", "dpef/unknown", "bizModel/b2b", "location/francesector/services", "canexplain/yes", "knowlaw/no", "knowrisksandoppo/no", "didAssess/no", "hasObj/yes", "objTerm/short", "parisCompat/unknown", "goodThinking/no", "investGreen/justabit", "anyoneInCharge/no", "hasPlan/no", "workshops/no", "activity/services", "energy/no", "trash/no", "mobility/yes", "transport/no", "supply/unknown", "sinks/justabit" ] },
    { "name": "Bertrand", "company": "Cogity", "role": "Directeur de la communication", "answers": [ "email/example", "name/example", "privacy/agreed", "company/example", "job/other", "otherJob/title", "size/pme", "dpef/no", "bizModel/b2c", "location/france", "sector/transport", "canexplain/yes", "knowlaw/no", "knowrisksandoppo/no", "didAssess/no", "hasObj/no", "goodThinking/no", "investGreen/no", "anyoneInCharge/no", "hasPlan/no", "workshops/no", "activity/services", "energy/no", "trash/no", "mobility/no", "transport/unknown", "supply/no", "sinks/no" ] },
  ]
}