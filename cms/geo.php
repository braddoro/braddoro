<?php
$s_key = "ABQIAAAA_9mbKT9DXEcGX7EA4eJmphRHzMeW5o0Dcduy0n8ATOI48L8-bRQeqZiODwtLn5LjuMnVkbXOqxwCcA";
$s_address = "http://maps.google.com/maps/geo?q=2535+Clover+Road+NW,+Concord,+NC,+28027&output=xml&key=$s_key";
//echo htmlspecialchars(file_get_contents($s_address));
$s_page = file_get_contents($s_address);
$o_xml = new SimpleXMLElement($s_page);
$s_coordinates = $o_xml->Response->Placemark->Point->coordinates;
$i_comma = strpos($s_coordinates,",",0);
$longitude = substr($s_coordinates,0,$i_comma-1);
$latitude = substr($s_coordinates,$i_comma+1,strlen($s_coordinates)-$i_comma);
echo 'latitude '.$latitude.'<br />';
echo 'longitude '.$longitude.'<br />';
//http://code.google.com/apis/maps/documentation/introduction.html
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <script src="http://maps.google.com/maps?file=api&v=1&key=ABQIAAAA_9mbKT9DXEcGX7EA4eJmphRHzMeW5o0Dcduy0n8ATOI48L8-bRQeqZiODwtLn5LjuMnVkbXOqxwCcA" type="text/javascript">
    </script>
  </head>
  <body>
    <div id="map" style="width: 400px; height: 300px"></div>
    <script type="text/javascript">
    //<![CDATA[
    var map = new GMap(document.getElementById("map"));
    map.centerAndZoom(
    new GPoint(<?php echo $longitude;?>, <?php echo $latitude;?>), 3);
    var point = new GPoint(<?php echo $longitude;?>, <?php echo $latitude;?>);
    var marker = new GMarker(point);
    map.addOverlay(marker);
    map.addControl(new GLargeMapControl());
    map.setMapType(G_SATELLITE_3D_MAP);
    //]]>
    </script>
  </body>
</html>