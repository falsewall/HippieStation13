/datum/wires/poolcontroller
	holder_type = /obj/machinery/poolcontroller
	wire_count = 3

var/const/POOL_WIRE_BLINK = 1
var/const/POOL_WIRE_EMAGGED = 2
var/const/POOL_WIRE_ELECTRIFY = 4

/datum/wires/poolcontroller/CanUse(var/mob/living/L)
	var/obj/machinery/poolcontroller/V = holder
	if(!istype(L, /mob/living/silicon))
		if(V.seconds_electrified)
			if(V.shock(L, 100))
				return 0
	if(V.panel_open)
		return 1
	return 0

/datum/wires/poolcontroller/Interact(var/mob/living/user)
	if(CanUse(user))
		var/obj/machinery/poolcontroller/P = holder
		P.attack_hand(user)

/datum/wires/poolcontroller/GetInteractWindow()
	var/obj/machinery/poolcontroller/P = holder
	. += ..()
	. += "<BR>The orange light is [P.blinking ? "blinking" : "off"].<BR>"
	. += "The red light is [P.shoot_inventory ? "off" : "blinking"].<BR>"
	. += "The green light is [P.extended_inventory ? "on" : "off"].<BR>"


/datum/wires/poolcontroller/UpdatePulsed(var/index)
	var/obj/machinery/poolcontroller/P = holder
	switch(index)
		if(POOL_WIRE_BLINK)
			P.shoot_inventory = !P.shoot_inventory
		if(POOL_WIRE_EMAGGED)
			P.emagged = !P.emagged
		if(POOL_WIRE_ELECTRIFY)
			P.seconds_electrified = 30

/datum/wires/poolcontroller/UpdateCut(var/index, var/mended)
	var/obj/machinery/poolcontroller/P = holder
	switch(index)
		if(POOL_WIRE_BLINK)
			P.shoot_inventory = !mended
		if(POOL_WIRE_EMAGGED)
			P.emagged = 0
		if(POOL_WIRE_ELECTRIFY)
			if(mended)
				P.seconds_electrified = 0
			else
				P.seconds_electrified = -1