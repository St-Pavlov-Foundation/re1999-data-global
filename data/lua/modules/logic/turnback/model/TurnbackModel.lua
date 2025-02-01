module("modules.logic.turnback.model.TurnbackModel", package.seeall)

slot0 = class("TurnbackModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.turnbackSubModuleInfo = {}
	slot0.unExitSubModules = {}
	slot0.turnbackInfoMo = nil
	slot0.targetCategoryId = 0
	slot0.curTurnbackId = 0
end

function slot0.setTurnbackInfo(slot0, slot1)
	if TurnbackConfig.instance:getTurnbackCo(slot1.id) then
		slot0.turnbackInfoMo = TurnbackInfoMo.New()

		slot0.turnbackInfoMo:init(slot1)
		slot0:setCurTurnbackId(slot1.id)
		slot0:setTaskInfoList()
		slot0:setSignInInfoList()
		slot0:initRecommendData()
	end
end

function slot0.setCurTurnbackId(slot0, slot1)
	slot0.curTurnbackId = slot1
end

function slot0.getCurTurnbackId(slot0)
	return slot0.curTurnbackId
end

function slot0.getCurTurnbackMo(slot0)
	return slot0.turnbackInfoMo
end

function slot0.getLeaveTime(slot0)
	return slot0.turnbackInfoMo.leaveTime
end

function slot0.getCurTurnbackMoWithNilError(slot0)
	if not slot0:getCurTurnbackMo() then
		logError("TurnbackModel:getCurTurnbackMoWithNilError, can't find turnbackMo")
	end

	return slot1
end

function slot0.canShowTurnbackPop(slot0)
	if not slot0.turnbackInfoMo then
		return false
	elseif slot0.turnbackInfoMo.firstShow then
		return false
	end

	return true
end

function slot0.initTurnbackSubModules(slot0, slot1)
	for slot6, slot7 in ipairs(TurnbackConfig.instance:getAllTurnbackSubModules(slot1)) do
		if not slot0.turnbackSubModuleInfo[slot7] then
			slot0.turnbackSubModuleInfo[slot7] = {
				id = slot7,
				config = TurnbackConfig.instance:getTurnbackSubModuleCo(slot7),
				order = slot6
			}
		end
	end

	slot0:removeUnExitSubModules(slot0.turnbackSubModuleInfo)
end

function slot0.setTargetCategoryId(slot0, slot1)
	slot0.targetCategoryId = slot1
end

function slot0.getTargetCategoryId(slot0, slot1)
	slot0:initTurnbackSubModules(slot1)

	if GameUtil.getTabLen(slot0.turnbackSubModuleInfo) == 0 then
		slot0.targetCategoryId = 0

		return 0
	end

	for slot5, slot6 in pairs(slot0.turnbackSubModuleInfo) do
		if slot6.config.id == slot0.targetCategoryId and slot6.config.turnbackId == slot1 then
			return slot0.targetCategoryId
		end
	end

	slot0.targetCategoryId = slot0:getTargetSubModules()

	return slot0.targetCategoryId
end

function slot0.getTargetSubModules(slot0)
	if uv0.instance:haveOnceBonusReward() then
		return TurnbackEnum.ActivityId.RewardShowView
	elseif uv0.instance:haveSignInReward() then
		return TurnbackEnum.ActivityId.SignIn
	elseif uv0.instance:haveTaskReward() then
		return TurnbackEnum.ActivityId.TaskView
	end

	return TurnbackEnum.ActivityId.TaskView
end

function slot0.haveOnceBonusReward(slot0)
	return not slot0.turnbackInfoMo.onceBonus
end

function slot0.haveSignInReward(slot0)
	return TurnbackSignInModel.instance:getTheFirstCanGetIndex() ~= 0
end

function slot0.haveTaskReward(slot0)
	slot1 = TurnbackTaskModel.instance:haveTaskItemReward()
	slot2 = slot0:getCurHasGetTaskBonus()
	slot4 = {}

	for slot8, slot9 in ipairs(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId)) do
		for slot14, slot15 in ipairs(slot2) do
			if slot9.id == slot15 then
				break
			end
		end

		slot4[slot8] = {
			config = slot9,
			hasGetState = false,
			hasGetState = true
		}
	end

	slot6 = false

	for slot10, slot11 in ipairs(slot4) do
		if slot11.config.needPoint <= slot0.turnbackInfoMo.bonusPoint and slot11.hasGetState == false then
			slot6 = true

			break
		end
	end

	return slot1 or slot6
end

