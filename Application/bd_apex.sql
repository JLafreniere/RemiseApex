DECLARE
f number;
BEGIN

    FOR f IN (SELECT sequence_name FROM user_sequences) 
    loop
      execute immediate 'drop sequence "'||f.sequence_name||'"';
    end loop;
    
    FOR f IN (SELECT table_name FROM user_tables) 
    loop
      execute immediate 'drop table '||f.table_name||' cascade constraint';
    end loop;    
end;
/
purge recyclebin;
/
create or replace 
PACKAGE Pck_Abbtr as
FUNCTION Afficher_Telephone(p_tel CHAR) RETURN CHAR;
FUNCTION Afficher_Code_Postal(p_code_postal CHAR) RETURN CHAR;
FUNCTION Verifier_No_Camisole(p_numero NUMBER) RETURN BOOLEAN;
FUNCTION Valider_Codepostal(code varchar2) Return Boolean;
FUNCTION VALIDERNAS(nas varchar2) RETURN BOOLEaN;
FUNCTION authenticate_user  (p_username in varchar2, p_password in varchar2) RETURN BOOLEAN;
FUNCTION composer_username (p_nom varchar2) return char;
FUNCTION FORMAT_HEURE (heure IN number ) RETURN VARCHAR2;
END Pck_Abbtr;

/
Create Sequence Seq_Transactions Maxvalue 99999 nocycle;
Create Sequence Seq_Camisoles Maxvalue 99999 nocycle;
Create Sequence Seq_Categories Maxvalue 99999 nocycle;
Create Sequence Seq_Dispos_Gyms Maxvalue 99999 nocycle;
Create Sequence Seq_Dispos_Entraineurs Maxvalue 99999 nocycle;
Create Sequence Seq_Ecoles Maxvalue 99999 nocycle;
Create Sequence Seq_Entraineurs Maxvalue 99999 nocycle;
Create Sequence Seq_Equipes_Tournois Maxvalue 99999 nocycle;
Create Sequence Seq_Equipes Maxvalue 99999 nocycle;
Create Sequence Seq_Equipes_Entraineurs Maxvalue 99999 nocycle;
Create Sequence Seq_Factures Maxvalue 99999 nocycle;
Create Sequence Seq_Gyms Maxvalue 99999 nocycle;
Create Sequence Seq_Inscriptions Maxvalue 99999 nocycle;
Create Sequence Seq_Inventaires Maxvalue 99999 nocycle;
Create Sequence Seq_Joueurs_Medicaments Maxvalue 99999 nocycle;
Create Sequence Seq_Joueurs Maxvalue 99999 nocycle;
Create Sequence Seq_Joueurs_Allergies Maxvalue 99999 nocycle;
Create Sequence Seq_Joueurs_Blessures Maxvalue 99999 nocycle;
Create Sequence Seq_Personnes Maxvalue 99999 nocycle; 
Create Sequence Seq_Personnes_Joueurs Maxvalue 99999 nocycle;
Create Sequence Seq_Postes_Budgetaires Maxvalue 99999 nocycle;
Create Sequence Seq_Pratiques Maxvalue 99999 nocycle;
Create Sequence Seq_Recompenses_Entraineurs Maxvalue 99999 nocycle;
Create Sequence Seq_Prets_Equipements Maxvalue 99999 nocycle;
Create Sequence Seq_Recipiendaires Maxvalue 99999 nocycle;
Create Sequence Seq_Recus_Impots Maxvalue 99999 nocycle;
Create Sequence Seq_Shorts Maxvalue 99999 nocycle;
Create Sequence Seq_Tournois Maxvalue 99999 nocycle;
create sequence Seq_utilisateurs Maxvalue 99999 nocycle;
create sequence apex_access_setup_seq;
create sequence apex_access_control_seq;
/

CREATE TABLE Camisoles (
ID_Camisole number(5) primary key,
No_Camisole number(2),
Categorie_Age varchar2(10),
Sexe char(1),
Couleur varchar2(50),
Taille varchar2(30)
);

/
CREATE TABLE Shorts (
ID_Short number(5) primary key,
Taille varchar2(30),
Quantite number(3)
);
/


CREATE TABLE Joueurs (
ID_Joueur number(5) primary key,
Nom varchar2(50),
Prenom varchar2(50),
Sexe char(1),
Adresse varchar2(100),
Ville varchar2(75),
Code_Postal char(6),
Date_naissance date,
Assurance_Maladie char(12),
Groupe_Sanguin varchar(3),
Diabete char(1),
Epilepsie char(1),
Asthme_Pompe char(1),
Auto_Administration char(1),
Infos_Sante_Supplementaires varchar2(255)

);

/
CREATE TABLE Categories(
ID_Categorie number(5) primary key,
Nom varchar2(50)
);


/
CREATE TABLE Ecoles(
ID_Ecole number(5) primary key,
Nom varchar2(100),
Adresse varchar2(100),
Ville varchar2(75),
Code_Postal char(6),
Telephone char(10),
Contact varchar2(100),
Role_Contact varchar2(50),
Cell_Contact char(10)
);

/
CREATE TABLE Postes_Budgetaires(
ID_Poste number(5) primary key,
Nom_Poste varchar2(75),
Depense char(1)
);

/
CREATE TABLE Inventaires(
ID_Inventaire number(5) primary key,
Objet varchar2(75),
Couleur varchar2(35),
Quantite number(4)
);




--PAS D'INSERT--
/
CREATE TABLE Tournois(
ID_Tournoi number(5),
Ville varchar2(75),
Date_Debut date,
Date_Fin Date,
Montant_Inscription number(5,2)
);

/
CREATE TABLE Entraineurs(
ID_Entraineur number(5) primary key,
Nom varchar2(50),
Prenom varchar2(50),
Date_Naissance date,
NAS number(9),
Fin_Service date,
Telephone char(10),
Adresse varchar2(100),
Ville varchar2(75),
Code_Postal char(6)

);


/
----- RELATION DEGRÉ 1 ---------------

CREATE TABLE Transactions (
ID_Transaction number(5) primary key,
Montant number(5,2),
Nom_Transaction varchar2(150),
Date_Transaction date,
Paye char(1),
Poste_Budgetaire varchar2(50),
Mode_Paiement varchar2(50)
);

