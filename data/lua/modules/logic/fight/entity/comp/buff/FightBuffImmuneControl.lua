module("modules.logic.fight.entity.comp.buff.FightBuffImmuneControl", package.seeall)

slot0 = class("FightBuffImmuneControl")
slot1 = {
	buff_immune = {
		"_TempOffsetTwoPass",
		"Vector4",
		"-0.2,4.2,-0.4,-0.2",
		"_OutlineColor",
		"Color",
		"12,9.55,5.83,1",
		"_NoiseMap4_ST",
		"Vector4",
		"0.1,0.1,0,0"
	}
}
slot2 = {
	["304901_kachakacha"] = {
		"_AlphaRange",
		"Vector4",
		"0,1,0,-1.78"
	},
	["304902_kachakacha"] = {
		"_AlphaRange",
		"Vector4",
		"0,1,0,-1.78"
	}
}

function slot0.onBuffStart(slot0, slot1, slot2)
	slot0.entity = slot1
	slot0.buffMO = slot2

	FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, slot0._onChangeMaterial, slot0)
end

function slot0.onBuffEnd(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, slot0._onChangeMaterial, slot0)
end

function slot0.reset(slot0)
	slot0._preMatName = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, slot0._onChangeMaterial, slot0)
end

function slot0.dispose(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, slot0._onChangeMaterial, slot0)
end

function slot0._onChangeMaterial(slot0, slot1, slot2)
	if slot1 ~= slot0.entity.id then
		return
	end

	if slot0._preMatName and slot0._preMatName == slot2.name then
		return
	end

	slot0._preMatName = slot2.name

	if not uv0[lua_skill_buff.configDict[slot0.buffMO.buffId].mat] then
		return
	end

	for slot8 = 1, 9, 3 do
		slot10 = slot4[slot8 + 1]

		MaterialUtil.setPropValue(slot2, slot4[slot8], slot10, MaterialUtil.getPropValueFromStr(slot10, slot4[slot8 + 2]))
	end

	slot6 = slot0.entity:getMO() and slot5:getSpineSkinCO()
	slot7 = slot6 and slot6.spine

	if not string.nilorempty(slot7) and uv1[slot7] then
		for slot12 = 1, 9, 3 do
			slot14 = slot8[slot12 + 1]

			MaterialUtil.setPropValue(slot2, slot8[slot12], slot14, MaterialUtil.getPropValueFromStr(slot14, slot8[slot12 + 2]))
		end
	end
end

return slot0
