$modelname	"lighter.mdl"

$body mybody	"lighter.smd"

$animation a_on_idle "anims/on_idle.smd" 

$sequence on_idle {
	a_on_idle
	angles -180, -180, -180
	fps 8
	loop
}

$animation a_closed_idle "anims/closed_idle.smd" 

$sequence closed_idle {
	a_closed_idle
	angles -180, -180, -180
	fps 8
	loop
}

$animation a_open "anims/open.smd" 

$sequence open {
	a_open
	angles -180, -180, -180
	fps 30
}

$animation a_close "anims/close.smd" 

$sequence close {
	a_close
	angles -180, -180, -180
	fps 40
}


$surfaceprop	combine_metal
$cdmaterials	"models\lighter"