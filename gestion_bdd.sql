-- Création de la base de données

create database gestion;
use gestion;

-- Création des tables

create table utilisateur(
id_utilisateur int primary key auto_increment not null,
nom varchar(50) not null,
prenom varchar(50) not null,
age int,
mail varchar(50) not null,
password varchar(100) not null,
id_poste int not null
)Engine=InnoDB;

create table poste(
id_poste int primary key auto_increment not null,
nom varchar(50) not null
)Engine=InnoDB;

create table logiciel(
id_logiciel int primary key auto_increment not null,
nom varchar(50) not null,
description text not null,
quantite int not null,
id_editeur int not null
)Engine=InnoDB;

create table editeur(
id_editeur int primary key auto_increment not null,
nom varchar(50) not null
)Engine=InnoDB;

create table installer(
id_utilisateur int,
id_logiciel int,
num_licence varchar(50),
date_assignation datetime,
primary key(id_utilisateur, id_logiciel)
)Engine=InnoDB;

create table type_ticket(
id_type_ticket int primary key auto_increment not null,
nom varchar(50) not null
)Engine=InnoDB;

create table ticket(
id_ticket int primary key auto_increment not null,
nom varchar(50) not null,
description text not null,
date_ouverture datetime not null,
date_fermeture datetime,
id_logiciel int,
id_materiel int,
id_statut int not null,
id_type_ticket int not null,
id_utilisateur int not null
)Engine=InnoDB;

create table statut(
id_statut int primary key auto_increment not null,
nom varchar(50) not null
)Engine=InnoDB;

create table materiel(
id_materiel int primary key auto_increment not null,
nom varchar(50) not null,
description text not null,
spare tinyint(1) default 0,
quantite int not null,
id_fabricant int not null,
id_type_materiel int not null
)Engine=InnoDB;

create table fabricant(
id_fabricant int primary key auto_increment not null,
nom varchar(50) not null
)Engine=InnoDB;

create table type_materiel(
id_type_materiel int primary key auto_increment not null,
nom varchar(50) not null
)Engine=InnoDB;

create table assigner(
id_utilisateur int,
id_materiel int,
reference varchar(50),
date_assignation datetime,
primary key(id_utilisateur, id_materiel)
)Engine=InnoDB;

create table intervention(
id_intervention int primary key auto_increment not null,
nom varchar(50) not null,
description text not null,
date_intervention datetime not null,
duree int not null,
verifie tinyint(1) default 0,
id_utilisateur int not null,
id_ticket int not null
)Engine=InnoDB;

create table solution(
id_solution int primary key auto_increment not null,
nom varchar(50) not null,
description text not null,
date_creation datetime not null,
date_modification datetime,
id_type_solution int not null,
id_materiel int,
id_logiciel int,
id_utilisateur int not null
)Engine=InnoDB;

create table type_solution(
id_type_solution int primary key auto_increment not null,
nom varchar(50) not null
)Engine=InnoDB;

create table incorporer(
id_intervention int,
id_solution int,
primary key(id_intervention, id_solution)
)Engine=InnoDB;

-- Ajout des contraintes foreign key

alter table utilisateur
add constraint fk_occuper_poste
foreign key (id_poste)
references poste(id_poste);

alter table logiciel
add constraint fk_editer_editeur
foreign key (id_editeur)
references editeur(id_editeur);

alter table ticket
add constraint fk_posseder_statut
foreign key (id_statut)
references statut(id_statut);

alter table ticket
add constraint fk_inclure_logiciel
foreign key (id_logiciel)
references logiciel(id_logiciel);

alter table ticket
add constraint fk_detailler_type_ticket
foreign key (id_type_ticket)
references type_ticket(id_type_ticket);

alter table ticket
add constraint fk_lier_materiel
foreign key (id_materiel)
references materiel(id_materiel);

alter table ticket
add constraint fk_rediger_utilisateur
foreign key (id_utilisateur)
references utilisateur(id_utilisateur);

alter table installer
add constraint fk_installer_logiciel
foreign key (id_logiciel)
references logiciel(id_logiciel);

alter table installer
add constraint fk_installer_utilisateur
foreign key (id_utilisateur)
references utilisateur(id_utilisateur);

alter table materiel
add constraint fk_fabriquer_fabricant
foreign key (id_fabricant)
references fabricant(id_fabricant);

alter table materiel
add constraint fk_completer_type_materiel
foreign key (id_type_materiel)
references type_materiel(id_type_materiel);

alter table intervention
add constraint fk_intervenir_ticket
foreign key (id_ticket)
references ticket(id_ticket);

alter table intervention
add constraint fk_ajouter_utilisateur
foreign key (id_utilisateur)
references utilisateur(id_utilisateur);

alter table incorporer
add constraint fk_incorporer_intervention
foreign key (id_intervention)
references intervention(id_intervention);

alter table incorporer
add constraint fk_incorporer_solution
foreign key (id_solution)
references solution(id_solution);

alter table assigner
add constraint fk_assigner_utilisateur
foreign key (id_utilisateur)
references utilisateur(id_utilisateur);

alter table assigner
add constraint fk_assigner_materiel
foreign key (id_materiel)
references materiel(id_materiel);

alter table solution
add constraint fk_classer_type_solution
foreign key (id_type_solution)
references type_solution(id_type_solution);

alter table solution
add constraint fk_appliquer_materiel
foreign key (id_materiel)
references materiel(id_materiel);

alter table solution
add constraint fk_depanner_logiciel
foreign key (id_logiciel)
references logiciel(id_logiciel);

