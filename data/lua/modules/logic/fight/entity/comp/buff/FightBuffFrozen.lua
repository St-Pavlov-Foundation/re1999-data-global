module("modules.logic.fight.entity.comp.buff.FightBuffFrozen", package.seeall)

slot0 = class("FightBuffFrozen")
slot1 = 0.5
slot2 = {
	buff_stone = {
		"_TempOffset3",
		"Vector4",
		"1,0,0,0",
		"-2,0,0,0"
	},
	buff_ice = {
		"_TempOffsetTwoPass",
		"Vector4",
		"1,1,1,0.7",
		"-2,1,1,0.7"
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
	TaskDispatcher.cancelTask(slot0._delayEnd, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0._delayEnd, slot0)
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

	slot9 = slot0.entity.spineRenderer and slot0.entity.spineRenderer:getCloneOriginMat()
	slot11 = slot9 and MaterialUtil.getPropValueFromMat(slot9, "_FloorAlpha", "Vector4")

	if slot9 and MaterialUtil.getPropValueFromMat(slot9, "_Pow", "Color") then
		MaterialUtil.setPropValue(slot2, slot5, slot7, slot10)
	end

	if slot11 then
		MaterialUtil.setPropValue(slot2, slot6, slot8, slot11)
	end

	slot12 = slot4[1]
	slot13 = slot4[2]
	slot15 = MaterialUtil.getPropValueFromStr(slot13, slot4[4])

	MaterialUtil.setPropValue(slot2, slot12, slot13, MaterialUtil.getPropValueFromStr(slot13, slot4[3]))

	slot16 = nil
	slot17 = UnityEngine.Shader.PropertyToID(slot12)
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, uv1, function (slot0)
		uv0 = MaterialUtil.getLerpValue(uv1, uv2, uv3, slot0, uv0)

		MaterialUtil.setPropValue(uv4, uv5, uv1, uv0)
	end)

	TaskDispatcher.runDelay(slot0._delayEnd, slot0, uv1)
end

function slot0._delayEnd(slot0)
	slot0._tweenId = nil
end

return slot0
