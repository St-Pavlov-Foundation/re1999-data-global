module("modules.logic.fight.view.FightViewHandCardItemRestrain", package.seeall)

slot0 = class("FightViewHandCardItemRestrain", LuaCompBase)
slot0.RestrainMvStatus = {
	Restrain = 2,
	BeRestrain = 3,
	None = 1
}

function slot0.ctor(slot0, slot1)
	slot0._subViewInst = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform

	gohelper.setActive(gohelper.findChild(slot0.go, "foranim/restrain"), true)

	slot0._restrainGO = gohelper.findChild(slot0.go, "foranim/restrain/restrain")
	slot0._beRestrainGO = gohelper.findChild(slot0.go, "foranim/restrain/beRestrain")
	slot0._restrainAnimator = slot0._restrainGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._beRestrainAnimator = slot0._beRestrainGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SelectSkillTarget, slot0._onSelectSkillTarget, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._updateRestrain, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SelectSkillTarget, slot0._onSelectSkillTarget, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._updateRestrain, slot0)
end

function slot0.updateItem(slot0, slot1)
	slot0.cardInfoMO = slot1 or slot0.cardInfoMO

	if not lua_skill.configDict[slot1.skillId] then
		logError("skill not exist: " .. slot1.skillId)

		return
	end

	slot0:_updateRestrain()
	slot0:_playNonAnimation()
end

function slot0._onSelectSkillTarget(slot0, slot1)
	slot0:_updateRestrain()
	slot0:_playAnimation()
end

function slot0._onStageChange(slot0, slot1)
	slot0:_updateRestrain()
	slot0:_playAnimation()
end

function slot0._updateRestrain(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card then
		slot3 = GMFightShowState.handCardRestrain

		gohelper.setActive(slot0._restrainGO, slot0:_getNewRestrainStatus() == uv0.RestrainMvStatus.Restrain and slot3)
		gohelper.setActive(slot0._beRestrainGO, slot2 == uv0.RestrainMvStatus.BeRestrain and slot3)
	else
		gohelper.setActive(slot0._restrainGO, false)
		gohelper.setActive(slot0._beRestrainGO, false)
	end
end

function slot0._playAnimation(slot0)
	if slot0:_getNewRestrainStatus() == uv0.RestrainMvStatus.Restrain then
		if slot0._restrainAnimator.gameObject.activeInHierarchy then
			slot0._restrainAnimator:Play("fight_restrain_all_in", 0, 0)
			slot0._restrainAnimator:Update(0)
		end
	elseif slot1 == uv0.RestrainMvStatus.BeRestrain and slot0._beRestrainAnimator.gameObject.activeInHierarchy then
		slot0._beRestrainAnimator:Play("fight_restrain_all_in", 0, 0)
		slot0._beRestrainAnimator:Update(0)
	end
end

function slot0._playNonAnimation(slot0)
	if slot0:_getNewRestrainStatus() == uv0.RestrainMvStatus.Restrain then
		if slot0._restrainAnimator.gameObject.activeInHierarchy then
			slot0._restrainAnimator:Play("fight_restrain_all_not", 0, 0)
			slot0._restrainAnimator:Update(0)
		end
	elseif slot1 == uv0.RestrainMvStatus.BeRestrain and slot0._beRestrainAnimator.gameObject.activeInHierarchy then
		slot0._beRestrainAnimator:Play("fight_restrain_all_not", 0, 0)
		slot0._beRestrainAnimator:Update(0)
	end
end

function slot0.getNewRestrainStatus(slot0, slot1)
	slot4 = FightHelper.getEntity(FightCardModel.instance.curSelectEntityId)
	slot6 = lua_skill.configDict[slot1] and slot5.showTag

	if (FightModel.instance:getCurStage() == FightEnum.Stage.Distribute or slot2 == FightEnum.Stage.Card) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightRestrainTag) and not FightModel.instance:isAuto() and FightCardModel.instance.curSelectEntityId ~= 0 and slot4 and (slot6 and FightEnum.NeedShowRestrainTag[slot6]) and not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRestrainTag) then
		if FightBuffHelper.restrainAll(slot0) then
			return uv0.RestrainMvStatus.Restrain
		end

		slot13 = FightDataHelper.entityMgr:getById(slot0) and slot12:getCO()
		slot16 = slot4:getMO() and slot15:getCO()
		slot17 = slot16 and slot16.career or 0

		if FightModel.instance:getVersion() >= 2 then
			if slot12 then
				slot14 = slot12.career or (slot13 and slot13.career or 0)
			end

			if slot15 then
				slot17 = slot15.career or slot17
			end
		end

		if (FightConfig.instance:getRestrain(slot14, slot17) or 1000) > 1000 then
			return uv0.RestrainMvStatus.Restrain
		elseif slot19 < 1000 then
			return uv0.RestrainMvStatus.BeRestrain
		else
			return uv0.RestrainMvStatus.None
		end
	else
		return uv0.RestrainMvStatus.None
	end
end

function slot0._getNewRestrainStatus(slot0)
	return uv0.getNewRestrainStatus(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId)
end

return slot0
