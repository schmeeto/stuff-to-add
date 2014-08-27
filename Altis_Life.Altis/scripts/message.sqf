/*
Repeat messages on server
advertise the server to f***
by: [AP] Jonny

desc:
Chucks out a hint every 6 mins advertising the server and that
*/


_text1 = parseText format ["<t color='#00E855' size='1.5'>ALL COPS MUST BE IN TEAMSPEAK3     [IP:5.152.219.146]</t>"];
_text2 = parseText format ["<t color='#00E855' size='1.5'>PLEASE SYNC DATA BEFORE LEAVING!</t>"];
_text3 = parseText format ["<t color='#00E855' size='1.5'>PLEASE BE PATIENT, THIS SERVER WILL KEEP IMPROVING</t>"];
_text4 = parseText format ["<t color='#00E855' size='1.5'>WE HAVE ONLY 3 RULES- NO VDM! ALL TOWNS ARE SAFE ZONES! ROLE PLAY A MUST! ENJOY</t>"];
_text5 = parseText format ["<t color='#00E855' size='1.5'>JOIN US ON TEAMSPEAK3!       [IP:5.152.219.146]</t>"];
_text6 = parseText format ["<t color='#00E855' size='1.5'>RESTARTS =6 HOURS 6AM,12PM,6PM,12AM</t>"];
_text7 = parseText format ["<t color='#00E855' size='1.5'>Signup at our Website - WWW.ELITEGAMINGUK.COM</t>"];

while {true} do
{
sleep 360;
hint _text1;
sleep 360;
hint _text2;
sleep 360;
hint _text3;
sleep 360;
hint _text4;
sleep 360;
hint _text5;
/*
sleep 360;
hint _text6;
*/
};

