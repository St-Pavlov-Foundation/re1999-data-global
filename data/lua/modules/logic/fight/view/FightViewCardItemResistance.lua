module("modules.logic.fight.view.FightViewCardItemResistance", package.seeall)

slot0 = class("FightViewCardItemResistance", LuaCompBase)

function slot0.ctor(slot0)
end

function slot0.init(slot0, slot1)
	slot0.resistanceGo = gohelper.findChild(slot1, "#go_resistance")
	slot0.rectTr = slot0.resistanceGo:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(slot0.resistanceGo, false)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SelectSkillTarget, slot0.onSelectSkillTarget, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SelectSkillTarget, slot0.onSelectSkillTarget, slot0)
end

function slot0.onSelectSkillTarget(slot0)
	if not slot0.cardInfoMO then
		return
	end

	slot0:updateByCardInfo(slot0.cardInfoMO)
end

function slot0.updateByBeginRoundOp(slot0, slot1)
	if not slot1 then
		return slot0:hideResistanceGo()
	end

	if not slot1:isPlayCard() then
		return slot0:hideResistanceGo()
	end

	if not slot1.toId then
		return slot0:hideResistanceGo()
	end

	if not FightDataHelper.entityMgr:getById(slot2) then
		return slot0:hideResistanceGo()
	end

	if slot3.side ~= FightEnum.EntitySide.EnemySide then
		return slot0:hideResistanceGo()
	end

	return slot0:refreshResistance(slot3, slot1.skillId)
end

function slot0.updateByCardInfo(slot0, slot1)
	slot0.cardInfoMO = slot1

	if not slot1 then
		return slot0:hideResistanceGo()
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return slot0:hideResistanceGo()
	end

	if FightModel.instance:isAuto() then
		return slot0:hideResistanceGo()
	end

	if FightCardModel.instance.curSelectEntityId == 0 then
		return slot0:hideResistanceGo()
	end

	if not FightDataHelper.entityMgr:getById(slot3) then
		return slot0:hideResistanceGo()
	end

	return slot0:refreshResistance(slot4, slot1.skillId)
end

function slot0.updateBySkillDisplayMo(slot0, slot1)
	if not slot1 then
		return slot0:hideResistanceGo()
	end

	if slot1.targetId == 0 then
		return slot0:hideResistanceGo()
	end

	if not FightDataHelper.entityMgr:getById(slot2) then
		return slot0:hideResistanceGo()
	end

	return slot0:refreshResistance(slot3, slot1.skillId)
end

slot0.AnchorY = {
	BigSkill = -68,
	Normal = -54
}

function slot0.refreshResistance(slot0, slot1, slot2)
	if not string.nilorempty(lua_skill.configDict[slot2] and slot3.resistancesTag) then
		slot6 = false

		for slot10, slot11 in ipairs(FightStrUtil.instance:getSplitCache(slot4, "#")) do
			if slot1:isFullResistance(slot11) then
				FightController.instance:dispatchEvent(FightEvent.TriggerCardShowResistanceTag)

				slot6 = true

				break
			end
		end

		gohelper.setActive(slot0.resistanceGo, slot6)

		if slot6 then
			recthelper.setAnchorY(slot0.rectTr, slot3.isBigSkill == 1 and uv0.AnchorY.BigSkill or uv0.AnchorY.Normal)
		end
	else
		slot0:hideResistanceGo()
	end
end

function slot0.hideResistanceGo(slot0)
	gohelper.setActive(slot0.resistanceGo, false)
end

return slot0