/
CREATE TABLE Factures (
ID_Facture number(5) primary key,
Date_Facture date,
Photocopie blob,
MimeType varchar2(255),
FileName varchar2(255),
ID_Transaction number(5),
CONSTRAINT FK_ID_transaction -- 
    FOREIGN KEY (ID_Transaction)
    REFERENCES Transactions (ID_Transaction)
);

/

CREATE TABLE Gyms(
ID_Gym number(5) primary key,
ID_Ecole number(5),
Nom varchar2(100),
CONSTRAINT FK_ID_ECOLE -- 
    FOREIGN KEY (ID_Ecole)
    REFERENCES Ecoles (ID_Ecole)
);
/
CREATE TABLE Equipes(
ID_Equipe number(5) primary key,
Nom varchar2(25),
ID_Categorie number(5),
ID_Ecole number(5),
Type_Equipe varchar2(25),
Montant_Inscription number(5, 2),
CONSTRAINT FK_ID_CATEGORIES_EQUIPES -- 
    FOREIGN KEY (ID_Categorie)
    REFERENCES Categories (ID_Categorie),
    CONSTRAINT FK_ID_ECOLE_EQUIPE -- 
    FOREIGN KEY (ID_Ecole)
    REFERENCES Ecoles (ID_Ecole)
);
/
CREATE TABLE Joueurs_Medicaments(
ID_Joueur_Medicament number(5) primary key,
Nom_Medicament varchar2(75),
Posologie varchar2(175),
ID_Joueur number(5),
CONSTRAINT FK_ID_JOUEURS_MEDICAMENTS -- 
    FOREIGN KEY (ID_Joueur)
    REFERENCES Joueurs (ID_Joueur)
);
/
CREATE TABLE Joueurs_Blessures(
ID_Joueur_Blessure number(5) primary key,
Nom_Blessure varchar2(75),
Date_Blessure date,
ID_Joueur number(5),
CONSTRAINT FK_ID_JOUEURS_BLESSURES -- 
    FOREIGN KEY (ID_Joueur)
    REFERENCES Joueurs (ID_Joueur)
);
/
CREATE TABLE Joueurs_Allergies(
ID_Joueur_Allergie number(5) primary key,
Nom_Allergie varchar2(75),
ID_Joueur number(5),
CONSTRAINT FK_ID_JOUEURS_ALLERGIES -- 
    FOREIGN KEY (ID_Joueur)
    REFERENCES Joueurs (ID_Joueur)
);
/
CREATE TABLE Personnes(
ID_Personne number(5) primary key,
Nom varchar2(50),
Prenom varchar2(50),
Telephone1 char(10),
Telephone2 char(10),
NAS char(9),
Adresse varchar2(100),
Ville varchar2(50),
Code_Postal char(6),
Eligible_Impot char(1)
);
/
CREATE TABLE Prets_Equipements(
ID_Pret number(5),
Date_Pret date,
ID_Camisole number(5),
ID_Short number(5),
Date_Remise_Prevue date,
Date_Reception date,
ID_Joueur number(5),
CONSTRAINT FK_ID_CAMISOLE_PRETS -- 
    FOREIGN KEY (ID_Camisole)
    REFERENCES Camisoles (ID_Camisole),
    CONSTRAINT FK_ID_SHORTS_PRETS -- 
    FOREIGN KEY (ID_Short)
    REFERENCES Shorts (ID_Short),
    CONSTRAINT FK_ID_JOUEURS_PRETS -- 
    FOREIGN KEY (ID_Joueur)
    REFERENCES Joueurs (ID_Joueur)
);
/
CREATE TABLE Recus_Impot(
ID_Recu number(5),
ID_Personne number(5),
Montant number(5,2),
Annee number(4,0),
    CONSTRAINT FK_ID_PERSONNE_RECUS -- 
    FOREIGN KEY (ID_Personne)
    REFERENCES Personnes (ID_Personne)
);

/

CREATE TABLE Dispos_Entraineurs(
ID_Dispo_Entraineur number(5),
Jour number(1),
Debut number(4,2),
Fin number(4,2),
ID_Entraineur number(5),
    CONSTRAINT FK_ID_ENTRAINEUR_DISPOS -- 
    FOREIGN KEY (ID_Entraineur)
    REFERENCES Entraineurs (ID_Entraineur)
);

---------------------------- DEGRÉ 2------------------------
/
CREATE TABLE Inscriptions(
ID_Inscription number(5) primary key,
ID_Joueur number(5),
ID_Equipe number(5),
Saison number(5), -- FOREIGN KEY???
ID_Transaction number(5),
    CONSTRAINT FK_ID_INSCR_Joueurs -- 
    FOREIGN KEY (ID_Joueur)
    REFERENCES Joueurs (ID_Joueur),
    
    CONSTRAINT FK_ID_INSCR_Equipes -- 
    FOREIGN KEY (ID_EQUIPE)
    REFERENCES Equipes (ID_Equipe),
    
    CONSTRAINT FK_ID_INSCR_Transactions -- 
    FOREIGN KEY (ID_Transaction)
    REFERENCES Transactions (ID_Transaction)

);
/
CREATE TABLE Equipes_Tournois(
ID_Equipe_Tournoi number(5) primary key,
ID_Equipe number(5),
ID_Tournoi number(5),
ID_Transaction number(5),
    CONSTRAINT FK_ID_EQTOUR_EQUIPE-- 
    FOREIGN KEY (ID_EQUIPE)
    REFERENCES EQUIPES (ID_EQUIPE),
        CONSTRAINT FK_ID_EQTOUR_TRANS-- 
    FOREIGN KEY (ID_TRANSACTION)
    REFERENCES TRANSACTIONS (ID_TRANSACTION)
);

