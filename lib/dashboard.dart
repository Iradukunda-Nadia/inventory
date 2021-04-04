import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:inventory/Reports/issuanceReport.dart';
import 'package:inventory/Reports/supReports.dart';
import 'package:inventory/Stock/issuance.dart';
import 'package:inventory/comp/suppliers.dart';
import 'package:inventory/returns/replace.dart';
import 'package:inventory/returns/returns.dart';
import 'Stock/inStock.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'Reports/deductionsRep.dart';
import 'dart:convert';
var jsonStr = """
 {
  "results": [
  {
    "docID": 1,
    "name": "MOKOMBA BENEDICT OPOLE",
    "id": 36636037,
    "region": "NAKURU",
    "assign": "ACK SECTION 58 -CHURCH NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 2,
    "name": "NDERITU PETER WANJIRU",
    "id": 33175274,
    "region": "NAKURU",
    "assign": "ACK SECTION 58 -CHURCH NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 3,
    "name": "NYAMBOGA KENNEDY",
    "id": 10908581,
    "region": "NAKURU",
    "assign": "ACK SECTION 58 -CHURCH NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 4,
    "name": "OGWANKWA SIMEON NYANUMBA",
    "id": 16115690,
    "region": "NAKURU",
    "assign": "ACK SECTION 58 -CHURCH NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 5,
    "name": "AMOIT JOSEPHINE ELIWA",
    "id": 13528405,
    "region": "NAKURU",
    "assign": "ACK SECTION 58 -CHURCH NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 6,
    "name": "OBOYA ALEXANDER ODUOR",
    "id": 7921774,
    "region": "NAKURU",
    "assign": "ACK SECTION 58 -CHURCH NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 7,
    "name": "MWORIA JOSEPH GITONGA KIRIMI",
    "id": 14415833,
    "region": "LAARE/MAUA",
    "assign": "AFRICA MOJA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 8,
    "name": "KARATHO JOHN KARUTI",
    "id": "",
    "region": "LAARE/MAUA",
    "assign": "AFRICA MOJA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 9,
    "name": "MUKARIA BENSON ISAAC NTONGAI",
    "id": "",
    "region": "LAARE/MAUA",
    "assign": "AFRICA MOJA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 10,
    "name": "KAUMBUTHU PAUL",
    "id": 1090630,
    "region": "MERU",
    "assign": "AGVENTURE LIMITED -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 11,
    "name": "KINYUA PATRICK NYAGAH",
    "id": 13402052,
    "region": "NANYUKI",
    "assign": "AGVENTURE LIMITED -TIMAU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 12,
    "name": "ERIMANIA FRANCIS K",
    "id": 11057195,
    "region": "LAARE/MAUA",
    "assign": "AKIRANG'ONDU BOYS SEC SCH -LAARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 13,
    "name": "JULIUS KINYUA MUTINKO",
    "id": 32325159,
    "region": "LAARE/MAUA",
    "assign": "AKIRANG'ONDU BOYS SEC SCH -LAARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 14,
    "name": "MWENDA DENNIS",
    "id": 34779321,
    "region": "LAARE/MAUA",
    "assign": "AKIRANG'ONDU BOYS SEC SCH -LAARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 15,
    "name": "KABERIA TONY KIRIMI",
    "id": "",
    "region": "ISIOLO",
    "assign": "AL-FALAH ISLAMIC CENTRE -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 16,
    "name": "DABASO ADAN HUKA",
    "id": 34893107,
    "region": "ISIOLO",
    "assign": "AL-FALAH ISLAMIC CENTRE -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 17,
    "name": "BONAYA ADEN SOMO",
    "id": 32057601,
    "region": "ISIOLO",
    "assign": "AL-FALAH ISLAMIC CENTRE -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 18,
    "name": "LOKITAENAE JOSEPH LEER",
    "id": 35311196,
    "region": "ISIOLO",
    "assign": "AL-FALAH ISLAMIC CENTRE -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 19,
    "name": "THIANE YUSSUFU NDEGWA",
    "id": 33883825,
    "region": "ISIOLO",
    "assign": "AL-FALAH ISLAMIC CENTRE -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 20,
    "name": "KUBAI ZACHARY KINYUA",
    "id": 7345,
    "region": "MERU",
    "assign": "ALIMKO LODGE-MAKUTANO -SHOP TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 21,
    "name": "IMANA CHARLES LWANGA",
    "id": 12579891,
    "region": "WESTERN",
    "assign": "ANDREW NDOBI APARTMENT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 22,
    "name": "DANIEL HELLEN MUNOCIA",
    "id": "",
    "region": "MERU",
    "assign": "ANTONY MUGIIRA K CONSTRUCTOR",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 23,
    "name": "NYAGA NAMU ANDREW",
    "id": 14411783,
    "region": "ISIOLO",
    "assign": "ARCH ANGELS' KANYUERI HIGH SCH. -ISHIARA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 24,
    "name": "KABERIA JADIEL MURITHI",
    "id": 22369778,
    "region": "MERU",
    "assign": "AYRUSH LIMITED -OFFICE MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 25,
    "name": "MUTHURWA NAFTARY MWITI",
    "id": 38088848,
    "region": "MERU",
    "assign": "AYRUSH LIMITED -OFFICE MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 26,
    "name": "MEEME ISAAC JACKSON",
    "id": 23140265,
    "region": "MERU",
    "assign": "BAIBUTU RIVERSIDE LODGE -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 27,
    "name": "MUGAMBI TIMOTHY",
    "id": 26082902,
    "region": "MERU",
    "assign": "BAIMWATI HOUSE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 28,
    "name": "MUNGAI KELVIN",
    "id": 38553440,
    "region": "MERU",
    "assign": "BEKERETI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 29,
    "name": "MWITHI GENESIO MURORI",
    "id": 34208356,
    "region": "MERU",
    "assign": "BEKERETI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 30,
    "name": "MUTEMBEI EYAN RUGENDO",
    "id": 33251412,
    "region": "MERU",
    "assign": "BEKERETI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 31,
    "name": "MUNENE DESMOND GITARI",
    "id": 36499488,
    "region": "MERU",
    "assign": "BEKERETI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 32,
    "name": "CHABARI TIMOTHY MBAE",
    "id": 11157815,
    "region": "MERU",
    "assign": "BEKERETI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 33,
    "name": "KIURA MARTIN MWENDA",
    "id": 35219468,
    "region": "MERU",
    "assign": "BEKERETI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 34,
    "name": "KENDI LUCY",
    "id": 27381825,
    "region": "MERU",
    "assign": "BESSONE PRIMARY SCHOOL -NKABUNE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 35,
    "name": "MUTURA JOHN",
    "id": 33980754,
    "region": "MERU",
    "assign": "BIO INTENSIVE -KAAGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 36,
    "name": "KINOTI CHRISTOPHER MUTUA",
    "id": 14645604,
    "region": "MERU",
    "assign": "BISHOP MWITI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 37,
    "name": "FESTUS LOHMAN MWINGIRWA",
    "id": 11325025,
    "region": "MERU",
    "assign": "BISHOP MWITI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 38,
    "name": "MUTETHIA SHADRACK MULA",
    "id": 35230700,
    "region": "MERU",
    "assign": "BRAVO MUTUMA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 39,
    "name": "CHERUIYOT SAMUEL",
    "id": 5589569,
    "region": "NAKURU",
    "assign": "BURAHA ZENONI HOTEL AND RESORT -BARNABAS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 40,
    "name": "LUBISHA CLARE NALIAKA",
    "id": 328656685,
    "region": "NAKURU",
    "assign": "BURAHA ZENONI HOTEL AND RESORT -BARNABAS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 41,
    "name": "RATEMO JOSHUA MATURETI",
    "id": 20713055,
    "region": "NAKURU",
    "assign": "BURAHA ZENONI HOTEL AND RESORT -BARNABAS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 42,
    "name": "RIRO JUSTUS RIRO",
    "id": 34077157,
    "region": "NAKURU",
    "assign": "BURAHA ZENONI HOTEL AND RESORT -BARNABAS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 43,
    "name": "MWIKA DAVID",
    "id": 35733825,
    "region": "LAARE/MAUA",
    "assign": "BURIERURI PETROL STATION -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 44,
    "name": "MKAIRARA ISAAC KUBAI",
    "id": 2441363,
    "region": "LAARE/MAUA",
    "assign": "BURIERURI PETROL STATION -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 45,
    "name": "M'AMBURUGUA JOSEPH GITONGA",
    "id": 23419776,
    "region": "LAARE/MAUA",
    "assign": "BURIERURI SECONDARY SCH -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 46,
    "name": "MWIRIGI GODFREY",
    "id": 35151237,
    "region": "LAARE/MAUA",
    "assign": "BURIERURI SECONDARY SCH -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 47,
    "name": "OBIERO BONFACE ONG'ALE",
    "id": 35870065,
    "region": "LAARE/MAUA",
    "assign": "BURIERURI SECONDARY SCH -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 48,
    "name": "MUTUMA MICHAEL MKAIRIAMA",
    "id": 27157316,
    "region": "LAARE/MAUA",
    "assign": "BURIERURI SECONDARY SCH -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 49,
    "name": "KIBUIYA EVAN MUYA",
    "id": 30806435,
    "region": "LAARE/MAUA",
    "assign": "BURIERURI SECONDARY SCH -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 50,
    "name": "MAINDA JAPHET MWONGERA",
    "id": 32248717,
    "region": "LAARE/MAUA",
    "assign": "BURIERURI SECONDARY SCH -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 51,
    "name": "KINYUA SAMUEL",
    "id": 23830112,
    "region": "LAARE/MAUA",
    "assign": "BURIERURI SECONDARY SCH -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 52,
    "name": "KITHINJI ALEX MUTETHIA",
    "id": 7345,
    "region": "MERU",
    "assign": "CAPITAL SACCO -CHAARIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 53,
    "name": "GAUKU RUTH KANARIO",
    "id": 23987712,
    "region": "MERU",
    "assign": "CAPITAL SACCO -CHAARIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 54,
    "name": "MURITHI MISHECK",
    "id": 31445941,
    "region": "LAARE/MAUA",
    "assign": "CAPITAL SACCO -KANGETA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 55,
    "name": "MEEME PURITY MWENDWA",
    "id": 25490967,
    "region": "LAARE/MAUA",
    "assign": "CAPITAL SACCO -KANGETA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 56,
    "name": "MWENDWA BENSON",
    "id": 28234566,
    "region": "CHUKA",
    "assign": "CAPITAL SACCO -KIANGUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 57,
    "name": "NDUGUTU JOHN MWINDI",
    "id": 33076345,
    "region": "CHUKA",
    "assign": "CAPITAL SACCO -KIANGUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 58,
    "name": "KIMANZI PETER MWENDWA",
    "id": 24168453,
    "region": "MERU",
    "assign": "CAPITAL SACCO -MITUNGUU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 59,
    "name": "MAWIRA JASON JOKA",
    "id": 34391800,
    "region": "MERU",
    "assign": "CAPITAL SACCO -MITUNGUU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 60,
    "name": "KAUME MARTIN",
    "id": 34728769,
    "region": "MERU",
    "assign": "CAR WASH BAR AND RESTAURANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 61,
    "name": "NYAGE NTWIGA JAMES",
    "id": 8311519,
    "region": "MERU",
    "assign": "CARINA VENTURES LIMITED -NATIONAL OIL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 62,
    "name": "KARIMI DORIS ITHALII",
    "id": 25508656,
    "region": "LAARE/MAUA",
    "assign": "CDF LAARE -LAARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 63,
    "name": "KIRUI DOMINIC KIPRUTO",
    "id": 35362090,
    "region": "NAIROBI",
    "assign": "CENTRIC COURT HOTEL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 64,
    "name": "NAVADE ELIZABETH KAGEHA",
    "id": 31880869,
    "region": "NAIROBI",
    "assign": "CENTRIC COURT HOTEL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 65,
    "name": "SANDE FREDY",
    "id": 39189161,
    "region": "NAIROBI",
    "assign": "CENTRIC COURT HOTEL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 66,
    "name": "MUSINYA BENARD ONONO",
    "id": 21383396,
    "region": "NAIROBI",
    "assign": "CENTRIC COURT HOTEL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 67,
    "name": "MUGAMBI BENSON",
    "id": 36260816,
    "region": "MERU",
    "assign": "CHARLES TIMBERYARD -KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 68,
    "name": "MWANGI CHRISTOPER WAWERU",
    "id": 25709730,
    "region": "NYERI",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 69,
    "name": "ITENDE NDEKE JORAM NJERU",
    "id": 32248760,
    "region": "NYERI",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 70,
    "name": "MURIMI VICTOR",
    "id": 35506575,
    "region": "NYERI",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 71,
    "name": "MARONCO HARUN KITHINJI",
    "id": 30144344,
    "region": "MERU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) - RELIEVER",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 72,
    "name": "ARIM LOTIKOL",
    "id": 4200116,
    "region": "ISIOLO",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -ACHERS POST",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 73,
    "name": "ALANGWASO SAMMY",
    "id": 7345,
    "region": "ISIOLO",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -ACHERS POST",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 74,
    "name": "OTIENO DENIS OKOTH",
    "id": 36585128,
    "region": "MERU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -CHURCH MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 75,
    "name": "NYAGA MATEO NJERU",
    "id": 21333774,
    "region": "MERU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -CHURCH MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 76,
    "name": "MUTUGI HILLARY",
    "id": 34749007,
    "region": "MERU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -CHURCH MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 77,
    "name": "LAALU GEOFFREY",
    "id": 2461308,
    "region": "MERU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -CHURCH MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 78,
    "name": "THIAINE LIBURU JULIUS",
    "id": 11487006,
    "region": "MERU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -CHURCH MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 79,
    "name": "KATHAMBI JOY",
    "id": 24922458,
    "region": "MERU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -CHURCH MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 80,
    "name": "HENRY MALINGU",
    "id": 32632690,
    "region": "NAKURU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -CHURCH NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 81,
    "name": "CHELUGO CHESEREK MICAH",
    "id": 35787758,
    "region": "NAKURU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -CHURCH NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 82,
    "name": "OSAIR GEOFFREY",
    "id": 7345,
    "region": "NAKURU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -CHURCH NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 83,
    "name": "KALUKI GRACE MUSYOKI",
    "id": 31275261,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -ELDORET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 84,
    "name": "OJUKA BRIAN OMONDI",
    "id": 35062392,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -ELDORET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 85,
    "name": "NG'ENO CHARLES KIPLANGAT",
    "id": 36621771,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -ELDORET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 86,
    "name": "BARNGOROR MOSES",
    "id": 30014745,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -ELDORET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 87,
    "name": "OCHIENG STEPHEN OGWADE",
    "id": 22321261,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -ELDORET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 88,
    "name": "GODANA WARIO GODANA GALGALO",
    "id": 213811,
    "region": "MARSABIT",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -GUEST HSE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 89,
    "name": "JALDESA MALISE GALGALO",
    "id": 22979005,
    "region": "MARSABIT",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -GUEST HSE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 90,
    "name": "QANCHORO WATO GUYO",
    "id": 37494386,
    "region": "MARSABIT",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -GUROROGESIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 91,
    "name": "KORIR ABRAHAM",
    "id": 33513210,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -KAPSABET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 92,
    "name": "EMARE JARED IJAKAA",
    "id": 30056638,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -KAPSABET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 93,
    "name": "TUWEI ROBERT CHERUIYOT",
    "id": 24383493,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -KAPSABET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 94,
    "name": "LEKERTE LETUWA",
    "id": 26673569,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -KARGI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 95,
    "name": "LESANJIR STEPHENE LOKIRU",
    "id": 37660613,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -LOYANGALANI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 96,
    "name": "JARSO MOSES MOLU",
    "id": 24994652,
    "region": "MARSABIT",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -MAT ARBA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 97,
    "name": "EMMANUEL SEREM",
    "id": 33188153,
    "region": "NAKURU",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 98,
    "name": "ESIMBALTOR JAMES BICHOWLO",
    "id": 30617693,
    "region": "WESTERN",
    "assign": "CHRIST IS THE ANSWER MINISTRIES (CITAM) -OLTUROUT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 99,
    "name": "CIERA JOEL KIMARU",
    "id": 30170198,
    "region": "MERU",
    "assign": "CHUGU BOYS HIGH SCHOOL -MUNITHU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 100,
    "name": "MITHIKA MORRIS",
    "id": 21371653,
    "region": "MERU",
    "assign": "CHUGU BOYS HIGH SCHOOL -MUNITHU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 101,
    "name": "MCHAMI CHARLES KAMATHI",
    "id": 14415806,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY -DRIVER",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 102,
    "name": "GITARI MUTEMBEI ANTONY GITARI",
    "id": 33252383,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY -KENNELS D_H",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 103,
    "name": "MWENDA KIMATHI MICHAEL",
    "id": 21514599,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY -KENNELS D_H",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 104,
    "name": "BURINJI PATRICK GITONGA",
    "id": 2531570,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 105,
    "name": "WANJA AGNES",
    "id": 31183165,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 106,
    "name": "NTWIGA ALEX FORAM",
    "id": 21065133,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 107,
    "name": "IRERI KATHAMBI ANN",
    "id": 29535108,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 108,
    "name": "KARANI ANTONY",
    "id": 13872903,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 109,
    "name": "RUGENDO ANTONY MURITHI",
    "id": 27930866,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 110,
    "name": "MUNENE BRIAN",
    "id": 35045774,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 111,
    "name": "MWANGANGI DAVID",
    "id": 35806827,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 112,
    "name": "GITONGA DAVID MUGENDI",
    "id": 33980218,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 113,
    "name": "MWEBIA LINUS MWEBIA",
    "id": 30259779,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 114,
    "name": "KIRIMI DENIS MBUBA",
    "id": 23641495,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 115,
    "name": "RUGENDO DIANA MWENDE",
    "id": 37117180,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 116,
    "name": "MWENDE DOREEN",
    "id": 2837709,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 117,
    "name": "KAWIRA DOREEN",
    "id": 7345,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 118,
    "name": "MURIUKI EDWIN",
    "id": 28751419,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 119,
    "name": "ELIPHAS NYAGA",
    "id": 8699757,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 120,
    "name": "MBAE ERIC MAWIRA",
    "id": 36211991,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 121,
    "name": "KIMATHI ERIC",
    "id": 22119064,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 122,
    "name": "ERICK NYANGAU",
    "id": 35765754,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 123,
    "name": "NJOGU ESTHER WAMBUI",
    "id": 30021126,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 124,
    "name": "NDERITU FRANCIS NJERI",
    "id": 35984835,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 125,
    "name": "KINYUA FRANKLINE",
    "id": 13870675,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 126,
    "name": "KIMATHI FRANKLINE MUCHIRI",
    "id": 13619352,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 127,
    "name": "GIKUNDI FRANKLINE NJERU",
    "id": 27158164,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 128,
    "name": "NYAGA FREDRICK GITONGA",
    "id": 13870577,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 129,
    "name": "MUGO FREDRICK MUKUBWA",
    "id": 4324349,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 130,
    "name": "MIRITI GEORGE KIRIMI",
    "id": 29864697,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 131,
    "name": "NDIGA GILBERT",
    "id": 4468002,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 132,
    "name": "KABURUNGA JAMES",
    "id": 34772945,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 133,
    "name": "NDONYE JAMES",
    "id": 36790889,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 134,
    "name": "IBRAHIM JOHN",
    "id": 2382700,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 135,
    "name": "NDERI JOHN MURITHI",
    "id": 33258138,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 136,
    "name": "MUTEGI JOHN MWANIKI",
    "id": 7345,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 137,
    "name": "GITONGA JOSEPH GEOFFREY",
    "id": 7458366,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 138,
    "name": "MWANZIA JOSEPH MWENDWA",
    "id": 36229956,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 139,
    "name": "WAMBUGU JOSEPH NJERI",
    "id": "",
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 140,
    "name": "MBAKA JUDITH GACHERI",
    "id": 21925345,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 141,
    "name": "GITARI MUTURI JUSTIN",
    "id": 24747854,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 142,
    "name": "MAWIRA KELVIN",
    "id": 36987449,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 143,
    "name": "MURANGIRI KENNETH",
    "id": 34843121,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 144,
    "name": "JOSHUA KITHUKA",
    "id": 34469683,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 145,
    "name": "MUTHOMI LAMSON",
    "id": 21357197,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 146,
    "name": "MWITI MARTIN",
    "id": 34289077,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 147,
    "name": "KANINI MILICENT",
    "id": 20742435,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 148,
    "name": "FREDRICK MWENDA HUMPREY",
    "id": 28990627,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 149,
    "name": "NKONGE NEWTON",
    "id": 27755179,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 150,
    "name": "ABUYA NICKSON MOINDE",
    "id": 28003245,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 151,
    "name": "AKOTH OLUOCH MAUREEN",
    "id": 30315179,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 152,
    "name": "EDWARD OMWERI KELVIN",
    "id": 21611991,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 153,
    "name": "SIMBA ZACHARY PATRICK",
    "id": 33665275,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 154,
    "name": "NJAGI PIUS NDARO",
    "id": 21406002,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 155,
    "name": "AWUOR RODAH HARRYATE",
    "id": 30593767,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 156,
    "name": "NTWIGA SALESIO",
    "id": 7345,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 157,
    "name": "MUTHONI SANCILACIA",
    "id": 28811799,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 158,
    "name": "MAWIRA SOLOMON",
    "id": 27828416,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 159,
    "name": "GITONGA VICTOR KINYUA",
    "id": 22528616,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 160,
    "name": "KIPRONO WILFRED",
    "id": 35798459,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 161,
    "name": "KABUNGE SEBASTIAN",
    "id": 4225602,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 162,
    "name": "MURITHI JAMES KANGA",
    "id": 12735556,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 163,
    "name": "GAKII DOREEN",
    "id": 27457075,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 164,
    "name": "MWOBORIA DOREEN KAWIRA",
    "id": "",
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 165,
    "name": "KIPKEMEI ZABLON",
    "id": 34854405,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 166,
    "name": "KARIMI DIPPORAH MICHENI",
    "id": 29757044,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 167,
    "name": "GITONGA ALBERT KEA",
    "id": 5087028,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 168,
    "name": "NDEGWA JACKSON WAWERU",
    "id": "",
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 169,
    "name": "MUKAMI FRANCIS NGANGA",
    "id": 33403261,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 170,
    "name": "KOECH TITUS KIPROTICH",
    "id": "",
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 171,
    "name": "NGURWE DENNIS KIRIMI",
    "id": 25433100,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 172,
    "name": "KIANIA TIMOTHY MUCEMBI",
    "id": 22534383,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 173,
    "name": "MUTHOMI LAWRENCE",
    "id": 35017948,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 174,
    "name": "NJAGI MERCY KARIMI",
    "id": 27988892,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 175,
    "name": "GITONGA ANN KAWIRA",
    "id": 33552427,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 176,
    "name": "KITHOME CHRISTINE GACHERI",
    "id": 28570200,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 177,
    "name": "MBAE DOREEN WANJA",
    "id": 33817385,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 178,
    "name": "JULIUS FLORENCE GAKII",
    "id": 10970775,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 179,
    "name": "MBURA FLORA KATHAMBI",
    "id": 33251072,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 180,
    "name": "MWENDA IAN MIRITI",
    "id": 29809470,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 181,
    "name": "KITHIUBI MARTIN KIMATHI",
    "id": 33168626,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 182,
    "name": "MURIUNGI GEOFFREY",
    "id": 37118825,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 183,
    "name": "NKONGE IRENE KAWIRA",
    "id": 29396297,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 184,
    "name": "GATAKAA ESTER NJAGI",
    "id": 20017426,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 185,
    "name": "NJAGI ANN MUTHONI",
    "id": 30066202,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 186,
    "name": "NJAGI SUSAN KATHOMI",
    "id": 25922668,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 187,
    "name": "NJAGI JOSEPH GITONGA",
    "id": 9354615,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 188,
    "name": "KABURU CAROLINE KAGWIRIA",
    "id": 37819925,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 189,
    "name": "MUGAMBI DOREEN ITHINA",
    "id": 26336829,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 190,
    "name": "MIRIKO DOREEN",
    "id": 28329824,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 191,
    "name": "ANN MARY WAIRIMU",
    "id": 36690128,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 192,
    "name": "KINYUA JASPER KINYUA",
    "id": 11607526,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 193,
    "name": "KAGENI LENAH KAGENI",
    "id": 23159700,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 194,
    "name": "MUTHONI MEREB",
    "id": 34624569,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 195,
    "name": "RIUNGU RISPER",
    "id": 34651423,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 196,
    "name": "KARIMI NANCY KARIMI",
    "id": 21940877,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 197,
    "name": "WAVETI PURITY WEVETI",
    "id": 21214527,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 198,
    "name": "MUTUGI MORRIS MUTUGI",
    "id": 34365424,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 199,
    "name": "MURITHI PETER MURITHI",
    "id": 3253365,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 200,
    "name": "CLEMENT EMILY MUKAMI",
    "id": "",
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 201,
    "name": "THURANIRA GIBSON KATHURIMA",
    "id": "",
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 202,
    "name": "KINYUA BONFACE MURIMI",
    "id": "",
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 203,
    "name": "FAITH MUTIGA KALAYU",
    "id": 37278786,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 204,
    "name": "NDUBI PATRICK MUGENDI",
    "id": 25806136,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 205,
    "name": "BARASA MARK",
    "id": 3536600,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY -NAIROBI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 206,
    "name": "EMMANUEL WAFULA WANGILA",
    "id": 32672945,
    "region": "CHUKA",
    "assign": "CHUKA UNIVERSITY -NAIROBI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 207,
    "name": "MWENDWA PETER",
    "id": 29359582,
    "region": "CHUKA",
    "assign": "CLOVERLEAF HOME -MURATHAKARI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 208,
    "name": "MUREGA PATRICK NTABATHIA",
    "id": 31770487,
    "region": "MERU",
    "assign": "CONSULAR HOTEL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 209,
    "name": "ISOKA JUSTUS ITWANI",
    "id": 30429644,
    "region": "NAKURU",
    "assign": "COOLMONT GUEST HOUSE NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 210,
    "name": "LOKUNIAT LAWRENCE MANGILE",
    "id": 33345867,
    "region": "CHUKA",
    "assign": "COOLMONT HOTEL -KATHWANA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 211,
    "name": "ASUMIRA KELVIN MUHEREKHIZI",
    "id": 25821374,
    "region": "EMBU",
    "assign": "COUNTRY VIEW DOWN TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 212,
    "name": "SIMIYU AMOS WANJALA",
    "id": 29805506,
    "region": "MERU",
    "assign": "DIGITAL DEN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 213,
    "name": "MUTUMA HARUN KITHINJI",
    "id": 11610224,
    "region": "MERU",
    "assign": "DOMKINGS BOUTIQUE -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 214,
    "name": "KIPSANG ALEX KIPKEMOI",
    "id": 26286139,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -CHEMERON",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 215,
    "name": "HASTINE CHEBURET KIPROP",
    "id": 3248979,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -CHEMERON",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 216,
    "name": "CHEPTOO CHEPCHIENG DOMINIC",
    "id": 27833277,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -CHEMERON",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 217,
    "name": "CHEROGONY KIPROP VICTOR",
    "id": 28030266,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -CHEMERON",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 218,
    "name": "RICHARD OMWENGA MARIENA",
    "id": 12898676,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -CHEMERON",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 219,
    "name": "NYAKUNDI CHARLES",
    "id": 37658391,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -CHEMERON",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 220,
    "name": "KOMEN ROONEX SERUGON",
    "id": 29110170,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -CHEMERON",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 221,
    "name": "CHEMJOR CHEPSENGOL JACOB",
    "id": 33017089,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -KENYATTA CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 222,
    "name": "MWENDA FREDRICK",
    "id": 31147936,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -KENYATTA CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 223,
    "name": "KARANJA JAMES KARANJA",
    "id": 23870336,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 224,
    "name": "ONDIEK TOBIAS ODIRA",
    "id": 10312492,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 225,
    "name": "MUTURA PAUL NJUGUNA",
    "id": 31881858,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 226,
    "name": "OMAI STEFANO",
    "id": 35332556,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 227,
    "name": "CHEMATIA PHELISTEAS CHEMATIA",
    "id": 22761582,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 228,
    "name": "NYARONDIA ISAAK NDAMA",
    "id": 31333452,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 229,
    "name": "KABEE DORCAS",
    "id": 22081949,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 230,
    "name": "CHEPCHIENG ISAIAH KOMEN",
    "id": 20676782,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 231,
    "name": "CHERUIYOT ABRAHAM KIPTOO",
    "id": 39183758,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 232,
    "name": "NG'ENO ALLAN KIPCHIRCHIR",
    "id": 38895173,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 233,
    "name": "NG'ETICH PETER KIPKEMOI",
    "id": "",
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 234,
    "name": "CHIRCHIR KEVIN KIBET",
    "id": "",
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 235,
    "name": "PHILLIP KEITANY KIPROP",
    "id": 13522583,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 236,
    "name": "JOSEPH BARASA SIMIYU",
    "id": 29444355,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 237,
    "name": "SAITOTI STEPHEN LAIPA SAITOTI",
    "id": "",
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 238,
    "name": "AMIRA BEVERLYNE LUVANDWA",
    "id": 33737182,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 239,
    "name": "ARNOLD KIBET",
    "id": 32047235,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 240,
    "name": "SARAH NYAMBURA",
    "id": 14497893,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 241,
    "name": "RICHARD NYAPARA BASWETI",
    "id": 21043523,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 242,
    "name": "KELVIN ARUNYE",
    "id": 34994783,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 243,
    "name": "BOSIBEN KIBET ISHMAEL",
    "id": 34744865,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 244,
    "name": "GEORGE KOECH",
    "id": 30391142,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 245,
    "name": "PROTUS OMWERI NYAKWARA",
    "id": 23075607,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 246,
    "name": "LYDIAH SAGWE KWAMBOKA",
    "id": 28838333,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 247,
    "name": "CHARLES KINYUA NJAGI",
    "id": 23713016,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 248,
    "name": "ALI ABDI HASSAN",
    "id": 20305501,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 249,
    "name": "ZEYNAB ABDUBA KANCHARA",
    "id": 31851139,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 250,
    "name": "MARIA ADAPAL LOCHOK",
    "id": 31395543,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 251,
    "name": "LILIAN ADHIAMBO MEYOH",
    "id": 31824678,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 252,
    "name": "BRENDA AVIGINGA OGAI",
    "id": 37036200,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 253,
    "name": "ISAAC BETT",
    "id": 22904753,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 254,
    "name": "DAVID BETT KIPKURUI",
    "id": 28550179,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 255,
    "name": "CHEBOI LILIAN",
    "id": 30282340,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 256,
    "name": "EUCABETH CHELENGAT KETER",
    "id": 33259764,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 257,
    "name": "ISAIAH CHEMINGING NYONGESA",
    "id": 36075489,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 258,
    "name": "PAMELA CHEMUTAI",
    "id": 22798857,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 259,
    "name": "NANCY CHEPCHIR",
    "id": 30097484,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 260,
    "name": "CHEPKOECH MONICA",
    "id": 28067631,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 261,
    "name": "INGASO CONSOLATA",
    "id": 21248476,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 262,
    "name": "MUNIU ELIJAH MWANGI",
    "id": 20555749,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 263,
    "name": "GWARD SHADRACK NYAGWARA",
    "id": 12504792,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 264,
    "name": "KISIERO JONATHAN MUCHAI",
    "id": 21669177,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 265,
    "name": "LILIAN KAVOCHI MUSALE",
    "id": 21259198,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 266,
    "name": "CHEPKWONY KIBET BENARD",
    "id": 26640434,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 267,
    "name": "BERNARD KIMETO",
    "id": 31877845,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 268,
    "name": "BOIT KIPCHUMBA KENNEDY",
    "id": 31264387,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 269,
    "name": "FELIX KIPKEMBOI TARUS",
    "id": 37623132,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 270,
    "name": "GEOFFREY KIPKOECH ROTICH",
    "id": 28617541,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 271,
    "name": "LEONARD KIPKOECH SALAT",
    "id": 26478062,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 272,
    "name": "CHELELGO KIPKOIKOI RICHARD",
    "id": 28047887,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 273,
    "name": "NELSON KIPKORIR KOROS",
    "id": 36729688,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 274,
    "name": "WILLY KIPKORIR",
    "id": 36425254,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 275,
    "name": "SAMUEL KIPLANGAT KITUR",
    "id": 12800636,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 276,
    "name": "JOSPHAT KIPROTICH SITIENEI",
    "id": 28982342,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 277,
    "name": "WESLEY KIPSANG",
    "id": 35392352,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 278,
    "name": "CHEPKWONY KIPTONUI PAUL",
    "id": 7961735,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 279,
    "name": "JOSEPHAT KIRUI",
    "id": 27149694,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 280,
    "name": "KIPKIRUI KOECH",
    "id": 21188731,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 281,
    "name": "DAVID KORIR",
    "id": 10544196,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 282,
    "name": "LENOOKE LCHUMA",
    "id": 29723092,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 283,
    "name": "CHEPKURUI LILIAN",
    "id": 22123519,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 284,
    "name": "JOHNSTONE LIMO KIGEN",
    "id": 26261873,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 285,
    "name": "ALEX MACHUKA",
    "id": 32222943,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 286,
    "name": "KANUT MHABINI WAMBANI",
    "id": 11835364,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 287,
    "name": "AGNES MORAA OMBACHI",
    "id": 13325358,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 288,
    "name": "PETER MUCHIRI",
    "id": 9836863,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 289,
    "name": "ANN MUGURE",
    "id": 26921547,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 290,
    "name": "FRANCIS MUTUA MAWEU",
    "id": 26552980,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 291,
    "name": "FREDRICK MUTUNGA",
    "id": 20735100,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 292,
    "name": "CHARLES NANDI",
    "id": 21673306,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 293,
    "name": "DORPHINE NASAMBU MAKOKHA",
    "id": 24329490,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 294,
    "name": "JOSEPH NDABARU",
    "id": 21181884,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 295,
    "name": "CHRISTOPHER NDEGE",
    "id": 21648002,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 296,
    "name": "MARY NELIMA WAFULA",
    "id": 35020241,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 297,
    "name": "HARUN NYAMBANE MOGAKA",
    "id": 36756868,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 298,
    "name": "GECHICHI OMWENGA CLIFFORD",
    "id": 28452956,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 299,
    "name": "EDWIN OMWERI MACHANI",
    "id": 24663152,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 300,
    "name": "DORCAS OSINO",
    "id": 31908774,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 301,
    "name": "GATHONI SARAH",
    "id": 28920953,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 302,
    "name": "DANIEL SEME",
    "id": 13568914,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 303,
    "name": "SAMUEL TANUI KIPROP",
    "id": 20487116,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 304,
    "name": "HARRISON THUKU NYOIKE",
    "id": 31277689,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 305,
    "name": "ERICK TOWETT",
    "id": 23407810,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 306,
    "name": "HELLEN WAMBUI WANJIKU",
    "id": 30187505,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 307,
    "name": "HARRISON WAMUTU NJUGUNA",
    "id": 22158921,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 308,
    "name": "ESTHER WAMUYU MUTHUKIA",
    "id": 14412853,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 309,
    "name": "ELVIS MUTAI",
    "id": 27458007,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 310,
    "name": "CATHERINE JOHN",
    "id": 23657639,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 311,
    "name": "EWOI SAMUEL",
    "id": 24501290,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 312,
    "name": "ONTITA KEVIN GASAMI",
    "id": 33016734,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 313,
    "name": "NYAKUNDI JOSPHAT",
    "id": 32782466,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 314,
    "name": "MAINA JOSEPH NJENGA",
    "id": 27965972,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 315,
    "name": "YEGON BENARD",
    "id": 23453075,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 316,
    "name": "CHEMIAT NEWTON",
    "id": 31080770,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 317,
    "name": "KIPRUTO JANE CHEPKORIR",
    "id": 24785656,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 318,
    "name": "IRUNGU KEVIN WANJOHI",
    "id": 35183208,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 319,
    "name": "GAKUMBA ROBERT NDEGWA",
    "id": 13440818,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 320,
    "name": "OGATO DANIEL MOGAKA",
    "id": 36103170,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 321,
    "name": "EKASIBA CRESENT OYULO",
    "id": 9955713,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 322,
    "name": "KIPKURUI RUTTO KIMSON",
    "id": 37669641,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 323,
    "name": "KAKUNDI EVANS MUTUA",
    "id": 35969562,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 324,
    "name": "MASI KELVIN",
    "id": 33362519,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 325,
    "name": "NGENO LILY CHELANGAT",
    "id": 28367997,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 326,
    "name": "KIPTOO ERIC",
    "id": 32353661,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 327,
    "name": "OROGO JEPHTAH GITHANA",
    "id": 35875522,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 328,
    "name": "MULONGO ELIAKIM WASIKE",
    "id": 37061327,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 329,
    "name": "KIPTUM MATTHEW",
    "id": 35842781,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 330,
    "name": "KIPKEMOI KENNETH",
    "id": 34800207,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 331,
    "name": "OCHIENG AGGREY ODHIAMBO",
    "id": 20519217,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 332,
    "name": "MATETE MARION NANJALA",
    "id": 30489560,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 333,
    "name": "SANDE FILIPU ASIKOLI",
    "id": 28800305,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 334,
    "name": "LOSWETI EDIWIN SHIGANGA",
    "id": 32262199,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 335,
    "name": "WANGILA EDWARD WABOMBA",
    "id": 3937361,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 336,
    "name": "OKUMU NELSON ODUOR",
    "id": 12684883,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 337,
    "name": "CHEPNGETICH PURITY",
    "id": 33565070,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 338,
    "name": "JOSEPH MANGERA MOMANYI",
    "id": 24356794,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 339,
    "name": "BENARD OTIENO NYAKUNDI",
    "id": 20473564,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 340,
    "name": "MAKANA JARED MAKORI",
    "id": 24830431,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 341,
    "name": "ABEY ERRI MARTHA",
    "id": 27036813,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 342,
    "name": "ANGWENYE ANGWENYI DOMINIC",
    "id": 28494648,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 343,
    "name": "VIOLA CHEPKEMOI LANGAT",
    "id": 35361487,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 344,
    "name": "JOHN CHERUIYOT",
    "id": 11430710,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 345,
    "name": "CHERUIYOT VINCENT",
    "id": 31929065,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 346,
    "name": "CHEPWOGEN JOYCE",
    "id": 26416751,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 347,
    "name": "CHELANGAT KANDAGOR JUSTIN",
    "id": 13062857,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 348,
    "name": "ONDERI KERUBO VENNY",
    "id": 31539878,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 349,
    "name": "DENNIS KIPKEMOI TERER",
    "id": 33318987,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 350,
    "name": "JARED MATARA OMWANGE",
    "id": 23178570,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 351,
    "name": "FELISTER MIKISEI SOTI",
    "id": 26325387,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 352,
    "name": "ERICK MOGITA OMBAYE",
    "id": 37815403,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 353,
    "name": "JOHN NDEGWA WANJOHI",
    "id": 29548641,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 354,
    "name": "CAROLINE NGESA",
    "id": 31734062,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 355,
    "name": "CHARLES NYAMBATI NYATWANGA",
    "id": 26986675,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 356,
    "name": "VINCENT ODHIAMBO OBANDA",
    "id": 27729876,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 357,
    "name": "RONALD OKACHI",
    "id": 21567746,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 358,
    "name": "SAMUEL OMORE NDOLO",
    "id": 12516873,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 359,
    "name": "OGATI OMWANDO",
    "id": 9699815,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 360,
    "name": "EVANS OTISO NYAMBOGA",
    "id": 11492870,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 361,
    "name": "MUCHESI GEORGE HABAKUK OWEYO",
    "id": 20311482,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 362,
    "name": "LEONARD RONO KIPKORIR",
    "id": 30861612,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 363,
    "name": "BEATRICE NYABOKE MOUKO",
    "id": 21822308,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 364,
    "name": "MAROA DANIEL",
    "id": 37981946,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 365,
    "name": "NYAKUNDI DUKE OMARA",
    "id": 25084686,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 366,
    "name": "OROGA ISAAC KINSLAY",
    "id": 5847061,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 367,
    "name": "OYARO BRIANI OYUGI",
    "id": 32257283,
    "region": "NAKURU",
    "assign": "EGERTON UNIVERSITY -TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 368,
    "name": "GIKIME FRANCIS LUFAS KIOGORA",
    "id": 24076227,
    "region": "NANYUKI",
    "assign": "ELOBY INVESTMENT-EQUATOR",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 369,
    "name": "MUCHOKI JAPHETH",
    "id": "",
    "region": "EMBU",
    "assign": "EMBU SLOPES HOTEL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 370,
    "name": "GITARI PETERSON KIMATHI",
    "id": 37230648,
    "region": "EMBU",
    "assign": "EMBU SLOPES HOTEL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 371,
    "name": "MOGIRE WILFRED MOREBU",
    "id": 36193657,
    "region": "MERU",
    "assign": "EVERO REALTORS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 372,
    "name": "ANAMPIU HARIZON KITHINJI",
    "id": 11608210,
    "region": "MERU",
    "assign": "EXECUTIVE FUNERAL SERVICES -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 373,
    "name": "ELIKIN TEMBA OMIA",
    "id": 33979274,
    "region": "NAIROBI",
    "assign": "FAVOUR MEDICAL CENTRE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 374,
    "name": "KIMOTHO MAGDALINE WANGECI",
    "id": 29403881,
    "region": "NAIROBI",
    "assign": "FAVOUR MEDICAL CENTRE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 375,
    "name": "KOOME LAWRENCE",
    "id": 37153864,
    "region": "NAIROBI",
    "assign": "FAVOUR MEDICAL CENTRE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 376,
    "name": "EDIKA NYONGESA",
    "id": 37805057,
    "region": "NAIROBI",
    "assign": "FAVOUR MEDICAL CENTRE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 377,
    "name": "KINYUA PAUL MUTEMBEI",
    "id": 35583368,
    "region": "MERU",
    "assign": "FORESTVIEW",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 378,
    "name": "NJAGI DOUGLAS MATI",
    "id": 33668265,
    "region": "MERU",
    "assign": "FORESTVIEW",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 379,
    "name": "KAGENDO LILIAN",
    "id": 35764762,
    "region": "MERU",
    "assign": "FORESTVIEW",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 380,
    "name": "AMWIRA MARTIN KATHEWA",
    "id": 22594108,
    "region": "MERU",
    "assign": "FORESTVIEW",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 381,
    "name": "MUKURA LUCAS KINYUA",
    "id": 21799839,
    "region": "MERU",
    "assign": "FORESTVIEW",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 382,
    "name": "KINYUA JOHN KIMATHI",
    "id": 35425318,
    "region": "MERU",
    "assign": "FORESTVIEW",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 383,
    "name": "MBAKA MWENDWA DENNIS",
    "id": 29743137,
    "region": "MERU",
    "assign": "FORESTVIEW",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 384,
    "name": "WACHIRA HASSAN",
    "id": 36014505,
    "region": "CHUKA",
    "assign": "FRASIA HOSTELS -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 385,
    "name": "MUKUNDI KELVIN MUCHUI",
    "id": 33247861,
    "region": "MERU",
    "assign": "G. K. HARDWARE -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 386,
    "name": "MWIKAMBA PETERSON MUTHOMI",
    "id": 22651014,
    "region": "MERU",
    "assign": "GATIMENE GARDENS -ANNEX KAAGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 387,
    "name": "WANJOHI CHARLES KIMONDO",
    "id": 3379694,
    "region": "NYANDARUA",
    "assign": "GATIMU GIRLS SECONDARY SCHOOL -NYANDARUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 388,
    "name": "MAGERETE GEORGE KERANDI",
    "id": 26010171,
    "region": "NYANDARUA",
    "assign": "GATIMU GIRLS SECONDARY SCHOOL -NYANDARUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 389,
    "name": "ONKOBA THOMAS KEBUNGO",
    "id": "",
    "region": "NYANDARUA",
    "assign": "GATIMU GIRLS SECONDARY SCHOOL -NYANDARUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 390,
    "name": "KIRIMI DERRICK MACHARIA",
    "id": 36641109,
    "region": "MERU",
    "assign": "GENESIS INVESTMENTS -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 391,
    "name": "GITIGI FAITH MAKENA",
    "id": 30921508,
    "region": "MERU",
    "assign": "GENESIS INVESTMENTS -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 392,
    "name": "GITUMA BRIAN KIMATHI",
    "id": 38519636,
    "region": "MERU",
    "assign": "GIKUMENE GIRLS HIGH SCHOOL -GIKUMENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 393,
    "name": "MUTAI PATRICK KIPCHIRCHIR",
    "id": 37461492,
    "region": "MERU",
    "assign": "GIKUMENE GIRLS HIGH SCHOOL -GIKUMENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 394,
    "name": "RUNGUMA BENJAMIN GICHARI",
    "id": 7740811,
    "region": "MERU",
    "assign": "GIKUMENE GIRLS HIGH SCHOOL -GIKUMENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 395,
    "name": "ABONGO BENINE ADOYO",
    "id": 6684643,
    "region": "MERU",
    "assign": "GIKUMENE GIRLS HIGH SCHOOL -GIKUMENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 396,
    "name": "MICHENI CHRISTINE KARUTANI",
    "id": 28662687,
    "region": "MERU",
    "assign": "GIKUMENE GIRLS HIGH SCHOOL -GIKUMENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 397,
    "name": "OBINO SIMON NYAMBOGA",
    "id": 5813988,
    "region": "NAKURU",
    "assign": "GITHIMA WELFARE STALLS AND SHOPS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 398,
    "name": "NJERU JONATHAN MUTHUI",
    "id": 37678445,
    "region": "MERU",
    "assign": "GLOBAL COMPANY LTD",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 399,
    "name": "MWONGERA JOHN",
    "id": 26445739,
    "region": "MERU",
    "assign": "GLOBAL COMPANY LTD",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 400,
    "name": "MUNENE DENIS MUKARIA",
    "id": 29765052,
    "region": "DAIRY",
    "assign": "GOLDEN BAKERIES -DAIRY ROAD MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 401,
    "name": "NYAOGA PETER",
    "id": 12898587,
    "region": "NAKURU",
    "assign": "GOSPEL OUTREACH CHURCH -NJORO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 402,
    "name": "KABURU ELIC MUGENDI",
    "id": "",
    "region": "MERU",
    "assign": "GULF ENERGY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 403,
    "name": "MWITI KENNETH MUTWIRI",
    "id": 36940312,
    "region": "CHUKA",
    "assign": "HIGHMARK TRADING COMPANY -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 404,
    "name": "WORRIS MWONGERA MWENDA",
    "id": 20406210,
    "region": "MERU",
    "assign": "HQ-DRIVER",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 405,
    "name": "IMUNYA DOUGLAS KIRIMI",
    "id": 26408138,
    "region": "MERU",
    "assign": "IMETHA WATER AND SANITATION CO. LTD -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 406,
    "name": "MWITI JAPHET MAILU",
    "id": 20701304,
    "region": "MERU",
    "assign": "IMETHA WATER AND SANITATION CO. LTD -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 407,
    "name": "JUMA SHARIFF HASSAN",
    "id": 35757984,
    "region": "ISIOLO",
    "assign": "ISIOLO INCHARGE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 408,
    "name": "MUGWIKA GIDEON MUTUGI",
    "id": "",
    "region": "ISIOLO",
    "assign": "ISIOLO OLA PETROL STATION",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 409,
    "name": "TAKWA STEPHEN EKUNYUK",
    "id": 23873171,
    "region": "ISIOLO",
    "assign": "ISIOLO STADIUM -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 410,
    "name": "DIDO ABDI KUNO",
    "id": "",
    "region": "ISIOLO",
    "assign": "ISIOLO STADIUM -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 411,
    "name": "REUBEN KINYUA",
    "id": 25876093,
    "region": "ISIOLO",
    "assign": "ISIOLO STADIUM -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 412,
    "name": "KABIRO NICHOLAS MUTETHIA",
    "id": 33897019,
    "region": "NAKURU",
    "assign": "JACKLINE GAKII/PETER MUREGA KAARIA -MILIMANI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 413,
    "name": "MWABU JAMES KIRIMI",
    "id": 21947255,
    "region": "MERU",
    "assign": "JAKIM CONTRACTORS LTD -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 414,
    "name": "ROTICH PHILEMON",
    "id": "",
    "region": "MERU",
    "assign": "JORDAN HOSPITAL KABAKIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 415,
    "name": "KETER RANGERS",
    "id": 35970304,
    "region": "MERU",
    "assign": "JORDAN HOSPITAL KABAKIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 416,
    "name": "MUTHAURA MORRIS MUNYUA",
    "id": 36428836,
    "region": "MERU",
    "assign": "KABSTAN FARM LIMITED -KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 417,
    "name": "KABERIA GEOFFREY KIRIANKI",
    "id": 23499254,
    "region": "MERU",
    "assign": "KABSTAN FARM LIMITED -KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 418,
    "name": "MWENDA KELVIN",
    "id": 34843660,
    "region": "MERU",
    "assign": "KABSTAN FARM LIMITED -KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 419,
    "name": "REUBEN MUGAMBI KITHURE",
    "id": 36869268,
    "region": "MERU",
    "assign": "KABSTAN FARM LIMITED -KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 420,
    "name": "MWENDA PHINEAS",
    "id": 34405228,
    "region": "MERU",
    "assign": "KAGUMA UPLINE -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 421,
    "name": "KAINGA JACOB",
    "id": 9704630,
    "region": "MERU",
    "assign": "KAINGA SHOP NCHIRU -NCHIRU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 422,
    "name": "KINYUA PETER MUGAO",
    "id": 34809708,
    "region": "LAARE/MAUA",
    "assign": "KATHANGA SEC SCH -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 423,
    "name": "KAIRENYA SAMSON GITONGA",
    "id": "",
    "region": "LAARE/MAUA",
    "assign": "KATHANGA SEC SCH -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 424,
    "name": "MPAKA PAUL KIMATHI",
    "id": 21434976,
    "region": "MERU",
    "assign": "KATHENDU DAIRY (FESKA FARM) -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 425,
    "name": "MUKHONJI WILFRED MUTONYI",
    "id": "",
    "region": "MERU",
    "assign": "KAUNGA HS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 426,
    "name": "OBINO WILFRED NYADIRI",
    "id": 24058931,
    "region": "NAIROBI",
    "assign": "KAVIRANIA VENTURES SHELL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 427,
    "name": "KHAYUMBI FRANKLINE",
    "id": "",
    "region": "NAIROBI",
    "assign": "KAVIRANIA VENTURES SHELL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 428,
    "name": "NDIWA KELVIN KWEMOI",
    "id": "",
    "region": "NAIROBI",
    "assign": "KAVIRANIA VENTURES SHELL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 429,
    "name": "KIMANI SAMUEL",
    "id": "",
    "region": "NAIROBI",
    "assign": "KAVIRANIA VENTURES SHELL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 430,
    "name": "LESEMANYON MIKE IPAA",
    "id": 32613839,
    "region": "NAIROBI",
    "assign": "KAVIRANIA VENTURES SHELL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 431,
    "name": "KAMUNDI PETERSON",
    "id": 9355255,
    "region": "CHUKA",
    "assign": "KEN COM -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 432,
    "name": "KOOME SILAS NGORE",
    "id": 24407540,
    "region": "MERU",
    "assign": "KENICOM ENERGY/OIL LYBIA -GITIMBINE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 433,
    "name": "ABDI HAMZA HASSAN",
    "id": 26074484,
    "region": "ISIOLO",
    "assign": "KENYA RED CROSS SOCIETY -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 434,
    "name": "EPIOT THOMAS",
    "id": 36584924,
    "region": "ISIOLO",
    "assign": "KENYA RED CROSS SOCIETY -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 435,
    "name": "HELLEN KARAI",
    "id": 38017881,
    "region": "ISIOLO",
    "assign": "KENYA RED CROSS SOCIETY -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 436,
    "name": "MARINGO NICHOLAS MULWA",
    "id": 13641601,
    "region": "EMBU",
    "assign": "KHIFAM LTD",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 437,
    "name": "OCHIENG FRED OTIENO",
    "id": 35860894,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 438,
    "name": "ONGWELO CHARLES OLUOCH",
    "id": 20007305,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 439,
    "name": "WANYONYI ELPHAS JUMA",
    "id": 22253268,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 440,
    "name": "NANGILA CATHERINE CHENJE",
    "id": 14725391,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 441,
    "name": "MASUMALI BENJAMIN KUNDU",
    "id": 13159902,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 442,
    "name": "WAMALWA JUSTUS WASIKOTE",
    "id": 8415268,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 443,
    "name": "WANGALA BERNARD WERE",
    "id": 22384702,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 444,
    "name": "KUNDU DAVID MANYONGE",
    "id": 28370555,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 445,
    "name": "MULWALE GILBERT SIMIYU",
    "id": 11328381,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 446,
    "name": "MUCHANGA SOSTINE JUMA",
    "id": 11561842,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 447,
    "name": "FRANCIS STEPHEN BARASA",
    "id": 28828813,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 448,
    "name": "WANJALA WILFRED WABWILE",
    "id": 32446178,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 449,
    "name": "MATACHI MOSES NYONGESA",
    "id": 9682580,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 450,
    "name": "LUSUI KELVIN NAMASWA",
    "id": 32293523,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 451,
    "name": "MWASAME JOTHAM WASULA",
    "id": 22417209,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 452,
    "name": "MANGOLI OLIVER MAHASO",
    "id": 14659407,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 453,
    "name": "WANYAMA JOSEPHAT WAFULA",
    "id": 32483599,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 454,
    "name": "MAINA DANIEL WEKESA",
    "id": 9513523,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 455,
    "name": "WEKESA MOUREEN NALIAKA",
    "id": 30379567,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 456,
    "name": "SIMIYU NICHOLAS WANYONYI",
    "id": 26062987,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 457,
    "name": "NDIWA ABRAHAM KIBOI",
    "id": 33792461,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 458,
    "name": "OPATIA CHRISPINUS NYONGESA",
    "id": 28370223,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 459,
    "name": "SIFUNA HARUN MAFWABI",
    "id": 14542805,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 460,
    "name": "WAFULA GERALD SIMIYU",
    "id": 37316870,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 461,
    "name": "OPICHO DAVID FWAMBA",
    "id": 10037839,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 462,
    "name": "SININO LEONARD JUMA",
    "id": 23919576,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 463,
    "name": "OSECHE RISPER AGWONAH",
    "id": 32836640,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 464,
    "name": "WAFULA STEPHEN NYONGESA",
    "id": 23358949,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 465,
    "name": "MILIMO LEONARD WAFULA JUMA",
    "id": 14640173,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 466,
    "name": "WAKHUNGU ERICK WANJALA",
    "id": 14611252,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 467,
    "name": "BWAMI GEORGE NALIANYA",
    "id": 32836640,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 468,
    "name": "SILALI HENRY JUMA",
    "id": 10037265,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 469,
    "name": "SIKUKU MAYENDE",
    "id": 25392513,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 470,
    "name": "SIMIYU NASHON OYIMBA",
    "id": 23108127,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 471,
    "name": "WEKESA ANDREW NYONGESA",
    "id": 34431965,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 472,
    "name": "WALUKHANGA SYLVIA NAFULA",
    "id": 24581456,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 473,
    "name": "WANYAMA WEMSLAUS FWAMBA",
    "id": 13660434,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 474,
    "name": "WAKOLI JOSEPH NAKOYO",
    "id": 21880949,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 475,
    "name": "WABWILE HOSEA WAFULA",
    "id": 36272653,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 476,
    "name": "NYONGESA ANDREW NAMIKASA",
    "id": 33277004,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 477,
    "name": "WASIKE KENNEDY WAFULA",
    "id": 13134841,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 478,
    "name": "WASIKE ROSE NAMAEMBA",
    "id": 13315343,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 479,
    "name": "WABOMBA KEVIN LUKE",
    "id": 20667502,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 480,
    "name": "SIFUNJI FRANCIS MAKOKHA",
    "id": 11454289,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 481,
    "name": "MATEBA MERITI WAFULA",
    "id": 1040175,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 482,
    "name": "KHWAKA GEOFRICE BIKETI",
    "id": 2245472280,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 483,
    "name": "OTOGO LEONARD OTITI",
    "id": 20582677,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 484,
    "name": "MAKOKHA LEONARD NYONGESA",
    "id": 11328208,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 485,
    "name": "WAMALWA ASMIN",
    "id": 35135975,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 486,
    "name": "NAKHISA JULIUS WANYONYI",
    "id": 28291803,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 487,
    "name": "MWAKALE VINCENT MAINDI",
    "id": 35078047,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 488,
    "name": "LUNGAI FRANCIS SIKUKU",
    "id": 35490504,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 489,
    "name": "MULONGO CATHERINE WERESHA",
    "id": 4391082,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 490,
    "name": "WEKESA NOAH WAFULA",
    "id": 20989272,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 491,
    "name": "OBETEL JETHRO EMOLOTO",
    "id": 34730015,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 492,
    "name": "MAYENDE ANNAH NANJALA",
    "id": 33141482,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 493,
    "name": "NYONGESA DENNIS SIMIYU",
    "id": 28666783,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 494,
    "name": "SIATA BENSON SIFUNA",
    "id": 9993823,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 495,
    "name": "WASIKE EUNICE NAFULA",
    "id": 31202537,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 496,
    "name": "WEKESA ALEX WANJALA",
    "id": 38704926,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 497,
    "name": "WECHABE WEMBANI BETTY",
    "id": 32917807,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 498,
    "name": "MUMIA MESHACK FORD",
    "id": 30934412,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 499,
    "name": "MASIBO MARTIN WAMALWA",
    "id": 9383887,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 500,
    "name": "GEMENET EMMANUALLA CHELANGAT",
    "id": 24447084,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 501,
    "name": "WALUMBE MARTIN JUMA",
    "id": 10718048,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 502,
    "name": "NAMYAMA STELLA WANYONYI",
    "id": 26437791,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 503,
    "name": "MAINA MAURICE WANYONYI",
    "id": 10530264,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 504,
    "name": "SIMIYU JONATHAN KACHENJA",
    "id": 27983980,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 505,
    "name": "NGOSIA ISMAEL",
    "id": 37158530,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 506,
    "name": "OTSIENO JOSEPH JOHN",
    "id": 21433941,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 507,
    "name": "NYONGESA JOSEPH WANYONYI",
    "id": 9998353,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 508,
    "name": "SARA FATUMA MMASI",
    "id": 25142941,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 509,
    "name": "NEKESA JOSEPHINE MAKOKHA",
    "id": 35682364,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 510,
    "name": "WANYONYI MUSA BRAMWEL",
    "id": 20587441,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 511,
    "name": "MUKITE MARGARET IMMACULATE",
    "id": 12455776,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 512,
    "name": "NAMUBUYA GANTRIX BARASA",
    "id": 30288817,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 513,
    "name": "WANYAMA SILAYO CONSTERN",
    "id": 24504326,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 514,
    "name": "NEKESA ESTHER KHAEMBA",
    "id": 26247103,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 515,
    "name": "MASIKA JOSEPH KIBERENGE",
    "id": 14542230,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 516,
    "name": "NDIEMA AUGUSTINE NETTO",
    "id": 21677012,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 517,
    "name": "BIKETI ELIUD WANGILA",
    "id": 21883262,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 518,
    "name": "BIKETI MILDRED NAFULA",
    "id": 31934927,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 519,
    "name": "WANYONYI MARTIN MAMULI",
    "id": 9458718,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 520,
    "name": "MANDILA ERIC MULATI",
    "id": 20652704,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 521,
    "name": "WEKESA WILFRED KITUYI",
    "id": 11786962,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 522,
    "name": "WANJALA DORCAS",
    "id": 36422011,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 523,
    "name": "NALIANYA MARK WATAKA",
    "id": 7343053,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 524,
    "name": "KITUI JOSEPH WEKESA",
    "id": 21568977,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 525,
    "name": "SIAMBA COLLINS WAFULA",
    "id": 409477923,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 526,
    "name": "KHABUTO EVERLINE MALOPA",
    "id": "",
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 527,
    "name": "WAKUNINA PETER WEKESA",
    "id": 11785818,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 528,
    "name": "MIRUKA OLIVER MIUKHEBI",
    "id": 28304050,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 529,
    "name": "WAFULA ESTHER WAMBANI WAFULA",
    "id": 36941093,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 530,
    "name": "BARASA EDWIN SHIUNDU",
    "id": 22660106,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 531,
    "name": "RUTH RUTO",
    "id": 30456122,
    "region": "WESTERN",
    "assign": "KIBABII UNIVERSITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 532,
    "name": "MBAYA RODGERS MWENDA",
    "id": 33619823,
    "region": "CHUKA",
    "assign": "KIENI KIA NDEGE KK -IGOJI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 533,
    "name": "NAUTI PETER KIMATHI",
    "id": 32205299,
    "region": "NYANDARUA",
    "assign": "KINANGOP GIRLS HIGH SCHOOL -KINANGOP",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 534,
    "name": "NJOKI DEBORAH",
    "id": 36094643,
    "region": "NYANDARUA",
    "assign": "KIPIPIRI TECHNICAL AND VOCATIONAL COLLEGE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 535,
    "name": "MWANGI PETER KEMI",
    "id": 11067093,
    "region": "NYANDARUA",
    "assign": "KIPIPIRI TECHNICAL AND VOCATIONAL COLLEGE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 536,
    "name": "ONDIEKI PETER MOSE",
    "id": 6934759,
    "region": "NYANDARUA",
    "assign": "KIPIPIRI TECHNICAL AND VOCATIONAL COLLEGE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 537,
    "name": "KIMATHI EVANS MAWIRA",
    "id": 30780400,
    "region": "MERU",
    "assign": "KIRIGIA RESIDENCE -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 538,
    "name": "KIREMA JAMES MUTHEE",
    "id": 28508078,
    "region": "MERU",
    "assign": "KIRUMENE FARM",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 539,
    "name": "MUTHAMIA JOSEPH",
    "id": 36249383,
    "region": "MERU",
    "assign": "KIRUMENE FARM",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 540,
    "name": "MAWIRA SALESIO MARANGU",
    "id": 4501946,
    "region": "MERU",
    "assign": "KIRUMENE FARM",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 541,
    "name": "GITUNDU MARTIN MUKUNDI",
    "id": 33428789,
    "region": "MERU",
    "assign": "KIRUMENE FARM",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 542,
    "name": "MWAMBIA BENSON MUCEE",
    "id": 37175343,
    "region": "MERU",
    "assign": "KIRUMENE FARM",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 543,
    "name": "MWANGI JAMES KIHENJO",
    "id": 37137876,
    "region": "LAARE/MAUA",
    "assign": "KISIMA BAR -LAARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 544,
    "name": "MITI KELVIN MUTWIRI",
    "id": 33374051,
    "region": "LAARE/MAUA",
    "assign": "KITHARE DAY SEC SCHOOL -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 545,
    "name": "MWENDA MICHAEL NGAI",
    "id": 13355956,
    "region": "CHUKA",
    "assign": "KMTC CHUKA -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 546,
    "name": "MBUBA DAINA MAKENA",
    "id": "",
    "region": "CHUKA",
    "assign": "KMTC CHUKA -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 547,
    "name": "BAUNI CHARLES",
    "id": 4322265,
    "region": "CHUKA",
    "assign": "KMTC CHUKA -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 548,
    "name": "KIPKIRUI MUTAI",
    "id": 32982123,
    "region": "NANYUKI",
    "assign": "KONGONI CAMP -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 549,
    "name": "MWENDWA CAROLINE MUGAMBI",
    "id": 37239939,
    "region": "NANYUKI",
    "assign": "KONGONI CAMP -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 550,
    "name": "WAITITU SIMON NDICHU",
    "id": 22125518,
    "region": "NANYUKI",
    "assign": "KONGONI CAMP -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 551,
    "name": "NKONGE HAPPLUS",
    "id": 2463416,
    "region": "NANYUKI",
    "assign": "KONGONI CAMP -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 552,
    "name": "DANIEL MUTUGI ELIJAH",
    "id": 11399511,
    "region": "MERU",
    "assign": "KONGONI CAMP -RELIEVER",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 553,
    "name": "LEREET PIUS LESUUDA",
    "id": "",
    "region": "NYANDARUA",
    "assign": "LAIKIPIA NORTH TECHNICAL & VOCATIONAL CO. -MARALAL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 554,
    "name": "LTAAPWA LESIMALE",
    "id": 21697286,
    "region": "NYANDARUA",
    "assign": "LAIKIPIA NORTH TECHNICAL & VOCATIONAL CO. -MARALAL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 555,
    "name": "LODUNGOKIOK PARANDAE",
    "id": 27968386,
    "region": "NYANDARUA",
    "assign": "LAIKIPIA NORTH TECHNICAL & VOCATIONAL CO. -MARALAL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 556,
    "name": "JACOB KARURA STEPHEN",
    "id": 2442461,
    "region": "NANYUKI",
    "assign": "LIKII SPECIAL SCHOOL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 557,
    "name": "WANJA CAROLINE MWIRIGI",
    "id": 32869969,
    "region": "NANYUKI",
    "assign": "LIKII SPECIAL SCHOOL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 558,
    "name": "MUGATHIA RONALD",
    "id": 34802212,
    "region": "LAARE/MAUA",
    "assign": "LUKUNUNU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 559,
    "name": "MWENDA ERASTUS",
    "id": 34174482,
    "region": "LAARE/MAUA",
    "assign": "LUKUNUNU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 560,
    "name": "KIPKOSGEI EVANS MUTAI",
    "id": 33428530,
    "region": "MERU",
    "assign": "LYMOND PETROL STATION KAGUMA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 561,
    "name": "MURIUNGI MOSES",
    "id": 35840976,
    "region": "LAARE/MAUA",
    "assign": "MADAM EDDAH -RESIDENCE KARAMA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 562,
    "name": "MURIANKI MARTIN MWITI",
    "id": 240046638,
    "region": "MERU",
    "assign": "MADAM RUTH",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 563,
    "name": "THIAURI MISHECK MURITHI",
    "id": 38947734,
    "region": "MERU",
    "assign": "MANSUDU TIMBER SALES - MUTUATI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 564,
    "name": "ECHENGI ROMANO KARANI",
    "id": 21780101,
    "region": "MERU",
    "assign": "MANYOTA CONSTRUCTORS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 565,
    "name": "KUBAI JOSEPH MWENDA",
    "id": 9907266,
    "region": "LAARE/MAUA",
    "assign": "MARIRI SECONDARY SCHOOL -MUTUATI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 566,
    "name": "MWENDA MARTIN MANSUDU",
    "id": 34713122,
    "region": "LAARE/MAUA",
    "assign": "MARIRI SECONDARY SCHOOL -MUTUATI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 567,
    "name": "KIOGORA ISAIAH MUREITHI",
    "id": 22352814,
    "region": "LAARE/MAUA",
    "assign": "MARIRI SECONDARY SCHOOL -MUTUATI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 568,
    "name": "KATHIAI M'ERIMBA DAVID",
    "id": 20631334,
    "region": "MERU",
    "assign": "MARTIN KIOGORA'S RESIDENCE(MILIMANI)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 569,
    "name": "MUJUMBE NICK MUTWIRI",
    "id": 36702903,
    "region": "NANYUKI",
    "assign": "MARY EMMACULATE TTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 570,
    "name": "MAYIANI PETER OLOLEPET",
    "id": 37595759,
    "region": "NANYUKI",
    "assign": "MARY IMMACULATE PRI SCHOOL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 571,
    "name": "KANYWITHIA ABRAHAM",
    "id": 12891912,
    "region": "NANYUKI",
    "assign": "MARY IMMACULATE PRI SCHOOL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 572,
    "name": "MAKORI HENRY BARASA",
    "id": 35478325,
    "region": "NYERI",
    "assign": "MATHENGE TECHNICAL TRAINING INSTITUTE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 573,
    "name": "KAIMENYI NANCY",
    "id": 33072286,
    "region": "NYERI",
    "assign": "MATHENGE TECHNICAL TRAINING INSTITUTE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 574,
    "name": "NG'ANG'A ESTHER WAMBUI",
    "id": 24569530,
    "region": "NYERI",
    "assign": "MATHENGE TECHNICAL TRAINING INSTITUTE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 575,
    "name": "KARIUKI DUNCAN",
    "id": "",
    "region": "NYERI",
    "assign": "MATHENGE TECHNICAL TRAINING INSTITUTE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 576,
    "name": "KIPKORIR GEOFFREY",
    "id": 35171721,
    "region": "NYERI",
    "assign": "MATHENGE TECHNICAL TRAINING INSTITUTE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 577,
    "name": "SAMUEL KITHINJI",
    "id": 2516912,
    "region": "NYERI",
    "assign": "MATHENGE TECHNICAL TRAINING INSTITUTE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 578,
    "name": "TANUI TITUS",
    "id": "",
    "region": "NYERI",
    "assign": "MATHENGE TECHNICAL TRAINING INSTITUTE -TECH CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 579,
    "name": "MARTINE EDWARD OPENDA",
    "id": 38136007,
    "region": "MERU",
    "assign": "MATIX OIL PETROL STATION -MITUNGUU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 580,
    "name": "MWORIA ANTONY",
    "id": 32587789,
    "region": "MERU",
    "assign": "MATIX OIL PETROL STATION -MITUNGUU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 581,
    "name": "JOHN PAUL MURIUKI",
    "id": 30921508,
    "region": "MERU",
    "assign": "MBAYA KARICHU -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 582,
    "name": "KENDI BRENDA LORAN",
    "id": "",
    "region": "MERU",
    "assign": "MBUGUA NYORI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 583,
    "name": "M'MBIRITHIA DAVID KOOME",
    "id": 14447050,
    "region": "MERU",
    "assign": "MENANY S.S -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 584,
    "name": "MUTHOMI PETER LITHIRA",
    "id": 35569817,
    "region": "MERU",
    "assign": "MENYA GULF P/STATION -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 585,
    "name": "MACHARIA LAMECH THUMBI",
    "id": 7345,
    "region": "MERU",
    "assign": "MENYA GULF P/STATION -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 586,
    "name": "MWIRIGI CHARLES",
    "id": 34125027,
    "region": "MERU",
    "assign": "MENYA GULF P/STATION -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 587,
    "name": "MWENDA PATRICK MURURU",
    "id": 25193121,
    "region": "MERU",
    "assign": "MERU CENTRAL COFFEE UNION -BROTHERHOOD",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 588,
    "name": "KINOTI ABEL",
    "id": 9355080,
    "region": "MERU",
    "assign": "MERU CENTRAL COFFEE UNION -BROTHERHOOD",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 589,
    "name": "MWENDA PATRICK",
    "id": 23433293,
    "region": "MERU",
    "assign": "MERU CENTRAL COFFEE UNION -BROTHERHOOD",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 590,
    "name": "KAVITA JOEL SYUMBUA",
    "id": 34782342,
    "region": "EMBU",
    "assign": "MERU CENTRAL COFFEE UNION -KIGURE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 591,
    "name": "MUGAMBI ERICK MUNENE",
    "id": 36000839,
    "region": "MERU",
    "assign": "MERU CENTRAL COFFEE UNION -OFFICE MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 592,
    "name": "MUTHEE ERICK NYAGA",
    "id": 23487560,
    "region": "MERU",
    "assign": "MERU CENTRAL COFFEE UNION -OFFICE MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 593,
    "name": "MURUKWA JAMES LERAWAN",
    "id": 28353851,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -C.E.O_NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 594,
    "name": "EVANS MURANGIRI",
    "id": 7345,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -C.E.O_NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 595,
    "name": "GIKUNDA PHINEAS",
    "id": 10381978,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -C.E.O_NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 596,
    "name": "DAVID MUTEMBEI",
    "id": 35759883,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -COOLER GIANTUNE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 597,
    "name": "MAWIA GLADYS",
    "id": 36821791,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -COOLER GIANTUNE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 598,
    "name": "MWITA ROMANO MITOBI",
    "id": 13587705,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 599,
    "name": "MWETI LYDIA KAWIRA",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -MILK BAR",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 600,
    "name": "GICHURU JOSEOH MUCHUI",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -MILK BAR",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 601,
    "name": "OKHALA ANTONY WECHULI",
    "id": 32629940,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 602,
    "name": "THURANIRA NICHOLAS",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 603,
    "name": "SANG ELIJA",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 604,
    "name": "KABURU ERIC MWENDA",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 605,
    "name": "MUTEGI HARUN IKUNDA",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 606,
    "name": "EMASU BENSON BARASA",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 607,
    "name": "MUTWIRI JOHN KIRIMO",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 608,
    "name": "M'ATAYA ANDREW MBARUA",
    "id": 7737810,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 609,
    "name": "MUTHURI TIMOTHY",
    "id": 21250613,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 610,
    "name": "SAMUEL PURITY KAGENDO",
    "id": 27447719,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 611,
    "name": "MUTHUI ROBERT MUATHA",
    "id": 34816650,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 612,
    "name": "GIKUNDI DAVID M'KAIRIAMA",
    "id": 27857215,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 613,
    "name": "KANJA DAVID KIRIMI",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 614,
    "name": "NYAMU AMOS KINYUA",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 615,
    "name": "GITILE PHINEAS",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 616,
    "name": "MWIRIGI PHYILLIS KAGWIRIA",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 617,
    "name": "MWENDA STANLEY MWITI",
    "id": 13836655,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 618,
    "name": "KIMATHI JOMINIC KAWIRA",
    "id": 39058127,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 619,
    "name": "OUMA BENARD ONDELE",
    "id": 37968637,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 620,
    "name": "MWENDA MARTIN NKONGE",
    "id": 25358445,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 621,
    "name": "MIRITI ERIC KATHURIMA",
    "id": 28632689,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 622,
    "name": "MAKENA POLYJOY",
    "id": 31870058,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 623,
    "name": "MAKAO DORIES MUTHINA",
    "id": 38514117,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 624,
    "name": "ALEX MITHIKA",
    "id": 33167603,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -PLANT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 625,
    "name": "ALOO SHADRACK OBONDO",
    "id": "",
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY -SUPERVISOR",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 626,
    "name": "MWORORO PAUL GITUMA",
    "id": 7345,
    "region": "MERU",
    "assign": "MERU CENTRAL DAIRY-PAY ON LEAVE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 627,
    "name": "KIRIMI ISAIAH",
    "id": 27971454,
    "region": "MERU",
    "assign": "MERU COUNTY URBAN WATER AND SANITATION -GAKOROMONE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 628,
    "name": "CHABARI SAMUEL MUSIKALI",
    "id": 34862909,
    "region": "MERU",
    "assign": "MERU COUNTY URBAN WATER AND SANITATION -GAKOROMONE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 629,
    "name": "MUTEGI LYDIA GAKII",
    "id": 25806814,
    "region": "MERU",
    "assign": "MERU COUNTY URBAN WATER AND SANITATION -KIGURE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 630,
    "name": "MBAE DENNIS MAWIRA",
    "id": 33348596,
    "region": "MERU",
    "assign": "MERU COUNTY URBAN WATER AND SANITATION -KIGURE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 631,
    "name": "NJOKI JULIUS DAISY",
    "id": 36617382,
    "region": "MERU",
    "assign": "MERU COUNTY URBAN WATER AND SANITATION -OFFICE MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 632,
    "name": "MWITI MOSES MWENDA",
    "id": 27932637,
    "region": "MERU",
    "assign": "MERU COUNTY URBAN WATER AND SANITATION -OFFICE MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 633,
    "name": "MURITHI BENJAMIN",
    "id": 25491780,
    "region": "MERU",
    "assign": "MERU COUNTY URBAN WATER AND SANITATION -OFFICE MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 634,
    "name": "MUCHIRA EUNICE WANJIRU",
    "id": 28711509,
    "region": "MERU",
    "assign": "MERU COUNTY URBAN WATER AND SANITATION -WATER TREATMENT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 635,
    "name": "JOSEPH KAIRITHIA MURITHI",
    "id": 23109452,
    "region": "MERU",
    "assign": "MERU COUNTY URBAN WATER AND SANITATION -WATER TREATMENT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 636,
    "name": "KITHOME JOSEPH MWASI",
    "id": 12447103,
    "region": "MERU",
    "assign": "MERU INDUSTIAL DAIRY ROAD -DAIRY ROAD",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 637,
    "name": "NABEA FRANCIS GITUMA",
    "id": 12496503,
    "region": "MERU",
    "assign": "MERU UNIFORM H/S -RESIDENCE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 638,
    "name": "KANYUA MERCY MUTHURI",
    "id": 27983669,
    "region": "MERU",
    "assign": "MERU UNIFORM H/S -RESIDENCE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 639,
    "name": "M'IPUI BENARD MACHARIA",
    "id": 7120855,
    "region": "MERU",
    "assign": "MERU UNIFORMS -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 640,
    "name": "KIMATHI MOSES",
    "id": 32710691,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. - TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 641,
    "name": "THAIMUTA ROBERT KOOME",
    "id": 31550917,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. - TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 642,
    "name": "MWENDA RICHARD",
    "id": 31898172,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. - TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 643,
    "name": "KAGWIRIA ESTHER KAIRITHIA",
    "id": 37861604,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. - TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 644,
    "name": "KAMAMO EDWIN MUCHIRI",
    "id": 22388881,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -DRIVER",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 645,
    "name": "MAJAU FELIX SALESIO",
    "id": 21625241,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -DRIVER",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 646,
    "name": "MUKIRA DAVID MURIUNGI",
    "id": 8610427,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -INCHARGE TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 647,
    "name": "DONALD SIMIYU WANYONYI",
    "id": 28975912,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -INCHARGE TOWN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 648,
    "name": "KIRIINYA FREDRICK",
    "id": 37073633,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 649,
    "name": "MWITI MOSES KALUNGE",
    "id": 27243503,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 650,
    "name": "KAGWIRIA LILIAN",
    "id": 38311283,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 651,
    "name": "KINOTI NICHOLAS GITONGA",
    "id": 24379787,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 652,
    "name": "KALUMA DAVID MUCHUI",
    "id": 36081679,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 653,
    "name": "KINYUA WILSON",
    "id": 36025270,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 654,
    "name": "MUGAMBI LUCY KENDI",
    "id": 25902468,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 655,
    "name": "WANGARI JUDY",
    "id": 37643647,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 656,
    "name": "NCEBERE ZACHAEUS MUNENE",
    "id": 10898116,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 657,
    "name": "M'INGALA NANCY KABURO",
    "id": 13836439,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 658,
    "name": "MUNGANIA DOREEN KATHAMBI",
    "id": 33766678,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 659,
    "name": "MURURU JAMES",
    "id": 31718426,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 660,
    "name": "NYANGUTHI ANN",
    "id": 25927396,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 661,
    "name": "KIMOTI PATRICK MUKUBIO",
    "id": 34223578,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 662,
    "name": "KARUGU CORNELIOUS KIRIUNGI",
    "id": 22917776,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 663,
    "name": "NDUBI GLADYS KENDI",
    "id": 36028780,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 664,
    "name": "STEPHENE RAYMOND MUTUMA",
    "id": 24058616,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 665,
    "name": "MURITHI BEMARRS KIRIINYA",
    "id": 30300842,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 666,
    "name": "KIREMA ALEX KITHINJI",
    "id": 35304617,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 667,
    "name": "GITHINJI SAMUEL MWANGI",
    "id": 25415110,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 668,
    "name": "MBAYA DORCAS KAGENDO",
    "id": 33000037,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 669,
    "name": "NJOROGE ROSE KAARI",
    "id": 13836054,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 670,
    "name": "GEOFFREY PAUL MWIKAMBA",
    "id": 13493994,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 671,
    "name": "NGUCINE CHERRY KINANU",
    "id": 28511906,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 672,
    "name": "WAITHERA YVONNE",
    "id": 34643693,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 673,
    "name": "MBUGI BENARD KIMATHI",
    "id": 33883687,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 674,
    "name": "NKINYANGI JEREMIAH",
    "id": 34287445,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 675,
    "name": "MUNENE CLINTON",
    "id": 34521841,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 676,
    "name": "THURANIRA BENSON KIRIINYA",
    "id": 27469366,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 677,
    "name": "KINOTI GEOFFREY KINOTI",
    "id": "",
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 678,
    "name": "KENDI PURITY",
    "id": 33404430,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 679,
    "name": "KENDI ZUBERIA",
    "id": 31133204,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 680,
    "name": "MWINGIRWA GODFREY",
    "id": 35024530,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 681,
    "name": "MURITHI DAVID",
    "id": 27201575,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 682,
    "name": "MUTHOMI MARTINE",
    "id": 38392118,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 683,
    "name": "TARIMBU MOSES MWITI",
    "id": 22270310,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 684,
    "name": "NTEAMIKIGU JENEAS",
    "id": 1190191,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 685,
    "name": "IAN DANCAN KATHURIMA",
    "id": 34081907,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 686,
    "name": "MUCHUI GODFREY",
    "id": 29784987,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 687,
    "name": "STANLEY FRIDA THAIRORA",
    "id": 31777113,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 688,
    "name": "MUTEMBEI DOUGLAS",
    "id": 35304836,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 689,
    "name": "MUTHONI TARASILA",
    "id": 12614738,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 690,
    "name": "NKIROTE GEOLDINE",
    "id": 37116198,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 691,
    "name": "KINYUA JAMES",
    "id": 13359440,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 692,
    "name": "MUROHIA AGNES",
    "id": 28956852,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 693,
    "name": "KALUMA JERUSHA NCULUBI",
    "id": 25743323,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 694,
    "name": "KAMATHI EVANGILINE",
    "id": 34927253,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 695,
    "name": "MWINGIRWA ALEX MWINGIRWA",
    "id": 33008082,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 696,
    "name": "KATHURE BEATRICE",
    "id": 36450792,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 697,
    "name": "MWENDA DANIEL",
    "id": 29819829,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 698,
    "name": "IKIAMBA KAIRI DANIEL",
    "id": 13835177,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 699,
    "name": "MUREGA DANIEL KALAWA",
    "id": 29474112,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 700,
    "name": "KAINGA DAVID",
    "id": 7652,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 701,
    "name": "MUGA DAVID KALUMA",
    "id": 27191641,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 702,
    "name": "KINYUA DAVID MWIRIGI",
    "id": 7652,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 703,
    "name": "KAUNYANGI DOMINIC",
    "id": 29690179,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 704,
    "name": "GATUMWA DORCAS",
    "id": 33554562,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 705,
    "name": "MOKAYA DUNCAN NGWONO",
    "id": 20180720,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 706,
    "name": "THURANIRA EDWARD",
    "id": 29983071,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 707,
    "name": "BAINGONI ELIAS NTONGAITI",
    "id": 13179534,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 708,
    "name": "THIAINE ELIJAH",
    "id": 2380965,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 709,
    "name": "KINYUA EMILY NKATHA",
    "id": 7652,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 710,
    "name": "KURI ESTHER KANYI",
    "id": 32107007,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 711,
    "name": "HENRY EUNICE KANANA",
    "id": 20421670,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 712,
    "name": "M'ITHULA FRANCIS KAIBUNG'A",
    "id": 2532215,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 713,
    "name": "KITHURE FRANCIS MUGWIKA",
    "id": 21462161,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 714,
    "name": "NYAGA FREDRICK NKONGE",
    "id": 8693198,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 715,
    "name": "MATAO GEOFFREY",
    "id": 7463036,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 716,
    "name": "KINOTI JACOB NJUE",
    "id": 25448397,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 717,
    "name": "MUTETHIA JAMES MWITI",
    "id": 33264673,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 718,
    "name": "KIMATHI JAPHETH MAMANJA",
    "id": 13551643,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 719,
    "name": "NKATHA JERICA",
    "id": 33003017,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 720,
    "name": "KAIMURI JERUSHA",
    "id": 36471217,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 721,
    "name": "MWORIA JOSEPH",
    "id": 10612474,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 722,
    "name": "MUTUA JOSEPH MBIJIWE",
    "id": 23468435,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 723,
    "name": "KAINGA JOSEPH",
    "id": 7447114,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 724,
    "name": "MUNGANIA JOSEPH KIRIAMBURI",
    "id": 9354301,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 725,
    "name": "NGUTHURI JOSEPH MWINYA",
    "id": 8593403,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 726,
    "name": "M'TABARI JOSHUA GIKUNDI",
    "id": 10149083,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 727,
    "name": "WANJA JOSEPHINE",
    "id": 35203979,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 728,
    "name": "M'MAATHI JULIUS MWENDA",
    "id": 11398134,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 729,
    "name": "GERALD KAUGIRIA KAIBUNG'A",
    "id": 29474026,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 730,
    "name": "KINYUA MBOROKI PAUL",
    "id": 23901296,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 731,
    "name": "MBAABU MESHACK",
    "id": 4516162,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 732,
    "name": "MIKIAO MIBUI",
    "id": 7191870,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 733,
    "name": "MAKENA NANCY MMARIMBA",
    "id": 21937390,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 734,
    "name": "MUTAI NATHAN KIPLANGAT",
    "id": 35665741,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 735,
    "name": "MURIUKI NATHAN MIRITHU",
    "id": 34622123,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 736,
    "name": "THAIMUTA PAUL KINYUA",
    "id": 10612069,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 737,
    "name": "MANYARA PETER GITONGA",
    "id": 14604522,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 738,
    "name": "GATWIRI RHODA",
    "id": 34069186,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 739,
    "name": "MIRITI RICHARD MITABARI",
    "id": 22102741,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 740,
    "name": "FESTUS SAMUEL MURITHI",
    "id": 24165130,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 741,
    "name": "MUGUNA TONNY",
    "id": 37070247,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 742,
    "name": "MURITHI DENIS",
    "id": 34751764,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 743,
    "name": "GATOBU TONNY",
    "id": 7652,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 744,
    "name": "MARCELLA KARMI",
    "id": 28112137,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 745,
    "name": "MUTHAURA CAROLINE KAINDA",
    "id": 23109653,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 746,
    "name": "NABEA PETER MUNGATHIA",
    "id": 24640031,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 747,
    "name": "KARIMI IRENE",
    "id": 31606188,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 748,
    "name": "KABERIA PATRICK MWENDA",
    "id": 28106675,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 749,
    "name": "NTOMBURA PAUL KOBIA",
    "id": 21601346,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MAIN CAMPUS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 750,
    "name": "KANANA SARAH",
    "id": 20766582,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 751,
    "name": "KUBAI SIVIRIANO",
    "id": 7261251,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 752,
    "name": "GITONGA DOUGLAS",
    "id": 36149941,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 753,
    "name": "MUTHOMI EZEKIEL KATHURIMA",
    "id": 30345659,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIMBA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 754,
    "name": "KIMATHERE STEPHEN MWITI",
    "id": 24165450,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIMBA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 755,
    "name": "M'MAUTA DAMARIS KENDI",
    "id": 37350657,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIMBA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 756,
    "name": "KIOGORA CAROLINE KENDI",
    "id": 30089251,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIMBA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 757,
    "name": "ANYIGA FREDRICK MULINDI",
    "id": 7652,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIMBA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 758,
    "name": "MWORIA JACOB MURIUKI",
    "id": 36937289,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIMBA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 759,
    "name": "M'THURANIRA FRANCIS RWANDA",
    "id": 8962028,
    "region": "MERU",
    "assign": "MERU UNIVERSITY OF SCIENCE AND TECH. -MARIMBA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 760,
    "name": "MUGAMBI BISMARK MURETI",
    "id": 36476647,
    "region": "MERU",
    "assign": "MIGAMBO BUILDING",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 761,
    "name": "KANAMPIU DAVID MWITI",
    "id": 32336630,
    "region": "MERU",
    "assign": "MIGAMBO BUILDING",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 762,
    "name": "MUNENE PHINEAS",
    "id": 37339547,
    "region": "MERU",
    "assign": "MIK INSURANCE BROKERS LIMITED KINORU -MILIMANI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 763,
    "name": "GITUMA FREDRICK MUTUMA",
    "id": 23430883,
    "region": "MERU",
    "assign": "MIK INSURANCE BROKERS LIMITED KINORU -MILIMANI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 764,
    "name": "KINOTI ALBERT M'ITHINJI",
    "id": 2531927,
    "region": "MERU",
    "assign": "MIK INSURANCE BROKERS LIMITED KINORU -MILIMANI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 765,
    "name": "MUCHIRI POLLINE GATWIRI",
    "id": 37419056,
    "region": "MERU",
    "assign": "MIK INSURANCE BROKERS LTD TOWN -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 766,
    "name": "ORONE STEPHEN",
    "id": 26616385,
    "region": "NAKURU",
    "assign": "MISSION OF HOPE - NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 767,
    "name": "SHARON JEPNG'ETICH KIPROP",
    "id": 32285797,
    "region": "NAKURU",
    "assign": "MISSION OF HOPE - NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 768,
    "name": "CHETALAAM ELIJAH AENGWO",
    "id": 26573443,
    "region": "NAKURU",
    "assign": "MISSION OF HOPE - NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 769,
    "name": "ACHUDI JOAN",
    "id": 25064726,
    "region": "NAKURU",
    "assign": "MISSION OF HOPE - NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 770,
    "name": "KIPLAGAT VINCENT",
    "id": 38526184,
    "region": "NAKURU",
    "assign": "MISSION OF HOPE - NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 771,
    "name": "MOSE THOMAS NYAMOKO",
    "id": 13569739,
    "region": "NAKURU",
    "assign": "MISSION OF HOPE - NAKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 772,
    "name": "YUSSUF PETER MOHAMMED",
    "id": 24528493,
    "region": "MERU",
    "assign": "MR AKWALU STEPHEN KAUME -KINORU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 773,
    "name": "MUKARIA DANCUN THIANA",
    "id": 30998596,
    "region": "NAIROBI",
    "assign": "MR GANATRA ASIF- MILIMANI RESIDENCE -MILIMANI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 774,
    "name": "MATATA WILLIAM",
    "id": 14671512,
    "region": "NAIROBI",
    "assign": "MR GANATRA ASIF- MILIMANI RESIDENCE -MILIMANI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 775,
    "name": "MKARICHIA DAVID KANAKE",
    "id": 9355659,
    "region": "NAIROBI",
    "assign": "MR MIKE HOMESTEAD -MILIMANI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 776,
    "name": "DAVID KELVIN GIKUNDI",
    "id": 34594677,
    "region": "NAIROBI",
    "assign": "MR MIKE HOMESTEAD -MILIMANI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 777,
    "name": "KUBIA ANDREW KIRU",
    "id": 35081357,
    "region": "MERU",
    "assign": "MR MURIMI KAGUMA QUARREY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 778,
    "name": "MUTAYI IGNATIUS SHIKUKU",
    "id": 30089135,
    "region": "MERU",
    "assign": "MR PETER MWITI'S HOMESTEAD -KAAGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 779,
    "name": "KAGWIRIA WENDY",
    "id": 2343009,
    "region": "MERU",
    "assign": "MR. KIBANGA RESIDENCE-KAAGA HOMESTEAD",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 780,
    "name": "MAKORI BENARD",
    "id": 7652,
    "region": "CHUKA",
    "assign": "MR. MOSHE MUSYOKA -SIAKAGO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 781,
    "name": "KIBITI JOSEPH",
    "id": 7456973,
    "region": "MERU",
    "assign": "MR. MUTHOMI-KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 782,
    "name": "KALWIGI MORRIS BAINGONI",
    "id": 11027218,
    "region": "MERU",
    "assign": "MR. STEPHEN KIKI KIRAI (KUKU)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 783,
    "name": "TOWETT VINCENT KIROTICH",
    "id": 33448903,
    "region": "NAKURU",
    "assign": "MRS KAMIRUI RESIDENCE -NJORO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 784,
    "name": "DAVID DANIEL APIYO OSWERE",
    "id": 12711130,
    "region": "MERU",
    "assign": "MULATHANKARI TTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 785,
    "name": "ALI MWANGI BASHIR",
    "id": 35909131,
    "region": "MERU",
    "assign": "MULATHANKARI TTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 786,
    "name": "MWENDWA PATRICK MUTUMA",
    "id": 36960970,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 787,
    "name": "THURANIRA PATRICK THURANIRA",
    "id": 356224282,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 788,
    "name": "OYIERA DANCAN OUMA",
    "id": 33146545,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 789,
    "name": "NYABOKE LISTER ORUKO",
    "id": 34201552,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 790,
    "name": "OUMA NASHONI JUMA",
    "id": 22297648,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 791,
    "name": "NDUBI WENZESLAS NDANDA",
    "id": 24488730,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 792,
    "name": "BETT NICHOLAS KIPLAGAT",
    "id": 38814227,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 793,
    "name": "KARIAINTO WINFRED",
    "id": 36036976,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 794,
    "name": "RIOBA LUCY MWIKWABE",
    "id": 34254465,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 795,
    "name": "BWAMBOK DANIEL KIPKEMBOI",
    "id": 27558164,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 796,
    "name": "NGELESO JOHN JUMBA",
    "id": 10017373,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 797,
    "name": "KORIR VICTOR KIPKOECH",
    "id": 37416552,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 798,
    "name": "KORIR GILBEERT KIPNGENO",
    "id": 322875016,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 799,
    "name": "GEKONGO RONALD NYAMBOGHI",
    "id": 26567750,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 800,
    "name": "MARIMBA SILAS KIRIINYA",
    "id": 24705942,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 801,
    "name": "CHEPKWONY DANIEL KIPROTICH",
    "id": 32943923,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 802,
    "name": "CHEPKEMBOI ROSE",
    "id": 27536053,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 803,
    "name": "OMASETE BENJAMIN ARERENG",
    "id": 36985570,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 804,
    "name": "NDANYI IBRAHIM LUGANJI",
    "id": 232107312,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 805,
    "name": "MUSUNGU BRIAN BARAKA",
    "id": 37164415,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 806,
    "name": "WASIKE MOSES MASIKA",
    "id": 33580468,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 807,
    "name": "ONYANGO JUDITH AUKO",
    "id": 35796626,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 808,
    "name": "KIMUTAI NICHOLAS SITIENEI",
    "id": 36672062,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 809,
    "name": "CHERIRO CALEB KIPNGENO",
    "id": 38457258,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 810,
    "name": "OTIENO JOHANA",
    "id": 32507533,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 811,
    "name": "MAINGI BEATRICE KASYOKA",
    "id": 35066925,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 812,
    "name": "MUKARIA STEPHEN MUTHOMI",
    "id": 32834216,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 813,
    "name": "KIMANI JULIET WAMBUI",
    "id": 32619759,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 814,
    "name": "VIRIRI ISAYA OMOKE",
    "id": 21343798,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 815,
    "name": "MUSOMBA PRISCILLAH MUKAI",
    "id": 33417951,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 816,
    "name": "MWIRIGI BENJAMIN MBURUGU",
    "id": 29053770,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 817,
    "name": "LEONIDA PURITY",
    "id": 35546500,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 818,
    "name": "GAKII CAROLYNE",
    "id": 35967900,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 819,
    "name": "ETARO ONESMUS ERUPE",
    "id": 12910683,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 820,
    "name": "GITONGA ERIC",
    "id": 32755439,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 821,
    "name": "KIVINDU JOSEPH MUEMA",
    "id": 36827837,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 822,
    "name": "KIRUI AMOS KIPLANGAT",
    "id": 38222500,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 823,
    "name": "MESA VICTOR MOMANYI",
    "id": 25292819,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 824,
    "name": "WATENE MARY MUGURE",
    "id": 32697224,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 825,
    "name": "MUUNJIA JOHN MUTIRYA",
    "id": 38858585,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 826,
    "name": "KASYOKA NICHOLAS MWANGANGI",
    "id": 31148210,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 827,
    "name": "KIPTANUI ANDREW REIGN",
    "id": 36973270,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 828,
    "name": "KAMAU BENSON MWAURA",
    "id": 36780759,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 829,
    "name": "KIRUI NICHOLUS KIPKORIR",
    "id": 27171549,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 830,
    "name": "LANGAT BENARD KIPKOECH",
    "id": 29793657,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 831,
    "name": "ROP ALPHAYO",
    "id": 11605511,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 832,
    "name": "KIPKORIR NICODEMUS",
    "id": 38882670,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 833,
    "name": "MWANGI DOUGLAS",
    "id": 38890879,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 834,
    "name": "DEBORAH DEBORAH CHEROP",
    "id": 36292159,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 835,
    "name": "AUMA DIANA",
    "id": 36370307,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 836,
    "name": "PEPELA JOSEPH LUBISIA",
    "id": 25415414,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 837,
    "name": "CHESERE TOBIAS KIBET",
    "id": 26163307,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 838,
    "name": "GISEMBE VINCENT SABWENGI",
    "id": "",
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 839,
    "name": "GERASO EVANS WAWIRE",
    "id": 36447526,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 840,
    "name": "MUGAMBI JAMES",
    "id": 26101495,
    "region": "NAIROBI",
    "assign": "MULTIMEDIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 841,
    "name": "GIKUNDA DOMISIANO",
    "id": 11257917,
    "region": "MERU",
    "assign": "MURUITHANIA PLAZA -HARDWARE NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 842,
    "name": "MUTHONI CAROLINE",
    "id": "",
    "region": "MERU",
    "assign": "MURUITHANIA PLAZA -PLAZA NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 843,
    "name": "MUNENE ERIC MURITHI",
    "id": 335223380,
    "region": "MERU",
    "assign": "MUSLIM MOSQUE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 844,
    "name": "KINOTI JOSEPH",
    "id": 16050481,
    "region": "MERU",
    "assign": "MUTHANGENE DAY SEC. SCHOOL -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 845,
    "name": "MIRITI ZAKAYO MWITI",
    "id": 34788516,
    "region": "LAARE/MAUA",
    "assign": "MWERONGONDU SEC -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 846,
    "name": "MUTETHIA PAUL",
    "id": 37339880,
    "region": "LAARE/MAUA",
    "assign": "MWERONGONDU SEC -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 847,
    "name": "PETER MUTUA",
    "id": 8693778,
    "region": "LAARE/MAUA",
    "assign": "MWERONGONDU SEC -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 848,
    "name": "CHERONO OLIVE",
    "id": 35949035,
    "region": "NAKURU",
    "assign": "MWIGITO HIGH SCHOOL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 849,
    "name": "KORIR GEOFFREY",
    "id": 24473418,
    "region": "NAKURU",
    "assign": "MWIGITO HIGH SCHOOL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 850,
    "name": "MASIKA BENEDICT SIMMIYU",
    "id": 29434096,
    "region": "NAKURU",
    "assign": "MWIGITO HIGH SCHOOL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 851,
    "name": "IGWETA STEPHEN MUCHUI",
    "id": 32396977,
    "region": "MERU",
    "assign": "NAARI DAIRY -KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 852,
    "name": "MUTWIRI MAUREEN KANANA",
    "id": 36890731,
    "region": "MERU",
    "assign": "NAARI DAIRY -NAARI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 853,
    "name": "KIOGORA JULIUS NKANATA",
    "id": 2377516,
    "region": "MERU",
    "assign": "NAARI DAIRY -NAARI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 854,
    "name": "ITHIBUA MITHIBUA HENRY MURANGIRI",
    "id": 34700186,
    "region": "MERU",
    "assign": "NAARI DAIRY -NAARI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 855,
    "name": "CHERUIYOT FESTUS KIPKOECH",
    "id": 38142122,
    "region": "NANYUKI",
    "assign": "NANYUKI FUN CITY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 856,
    "name": "GICHARA PETER KIMANI",
    "id": 35291903,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL (SHOWGROUND)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 857,
    "name": "KILOKU SASINE COLLISON",
    "id": 38025531,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL (SHOWGROUND)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 858,
    "name": "LEPAINAH EMMANUEL LTANIYIA",
    "id": 38366005,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL (SHOWGROUND)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 859,
    "name": "GATIGI JOSEPH WANYIRI",
    "id": 34810411,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL (SHOWGROUND)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 860,
    "name": "MAKENA FELISTER",
    "id": 36352523,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL (SHOWGROUND)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 861,
    "name": "KITHINJI ELIAS KIRIMI",
    "id": 25480321,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL (SHOWGROUND)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 862,
    "name": "LOBEKI SAMUEL LORUNYE",
    "id": 36925376,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL (SHOWGROUND)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 863,
    "name": "ANNITA GACHERI",
    "id": 24094400,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 864,
    "name": "MUTUA JOSHUA",
    "id": 35203922,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 865,
    "name": "MUGWERU CHRIS MAINA",
    "id": 31682243,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 866,
    "name": "KIMUTAI ELKANAH KORIR",
    "id": 32981825,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 867,
    "name": "KIMATHI ALEXANDER MUGAMBI",
    "id": 36898578,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 868,
    "name": "MARETE PAUL GITONGA",
    "id": 11260178,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 869,
    "name": "CHERUIYOT PETER",
    "id": 29232826,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 870,
    "name": "MURIUNGI ERICK MWENDA",
    "id": 32218538,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 871,
    "name": "KIPKOSGEI ELISHA",
    "id": "38343=5444",
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 872,
    "name": "SAIDIMU JULIUS",
    "id": 34901211,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 873,
    "name": "NJOKI DENNIS GIKONYO",
    "id": 33663463,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 874,
    "name": "WABWIRE SYLVESTER WESONGA",
    "id": 24218951,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 875,
    "name": "MURITHI TERESA WAMBUI",
    "id": "",
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 876,
    "name": "M'IBERE BATISTA MURIUKI",
    "id": 2389870,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 877,
    "name": "KABERIA DAVID MUNJURI",
    "id": 32403430,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 878,
    "name": "MARETE BENSON KIMATHI",
    "id": 23281510,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 879,
    "name": "EIBAR ERUPE",
    "id": 5962588,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 880,
    "name": "RUTO EMMANUEL KIPROP",
    "id": 32710770,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 881,
    "name": "WANG'OMBE NANCY WANJIRU",
    "id": 27306954,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 882,
    "name": "FLORENCE KANGAI",
    "id": 35416315,
    "region": "NANYUKI",
    "assign": "NANYUKI GENERAL HOSPITAL -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 883,
    "name": "KIPKURUI ERICK KIPLAGAT",
    "id": 33971483,
    "region": "NANYUKI",
    "assign": "NAPOLITANA HOTEL",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 884,
    "name": "MUCHUI ERASTUS",
    "id": 37628315,
    "region": "MERU",
    "assign": "NEW SILENT TRAVELLERS -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 885,
    "name": "KUBAI SAMUEL MBAABU",
    "id": 28364233,
    "region": "MERU",
    "assign": "NEWLOOK -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 886,
    "name": "JASON KARITHI",
    "id": 26964678,
    "region": "MERU",
    "assign": "NEWLOOK -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 887,
    "name": "MUTHAURA BENSON",
    "id": 38123961,
    "region": "MERU",
    "assign": "NITYA INVESTMENT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 888,
    "name": "CHANGALA PETER AYIMA",
    "id": 30180005,
    "region": "ISIOLO",
    "assign": "NORTHGATE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 889,
    "name": "M'LIMBERIA DAVID NTONGAI",
    "id": 9702681,
    "region": "ISIOLO",
    "assign": "NORTHGATE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 890,
    "name": "MUTETHIA PHINEAS MUTETHIA",
    "id": 38119598,
    "region": "ISIOLO",
    "assign": "NORTHGATE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 891,
    "name": "MWANGANGI DAVID",
    "id": 36657888,
    "region": "LAARE/MAUA",
    "assign": "NYAMBENE CLINICAL SERVICES & NURSING HOME -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 892,
    "name": "KIRERA EVANS MURITHI",
    "id": 25124856,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 893,
    "name": "KAHUTHIA MICHAEL",
    "id": 22042877,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 894,
    "name": "MURITHI ALLAN DODD",
    "id": 31440278,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 895,
    "name": "NDIRANGU SARA WAMUCHI",
    "id": 33964404,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 896,
    "name": "IRUNGU AWOUR AWOUR",
    "id": 34387506,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 897,
    "name": "GATHUNGU JOHMUTURI",
    "id": 34817961,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 898,
    "name": "MUTHONI PERIS",
    "id": "",
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 899,
    "name": "NJERU ALBERT NJIRU",
    "id": 3795977,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 900,
    "name": "OCHANGI BENSON OMWANGA",
    "id": "",
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 901,
    "name": "NDIRANGU FRANCIS MOGEREKI",
    "id": 22135546,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 902,
    "name": "NYONGESA BONFACE BARASA",
    "id": 34135357,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 903,
    "name": "MUTAGIA FRANCIS MBURU",
    "id": 3729752,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 904,
    "name": "NDIRANGU HENRY KARANJA",
    "id": 1865591,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 905,
    "name": "MWANGI JOSEPHINE WAMBUI",
    "id": 14566308,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 906,
    "name": "CHELEKESI YVONNE NEKESA",
    "id": 36052200,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 907,
    "name": "MIKWA STANLEY KIRIMBA",
    "id": 4541780,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 908,
    "name": "GITONGA LEWIS KAMANI MWANGI",
    "id": 26606303,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 909,
    "name": "KIRITO MIRIAM",
    "id": 11168313,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 910,
    "name": "DANIEL ROSE KAINGU",
    "id": 25570282,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 911,
    "name": "KAMAU MARY NGATHA",
    "id": 34493327,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 912,
    "name": "WAMBUI PETER KARIU",
    "id": 12420221,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 913,
    "name": "RURI JUDY WANGUI",
    "id": 25645406,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 914,
    "name": "GATHOYA DUNCAN KAGURE",
    "id": 22173607,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 915,
    "name": "GATHUYA PAUL MAINA",
    "id": 9857436,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 916,
    "name": "NDUHIU DENNIS WANJIRI",
    "id": 31076954,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 917,
    "name": "WANJAU GRECORY KIHANDI",
    "id": 32209979,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 918,
    "name": "MUKUNDI ANNASTACIA WANJIRU",
    "id": 21782226,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 919,
    "name": "NGAISI JOSHUA LEKATOO",
    "id": 37730386,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 920,
    "name": "NKONGE LEWIS MWENDA",
    "id": 35900705,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 921,
    "name": "MIRIITHI JOHN MAINA",
    "id": 900743,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 922,
    "name": "MUTHURI JAPHETH",
    "id": 31399780,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 923,
    "name": "GAKANGA ANTONY MWANGI",
    "id": 11652526,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 924,
    "name": "MURAGE PAUL NDIRANGU",
    "id": 13452047,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 925,
    "name": "NYARINGOTI NELSON MAGUDU",
    "id": 23133205,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 926,
    "name": "NYONGESA SAMUEL SIFUNA",
    "id": 36017024,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 927,
    "name": "MUCHOKI JAMES NDERITU",
    "id": 20221792,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 928,
    "name": "MWANGI JOSHUA MWANIKI",
    "id": 21865874,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 929,
    "name": "WAMBU EVALYNE NDUTA",
    "id": 32477629,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 930,
    "name": "MUGO WILSON WACHIRA",
    "id": 25858539,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 931,
    "name": "FRANCIS CATHERINE KIGETU",
    "id": 13814663,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 932,
    "name": "CHELANGAT EVERLYN",
    "id": 22763541,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 933,
    "name": "MUCHINJU TERESA WACERA",
    "id": 27789862,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 934,
    "name": "NAITORE VEROLINE NAITORE",
    "id": 35550422,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 935,
    "name": "MURIUKI ESTER WANGARI",
    "id": 22916172,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 936,
    "name": "KAHUNYU JOHN NDIRITU",
    "id": 22966367,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 937,
    "name": "KAGUMA WINNIE WAMBUI",
    "id": 30877915,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 938,
    "name": "PAMBA RICHARD",
    "id": 30234779,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 939,
    "name": "MURANGIRI WILFRED",
    "id": 37381368,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 940,
    "name": "SANG WESLEY CHERUIYOT",
    "id": 32888717,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 941,
    "name": "JOSPHET FRIDA KENDI",
    "id": 33181126,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 942,
    "name": "NGENO KIPLANGAT",
    "id": 33313040,
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 943,
    "name": "NDUNGU JOSEPH MAINA",
    "id": "",
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 944,
    "name": "MAINA SAMUEL GACHUKIA",
    "id": "",
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 945,
    "name": "JUMA BENARD",
    "id": "",
    "region": "NYERI",
    "assign": "NYEWASCO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 946,
    "name": "MBAKA LONNEY NGUGI",
    "id": 34841189,
    "region": "CHUKA",
    "assign": "OLA ENERGY -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 947,
    "name": "MUJUMBE ALFRED",
    "id": 11256310,
    "region": "CHUKA",
    "assign": "OLA ENERGY -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 948,
    "name": "ISSA MCHELULE MALALA",
    "id": 20590538,
    "region": "NAKURU",
    "assign": "PALACE TENTS -PALACE TENT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 949,
    "name": "NGUGI DORCAS",
    "id": 30052102,
    "region": "MERU",
    "assign": "PARAMOUNT HOTEL -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 950,
    "name": "KIMATHI AQUINUS",
    "id": 36643529,
    "region": "MERU",
    "assign": "PARAMOUNT HOTEL -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 951,
    "name": "KATHONI GRACE",
    "id": 36200403,
    "region": "MERU",
    "assign": "PATMOS ISLAND TARVEN -KIROGINE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 952,
    "name": "MAINA JOSPHAT GIKONYO",
    "id": "",
    "region": "NANYUKI",
    "assign": "PCEA NGENIA CDC",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 953,
    "name": "NJUE RAEL KARIUNGI",
    "id": "",
    "region": "MERU",
    "assign": "PENTHOUSE -THE SPA NKUNGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 954,
    "name": "KINYUA FESTUS NJUE",
    "id": 9047120,
    "region": "CHUKA",
    "assign": "PETER IRUMA -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 955,
    "name": "EUSTACE EDWARD KIMATHI",
    "id": 21036417,
    "region": "CHUKA",
    "assign": "PETER IRUMA -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 956,
    "name": "KIRUJA JAMES MURIITHI",
    "id": 11810267,
    "region": "CHUKA",
    "assign": "PICNIC LOUNGE -CHOGORIA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 957,
    "name": "MBAABU CHARLES",
    "id": 9704100,
    "region": "MERU",
    "assign": "PLAN AND TREND",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 958,
    "name": "MUSYOKA DAVID",
    "id": 35711675,
    "region": "MERU",
    "assign": "PS KIRIINYA -KEMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 959,
    "name": "OGARI METHUSELLER OSIANGO",
    "id": 8795853,
    "region": "NAKURU",
    "assign": "QINGDAO TYRES",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 960,
    "name": "DANIEL JAPHET GITARI",
    "id": 8881118,
    "region": "MERU",
    "assign": "RED ARROW -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 961,
    "name": "MUTEMI JACQUILINE MWIKALI",
    "id": 33079567,
    "region": "MERU",
    "assign": "REGIONAL BUSINESS CONNECTION LIMITED -KITHOKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 962,
    "name": "M'IMAINGI JASON MUGAMBI",
    "id": 8693107,
    "region": "MERU",
    "assign": "REGIONAL BUSINESS CONNECTION LIMITED -KITHOKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 963,
    "name": "NJOKI BENSON MAINA",
    "id": 22187122,
    "region": "MERU",
    "assign": "RELIEVER - NYERI DIASPORA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 964,
    "name": "OMWANDO SIMON NYANDIRI",
    "id": 23622999,
    "region": "MERU",
    "assign": "RELIEVER - NYERI DIASPORA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 965,
    "name": "CHEPTOO LORNA",
    "id": 28700948,
    "region": "MERU",
    "assign": "RELIEVER - NYERI DIASPORA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 966,
    "name": "KIPROP ISAAC",
    "id": 35273225,
    "region": "WESTERN",
    "assign": "RELIEVER -ELDORET/KAPSABET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 967,
    "name": "GATILIO PAUL MWENDIA",
    "id": 37853458,
    "region": "CHUKA",
    "assign": "RELIEVER -IGONJI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 968,
    "name": "AHMED KHALID ALI",
    "id": 35820941,
    "region": "ISIOLO",
    "assign": "RELIEVER -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 969,
    "name": "BONAYA GODANA HALAKE",
    "id": 34411954,
    "region": "MARSABIT",
    "assign": "RELIEVER -MARSABIT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 970,
    "name": "NTONGAI JEREMIAH MABURUKI",
    "id": 35415950,
    "region": "MERU",
    "assign": "RELIEVER -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 971,
    "name": "NKATHA JOSEPHINE",
    "id": 33996553,
    "region": "MERU",
    "assign": "RELIEVER -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 972,
    "name": "SIANTO MARGARET MARTI",
    "id": "",
    "region": "MERU",
    "assign": "RELIEVER -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 973,
    "name": "MAMULI DAVID NYONGESA",
    "id": 36817252,
    "region": "MERU",
    "assign": "RELIEVER -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 974,
    "name": "MBURIA ALEX MWIRIGI",
    "id": "",
    "region": "MERU",
    "assign": "RELIEVER -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 975,
    "name": "KABURU KEVEN NJUE",
    "id": "",
    "region": "MERU",
    "assign": "RELIEVER -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 976,
    "name": "ABDUL ASHA",
    "id": 24942458,
    "region": "MERU",
    "assign": "RELIEVER -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 977,
    "name": "LOPILI SAMUEL LEPAYATE",
    "id": 29559706,
    "region": "MERU",
    "assign": "RELIEVER -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 978,
    "name": "GITUMA JULIUS",
    "id": 10612855,
    "region": "MERU",
    "assign": "RELIEVER -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 979,
    "name": "MOREBU STEPHEN ABAI",
    "id": "",
    "region": "MERU",
    "assign": "RELIEVER -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 980,
    "name": "LUBUARU CYPRIAN",
    "id": 7749041,
    "region": "MERU",
    "assign": "RIPPLES INTERNATIONAL -KITHOKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 981,
    "name": "MURIUKI BENSON MURIUKI",
    "id": 31453575,
    "region": "MERU",
    "assign": "RIPPLES INTERNATIONAL -KITHOKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 982,
    "name": "GITONGA BENARD",
    "id": 13754800,
    "region": "MERU",
    "assign": "RIPPLES INTERNATIONAL -KITHOKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 983,
    "name": "KARANI CHARLES",
    "id": 11056202,
    "region": "MERU",
    "assign": "RISE UP INVESTMENTS(OFFICE MERU)",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 984,
    "name": "MUREGA ELIAS MUCHUIRI",
    "id": "",
    "region": "MERU",
    "assign": "RIVERSIDE -ESTATE MAKUTANO 1",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 985,
    "name": "NKATHA BRENDA",
    "id": "",
    "region": "MERU",
    "assign": "RIVERSIDE -ESTATE MAKUTANO 1",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 986,
    "name": "MWENDA JONATHAN",
    "id": 26953010,
    "region": "MERU",
    "assign": "RIVERSIDE -ESTATE MAKUTANO 2",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 987,
    "name": "KAARI CHRISTINE RIUNGU",
    "id": 21434065,
    "region": "MERU",
    "assign": "RIVERSIDE -ESTATE MAKUTANO 2",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 988,
    "name": "GERALD MUCHEE",
    "id": 3646349,
    "region": "MERU",
    "assign": "RIVERSIDE -MID WAY ESTATE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 989,
    "name": "GITARI JACKSON",
    "id": 30841810,
    "region": "NAIROBI",
    "assign": "RWARE HIGH SCHOOL -RWARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 990,
    "name": "MWANZIA JULIUS SILA",
    "id": 27944739,
    "region": "NAIROBI",
    "assign": "RWARE HIGH SCHOOL -RWARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 991,
    "name": "KIMANI JACKSON GITARI",
    "id": 30941810,
    "region": "NAIROBI",
    "assign": "RWARE HIGH SCHOOL -RWARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 992,
    "name": "NKUNJA JAPHET",
    "id": 25887151,
    "region": "MERU",
    "assign": "SILVER SPREAD TRADE CENTRE -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 993,
    "name": "MUCHAI JOSHUA",
    "id": 10149006,
    "region": "MERU",
    "assign": "SILVER SPREAD TRADE CENTRE -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 994,
    "name": "GIKUNDA ANGELO",
    "id": 8311923,
    "region": "MERU",
    "assign": "SILVER SPREAD TRADE CENTRE -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 995,
    "name": "MAULU STANLEY",
    "id": 20754209,
    "region": "NANYUKI",
    "assign": "SINCOE DAIRY",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 996,
    "name": "GABRIEL CAROLINE WAIRIMU",
    "id": 23654968,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 997,
    "name": "NJERU KAARIA THOMAS",
    "id": 23432721,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 998,
    "name": "MATI LAWRENCE ZAKAYO",
    "id": 4450802,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 999,
    "name": "GITONGA MAWIRA MICHAEL",
    "id": 33079227,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1000,
    "name": "MUTUNGA JOSEPH",
    "id": 20110474,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1001,
    "name": "WAKESHO PASCALINA",
    "id": 34038800,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1002,
    "name": "KIBET VIDELIS",
    "id": 37154883,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1003,
    "name": "ADO HUSSEIN MOHAMMED",
    "id": 24649682,
    "region": "ISIOLO",
    "assign": "SOLUTION SACCO -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1004,
    "name": "LEMONGI MICHAEL",
    "id": 23740692,
    "region": "ISIOLO",
    "assign": "SOLUTION SACCO -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1005,
    "name": "SUKUTA ROSEPAULA",
    "id": 34345458,
    "region": "ISIOLO",
    "assign": "SOLUTION SACCO -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1006,
    "name": "MUTHOMI JOHN",
    "id": "",
    "region": "ISIOLO",
    "assign": "SOLUTION SACCO -ISIOLO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1007,
    "name": "GITONGA ANTONY",
    "id": 24957210,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -KATHWANA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1008,
    "name": "KINYUA JOSPHAT MUTWIRI",
    "id": 33439730,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -KATHWANA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1009,
    "name": "MARTIN MUTHENGI NJERU",
    "id": 32513880,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -KATHWANA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1010,
    "name": "MUTAI IRENE JEPKOSGEI",
    "id": 26627928,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -KATHWANA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1011,
    "name": "KABIRITHU ROBIN MITHIKA",
    "id": 38881708,
    "region": "LAARE/MAUA",
    "assign": "SOLUTION SACCO -LAARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1012,
    "name": "GICHUNGE PETER",
    "id": 23092471,
    "region": "LAARE/MAUA",
    "assign": "SOLUTION SACCO -LAARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1013,
    "name": "KELVIN MUGAMBI",
    "id": 36990688,
    "region": "LAARE/MAUA",
    "assign": "SOLUTION SACCO -LAARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1014,
    "name": "MUTEGI ABRAHAM",
    "id": 34827625,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -MARIMANTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1015,
    "name": "MURIUNGI DANIEL MWANGA",
    "id": 9907083,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -MARIMANTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1016,
    "name": "KIMATHI ELIAS",
    "id": 34372992,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -MARIMANTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1017,
    "name": "NDEGWA RISPER NJERI",
    "id": 35086718,
    "region": "CHUKA",
    "assign": "SOLUTION SACCO -MARIMANTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1018,
    "name": "NKATHA ALICE",
    "id": 28646128,
    "region": "LAARE/MAUA",
    "assign": "SOLUTION SACCO -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1019,
    "name": "M'IMARA BERNARD BAARIU",
    "id": 14446454,
    "region": "LAARE/MAUA",
    "assign": "SOLUTION SACCO -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1020,
    "name": "MWENDA JOHN",
    "id": 22434681,
    "region": "LAARE/MAUA",
    "assign": "SOLUTION SACCO -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1021,
    "name": "MURANGIRII JOHN KINOTI",
    "id": 37016417,
    "region": "LAARE/MAUA",
    "assign": "SOLUTION SACCO -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1022,
    "name": "AKWALU PAULINE GACHERI",
    "id": 23411551,
    "region": "MERU",
    "assign": "SOLUTION SACCO -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1023,
    "name": "CHERUIYOT FESTUS",
    "id": 31224107,
    "region": "MERU",
    "assign": "SOLUTION SACCO -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1024,
    "name": "OSAKULO BESTINE KHANYELEHI",
    "id": 33472548,
    "region": "MERU",
    "assign": "SOLUTION SACCO -MIKINDURI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1025,
    "name": "MWIRIGI LANMARK",
    "id": 38135576,
    "region": "MERU",
    "assign": "SOLUTION SACCO -MIKINDURI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1026,
    "name": "MUNGIRIA ALFRED MURIUKI",
    "id": 13873798,
    "region": "MERU",
    "assign": "SOLUTION SACCO -MIKINDURI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1027,
    "name": "MOGOI ZIRUEL OROKO",
    "id": "",
    "region": "NAIROBI",
    "assign": "SOLUTION SACCO -NAIROBI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1028,
    "name": "NYONGESA EDWIN WANYONYI",
    "id": 26851209,
    "region": "NAIROBI",
    "assign": "SOLUTION SACCO -NAIROBI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1029,
    "name": "BEATRICE AWUOR",
    "id": 34781480,
    "region": "NAIROBI",
    "assign": "SOLUTION SACCO -NAIROBI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1030,
    "name": "APUDO CHARLES OCHIENG'",
    "id": 12601996,
    "region": "NAIROBI",
    "assign": "SOLUTION SACCO -NAIROBI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1031,
    "name": "KOISA STEPHEN SAIGULU",
    "id": 37641938,
    "region": "NAIROBI",
    "assign": "SOLUTION SACCO -NAIROBI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1032,
    "name": "MUCHOMBA JAMES MUTUGI",
    "id": 23113384,
    "region": "MERU",
    "assign": "SOLUTION SACCO -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1033,
    "name": "KIUGU ROSE KATHURE",
    "id": "",
    "region": "MERU",
    "assign": "SOLUTION SACCO -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1034,
    "name": "MUROKI GEOFFREY",
    "id": 36013271,
    "region": "MERU",
    "assign": "SOLUTION SACCO -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1035,
    "name": "KABETE GODFFREY GITONGA",
    "id": 34315608,
    "region": "MERU",
    "assign": "SOLUTION SACCO -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1036,
    "name": "KENNETH MWENDA KIRIMI",
    "id": 11327012,
    "region": "MERU",
    "assign": "SOLUTION SACCO -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1037,
    "name": "KARAMBU NICHOLUS BUNDI",
    "id": 29700062,
    "region": "NANYUKI",
    "assign": "SOLUTION SACCO -TIMAU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1038,
    "name": "MUREA JACKSON KIRIMI",
    "id": 27951892,
    "region": "NANYUKI",
    "assign": "SOLUTION SACCO -TIMAU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1039,
    "name": "GATWIRI JUSTER",
    "id": 35648171,
    "region": "NANYUKI",
    "assign": "SOLUTION SACCO -TIMAU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1040,
    "name": "MWATHA ZAKAYO MAINA",
    "id": 34308209,
    "region": "NANYUKI",
    "assign": "SOLUTION SACCO -TIMAU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1041,
    "name": "MUSILI ANASTACIA MUENI",
    "id": 26822684,
    "region": "MWINGI",
    "assign": "SOLUTION SACCO -TSEIKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1042,
    "name": "MUTISYA NICHOLAS MUIMI",
    "id": 10323024,
    "region": "MWINGI",
    "assign": "SOLUTION SACCO -TSEIKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1043,
    "name": "NZARU SAMSON MUNYOKI",
    "id": 11721367,
    "region": "MWINGI",
    "assign": "SOLUTION SACCO -TSEIKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1044,
    "name": "MUTISYA KAIRU MUTISYA",
    "id": "",
    "region": "MWINGI",
    "assign": "SOLUTION SACCO -TSEIKURU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1045,
    "name": "DIRA WARE",
    "id": 29056394,
    "region": "MARSABIT",
    "assign": "SOLUTION SACCO-MARSABIT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1046,
    "name": "KULI ABDI DUBA",
    "id": 26046165,
    "region": "MARSABIT",
    "assign": "SOLUTION SACCO-MARSABIT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1047,
    "name": "KATELO WARIO JARSO",
    "id": 21625570,
    "region": "MARSABIT",
    "assign": "SOLUTION SACCO-MARSABIT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1048,
    "name": "DULACHA GALGALO JABA",
    "id": 36425770,
    "region": "MARSABIT",
    "assign": "SOLUTION SACCO-MARSABIT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1049,
    "name": "LEKOYAYA ISAAC LOTEKU",
    "id": 25085235,
    "region": "NYERI",
    "assign": "SOUTH TETU GIRLS SEC SCH -NYERI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1050,
    "name": "MWANIKI CATHERINE WAIRIMU",
    "id": 27944369,
    "region": "NYERI",
    "assign": "SOUTH TETU GIRLS SEC SCH -NYERI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1051,
    "name": "NJERU GEOFFREY",
    "id": 11697338,
    "region": "CHUKA",
    "assign": "ST ANNE MISSION HOSPITAL -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1052,
    "name": "KIRIA IRAMBU",
    "id": 10148516,
    "region": "CHUKA",
    "assign": "ST ANNE MISSION HOSPITAL -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1053,
    "name": "RUTERE JAPHET MWITI",
    "id": 12493671,
    "region": "CHUKA",
    "assign": "ST ANNE MISSION HOSPITAL -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1054,
    "name": "GATWIRI PURITY",
    "id": 24238568,
    "region": "CHUKA",
    "assign": "ST ANNE MISSION HOSPITAL -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1055,
    "name": "MARETE ERICK MWITI",
    "id": 22586138,
    "region": "CHUKA",
    "assign": "ST ANNE MISSION HOSPITAL -CHUKA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1056,
    "name": "BARASA STEPHEN ADUKA",
    "id": 3654436,
    "region": "NAKURU",
    "assign": "ST ANTHONY HEALTH CARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1057,
    "name": "OLELA LAVENDER ADHIAMBO",
    "id": 35112385,
    "region": "NAKURU",
    "assign": "ST ANTHONY HEALTH CARE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1058,
    "name": "KENDI MILLICENT",
    "id": 29052870,
    "region": "MERU",
    "assign": "ST MICHAELS -KAAGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1059,
    "name": "KIRICHA WILSON",
    "id": 28797926,
    "region": "CHUKA",
    "assign": "ST ORSOLA CATHOLIC HOSPITAL -MATERI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1060,
    "name": "GITUMA ELIJAH MUGAMBI",
    "id": 13617237,
    "region": "CHUKA",
    "assign": "ST ORSOLA CATHOLIC HOSPITAL -MATERI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1061,
    "name": "MUTHEE JUSTIN KINYUA",
    "id": 28197194,
    "region": "CHUKA",
    "assign": "ST ORSOLA CATHOLIC HOSPITAL -MATERI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1062,
    "name": "MWITI SIMON MBOGORI",
    "id": 16001144,
    "region": "CHUKA",
    "assign": "ST ORSOLA CATHOLIC HOSPITAL -MATERI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1063,
    "name": "MUTHONI MILCAH MUTEGI",
    "id": 23838503,
    "region": "CHUKA",
    "assign": "ST ORSOLA CATHOLIC HOSPITAL -MATERI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1064,
    "name": "NTHIGA CATHERINE NJIRA",
    "id": "",
    "region": "CHUKA",
    "assign": "ST ORSOLA CATHOLIC HOSPITAL -MATERI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1065,
    "name": "MWORIA JEREMIAH",
    "id": 33700400,
    "region": "MERU",
    "assign": "STAGE MARKET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1066,
    "name": "MUTIRIA JOSPHAT KINOTI",
    "id": 34380772,
    "region": "MERU",
    "assign": "SUNSHINE HOTEL -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1067,
    "name": "NDIGA ANTONY MUTUMA",
    "id": 36079766,
    "region": "MERU",
    "assign": "TALYA SUITE -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1068,
    "name": "MURIUNGI PATRICK MUGAMBI",
    "id": 22309648,
    "region": "MERU",
    "assign": "TARMOHAMED AYUB -RESIDENCE MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1069,
    "name": "KAIGONGI ABRAHAM LINTURI",
    "id": 23761020,
    "region": "MERU",
    "assign": "TARMOHAMED AYUB -TAWAKAL SHOPPING CENTER",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1070,
    "name": "GIKUNDI CYPRIAN MWERIRIA",
    "id": "",
    "region": "MERU",
    "assign": "TARMOHAMED AYUB -TAWAKAL SHOPPING CENTER",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1071,
    "name": "SOLOMON JULIUS MWITI",
    "id": 7010087,
    "region": "MERU",
    "assign": "TASHA ENTERPRISES (K) LTD -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1072,
    "name": "KUBAI GODFREY KINYUA",
    "id": 35203811,
    "region": "MERU",
    "assign": "TENDER BRAINS -NCHIRU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1073,
    "name": "NYONGESA JACKLYNE MULONGO",
    "id": 30422589,
    "region": "MERU",
    "assign": "TENDER BRAINS -NCHIRU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1074,
    "name": "MEROKA ERICK MIRERA",
    "id": 31119778,
    "region": "CHUKA",
    "assign": "THARAKA UNIVERSITY -GATUNGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1075,
    "name": "KARIMI REGINA",
    "id": 23802007,
    "region": "CHUKA",
    "assign": "THARAKA UNIVERSITY -GATUNGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1076,
    "name": "WEKESA LEWIS CHENGE",
    "id": 35640925,
    "region": "CHUKA",
    "assign": "THARAKA UNIVERSITY -GATUNGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1077,
    "name": "MUGAO JOSEPH MAKEMBO",
    "id": 13353227,
    "region": "CHUKA",
    "assign": "THARAKA UNIVERSITY -GATUNGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1078,
    "name": "KANYARU ALICE MUTHONI",
    "id": 25286144,
    "region": "CHUKA",
    "assign": "THARAKA UNIVERSITY -GATUNGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1079,
    "name": "KUBIU PETER KIAMBATI",
    "id": 28700948,
    "region": "NYERI",
    "assign": "THE AVENUE MEDICAL DIAGNOSIS-NYERI [4977]",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1080,
    "name": "WACHIRA NAOMI WANGARI",
    "id": 31170001,
    "region": "NYERI",
    "assign": "THE AVENUE MEDICAL DIAGNOSIS-NYERI [4977]",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1081,
    "name": "NTHIGAI FLORA KAWIRA",
    "id": 37233532,
    "region": "MERU",
    "assign": "THE AVENUE MEDICAL DIAGNOSTIC CENTRE -MIKINDURI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1082,
    "name": "NAFTARY AYUB MUTETHIA",
    "id": 37566916,
    "region": "MERU",
    "assign": "THE AVENUE MEDICAL DIAGNOSTIC CENTRE -MIKINDURI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1083,
    "name": "KHAEMBA RINESTONE WAFULA",
    "id": 31939893,
    "region": "WESTERN",
    "assign": "THE HOPKINS CRESCENT HOSPITALS",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1084,
    "name": "MUTHAURA SOLOMON MMURAA",
    "id": 32979680,
    "region": "MERU",
    "assign": "THE RAAMS PLACE -KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1085,
    "name": "DAVID WANJALA NYONGESA",
    "id": 36820724,
    "region": "MERU",
    "assign": "THE RAAMS PLACE -KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1086,
    "name": "KABURIA JOHN",
    "id": 12617480,
    "region": "MERU",
    "assign": "THE RIVERS COURT -KIRUNG'A",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1087,
    "name": "GAICHU JEREMAH NJAGI",
    "id": 12733095,
    "region": "MERU",
    "assign": "TIMES U SACCO -GITHONGO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1088,
    "name": "KAMATHI VICTORY",
    "id": 34464067,
    "region": "MERU",
    "assign": "TIMES U SACCO -GITHONGO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1089,
    "name": "KIRIGU DICKSON MWANDIKI",
    "id": "",
    "region": "MERU",
    "assign": "TIMES U SACCO -KARIENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1090,
    "name": "NABIKI DANSON AMOS",
    "id": 34730121,
    "region": "MERU",
    "assign": "TIMES U SACCO -KARIENE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1091,
    "name": "MURITHI NELSON KABURU",
    "id": 35229995,
    "region": "MERU",
    "assign": "TIMES U SACCO -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1092,
    "name": "PETER MURIUNGI",
    "id": 37905949,
    "region": "MERU",
    "assign": "TIMES U SACCO -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1093,
    "name": "KIBAARA ASHFORD MARIGI",
    "id": 31113823,
    "region": "MERU",
    "assign": "TIMES U SACCO -MITUNGUU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1094,
    "name": "KARUNDU FRANCIS MWITI",
    "id": 27198942,
    "region": "MERU",
    "assign": "TIMES U SACCO -MITUNGUU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1095,
    "name": "KAWIRA JOSEPHINE",
    "id": 7652,
    "region": "MERU",
    "assign": "TIMES U SACCO -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1096,
    "name": "MURUNGI JOHN",
    "id": 32541788,
    "region": "MERU",
    "assign": "TIMES U SACCO -NKUBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1097,
    "name": "JOHN JULIUS KOBIA",
    "id": 33617150,
    "region": "MERU",
    "assign": "UNIQUE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1098,
    "name": "MUCERU CHARITY KARIMI",
    "id": 38637558,
    "region": "MERU",
    "assign": "VICKSTAR BAKERY -GITIMBINE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1099,
    "name": "MWITI KENNETH",
    "id": 32106886,
    "region": "MERU",
    "assign": "VICKSTAR BAKERY -GITIMBINE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1100,
    "name": "MWENDA HARUN MURONGA",
    "id": 14414614,
    "region": "MERU",
    "assign": "VICKSTAR BAKERY -GITIMBINE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1101,
    "name": "MITHANA TIMOTHY MUKARIA",
    "id": 34999536,
    "region": "MERU",
    "assign": "VIRGO BAR AND RESTAURANT -MERU TOWN",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1102,
    "name": "LUKA GITONGA",
    "id": 7446515,
    "region": "MERU",
    "assign": "WANJUGI STORES -GITIMBINE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1103,
    "name": "MIRITI WILLIAM",
    "id": 8614032,
    "region": "LAARE/MAUA",
    "assign": "WANJUGI STORES -MAUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1104,
    "name": "MUTHONI PAMELA MUTHONI",
    "id": 23584000,
    "region": "EMBU",
    "assign": "WATER RESOURCE AUTHORITY- EMBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1105,
    "name": "KANG'I DANIEL MUTHOMI",
    "id": 34793382,
    "region": "EMBU",
    "assign": "WATER RESOURCE AUTHORITY- EMBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1106,
    "name": "KYUTI JOHN MUEMA",
    "id": 37819838,
    "region": "EMBU",
    "assign": "WATER RESOURCE AUTHORITY- EMBU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1107,
    "name": "MUCHIRAU PERIS RUGURU",
    "id": 22906088,
    "region": "KERUGOYA",
    "assign": "WATER RESOURCES AUTHORITY - KERUGOYA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1108,
    "name": "NGARI BENSON MURITHI",
    "id": 13848476,
    "region": "KERUGOYA",
    "assign": "WATER RESOURCES AUTHORITY - KERUGOYA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1109,
    "name": "MUGO PATRICK MACHARIA",
    "id": 24778177,
    "region": "KERUGOYA",
    "assign": "WATER RESOURCES AUTHORITY - KERUGOYA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1110,
    "name": "KIBIWOTT WILBON",
    "id": 30940396,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -ELDORET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1111,
    "name": "BENARD KIPKEMEI",
    "id": 35818541,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -ELDORET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1112,
    "name": "MUGE SHADRACK KIPKOECH",
    "id": 33217169,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -ELDORET",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1113,
    "name": "MARANI STEPHEN MASIKA",
    "id": 32953927,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KAKAMEGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1114,
    "name": "OTULA AUDREY NAFULA",
    "id": 26678730,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KAKAMEGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1115,
    "name": "OPATI MORFFAT OSALE",
    "id": 21079260,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KAKAMEGA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1116,
    "name": "KIPKOECH JAPHETH",
    "id": "",
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KERICHO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1117,
    "name": "CHEPKORIR EVERLINE",
    "id": 246000351,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KERICHO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1118,
    "name": "KIPROTICH HILLARY",
    "id": 34320054,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KERICHO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1119,
    "name": "GILBERT KIBET KORIR",
    "id": 32046287,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KERICHO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1120,
    "name": "OMBUI LAMECH MASEA",
    "id": 31108339,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISII",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1121,
    "name": "MASONGA JAVAN OMBOSA",
    "id": 9976810,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISII",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1122,
    "name": "MAKOME LAWRENCE",
    "id": 12898073,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISII",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1123,
    "name": "OBONDO LEONARD",
    "id": 4041552,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISUMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1124,
    "name": "OBETELE HARON MAMAI",
    "id": 29319269,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISUMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1125,
    "name": "OMOL GEORGE OCHIENG'",
    "id": 20211457,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISUMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1126,
    "name": "ARODI JACOB OUMA",
    "id": 20909845,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISUMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1127,
    "name": "MIRUKA RICHARD ONYANGO MIRUKA",
    "id": 14453393,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISUMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1128,
    "name": "OBONDO CAROLINE ANYANGO",
    "id": 24945278,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISUMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1129,
    "name": "ODEKE LAWRENCE OSIEL",
    "id": 10628332,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISUMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1130,
    "name": "PHILLIP ONYANGO OKIDI",
    "id": 12671843,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISUMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1131,
    "name": "OWINO WILLIAM NDISO",
    "id": 25390320,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KISUMU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1132,
    "name": "WEPUKHULU CAROLYNE NALIAKA",
    "id": 24822475,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KITALE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1133,
    "name": "KIPKEMBOI PHILIP TOO",
    "id": 7444457,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KITALE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1134,
    "name": "OKANYA SIMIYU",
    "id": 10705465,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -KITALE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1135,
    "name": "MWANGI EUNICE WAMBUI",
    "id": 23850176,
    "region": "MURANGA",
    "assign": "WATER RESOURCES AUTHORITY -MURANG'A",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1136,
    "name": "KIRORI ISAAK KANYI",
    "id": 29402128,
    "region": "MURANGA",
    "assign": "WATER RESOURCES AUTHORITY -MURANG'A",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1137,
    "name": "MWANGI TITUS MUTURI",
    "id": 23106279,
    "region": "MURANGA",
    "assign": "WATER RESOURCES AUTHORITY -MURANG'A",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1138,
    "name": "KAPARO PETER",
    "id": 371786662,
    "region": "NANYUKI",
    "assign": "WATER RESOURCES AUTHORITY -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1139,
    "name": "KABILILE STELLA SISIA",
    "id": 28060335,
    "region": "NANYUKI",
    "assign": "WATER RESOURCES AUTHORITY -NANYUKI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1140,
    "name": "LEMARKAT ELIJAH SAIKOBI",
    "id": 38755294,
    "region": "NANYUKI",
    "assign": "WATER RESOURCES AUTHORITY -RUMURUTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1141,
    "name": "LEKALJA SAININGO",
    "id": 36559011,
    "region": "NANYUKI",
    "assign": "WATER RESOURCES AUTHORITY -RUMURUTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1142,
    "name": "ROTICH ELIJA KIPKORIR",
    "id": 25812816,
    "region": "NANYUKI",
    "assign": "WATER RESOURCES AUTHORITY -RUMURUTI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1143,
    "name": "OKUMU BENJAMIN",
    "id": 10706404,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -SIAYA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1144,
    "name": "WANYONYI DUNCAN",
    "id": 32598314,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -SIAYA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1145,
    "name": "OWUOR JOAN AWINO",
    "id": 32288430,
    "region": "WESTERN",
    "assign": "WATER RESOURCES AUTHORITY -SIAYA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1146,
    "name": "JILLO AHMED SOMAN",
    "id": 26664392,
    "region": "GARISA",
    "assign": "WATER RESOURCES AUTHORITY-GARISA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1147,
    "name": "KITUI REGINA KAKI",
    "id": 26118180,
    "region": "GARISA",
    "assign": "WATER RESOURCES AUTHORITY-GARISA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1148,
    "name": "OMAR KUNO OMAR KUNO ADEN",
    "id": 25016610,
    "region": "GARISA",
    "assign": "WATER RESOURCES AUTHORITY-GARISA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1149,
    "name": "SAMMY VICTOR WAMBUA",
    "id": 35325517,
    "region": "KITUI",
    "assign": "WATER RESOURCES AUTHORITY-KITUI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1150,
    "name": "JOHN NICHOLAS MUSEMBI",
    "id": 35865393,
    "region": "KITUI",
    "assign": "WATER RESOURCES AUTHORITY-KITUI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1151,
    "name": "KIMANZI EDWIN MWONGELA",
    "id": 33677611,
    "region": "KITUI",
    "assign": "WATER RESOURCES AUTHORITY-KITUI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1152,
    "name": "KYOA MUSEE",
    "id": 13740607,
    "region": "KITUI",
    "assign": "WATER RESOURCES AUTHORITY-KITUI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1153,
    "name": "LETUPEYA LILU",
    "id": 25056394,
    "region": "MARSABIT",
    "assign": "WATER RESOURCES AUTHORITY-MARSABIT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1154,
    "name": "OMIENO GODRICK MULUNDA",
    "id": 13865510,
    "region": "MARSABIT",
    "assign": "WATER RESOURCES AUTHORITY-MARSABIT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1155,
    "name": "GODANA ROSE RUFO",
    "id": 30083717,
    "region": "MARSABIT",
    "assign": "WATER RESOURCES AUTHORITY-MARSABIT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1156,
    "name": "HUQA GUYU GODANA",
    "id": 31562346,
    "region": "MARSABIT",
    "assign": "WATER RESOURCES AUTHORITY-MARSABIT",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1157,
    "name": "KITHINJI GODFFREY KIMATHI",
    "id": 26862106,
    "region": "MERU",
    "assign": "WATER RESOURCES AUTHORITY-MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1158,
    "name": "KAJUJU ZIPPORAH",
    "id": 21487445,
    "region": "MERU",
    "assign": "WATER RESOURCES AUTHORITY-MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1159,
    "name": "MUNYA PETER MUTHURI",
    "id": 26363712,
    "region": "MERU",
    "assign": "WATER RESOURCES AUTHORITY-MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1160,
    "name": "BARASA CELESTINE CHEROP",
    "id": 35568958,
    "region": "MERU",
    "assign": "WATER RESOURCES AUTHORITY-MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1161,
    "name": "GITI KENETH KINOTI",
    "id": 34823764,
    "region": "MERU",
    "assign": "WATER RESOURCES AUTHORITY-MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1162,
    "name": "KIMATHI PETER MWORIA",
    "id": 30292929,
    "region": "MERU",
    "assign": "WATER RESOURCES AUTHORITY-MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1163,
    "name": "ADAN BISHAR AHMED",
    "id": "",
    "region": "MANDERA",
    "assign": "WATER RESOURCES AUTHORTY - MANDERA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1164,
    "name": "ALIO ABDULLAHI",
    "id": 6410160,
    "region": "MANDERA",
    "assign": "WATER RESOURCES AUTHORTY - MANDERA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1165,
    "name": "MOHAMMED ISSACK MOHAMMED AHMED",
    "id": 21565042,
    "region": "MANDERA",
    "assign": "WATER RESOURCES AUTHORTY - MANDERA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1166,
    "name": "KINOTI BENSON MWONGERA",
    "id": 34908011,
    "region": "MERU",
    "assign": "WEBSTAR SOLUTIONS-KIBUI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1167,
    "name": "SIMON JULIUS MWITI",
    "id": "",
    "region": "MERU",
    "assign": "WESTWIND HOTEL -MAKUTANO",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1168,
    "name": "NDEGWA ISAAC NJERI",
    "id": 37104168,
    "region": "MERU",
    "assign": "WESTWIND HOTEL -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1169,
    "name": "NJAGI GIDEON KIMATHI",
    "id": 35518946,
    "region": "MERU",
    "assign": "WESTWIND HOTEL -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1170,
    "name": "IBAYA BONFACE MURITHI",
    "id": 36472189,
    "region": "MERU",
    "assign": "WESTWIND HOTEL -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1171,
    "name": "MUTUMA PATRICK",
    "id": 32861427,
    "region": "MERU",
    "assign": "WESTWIND HOTEL -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1172,
    "name": "KOOME WILLIAM",
    "id": 33945646,
    "region": "MERU",
    "assign": "WESTWIND HOTEL -MERU",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1173,
    "name": "MUTHOMI JANET",
    "id": "",
    "region": "MERU",
    "assign": "WHITE BIRD MILLERS-KIIRUA",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1174,
    "name": "MOLONKO DANIEL NTOKOIWUAN",
    "id": 38454507,
    "region": "MERU",
    "assign": "YUNUS KAGUMA RESIDENCE",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1175,
    "name": "NJERI DOUGLAS MWANGI",
    "id": 27134259,
    "region": "NYERI",
    "assign": "ZINC HOTEL -MUKURWEINI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1176,
    "name": "MWITI MORRIS MWORIA",
    "id": 30405199,
    "region": "NYERI",
    "assign": "ZINC HOTEL -MUKURWEINI",
    "pfn": "",
    "company": "pelt"
  },
  {
    "docID": 1177,
    "name": "KIMTAI WILLINGTON KIPYEGON",
    "id": "",
    "region": "",
    "assign": "",
    "pfn": "",
    "company": "pelt"
  }
   ]
}

 """;
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


 Map<String, dynamic> myMap = jsonDecode(jsonStr);
 Future<void> _loginCommand() async {
   var myArray = myMap['results'];
   print('Loading');
   for(int i=0; i<myArray.length; i++){
     CollectionReference reference = Firestore.instance.collection('issuance');

     await reference.add({
       'date': DateFormat(' yyyy- MM - dd').format(DateTime.now()),
       "name": myArray[i]['name'],
       'id': myArray[i]['id'].toString(),
       'company': 'pelt',
       'assign': myArray[i]['assign'],
       'region': myArray[i]['region'],
       'pfn': myArray[i]['pfn'],
       "uniform": {},
     });

     Firestore.instance.collection('company').document('pelt').updateData({
       'staff' : FieldValue.increment(1),
     });

   }
   _showRequest();
 }
 void _showRequest() {
   // flutter defined function
   showDialog(
     context: context,
     builder: (BuildContext context) {
       // return object of type Dialog
       return AlertDialog(
         content: new Text("Your data has been added"),
         actions: <Widget>[
           // usually buttons at the bottom of the dialog
           new FlatButton(
             child: new Text("close"),
             onPressed: () {
               Navigator.of(context).pop();
               Navigator.of(context).pop();
             },
           ),
         ],
       );
     },
   );
 }



 final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    _messaging.subscribeToTopic('procurement');
    super.initState();
    _messaging.getToken().then((token) {
      print(token);
    });
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );

        print(message['notification']['title']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffC3B1E1),
        appBar: new AppBar(
          title: new Text("INVENTORY"),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: const Color(0xffC3B1E1),
        ),
        body:SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => inStock()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.arrow_downward_sharp),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Text("Stock-In"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => issue(

                        )));
                  },
                  child: new CircleAvatar(
                    maxRadius: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.arrow_upward_sharp),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Text("Stock-Out"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(
              height: 20.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => Return()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.exit_to_app),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Text("Clearance"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => Replace()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.autorenew_rounded),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Text("Replacement"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(
              height: 70.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shadowColor: Colors.black12,
                color: Colors.white70,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,35.0,8.0,35.0),
                  child: StreamBuilder(
                      stream: Firestore.instance.collection("company").document('pelt').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: new ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (BuildContext context, int index) {
                                    return new IntrinsicHeight(
                                        child: new Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                           GestureDetector(
                                              onTap: (){
                                                Navigator.of(context).push(new CupertinoPageRoute(
                                                    builder: (context) => Suppliers()));
                                                },
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(snapshot.data['suppliers'
                                                    ] > 100 ? '100+': '${snapshot.data['suppliers'
                                                      ].toString()}+',
                                                      style: new TextStyle(
                                                        fontSize: 30.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),),
                                                    Text('SUPPLIER \n Reports'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(color: Colors.purpleAccent),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.of(context).push(new CupertinoPageRoute(
                                                    builder: (context) => issuanceReport()));
                                              },
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(snapshot.data['issuance'
                                                    ] > 100 ? '100+': '${snapshot.data['issuance'
                                                    ].toString()}+',
                                                      style: new TextStyle(
                                                        fontSize: 30.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),),
                                                    Text('ISSUANCE \n Reports'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(color: Colors.purpleAccent),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.of(context).push(new CupertinoPageRoute(
                                                    builder: (context) => Deductions()));
                                              },
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(snapshot.data['deductions'
                                                    ] > 100 ? '100+': '${snapshot.data['deductions'
                                                    ].toString()}+',
                                                      style: new TextStyle(
                                                        fontSize: 30.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),),
                                                    Text('DEDUCTIONS \n Reports'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Text('');
                        }
                      }),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
