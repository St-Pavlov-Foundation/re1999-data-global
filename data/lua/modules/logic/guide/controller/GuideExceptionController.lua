module("modules.logic.guide.controller.GuideExceptionController", package.seeall)

slot0 = class("GuideExceptionController", BaseController)

function slot0.onInit(slot0)
	slot0.guideId = nil
	slot0.stepId = nil
	slot0.checkFuncDict = {
		checkCurrency = GuideExceptionChecker.checkCurrency,
		checkDungeonUsePower = GuideExceptionChecker.checkDungeonUsePower,
		checkBuildingPut = GuideExceptionChecker.checkBuildingPut,
		checkBuildingPutMatchStep = GuideExceptionChecker.checkBuildingPutMatchStep,
		checkViewShow = GuideExceptionChecker.checkViewShow,
		checkViewNotShow = GuideExceptionChecker.checkViewNotShow,
		checkViewExist = GuideExceptionChecker.checkViewExist,
		checkViewNotExist = GuideExceptionChecker.checkViewNotExist,
		checkScene = GuideExceptionChecker.checkScene,
		checkMaterial = GuideExceptionChecker.checkMaterial,
		findTalentFirstChess = GuideExceptionChecker.findTalentFirstChess,
		checkTaskFinish = GuideExceptionChecker.checkTaskFinish,
		checkTaskNotFinish = GuideExceptionChecker.checkTaskNotFinish,
		checkBlockCountGE = GuideExceptionChecker.checkBlockCountGE,
		checkBlockCountL = GuideExceptionChecker.checkBlockCountL,
		checkRoomCanGetRes = GuideExceptionChecker.checkRoomCanGetRes,
		noRemainStars = GuideExceptionChecker.noRemainStars,
		noPointReward = GuideExceptionChecker.noPointReward,
		checkAllEquipLevel = GuideExceptionChecker.checkAllEquipLevel,
		checkHeroTalent = GuideExceptionChecker.checkHeroTalent,
		checkSummon = GuideExceptionChecker.checkSummon,
		check1_2DungeonHasNotCollectNote = GuideExceptionChecker.check1_2DungeonHasNotCollectNote,
		check1_2DungeonHasNotBonusFinisd = GuideExceptionChecker.check1_2DungeonHasNotBonusFinisd,
		check1_2DungeonBonusFinish = GuideExceptionChecker.check1_2DungeonBonusFinish,
		checkRoleStoryCanExchange = GuideExceptionChecker.checkRoleStoryCanExchange,
		checkCurBgmGearStateEqual = GuideExceptionChecker.checkCurBgmGearStateEqual,
		checkCurBgmDeviceNotShowingPPT = GuideExceptionChecker.checkCurBgmDeviceNotShowingPPT,
		checkReturnFalse = GuideExceptionChecker.checkReturnFalse,
		checkMaterialNotEnough = GuideExceptionChecker.checkMaterialNotEnough,
		checkCan174EnoughHpToBet = GuideExceptionChecker.checkCan174EnoughHpToBet
	}
	slot0.handlerFuncDict = {
		finishStep = GuideExceptionHandler.finishStep,
		finishGuide = GuideExceptionHandler.finishGuide,
		gotoStep = GuideExceptionHandler.gotoStep,
		openView = GuideExceptionHandler.openView,
		closeView = GuideExceptionHandler.closeView
	}
	slot0._findBtn = GuideExceptionFindBtn.New()
end

function slot0.checkStep(slot0, slot1, slot2)
	if not GuideConfig.instance:getStepCO(slot1, slot2) then
		return
	end

	if string.nilorempty(slot3.exception) then
		if slot0:_checkInterruptFinish(slot1) then
			slot0:_startInterruptFinish(slot1, slot2)
		end

		return
	end

	slot0.guideId = slot1
	slot0.stepId = slot2

	if slot3.exceptionDelay > 0 then
		TaskDispatcher.runDelay(slot0._startCheck, slot0, slot3.exceptionDelay)
	else
		slot0:_startCheck()
	end
end

function slot0.stopCheck(slot0)
	slot0._findBtn:stopCheck()
	TaskDispatcher.cancelTask(slot0._startCheck, slot0)
end

function slot0._checkInterruptFinish(slot0, slot1)
	return GuideConfig.instance:getGuideCO(slot1).interruptFinish == 1
end

function slot0._startInterruptFinish(slot0, slot1, slot2)
	if string.nilorempty(GuideModel.instance:getStepGOPath(slot1, slot2)) then
		return
	end

	slot4 = GuideConfig.instance:getGuideCO(slot1)

	slot0._findBtn:startCheck(slot1, slot2, "4_1", {
		"finishGuide"
	}, {})
end

function slot0._startCheck(slot0)
	slot0.guideId = nil
	slot0.stepId = nil
	slot3 = GuideConfig.instance:getStepCO(slot0.guideId, slot0.stepId)
	slot4 = string.split(slot3.exception, "|")

	if not string.find(slot3.exception, "findBtn") and slot0:_checkInterruptFinish(slot1) then
		slot0:_startInterruptFinish(slot1, slot2)
	end

	for slot8 = 1, #slot4 do
		slot9 = string.split(slot4[slot8], "#")
		slot10 = slot9[1]
		slot11 = slot9[2]

		for slot17 = 3, #slot9, 2 do
			table.insert({}, slot9[slot17])
			table.insert({}, slot9[slot17 + 1])
		end

		if slot10 == "findBtn" then
			slot0._findBtn:startCheck(slot1, slot2, slot11, slot12, slot13)
		else
			if slot0.checkFuncDict[slot10] == nil then
				logError("guide exception checker not exist: " .. slot10)
			end

			if not slot0.checkFuncDict[slot10](slot1, slot2, slot11) then
				slot17 = slot1

				logNormal(string.format("<color=#FF0000>guide_%d_%d exception-> %s</color>", slot17, slot2, slot4[slot8]))

				for slot17 = 1, #slot12 do
					slot0:handle(slot1, slot2, slot12[slot17], slot13[slot17])
				end

				break
			end
		end
	end
end

function slot0.handle(slot0, slot1, slot2, slot3, slot4)
	slot0.handlerFuncDict[slot3](slot1, slot2, slot4)
	GuideController.instance:statFinishStep(slot1, slot2, true)
end

slot0.instance = slot0.New()

return slot0