/
CREATE TABLE Pratiques(
ID_Pratique number(5) primary key,
ID_Equipe number(5),
ID_Gym number(5),
Jour number(1),
Heure_Debut number(4,2),
Heure_Fin number(4,2),
Date_Pratique DATE,
    CONSTRAINT FK_ID_PRATIQUE_EQUIPE-- 
    FOREIGN KEY (ID_EQUIPE)
    REFERENCES EQUIPES (ID_EQUIPE),
    CONSTRAINT FK_ID_PRATIQUE_GYM-- 
    FOREIGN KEY (ID_GYM)
    REFERENCES GYMS (ID_GYM)
);
/
CREATE TABLE Dispos_Gyms(
ID_Dispo_Gym number(5) primary key,
ID_Gym number(5),
Jour number(1),
Heure_Debut number(4,2),
Heure_Fin number(4,2),
    CONSTRAINT FK_ID_DISPOS_GYM-- 
    FOREIGN KEY (ID_Gym)
    REFERENCES Gyms (ID_Gym)
);
/

CREATE TABLE Equipes_Entraineurs(
ID_Equipe_Entraineur number(5) primary key,
Type_Entraineur varchar2(50),
ID_Equipe number(5),
ID_Entraineur number(5),

    CONSTRAINT FK_ID_EQENT_Equipes -- 
    FOREIGN KEY (ID_EQUIPE)
    REFERENCES Equipes (ID_Equipe),
    CONSTRAINT FK_ID_EQENT_Ent -- 
    FOREIGN KEY (ID_Entraineur)
    REFERENCES Entraineurs (ID_Entraineur)
);
/
CREATE TABLE Recipiendaires(
ID_Recipiendaire number(5) primary key,
Titre varchar2(75),
ID_INSCRIPTION number(5),
    CONSTRAINT FK_ID_REC_INSCR-- 
    FOREIGN KEY (ID_INSCRIPTION)
    REFERENCES Inscriptions (ID_INSCRIPTION)
);
/
CREATE TABLE Personnes_Joueurs(
ID_Personne_Joueur number(5) primary key,
ID_Personne number(5),
ID_Joueur number(5),
Role_Personne varchar2(50),
Contact_Urgence varchar2(75),
CONSTRAINT FK_ID_PERSJOU_PERS-- 
    FOREIGN KEY (ID_PERSONNE)
    REFERENCES PERSONNES (ID_PERSONNE),
    CONSTRAINT FK_ID_PERSJOU_JOUEUR-- 
    FOREIGN KEY (ID_JOUEUR)
    REFERENCES JOUEURS (ID_JOUEUR)
);
/
create table utilisateurs(
id_utilisateur NUMBER(5)  PRIMARY KEY,
nom_utilisateur varchar2(50),
mot_de_passe varchar2(255),
id_personne number(5),
CONSTRAINT FK_user_personnes 
    FOREIGN KEY (ID_Personne)
    REFERENCES Personnes (ID_Personne));

create table  apex_access_setup (
ID NUMBER constraint pk_apex_access_setup primary key, 
APPLICATION_MODE VARCHAR2(255), 
APPLICATION_ID NUMBER constraint un_apex_access_setup_id unique);
/
create table  apex_access_control (
id NUMBER constraint pk_apex_access_control primary key,
ADMIN_USERNAME VARCHAR2(255), 
ADMIN_PRIVILEGES VARCHAR2(255), 
SETUP_ID NUMBER constraint fk_apex_access_control_set references apex_access_setup(id), 
CREATED_BY VARCHAR2(255), 
CREATED_ON DATE, 
UPDATED_ON DATE, 
UPDATED_BY VARCHAR2(255),
   constraint un_apex_access_control unique(admin_username, setup_id));
/


CREATE TABLE RECOMPENSES_ENTRAINEURS(
ID_RECOMPENSE_ENTRAINEUR number(5) primary key,
ID_Entraineur number(5),
Montant number(5,2),
Date_Recompense date,
    CONSTRAINT FK_ID_RECENT_ENT-- 
    FOREIGN KEY (ID_ENTRAINEUR)
    REFERENCES ENTRAINEURS (ID_ENTRAINEUR)
);
/
ALTER TABLE inscriptions
DISABLE CONSTRAINT FK_ID_INSCR_TRANSACTIONS;


/


create or replace 
PACKAGE BODY Pck_Abbtr as
  FUNCTION Afficher_Telephone(p_tel CHAR) RETURN CHAR is
  BEGIN
  return '(' || substr(p_tel,1,3) || ') ' ||
  substr(p_tel,4,3) || '-' || 
  substr(p_tel,7,4);
  END Afficher_Telephone;
  
  FUNCTION Afficher_Code_Postal(p_code_postal CHAR) RETURN CHAR is
  BEGIN
  return upper(substr(p_code_postal,1,3) || ' ' || substr(p_code_postal,4,3));
  END Afficher_Code_Postal;
  
  FUNCTION Verifier_No_Camisole(p_numero NUMBER) RETURN BOOLEAN is
  BEGIN
  
  if (p_numero < 10 ) and (p_numero > 0) THEN
  return true;
  end if;
  
  if (p_numero >= 10) and ( mod(p_numero,10) >= 0 ) and ( mod(p_numero,10) <= 5 ) and (p_numero <= 55) THEN
  return true;
  end if;
  
  return false;
  END Verifier_No_Camisole;

  Function Valider_Codepostal(code varchar2) Return Boolean As 
    begin
    If Regexp_Like(code, '^[a-zA-Z]{1}[0-9]{1}[a-zA-Z]{1}(\-| |){1}[0-9]{1}[a-zA-Z]{1}[0-9]{1}$') Then
    return true;
  Else 
    return false;
     End If;
 end Valider_Codepostal;


  FUNCTION VALIDERNAS(nas varchar2) RETURN BOOLEAN AS 
  Begin
  If Regexp_Like(nas, '[0-9]{9}') Then
    return true;
  Else 
    return false;
  End If;
  end VALIDERNAS;

  function authenticate_user
  (p_username in varchar2, p_password in varchar2)
return boolean
is
  l_user_name       utilisateurs.nom_utilisateur%type    := upper(p_username);
  l_password        utilisateurs.mot_de_passe%type;
  l_count           number;
begin
-- First, check to see if the user exists
select count(*) into l_count from utilisateurs
  where nom_utilisateur = l_user_name;

if l_count > 0 then
  -- Get the stored password
  select mot_de_passe into l_password from utilisateurs where nom_utilisateur = l_user_name;
  -- Compare the two, and if there is a match, return TRUE
  if p_password = l_password then
    return true;
  else
    return false;
  end if;
  