function slot0.addUnExitSubModule(slot0, slot1)
	slot0.unExitSubModules[slot1] = slot1
end

function slot0.removeUnExitSubModules(slot0, slot1)
	if GameUtil.getTabLen(slot1) == 0 then
		return
	end

	for slot5, slot6 in pairs(slot0.unExitSubModules) do
		for slot10, slot11 in ipairs(slot1) do
			if slot11.id == slot6 then
				table.remove(slot1, slot10)
			end
		end
	end

	return slot1
end

function slot0.removeUnExitCategory(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot6 == TurnbackEnum.ActivityId.DungeonShowView and not slot0.turnbackInfoMo:isAdditionInOpenTime() then
			slot0:addUnExitSubModule(slot6)
			table.remove(slot1, slot5)
		end

		if slot6 == TurnbackEnum.ActivityId.RecommendView and (TurnbackRecommendModel.instance:getCanShowRecommendCount() == 0 or not slot0.turnbackInfoMo:isInReommendTime()) then
			slot0:addUnExitSubModule(slot6)
			table.remove(slot1, slot5)
		end
	end

	return slot1
end

function slot0.getRemainTime(slot0, slot1)
	if slot0:getCurTurnbackMo() then
		slot4 = (slot1 or slot2.endTime) - ServerTime.now()
		slot6 = slot4 % TimeUtil.OneDaySecond
		slot8 = slot6 % TimeUtil.OneHourSecond

		return Mathf.Floor(slot4 / TimeUtil.OneDaySecond), Mathf.Floor(slot6 / TimeUtil.OneHourSecond), Mathf.Floor(slot8 / TimeUtil.OneMinuteSecond), Mathf.Floor(slot8 % TimeUtil.OneMinuteSecond)
	else
		return 0, 0, 0, 0
	end
end

function slot0.isInOpenTime(slot0)
	if slot0.turnbackInfoMo then
		return slot0.turnbackInfoMo:isInOpenTime()
	end
end

function slot0.setTaskInfoList(slot0)
	TurnbackTaskModel.instance:setTaskInfoList(slot0.turnbackInfoMo.tasks)
	TurnbackTaskModel.instance:refreshList(TurnbackTaskModel.instance:getCurTaskLoopType())
end

function slot0.updateHasGetTaskBonus(slot0, slot1)
	slot0.turnbackInfoMo:updateHasGetTaskBonus(slot1.hasGetTaskBonus)
end

function slot0.updateCurBonusPoint(slot0, slot1)
	slot0.turnbackInfoMo.bonusPoint = slot1
end

function slot0.getCurHasGetTaskBonus(slot0)
	return slot0.turnbackInfoMo.hasGetTaskBonus
end

function slot0.setOnceBonusGetState(slot0)
	slot0.turnbackInfoMo.onceBonus = true
end

function slot0.getOnceBonusGetState(slot0)
	return slot0.turnbackInfoMo.onceBonus
end

function slot0.setSignInInfoList(slot0)
	TurnbackSignInModel.instance:setSignInInfoList(slot0.turnbackInfoMo.signInInfos)
end

function slot0.getCurSignInDay(slot0)
	return slot0.turnbackInfoMo.signInDay
end

function slot0.initRecommendData(slot0)
	TurnbackRecommendModel.instance:initReommendShowState(slot0.curTurnbackId)
end

function slot0.isAdditionValid(slot0)
	slot1 = false

	if slot0:getCurTurnbackMo() then
		slot1 = slot2:isAdditionValid()
	end

	return slot1
end

function slot0.isShowTurnBackAddition(slot0, slot1)
	return slot0:isAdditionValid() and TurnbackConfig.instance:isTurnBackAdditionToChapter(uv0.instance:getCurTurnbackId(), slot1)
end

function slot0.getAdditionCountInfo(slot0)
	slot2 = TurnbackConfig.instance:getAdditionTotalCount(slot0:getCurTurnbackId())
	slot3 = 0

	if slot0:getCurTurnbackMoWithNilError() then
		slot3 = slot4:getRemainAdditionCount()
	end

	return slot3, slot2
end

function slot0.getAdditionRewardList(slot0, slot1)
	if not slot1 then
		return {}
	end

	if TurnbackConfig.instance:getAdditionRate(slot0:getCurTurnbackId()) and slot4 > 0 then
		for slot8, slot9 in ipairs(slot1) do
			table.insert(slot2, {
				slot9[1],
				slot9[2],
				math.ceil(slot9[3] * slot4 / 1000),
				isAddition = true
			})
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
