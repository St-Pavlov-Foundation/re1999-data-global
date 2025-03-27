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
	slot0.lastGetSigninDay = nil
end

function slot0.setTurnbackInfo(slot0, slot1)
	if TurnbackConfig.instance:getTurnbackCo(slot1.id) then
		slot0.turnbackInfoMo = TurnbackInfoMo.New()

		slot0.turnbackInfoMo:init(slot1)
		slot0:setCurTurnbackId(slot1.id)
		slot0:setTaskInfoList()
		slot0:setSignInInfoList()
		slot0:initRecommendData()
		slot0:getBonusHeroConfigList()
		slot0:_calcAllBonus()
		slot0:setDropInfoList(slot1.dropInfos)
	end
end

function slot0.setCurTurnbackId(slot0, slot1)
	slot0.curTurnbackId = slot1
end

function slot0.getCurTurnbackId(slot0)
	return slot0.curTurnbackId
end

function slot0.isNewType(slot0)
	return slot0.turnbackInfoMo:isNewType()
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

	if not slot0:isNewType() then
		slot0.targetCategoryId = slot0:getTargetSubModules()
	else
		slot0.targetCategoryId = slot0:getTargetNewSubModules()
	end

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

function slot0.getTargetNewSubModules(slot0)
	if uv0.instance:haveSignInReward() then
		return TurnbackEnum.ActivityId.NewSignIn
	elseif uv0.instance:haveTaskReward() then
		return TurnbackEnum.ActivityId.NewTaskView
	end

	return TurnbackEnum.ActivityId.NewSignIn
end

function slot0.haveOnceBonusReward(slot0)
	return not slot0.turnbackInfoMo.onceBonus
end

function slot0.haveSignInReward(slot0)
	return TurnbackSignInModel.instance:getTheFirstCanGetIndex() ~= 0
end

function slot0.setLastGetSigninReward(slot0, slot1)
	slot0.lastGetSigninDay = slot1
end

function slot0.getLastGetSigninReward(slot0)
	return slot0.lastGetSigninDay
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

	if not slot0:isNewType() then
		TurnbackTaskModel.instance:refreshList(TurnbackTaskModel.instance:getCurTaskLoopType())
	else
		TurnbackTaskModel.instance:refreshListNewTaskList()
	end
end

function slot0.getBuyDoubleBonus(slot0)
	return slot0.turnbackInfoMo:getBuyDoubleBonus()
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

function slot0.getMonthCardShowState(slot0)
	if slot0:getCurTurnbackMo() == nil then
		return false
	end

	if slot1.config == nil then
		return false
	end

	if slot2.monthCardAddedId == nil then
		return false
	end

	if StoreConfig.instance:getMonthCardAddConfig(slot2.monthCardAddedId) == nil then
		return false
	end

	return slot1.monthCardAddedBuyCount < slot3.limit
end

function slot0.getCurrentTurnbackMonthCardId(slot0)
	if slot0:getCurTurnbackMo() == nil then
		return nil
	end

	return slot1.config.monthCardAddedId
end

function slot0.addCurrentMonthBuyCount(slot0)
	if slot0:getCurTurnbackMo() == nil then
		return
	end

	slot1.monthCardAddedBuyCount = slot1.monthCardAddedBuyCount + 1
end

function slot0.getCanGetRewardList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId)) do
		if slot0:checkBonusCanGetById(slot7.id) then
			table.insert(slot1, slot7.id)
		end
	end

	return slot1
end