else
  -- The username does not exist
  return false;
end if;
return true;
end authenticate_user;

  FUNCTION composer_username (p_nom varchar2) return char
  is
  v_nbr_compte number;
  v_nbr number;
  begin
  
  select count(*) into v_nbr from joueurs where nom = Initcap(p_nom);
  select Count(*) into v_nbr_compte from utilisateurs where  substr(Upper(nom_utilisateur),1,3) = substr(Upper(p_nom),1,3);
  
  if (v_nbr +1 < 10) and (v_nbr_compte +1 < 10) then
  return substr(Upper(p_nom),1,3) || '0' || (v_nbr+1) || '-' || '0' || (v_nbr_compte + 1);
  elsif (v_nbr +1 >= 10) and (v_nbr_compte +1 < 10) then
  return substr(Upper(p_nom),1,3) || (v_nbr+1) || '-' || '0' || (v_nbr_compte + 1);
  elsif (v_nbr +1 < 10) and (v_nbr_compte +1 >= 10) then
  return substr(Upper(p_nom),1,3) || '0' || (v_nbr+1) || '-' || (v_nbr_compte + 1);  
  else
  return substr(Upper(p_nom),1,3) || (v_nbr+1) || '-' || (v_nbr_compte + 1);
  end if;
  end composer_username;
  FUNCTION FORMAT_HEURE (heure IN number ) RETURN VARCHAR2 AS 
  resultat varchar2(5);
  H varchar2(2);
  M char(2);
  BEGIN
  
  M := Lpad(Floor(Mod(heure, 1)*60), 2, '0');
  H := Floor(heure);
  
  resultat := H||':'||M;
  return resultat;
  
  
  END FORMAT_HEURE;
END pck_abbtr;
/
create or replace TRIGGER TI_Camisoles
BEFORE INSERT
ON Camisoles
FOR EACH ROW
BEGIN
:New.ID_Camisole := Seq_Camisoles.nextval;
:New.Sexe := UPPER(:New.Sexe);
:New.Couleur := Initcap(:New.Couleur);
:New.Taille := Initcap(:New.Taille);
END TI_Camisoles;

/
--Trigger insert Table Shorts
--

create or replace TRIGGER TI_Shorts
BEFORE INSERT
ON Shorts
FOR EACH ROW
BEGIN
:New.ID_Short := Seq_Shorts.nextval;
:New.Taille := Initcap(:New.Taille);
END TI_Shorts;

--Trigger insert Table Inventaires
--
/
create or replace 
trigger TI_Inventaire
BEFORE INSERT
on Inventaires
FOR EACH ROW
BEGIN
:new.ID_Inventaire := Seq_Inventaires.nextval;
:new.Objet := Initcap(:new.Objet);
:new.Couleur := Initcap(:new.Couleur);
END;


--Trigger insert Table Joueurs
--
/
create or replace TRIGGER TI_Joueurs
BEFORE INSERT
ON Joueurs
FOR EACH ROW
BEGIN
:New.ID_Joueur := Seq_Joueurs.nextval;
:New.Nom := Initcap(:New.Nom);
:New.Prenom := Initcap(:New.Prenom);
:New.Adresse := Initcap(:New.Adresse);
:New.Ville := Initcap(:New.Ville);
:New.Code_Postal := UPPER(:New.Code_Postal);
:New.Assurance_Maladie := Upper(:New.Assurance_Maladie);
:New.Groupe_Sanguin := Upper(:New.Groupe_Sanguin);
:New.Diabete := Upper(:New.Diabete);
:New.Epilepsie := Upper(:New.Epilepsie);
:New.Asthme_Pompe := Upper(:New.Asthme_Pompe);
:New.Auto_Administration := Upper(:New.Auto_Administration);
:New.Infos_Sante_Supplementaires := Initcap(:New.Infos_Sante_Supplementaires);
END TI_Joueurs;


--Trigger insert Table entraineurs
--
/
create or replace TRIGGER TI_Entraineurs
BEFORE INSERT 
ON Entraineurs
FOR EACH ROW
BEGIN
:New.ID_Entraineur := Seq_Entraineurs.nextval;
:New.Nom := Initcap(:New.Nom);
:New.Prenom := Initcap(:New.Prenom);
:New.Adresse := Initcap(:New.Adresse);
:New.Ville := Initcap(:New.Ville);
:New.Code_Postal := UPPER(:New.Code_Postal);
END TI_Entraineurs;


--Trigger insert Table Categories
--
/
create or replace TRIGGER TI_Categories
BEFORE INSERT
ON Categories
FOR EACH ROW
BEGIN
:New.ID_Categorie := Seq_Categories.nextval;
:New.Nom := Initcap(:New.Nom);
END TI_Categories;


--Trigger Insert Table Ecoles
--
/
create or replace TRIGGER TI_Ecoles
BEFORE INSERT
ON Ecoles
FOR EACH ROW
BEGIN
:New.ID_Ecole := Seq_Ecoles.nextval;
:New.Nom := Initcap(:New.nom);
:New.Adresse := Initcap(:New.Adresse);
:New.Ville := Initcap(:New.Ville);
:New.Code_Postal := UPPER(:New.Code_Postal);
:New.Contact := Initcap(:New.Contact);
:New.Role_Contact := Initcap(:New.Role_Contact);
END TI_Ecoles;


--Trigger insert Table Postes_Budgetaires
--
/
create or replace TRIGGER TI_Postes_Budgetaires
BEFORE INSERT
ON Postes_Budgetaires
FOR EACH ROW
BEGIN
:New.ID_Poste := Seq_Postes_Budgetaires.nextval;
:New.Nom_Poste := Initcap(:New.Nom_Poste);
:New.Depense := Upper(:New.Depense);
END TI_Postes_Budgetaires;

--Trigger Insert Table Factures
--
/
create or replace TRIGGER TI_Factures
before insert
on Factures
for each row
BEGIN
:New.ID_Facture := Seq_Factures.nextval;
END TI_Factures;


