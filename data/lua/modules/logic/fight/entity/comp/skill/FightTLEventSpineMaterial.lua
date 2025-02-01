module("modules.logic.fight.entity.comp.skill.FightTLEventSpineMaterial", package.seeall)

slot0 = class("FightTLEventSpineMaterial")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._matName = slot3[2]
	slot0._transitName = slot3[3]
	slot0._transitType = slot3[4]
	slot5 = slot3[5]
	slot6 = tonumber(slot3[6])
	slot0._targetEntitys = nil

	if slot3[1] == "1" then
		slot0._targetEntitys = {}

		table.insert(slot0._targetEntitys, FightHelper.getEntity(slot1.fromId))
	elseif slot4 == "2" then
		slot0._targetEntitys = FightHelper.getSkillTargetEntitys(slot1)
	elseif not string.nilorempty(slot4) then
		if GameSceneMgr.instance:getCurScene().entityMgr:getUnit(SceneTag.UnitNpc, slot1.stepUid .. "_" .. slot4) then
			slot0._targetEntitys = {}

			table.insert(slot0._targetEntitys, slot9)
		else
			logError("找不到实体, id: " .. tostring(slot4))

			return
		end
	end

	slot7 = not string.nilorempty(slot0._matName) and FightSpineMatPool.getMat(slot0._matName)
	slot8 = not string.nilorempty(slot0._transitName)
	slot9 = MaterialUtil.getPropValueFromStr(slot0._transitType, slot5)

	for slot13, slot14 in ipairs(slot0._targetEntitys) do
		if slot7 then
			slot14.spineRenderer:replaceSpineMat(slot7)
			FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, slot14.id, slot14.spineRenderer:getReplaceMat())
		end
	end

	if slot6 > 0 then
		slot10 = {
			[slot17.id] = slot18
		}
		slot11 = {
			[slot17.id] = MaterialUtil.getPropValueFromMat(slot18, slot0._transitName, slot0._transitType)
		}
		slot12 = {}

		for slot16, slot17 in ipairs(slot0._targetEntitys) do
			slot18 = slot17.spineRenderer:getReplaceMat()
		end

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot6, function (slot0)
			for slot4, slot5 in ipairs(uv0._targetEntitys) do
				uv3[slot5.id] = MaterialUtil.getLerpValue(uv0._transitType, uv1[slot5.id], uv4, slot0, uv3[slot5.id])

				MaterialUtil.setPropValue(uv2[slot5.id], uv0._transitName, uv0._transitType, uv3[slot5.id])
			end
		end, nil, , , EaseType.Linear)

		return
	end

	if slot8 then
		for slot13, slot14 in ipairs(slot0._targetEntitys) do
			MaterialUtil.setPropValue(slot14.spineRenderer:getReplaceMat(), slot0._transitName, slot0._transitType, slot9)
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_clear()
end

function slot0.reset(slot0)
	slot0:_clear()
end

function slot0.dispose(slot0)
	slot0:_clear()
end

function slot0._clear(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

return slot0
