module("modules.logic.fight.entity.comp.skill.FightTLEventEntityScale", package.seeall)

slot0 = class("FightTLEventEntityScale")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._paramsArr = slot3
	slot0._targetScale = tonumber(slot3[1])
	slot0._revertScale = slot3[5] == "1"
	slot5 = slot3[3] == "1"
	slot6 = nil

	if slot3[2] == "1" then
		table.insert({}, FightHelper.getEntity(slot1.fromId))
	elseif slot4 == "2" then
		slot6 = FightHelper.getSkillTargetEntitys(slot1)
	elseif slot4 == "3" then
		slot6 = FightHelper.getSideEntitys(FightHelper.getEntity(slot1.fromId):getSide(), true)
	elseif slot4 == "4" then
		slot6 = FightHelper.getSideEntitys(FightHelper.getEntity(slot1.toId):getSide(), true)
	end

	if not string.nilorempty(slot3[4]) then
		if FightHelper.getEntity(slot1.stepUid .. "_" .. slot3[4]) then
			table.insert({}, slot7)
		end
	end

	if slot5 then
		for slot10, slot11 in ipairs(slot6) do
			slot12 = slot0:_getScale(slot11)

			slot11:setScale(slot12)
			FightHelper.refreshCombinativeMonsterScaleAndPos(slot11, slot12)
		end
	elseif #slot6 > 0 then
		slot0._tweenList = {}

		for slot10, slot11 in ipairs(slot6) do
			if not gohelper.isNil(slot11.go) then
				table.insert(slot0._tweenList, ZProj.TweenHelper.DOTweenFloat(slot11:getScale() or 1, slot0:_getScale(slot11), slot2, function (slot0)
					if uv0.go then
						uv0:setScale(slot0)
						FightHelper.refreshCombinativeMonsterScaleAndPos(uv0, slot0)
					end
				end))
			end
		end
	end
end

function slot0._getScale(slot0, slot1)
	slot2 = slot1 and slot1:getMO()

	if slot0._revertScale and slot2 then
		slot3, slot4, slot5, slot6 = FightHelper.getEntityStandPos(slot2)

		return slot6
	end

	if slot2 and not string.nilorempty(slot0._paramsArr[6]) then
		slot7 = "|"

		for slot7, slot8 in ipairs(FightStrUtil.instance:getSplitCache(slot0._paramsArr[6], slot7)) do
			if slot2.skin == FightStrUtil.instance:getSplitToNumberCache(slot8, "_")[1] then
				return slot9[2]
			end
		end
	end

	return slot0._targetScale
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
	if slot0._tweenList then
		for slot4, slot5 in ipairs(slot0._tweenList) do
			ZProj.TweenHelper.KillById(slot5)
		end

		slot0._tweenList = nil
	end
end

return slot0