--Trigger insert Table Tournois
--
/
create or replace TRIGGER TI_Tournois
BEFORE INSERT
ON Tournois
for each row
BEGIN
:New.ID_Tournoi := Seq_Tournois.nextval;
:New.Ville := Initcap(:New.Ville);
END TI_Tournois;

---------------------------------
------- Trigger Niveau 1 --------
---------------------------------

--Trigger insert Table Prets_Equipements
--
/
create or replace TRIGGER TI_Prets_Equipements
BEFORE INSERT
ON Prets_Equipements
FOR EACH ROW
BEGIN
:New.ID_Pret := Seq_Prets_Equipements.nextval;
END TI_Prets_Equipements;



--Trigger Insert Table Joueurs_Blessures
--
/
create or replace TRIGGER Ti_Joueurs_Blessures
BEFORE INSERT
ON Joueurs_Blessures
for each row
BEGIN
:New.ID_Joueur_Blessure := Seq_Joueurs_Blessures.nextval;
:New.Nom_Blessure := Initcap(:New.Nom_Blessure);
END Ti_Joueurs_Blessures;

--Trigger Insert Table Joueurs_Allergies
--
/
create or replace TRIGGER Ti_Joueurs_Allergies
BEFORE INSERT
on Joueurs_Allergies
for each row
BEGIN
:New.ID_Joueur_Allergie := Seq_Joueurs_Allergies.nextval;
:New.Nom_Allergie := Initcap(:New.Nom_Allergie);
END Ti_Joueurs_Allergies;

--Trigger Insert Table Joueurs_MÃ©dicaments
--
/
create or replace TRIGGER Ti_Joueurs_Medicaments
BEFORE INSERT
ON Joueurs_Medicaments
FOR EACH ROW
BEGIN
:New.ID_Joueur_Medicament := Seq_Joueurs_Medicaments.nextval;
:New.Nom_Medicament := InitCap(:New.Nom_Medicament);
:New.Posologie := InitCap(:New.Posologie);
END Ti_Joueurs_Medicament;

--Trigger Insert Table Dispos_Entraineurs
--
/
create or replace TRIGGER TI_Dispos_Entraineurs
BEFORE INSERT
ON Dispos_Entraineurs
FOR EACH ROW
BEGIN
:New.ID_Dispo_Entraineur := Seq_Dispos_Entraineurs.nextval;
:New.Jour := Initcap(:New.Jour);
END TI_Dispos_Entraineurs;

--Trigger Insert Table Recompenses_Entraineurs
--
/
create or replace TRIGGER TI_Recompenses_Entraineurs
BEFORE INSERT
ON Recompenses_Entraineurs
FOR EACH ROW
BEGIN
:New.ID_Recompense_Entraineur := Seq_Recompenses_Entraineurs.nextval;
END TI_Recompenses_Entraineurs;

--Trigger Insert Table Personnes
--
/
create or replace TRIGGER TI_Personnes
BEFORE INSERT
ON Personnes
FOR EACH ROW
BEGIN
:New.ID_Personne := Seq_Personnes.nextval;
:New.Nom := Initcap(:New.Nom);
:New.Prenom := Initcap(:New.Prenom);
:New.Adresse := Initcap(:New.Adresse);
:New.Ville := Initcap(:New.Ville);
:New.Code_Postal := Initcap(:New.Code_Postal);
:New.Eligible_Impot := Initcap(:New.Eligible_Impot);
END TI_Personnes;

--Trigger Insert Table Personnes_Joueurs
--
/
create or replace TRIGGER TI_Personnes_Joueurs
BEFORE INSERT
ON Personnes_Joueurs
FOR EACH ROW
BEGIN
:New.Role_Personne := Initcap(:New.Role_Personne);
:New.Contact_Urgence := Initcap(:New.Contact_Urgence);
END TI_Personnes_Joueurs;

--Trigger insert Table Equipes
--
/
create or replace TRIGGER TI_Equipes
BEFORE INSERT
ON Equipes
FOR EACH ROW
BEGIN
:New.ID_Equipe := Seq_Equipes.nextval;
:New.Nom := Initcap(:New.Nom);
:New.Type_Equipe := Initcap(:New.Type_Equipe);
END TI_Equipes;

--Trigger Insert Table Gyms
--
/
create or replace TRIGGER TI_Gyms
BEFORE INSERT
ON Gyms
FOR EACH ROW
BEGIN
:New.ID_Gym := Seq_Gyms.nextval;
:New.Nom := Initcap(:New.Nom);
END TI_Gyms;

--Trigger Insert Table Transactions
--
/
create or replace TRIGGER TI_Transactions
BEFORE INSERT
ON Transactions
FOR EACH ROW
BEGIN
:New.ID_Transaction := Seq_Transactions.nextval;
:New.Nom_Transaction := Initcap(:New.Nom_Transaction);
:New.Mode_Paiement := Initcap(:New.Mode_Paiement);
:New.Paye := Initcap(:New.Paye);
END TI_Transactions;
---------------------------------
------- Trigger Niveau 2 --------
---------------------------------

--Trigger insert Table Personnes_Joueurs
--
/
create or replace TRIGGER TI_Personnes_Joueurs
BEFORE INSERT
ON Personnes_Joueurs
for each row
BEGIN
:New.ID_Personne_Joueur := Seq_Personnes_Joueurs.nextval;
:New.Role_Personne := Initcap(:New.Role_Personne);
:New.Contact_Urgence := UPPER(:NEW.Contact_Urgence);
END TI_Joueurs_Personne;

--Trigger insert Table Utilisateurs
--
/

create or replace 
trigger ti_utilisateurs 
  before insert on utilisateurs 
  for each row
declare 
v_nom varchar2(50);
begin 
  select Seq_Utilisateurs.nextval into :new.id_utilisateur from dual; 
  
  if (:new.nom_utilisateur is not null) then  
  :new.nom_utilisateur := upper(:new.nom_utilisateur);
  insert into apex_access_control values (apex_access_control_seq.nextval, :new.nom_utilisateur, 'ADMIN', 1, 'AP0519', sysdate, null, null);
  else
    select distinct j.nom into v_nom 
    from personnes p,personnes_joueurs pj,joueurs j
    where :new.id_personne = p.id_personne and 
          p.id_personne = pj.id_personne and 
          pj.id_joueur = j.id_joueur;
    :new.nom_utilisateur := pck_abbtr.composer_username(v_nom);
    
    insert into apex_access_control values (apex_access_control_seq.nextval, :new.nom_utilisateur, 'VIEW', 1, 'AP0519', sysdate, null, null);
  end if;
  end ti_utilisateurs;       
