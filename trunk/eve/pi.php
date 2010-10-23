<?php
include "_functions.php";
header("Cache: private");
$s_filename = basename(__FILE__);
$s_pageName = "Planetary Interaction";
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$s_html = "";
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(__LINE__,mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(__LINE__,mysql_error());}
$s_sql = "select distinct system, planet from braddoro.dyn_intel_pos_list where constellation = 'Ombil' order by system, planet;";
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(__LINE__,mysql_error());}
$s_sel = "<select id='system' name='system' onchange='js_getplanets(this.value);'>";
$i_key = 0;
$s_system_hold = "";
$s_jsArray = "var a_location = new Array();\n";
while ($rowData = mysql_fetch_row($q_data))
	{
	$s_system = trim($rowData[0]);
	$i_planet = trim($rowData[1]);
	$s_jsArray .= 'a_location['.$i_key.'] = new Array(2);'."\n";
	$s_jsArray .= 'a_location['.$i_key.'][0] = "'.$s_system.'";'."\n";
	$s_jsArray .= 'a_location['.$i_key.'][1] = "'.$i_planet.'";'."\n";
	$a_location[$i_key] = array("system" => $s_system, "planet" => $i_planet);
	if ($s_system_hold != $s_system)
		{
		$s_sel .= "<option value='$s_system'>$s_system</option>";
		}
	$s_system_hold = $s_system;
	$i_key++;
	}
$s_sel .= "</select>";
$s_html .= $s_sel;

$s_sel = "<select id='planet' name='planet'>";
$s_planet_hold = "";
for ($x=0;$x<sizeof($a_location);$x++)
	{
	if ($a_location[$x]["system"] == $a_location[0]["system"])
		{
		$s_sel .= "<option value='".$a_location[$x]["planet"]."'>".$a_location[$x]["planet"]."</option>";
		}
	$s_system_hold = $s_system;
	$i_key++;
	}
$s_sel .= "</select>";
$s_html .= $s_sel;
$s_html .= '<input class="s3" type="text" size="30" name="user" id="user" value=""/>';

$s_sel = "<select id='cc_size' name='cc_size'>";
$s_sel .= "<option value='1'>Basic</option>";
$s_sel .= "<option value='2'>Intermediate</option>";
$s_sel .= "<option value='3'>Standard</option>";
$s_sel .= "<option value='4'>Advanced</option>";
$s_sel .= "<option value='5'>Elite</option>";
$s_sel .= "</select>";
$s_html .= $s_sel;
mysql_free_result($q_data);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="generator" content="'<?php echo $s_pageName; ?>"/>
<meta name="keywords" content="<?php echo $s_pageName; ?>"/> 
<meta name="description" content="<?php echo $s_pageName; ?>" />
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />
<meta http-equiv="refresh" content="30;url='<?php echo $s_filename; ?>'">
<title><?php echo $s_pageName; ?></title> 
<link rel="stylesheet" href="eve2.css">
<script language="javascript">
function js_getplanets(theid)
	{
	<?php echo $s_jsArray; ?>
	var s_values = "";
	planet = document.getElementById("planet");
	planet.options.length = 0;
	for (var ax=0;ax<a_location.length;ax++)
		{
		if (theid == a_location[ax][0])
			{
			planet.options[planet.options.length ] = new Option(a_location[ax][1],a_location[ax][1]);
			}
		}
	}
</script>
</head> 
<body class="body">
<span class="title"><?php echo $s_pageName; ?></span>
<span id="swirly" style="display:block;">&nbsp;<img src="../../images/new-spinner.gif" border="0" height="12" width="12" title="loading..."></span>
<br/>
<?php echo $s_html; ?>
<script language="javascript">
document.getElementById("swirly").style.display = "none";
</script>
</body> 
</html>