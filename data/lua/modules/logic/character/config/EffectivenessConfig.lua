module("modules.logic.character.config.EffectivenessConfig", package.seeall)

slot0 = class("EffectivenessConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.subValue = 0.7
end

function slot0.reqConfigNames(slot0)
	return {
		"hero_effectiveness",
		"equip_effectiveness",
		"talent_effectiveness",
		"talent_scheme"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

slot0.HeroRareRareEnum = {
	SR = 4,
	Other = 3,
	SSR = 5
}
slot0.EquipRareRareEnum = {
	SR = 4,
	Other = 3,
	SSR = 5
}

function slot0.calculateHeroEffectiveness(slot0, slot1, slot2)
	slot3 = lua_hero_effectiveness.configDict[slot1.level]
	slot5 = nil
	slot5 = (slot1.config.rare ~= uv0.HeroRareRareEnum.SSR or slot3.ssr) and (slot4.rare ~= uv0.HeroRareRareEnum.SR or slot3.sr) and slot3.r

	if slot2 then
		return slot5 * slot0.subValue
	end

	return slot5
end

function slot0.calculateHeroAverageEffectiveness(slot0, slot1, slot2)
	for slot7 = 1, #slot1 do
		slot3 = 0 + slot0:calculateHeroEffectiveness(slot1[slot7])
	end

	for slot7 = 1, #slot2 do
		slot3 = slot3 + slot0:calculateHeroEffectiveness(slot2[slot7], true)
	end

	return slot3 / (#slot1 + #slot2)
end

function slot0.calculateEquipEffectiveness(slot0, slot1, slot2)
	slot3 = lua_equip_effectiveness.configDict[slot1.level]
	slot5 = nil
	slot5 = (slot1.config.rare ~= uv0.EquipRareRareEnum.SSR or slot3.ssr) and (slot4.rare ~= uv0.EquipRareRareEnum.SR or slot3.sr) and slot3.r

	if slot2 then
		return slot5 * slot0.subValue
	end

	return slot5
end

function slot0.calculateEquipAverageEffectiveness(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot1) do
		slot2 = slot6 == 4 and slot2 + slot0:calculateEquipEffectiveness(slot7, true) or slot2 + slot0:calculateEquipEffectiveness(slot7)
	end

	return #slot1 ~= 0 and slot2 / #slot1 or 0
end

function slot0.calculateTalentEffectiveness(slot0, slot1, slot2)
	slot3 = lua_talent_effectiveness.configDict[slot1.talent]
	slot5 = nil
	slot5 = (slot1.config.rare ~= uv0.HeroRareRareEnum.SSR or slot3.ssr) and (slot4.rare ~= uv0.HeroRareRareEnum.SR or slot3.sr) and slot3.r

	if slot2 then
		return slot5 * slot0.subValue
	end

	return slot5
end

function slot0.calculateTalentAverageEffectiveness(slot0, slot1, slot2)
	for slot7 = 1, #slot1 do
		slot3 = 0 + slot0:calculateTalentEffectiveness(slot1[slot7])
	end

	for slot7 = 1, #slot2 do
		slot3 = slot3 + slot0:calculateTalentEffectiveness(slot2[slot7], true)
	end

	return slot3 / (#slot1 + #slot2)
end

slot0.instance = slot0.New()

return slot0
