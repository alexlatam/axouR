<?php
$ch=curl_init();
curl_setopt($ch,CURLOPT_URL,'https://s3.amazonaws.com/dolartoday/data.json');
curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
$result=curl_exec($ch);
curl_close($ch);
$consulta=json_decode($result);
$dolar=@$consulta->USD->transferencia;

//$dolar=15000;
