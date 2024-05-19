The first alteration needed was in the "spells.xml" file, located in the Server data
Here the spell "Frigo was created" and in order to be tested more easily the cooldown was set to 0, mana set to 0 and selftarget set to 1.
This spell was based on the Eternal Winter spell

<instant group="attack" spellid="118" name="Frigo" words="frigo" level="60" mana="0" premium="0" selftarget="1" cooldown="0" groupcooldown="0" needlearn="0" script="attack/frigo_spell.lua">
		<vocation name="Druid" />
		<vocation name="Elder Druid" />
	</instant>

The next alteration was in the frigo_spell.lua, which maintained the basic spell layout similar to Eternal Winter, except for the Combat are which was changed to AREA_CIRCLE4X4

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_CIRCLE4X4))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

Lastly, an Area Circle of 4x4 was created in order to place the tornados in the correct positions, 
the center value was changed from 3 to 2 to not add a sprite to the player's tile.

AREA_CIRCLE4X4 = {
	{0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0},
	{0, 0, 0, 1, 1, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 2, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 1, 1, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0}
}