--Trigger update Table utilisateurs
--
/
create or replace trigger  tu_utilisateurs 
  before update on utilisateurs 
  for each row 
begin 
  :new.nom_utilisateur := upper(:new.nom_utilisateur); 
  if :new.mot_de_passe is not null then 
    :new.mot_de_passe := :new.mot_de_passe;
    else 
    :new.mot_de_passe := :old.mot_de_passe; 
  end if; 
end tu_utilisateurs; 
--Trigger delete Table utilisateurs
--
/
create or replace 
trigger TD_Utilisateurs
before delete 
on Utilisateurs
for each row
begin
delete from apex_access_control where :old.nom_utilisateur = admin_username;
end TD_Utilisateurs;

--Trigger insert Table Apex_access_setup
--
/
create or replace trigger  ti_apex_access_setup 
before insert or update on apex_access_setup 
for each row
begin
if inserting and :new.id is null then
select apex_access_control_seq.nextval into :new.id from dual;
end if;
if :new.application_id is null then
:new.application_id := v('APP_ID');
end if;
end ti_apex_access_setup;

--Trigger insert Table Apex_access_control
--
/
create or replace trigger ti_apex_access_control 
  before insert or update on apex_access_control
  for each row
begin
    if inserting and :new.id is null then
        select apex_access_control_seq.nextval into :new.id from dual;
    end if;
    if inserting then
        :new.created_by := v('USER');
        :new.created_on := sysdate;
    end if;
    if updating then
        :new.updated_by := v('USER');
        :new.updated_on := sysdate;
    end if;
end ti_apex_access_control; 

-- Trigger Insert Table Equipes_Entraineurs
--
/
create or replace TRIGGER TI_Equipes_Entraineurs
BEFORE INSERT
ON Equipes_Entraineurs
FOR EACH ROW
BEGIN
:New.ID_Equipe_Entraineur := Seq_Equipes_Entraineurs.nextval;
:New.Type_Entraineur := Initcap(:New.Type_Entraineur);
END TI_Equipes_Entraineurs;

-- Trigger Insert Table Equipes_Tournois
--
/
create or replace TRIGGER TI_Equipes_Tournois
BEFORE INSERT
ON Equipes_Tournois
FOR EACH ROW
BEGIN
:New.ID_Equipe_Tournoi := Seq_Equipes_Tournois.nextval;
END TI_Equipes_Tournois;
/
--Trigger insert Table Recus_Impots
--

create or replace TRIGGER TI_Recus_Impot
BEFORE INSERT
ON Recus_Impot
for each row
BEGIN
:New.ID_Recu := Seq_Recus_Impots.nextval;
END TI_Recus_Impots;

--Trigger insert Table Pratiques
--
/
create or replace TRIGGER TI_Pratiques
BEFORE INSERT
ON Pratiques
for each row
BEGIN
:New.ID_Pratique := Seq_Pratiques.nextval;
:New.Jour := Initcap(:New.Jour);
END TI_Recus_Impots;

--Trigger insert Table dispos_gyms
--
/
create or replace TRIGGER TI_Dispos_Gyms
BEFORE INSERT
ON Dispos_Gyms
FOR EACH ROW
BEGIN
:New.ID_Dispo_Gym := Seq_Dispos_Gyms.nextval;
:New.Jour := Initcap(:New.Jour);
END TI_Dispos_Gyms;

--Trigger insert Table Inscriptions
--
/
create or replace 
trigger TI_Inscriptions
 BEFORE INSERT
 ON Inscriptions
 for each row
DECLARE
v_joueur varchar2(200);
v_montant number;
v_equipe varchar2(100);
 BEGIN
:New.ID_Inscription := Seq_Inscriptions.nextval;
select nom||', '||prenom into v_joueur from joueurs where id_joueur = :new.id_joueur;
select montant_inscription into v_montant from equipes where id_equipe = :new.id_equipe;
select nom into v_equipe from equipes where id_equipe = :new.id_equipe;

insert into transactions values(null, v_montant, 'INSCRIPTION JOUEUR '||v_joueur||' '||v_equipe, sysdate,null,  2, 'Indéterminé');
:New.ID_Transaction := Seq_Transactions.currval;
END TI_Inscriptions;

---------------------------------
------- Trigger Niveau 3 --------
---------------------------------

--Trigger insert Table Recipiendaires 
--
/
create or replace TRIGGER TI_Recipiendaires
BEFORE INSERT
ON Recipiendaires
for each row
BEGIN
:New.ID_Recipiendaire := Seq_Recipiendaires.nextval;
:New.Titre := Initcap(:New.Titre);
END TI_Recipiendaires;

/

commit;