function slot0.getNextUnlockReward(slot0)
	slot1 = slot0:getCurrentPointId()

	for slot6, slot7 in ipairs(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId)) do
		if slot1 < slot7.needPoint then
			return slot7.id
		end
	end

	if slot2[#slot2].needPoint <= slot1 then
		return slot2[#slot2].id
	end
end

function slot0.checkBonusCanGetById(slot0, slot1)
	if TurnbackConfig.instance:getTurnbackTaskBonusCo(slot0.curTurnbackId, slot1).needPoint <= slot0:getCurrentPointId() and not slot0:checkBonusGetById(slot1) then
		return true
	end

	return false
end

function slot0.getCurrentPointId(slot0)
	slot1, slot2 = TurnbackConfig.instance:getBonusPointCo(slot0.curTurnbackId)

	return CurrencyModel.instance:getCurrency(slot2) and slot3.quantity or 0
end

function slot0.checkBonusGetById(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getCurHasGetTaskBonus()) do
		if slot1 == slot7 then
			return true
		end
	end

	return false
end

function slot0.checkHasGetAllTaskReward(slot0)
	if #slot0:getCurHasGetTaskBonus() == #TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId) then
		return true
	end

	return false
end

function slot0._calcAllBonus(slot0)
	slot0.bounsdict = {}
	slot0.allBonusList = {}

	for slot5, slot6 in ipairs(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId)) do
		slot0:_calcBonus(slot0.bounsdict, slot0.allBonusList, slot6.bonus)
	end
end

function slot0.getAllBonus(slot0)
	return slot0.allBonusList
end

function slot0.getAllBonusCount(slot0)
	return #slot0.allBonusList
end

function slot0._calcBonus(slot0, slot1, slot2, slot3)
	slot7 = "|"

	for slot7, slot8 in pairs(string.split(slot3, slot7)) do
		slot9 = string.splitToNumber(slot8, "#")
		slot11 = slot9[3]

		if not slot1[slot9[2]] then
			slot1[slot10] = slot9

			table.insert(slot2, slot9)
		else
			slot1[slot10][3] = slot1[slot10][3] + slot11
		end
	end
end

function slot0.getFirstBonusHeroConfig(slot0)
	if not slot0.bonusHeroConfigList then
		return slot0:getBonusHeroConfigList()[1]
	else
		return slot0.bonusHeroConfigList[1]
	end
end

function slot0.getBonusHeroConfigList(slot0)
	if slot0.bonusHeroConfigList then
		return slot0.bonusHeroConfigList
	else
		slot0.bonusHeroConfigList = {}
		slot0.unlockHeroList = {}

		for slot5, slot6 in ipairs(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId)) do
			if slot6 and not string.nilorempty(slot6.character) then
				if not slot0.firstBonusHeroConfig then
					slot0.firstBonusHeroConfig = slot6
				end

				if slot0:checkBonusGetById(slot6.id) then
					table.insert(slot0.unlockHeroList, slot7)
				end

				table.insert(slot0.bonusHeroConfigList, slot6)
			end
		end
	end
end

function slot0.getUnlockHeroList(slot0)
	slot0.unlockHeroList = {}

	for slot5, slot6 in ipairs(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId)) do
		if slot6 and not string.nilorempty(slot6.character) then
			if slot6.needPoint <= slot0:getCurrentPointId() then
				table.insert(slot0.unlockHeroList, slot6)
			else
				table.insert(slot0.unlockHeroList, slot6)

				return slot0.unlockHeroList
			end
		end
	end

	return slot0.unlockHeroList
end

function slot0.setDropInfoList(slot0, slot1)
	slot0._dropInfoList = {}
	slot2 = TurnbackConfig.instance:getDropCoList()

	if slot1 then
		for slot6, slot7 in ipairs(slot2) do
			slot8 = {
				co = slot7
			}

			if #slot1 > 0 then
				for slot12, slot13 in ipairs(slot1) do
					if slot7.id == slot13.type then
						slot8.progress = slot13.currentNum / slot13.totalNum
					end
				end
			else
				slot8.progress = 0
			end

			slot0._dropInfoList[slot7.id] = slot8
		end
	end
end

function slot0.getDropInfoByType(slot0, slot1)
	return slot0._dropInfoList and slot0._dropInfoList[slot1]
end

function slot0.getDropInfoList(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = TurnbackConfig.instance:getDropCoCount()

	if slot0._dropInfoList and #slot0._dropInfoList > 0 then
		while #slot3 < 4 do
			if not tabletool.indexOf(slot3, math.random(1, slot4)) then
				if TurnbackConfig.instance:getDropCoById(slot5).level == 2 and #slot1 < TurnbackEnum.Level2Count then
					table.insert(slot1, slot0._dropInfoList[slot5])
					table.insert(slot3, slot5)
				elseif slot6.level == 3 and #slot2 < TurnbackEnum.Level3Count then
					table.insert(slot2, slot0._dropInfoList[slot5])
					table.insert(slot3, slot5)
				end
			end
		end
	end

	return slot1, slot2
end

function slot0.getContentWidth(slot0)
	slot5 = #TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId)

	return 50 + 50 + 100 * slot5 + 100 * (slot5 - 1)
end

slot0.instance = slot0.New()

return slot0