alter table solution
add constraint fk_ecrire_utilisateur
foreign key (id_utilisateur)
references utilisateur(id_utilisateur);



insert into poste(nom)
values ("employé"),("technicien"),("responsable"),("admin");

select *
from poste;

insert into utilisateur(nom,prenom,age,mail,password,id_poste)
values ("antoine","habiche",27,"tonio@hotmail.com","coco31",3),("bastien","adam",30,"lebast@hotmail.com","passepasse",4),("kevin","marin",31,"kevinMar@hotmail.com","passepartout",2),("remi","salvan",30,"indus31@hotmail.fr","passeparlà",1);

select *
from utilisateur;

insert into fabricant(nom)
values ("microsoft"),("asus"),("nvdia");

select *
from fabricant;

insert into type_materiel(nom)
values("informatique"),("bureautique"),("entretien");

select *
from type_materiel;

insert into editeur(nom)
values("IBM"),("infoLOGI"),("oracleLTD");

select *
from editeur;

insert into statut(nom)
values ("en panne"),("en cours"),("en attente");

select *
from statut;

insert into type_ticket(nom)
values ("reparation"),("installation"),("remplacement");

select * 
from type_ticket;

insert into type_solution(nom)
values("mise à jour"),("remplacement materiel"),("debuggage");

select *
from type_solution;

insert into logiciel(nom,description,quantite,id_editeur)
values ("steal","récupère des données",2,1),("wax","logiciel bureautique",4,2);

select *
from logiciel;

insert into materiel(nom,description,spare,quantite,id_fabricant,id_type_materiel)
values ("ordinateur","unité centrale",15,20,2,1);

select * 
from materiel;

insert into ticket(nom, description,date_ouverture,date_fermeture,id_logiciel,id_materiel,id_statut,id_type_ticket,id_utilisateur)
values ("ticket7","intervention aux bureaux 201,203,204","2023-08-08","2023-08-09",1,1,1,1,2),
("ticket8","intervention aux bureaux 201,203,204","2023-08-08","2023-08-09",1,1,1,1,2),
("ticket9","intervention aux bureaux 204,205,206","2023-08-08","2023-08-09",1,1,1,1,4),
("ticket10","intervention aux bureaux 201,203,204","2023-08-08","2023-08-09",1,1,1,1,1),
("ticket11","intervention aux bureaux 201,203,204","2023-08-08","2023-08-09",1,1,1,1,4);

select *
from ticket;

insert into intervention(nom,description,date_intervention,duree,id_utilisateur,id_ticket)
values ("intervention4","prévu au 1er étage","2022-08-16",22,3,1),
("intervention5","prévu au 4éme étage","2022-08-17",22,3,1),
("intervention6","prévu au 4éme étage","2022-08-17",22,2,1),
("intervention7","prévu au 5éme étage","2021-08-17",22,2,1);



select *
from intervention;

insert into solution(nom,description,date_creation,date_modification,id_type_solution,id_materiel,id_logiciel,id_utilisateur)
values ("réparation1","on répare","2023-08-13","2023-08-15",1,1,2,3);

select *
from solution;

select utilisateur.nom,utilisateur.prenom,poste.nom
from utilisateur
join poste on poste.id_poste = utilisateur.id_poste;

select utilisateur.nom,utilisateur.prenom,poste.nom
from utilisateur
join poste on poste.id_poste = utilisateur.id_poste
where poste.nom = "technicien";

select materiel.nom,materiel.description,materiel.quantite,fabricant.nom as fabricant,type_materiel.nom as type
from materiel
join type_materiel on type_materiel.id_type_materiel = materiel.id_type_materiel
join fabricant on fabricant.id_fabricant = materiel.id_fabricant;

select logiciel.nom, logiciel.description,editeur.nom as editeur
from logiciel
join editeur on editeur.id_editeur = logiciel.id_editeur
order by editeur.nom;

select ticket.nom, ticket.description,ticket.date_ouverture,statut.nom as statut,utilisateur.nom,utilisateur.prenom,type_ticket.nom as typeticket
from ticket
join statut on statut.id_statut = ticket.id_statut
join utilisateur on utilisateur.id_utilisateur = ticket.id_utilisateur
join type_ticket on type_ticket.id_type_ticket = ticket.id_type_ticket
;
select intervention.nom,intervention.description,intervention.date_intervention,intervention.duree,utilisateur.nom,utilisateur.prenom
from intervention
join utilisateur on utilisateur.id_utilisateur = intervention.id_utilisateur;

select intervention.nom,intervention.description,intervention.date_intervention,intervention.duree,utilisateur.nom,utilisateur.prenom
from intervention
join utilisateur on utilisateur.id_utilisateur = intervention.id_utilisateur
where year(date_intervention) >= "2023-01-01";
select *
from intervention;

select *
from utilisateur;


select utilisateur.nom,utilisateur.prenom, count(ticket.id_utilisateur) as nombre_demande, count(intervention.id_utilisateur) as nbr_intervention from ticket
inner join utilisateur on utilisateur.id_utilisateur = ticket.id_utilisateur
inner join intervention on intervention.id_ticket = ticket.id_ticket
order by utilisateur.nom asc, utilisateur.prenom asc;

select utilisateur.nom,utilisateur.prenom, count(ticket.id_utilisateur) as nombre_demande from ticket
inner join utilisateur on utilisateur.id_utilisateur = ticket.id_utilisateur

order by utilisateur.nom asc, utilisateur.prenom asc;