---------------------------------
---- Test  Trigger Niveau 0 -----
---------------------------------
--Test Camisoles

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(1,'5-6','h','Bleu','Large');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(12,'5-6','h','Bleu','Large');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(14,'5-6','h','Bleu','Large');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(33,'5-6','h','Bleu','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(45,'5-6','h','Bleu','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(51,'5-6','h','Bleu','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(54,'5-6','h','Bleu','X Large');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(39,'5-6','h','Bleu','X Large');


insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(12,'Mini 4','h','Bleu','Small');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(11,'Mini 4','h','Bleu','Small');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(8,'Mini 4','h','Bleu','Small');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(4,'Mini 4','h','Bleu','X Small');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(24,'Mini 4','h','Bleu','Small');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(35,'Mini 4','h','Bleu','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(42,'Mini 4','h','Bleu','XL Youth');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(51,'Mini 4','h','Bleu','XL Youth');



insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(17,'5-6','f','Royal','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(22,'5-6','f','Royal','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(25,'5-6','f','Royal','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(31,'5-6','f','Royal','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(41,'5-6','f','Royal','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(43,'5-6','f','Royal','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(11,'5-6','f','Royal','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(8,'5-6','f','Royal','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(24,'5-6','f','Royal','Medium');



insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(12,'Mini 4','f','Blanc','L Youth');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(20,'Mini 4','f','Blanc','XL Youth');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(22,'Mini 4','f','Blanc','Small');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(32,'Mini 4','f','Blanc','Small');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(42,'Mini 4','f','Blanc','XL Youth');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(2,'Mini 4','f','Blanc','L Youth');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(7,'Mini 4','f','Blanc','XL Youth');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(41,'Mini 4','f','Blanc','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(35,'Mini 4','f','Blanc','Medium');

insert into camisoles (No_camisole,categorie_age,sexe,couleur,taille) 
values(43,'Mini 4','f','Blanc','Small');





--Test Shorts
insert into shorts (taille,quantite) values('XL Youth',15);

insert into shorts (taille,quantite) values('X Small',20);

insert into shorts (taille,quantite) values('Small',11);

insert into shorts (taille,quantite) values('Medium',5);

insert into shorts (taille,quantite) values('X Large',25);


--Test Joueurs

insert into joueurs (nom,prenom,sexe,adresse,ville,
					   code_postal,date_naissance,assurance_maladie,groupe_sanguin,
					   diabete,epilepsie,asthme_pompe,auto_administration) values
						('Genest','Lucie','F','300 3e avenue','Trois-Rivières','g9b7x5',
						'2005-12-12','LUGE05121203','AB-',null,null,null,null);


insert into joueurs (nom,prenom,sexe,adresse,ville,
					   code_postal,date_naissance,assurance_maladie,groupe_sanguin,
					   diabete,epilepsie,asthme_pompe,auto_administration) values
						('Genest','Luc','H','300 3e avenue','Trois-Rivières','g9b7x5',
						'2004-10-12','LGEN05121203','AB+','o','o','o',null);


insert into joueurs (nom,prenom,sexe,adresse,ville,
					   code_postal,date_naissance,assurance_maladie,groupe_sanguin,
					   diabete,epilepsie,asthme_pompe,auto_administration) values
						('Dubé','George','H','300 3e rue','Trois-Rivières','p9b7k5',
						'2005-01-12','GDUB05121203','A+',null,null,'o','o');

insert into joueurs (nom,prenom,sexe,adresse,ville,
					   code_postal,date_naissance,assurance_maladie,groupe_sanguin,
					   diabete,epilepsie,asthme_pompe,auto_administration) values
						('Lafrance','Arnold','H','25 rue principale','Trois-Rivières','p8b5k2',
						'2004-02-06','LGEN05121203','B-',null,null,null,null);

insert into joueurs values(null, 'Martin', 'Renaud', 'H','222 3eme avenue ','Trois-Rivières', 'G0X2P0', sysdate - 3600, 'MARR29010110', 'AB+', 'O', 'O', null, 'O', 'Asthmatique');

insert into joueurs values(null, 'Marie', 'Renaude', 'F', '222 65eme avenue ', 'Cap de la Madeleine', 'P0X9P3', sysdate - 4000, 'MARR29010111', 'O+', 'O', 'O', null, 'O', null);

insert into joueurs values(null, 'Spicer', 'Bob', 'H', '205 rue des écureuils ','Saint-Étienne-des-Grès', 'G9B9P3', sysdate - 4600, 'MARR29010111', 'O+', 'O', 'O', null, 'O', null);

insert into joueurs values(null, 'Donald', 'Ron', 'H', '400 5e rue ','Trois-Rivières', 'G9B9P3', sysdate - 4500, 'MARR29010111', 'O+', 'O', 'O', null, 'O', 'Leucémie');

--Test Entraineurs

insert into entraineurs (nom,prenom,date_naissance,nas,fin_service,telephone,adresse,ville,code_postal)
values('Bérubé','Benoît','1980-12-06','287162538',null,'8193772618','120 rue Montour','Trois-Rivières','y6t7u8');

insert into entraineurs (nom,prenom,date_naissance,nas,fin_service,telephone,adresse,ville,code_postal)
values('Tremblay','Marcel','1992-02-06','287162538',null,'8192692348','220 rue Montour','Trois-Rivières','y6t7u8');

insert into entraineurs (nom,prenom,date_naissance,nas,fin_service,telephone,adresse,ville,code_postal)
values('Lapointe','Philippe','1975-10-06','183971265',null,'8193972448','500 9e rue','Trois-Rivières','y6t7u8');

insert into entraineurs (nom,prenom,date_naissance,nas,fin_service,telephone,adresse,ville,code_postal)
values('Leclerc','Éric','1982-12-07','173946285',null,'8193472008','39 10e rue','Trois-Rivières','y6t7z7');

insert into entraineurs (nom,prenom,date_naissance,nas,fin_service,telephone,adresse,ville,code_postal)
values('Caron','Pierre-Édouard','1990-09-08','854596553',null,'8194182618','110 avenue nord','Trois-Rivières','b6zk2h');

insert into entraineurs values(null, 'Rubio', 'Marco', sysdate-9000, '123333321', null, 8193331234, 
	'205 Avenue Émeraude', 'Québec', 'R1B1OS');

insert into entraineurs values(null, 'Paré', 'Martin', sysdate-9500, '123444321', null, 8194442345, 
	'255 Avenue Diamant', 'Montréal', 'M4R71N');
insert into entraineurs values(null, 'Roy', 'Mathieu', sysdate-9600, '234554321', null, 8196542345, 
	'255 Avenue Opale', 'Daveluyvill', 'M4713U');
--Test Categorie

insert into categories (nom) values ('5-6 Filles');
insert into categories (nom) values ('5-6 Gars');
insert into categories (nom) values ('Mini 4 Filles');
insert into categories (nom) values ('Mini 4 Gars');
insert into categories (nom) values ('Mini 3 Filles');
insert into categories (nom) values ('Mini 3 Gars');

--Test Ecoles
 
insert into ecoles (nom,adresse,ville,code_postal,telephone,contact,role_contact,cell_contact)
	values ('Beau-Soleil','1212 chemin St-Marguerite','Pointe-Du-Lac','G9b5h4',
		   '8193772837','Pierre Laporte','Responsable','8192681415');

insert into ecoles values
	(null, 'Chavigny', '3000 rue Chavigny', 'Shawinigan', 'C4AV1G',
	 8193639000, 'Jean Chavigny', 'Directeur de chavigny', 8199999999);
insert into ecoles values(null, 'Pionniers', '3000 avenue des Pionniers', 'Trois-Rivières', 'P10N13',
 8193639050, 'Marc Pionnier', 'Directeur des Pionniers', 8199999329);
insert into ecoles values(null, 'Keranna', '3000 boulevard Keranna', 'Trois-Rivières', 'P10N13', 
	8193639050, 'Marc Pionnier', 'Directeur des Pionniers', 8199999329);

--Test Poste budgetaires
insert into postes_budgetaires values(null, 'Opérations courantes', 'O');
insert into postes_budgetaires values(null, 'Revenus Inscription', null);

--Test Factures

--Test Tournois
insert into tournois values(null, 'Sainte-Clémentine', sysdate+400, sysdate +403, 200);
insert into tournois values(null, 'Sainte-Pérpétue', sysdate+500, sysdate +505, 225);
---------------------------------
---- Test  Trigger Niveau 1 -----
---------------------------------
--Test Prets_Equipements
insert into prets_equipements values(null, sysdate-1000, 1, 1, sysdate + 15, null, 1);
insert into prets_equipements values(null, sysdate-700, 2, 2, sysdate + 20, null, 3);
insert into prets_equipements values(null, sysdate-300, 4, 2, sysdate + 120, Sysdate + 120, 4);
--Test Joueurs blessures
insert into joueurs_blessures values(null, 'Fracture du Tibia', sysdate-2000, 1);
insert into joueurs_blessures values(null, 'Fracture du Fémur', sysdate-1500, 1);
insert into joueurs_blessures values(null, 'Foulure de la cheville', sysdate-1500, 1);
insert into joueurs_blessures values(null, 'Crise cardiaque', sysdate-1100, 3);
insert into joueurs_blessures values(null, 'Épaule déplacée', sysdate-700, 2);
--Test Joueurs allergies
insert into joueurs_allergies values(null, 'Arachides', 1);
insert into joueurs_allergies values(null, 'Fruits de mer', 1);
insert into joueurs_allergies values(null, 'Gluten', 2);
insert into joueurs_allergies values(null, 'Lactose', 3);
--Test Joueurs medicaments
insert into joueurs_medicaments values(null, 'Doliprane', '2 pilules 2 fois par jour', 1);
insert into joueurs_medicaments values(null, 'Efferalgan', '2 pilules 1 fois par jour', 1);
insert into joueurs_medicaments values(null, 'Dafalgan', '2 pilules 1 fois par jour', 2);
insert into joueurs_medicaments values(null, 'Méthadone', '2 berlingots 1 fois par jour', 2);
--Test dispos entraineurs
--Test recompenses entraineurs
Insert into recompenses_entraineurs values(null, 1, 200, sysdate - 100);
Insert into recompenses_entraineurs values(null, 1, 210, sysdate - 200);
Insert into recompenses_entraineurs values(null, 3, 160, sysdate - 300);
Insert into recompenses_entraineurs values(null, 2, 175, sysdate - 50);
Insert into recompenses_entraineurs values(null, 4, 275, sysdate - 50);
Insert into recompenses_entraineurs values(null, 1, 375, sysdate - 150);
--Test Personnes
insert into personnes values (null,'Genest','Marc','8193093938',null,'837837823','300 3e avenue','Trois-Rivières','g9b7x5','O');
insert into personnes values (null,'Dubé','Pierre','8193771238',null,'837837823','300 3e rue','Trois-Rivières','p9b7k5',null);
insert into personnes values (null,'Lafrance','Monique','8193774546',null,'837837823','25 rue principale','Trois-Rivières','p8b5k2','O');

--Test Equipes
insert into equipes values(null, 'Les Éclairs', 1, 1, 'Mixte', 100);
insert into equipes values(null, 'Les Magiciens', 2,1, 'Mixte', 200);
insert into equipes values(null, 'Les Serpents', 3,1, 'Mixte', 150);
insert into equipes values(null, 'Les Abeilles', 4,1,  'Féminin', 220);
--Test Gyms
insert into gyms values(null, 1, 'Gymnase du Pavillon Pierre-Édouard');
insert into gyms values(null, 3, 'Gymnase Central');
insert into gyms values(null, 2, 'Gymnase A1');
insert into gyms values(null, 2, 'Gymnase A2');


--Test Transactions
---------------------------------
---- Test  Trigger Niveau 2 -----
---------------------------------
--Test Personne Joueurs
insert into personnes_joueurs values (null,1,1,'Père','O');
insert into personnes_joueurs values (null,1,2,'Père','O');
insert into personnes_joueurs values (null,2,3,'Père',null);
insert into personnes_joueurs values (null,3,4,'Mère','O');

--Test apex_access_setup
insert into apex_access_setup values (1, 'PUBLIC_RESTRICTED', 887);

--Test utilisateurs
INSERT INTO utilisateurs VALUES (null, 'bob', 'bob',null);
INSERT INTO utilisateurs VALUES (null, null, 'bob',1);
INSERT INTO utilisateurs VALUES (null, null, 'bob',2);
INSERT INTO utilisateurs VALUES (null, null, 'bob',3);


--Test Equipes entraineurs
insert into equipes_entraineurs values (null, 'Entraineur Chef', 1, 1);
insert into equipes_entraineurs values(null, 'Entraineur Chef', 2, 3);
insert into equipes_entraineurs values(null, 'Assistant Entraineur', 3, 2);

--Test Equipes Tournois
insert into equipes_tournois values(null, 1, 2, null);
insert into equipes_tournois values(null, 3, 2, null);
insert into equipes_tournois values(null, 2, 2, null);
insert into equipes_tournois values(null, 1, 1, null);
insert into equipes_tournois values(null, 3, 1, null);

--Test Recus Impot
--Test Pratiques
--Test Dispos Gyms
--Test Inscriptions
---------------------------------
---- Test  Trigger Niveau 3 -----
---------------------------------
--Test Recipiendaires 

commit;