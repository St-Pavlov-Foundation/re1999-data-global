module("modules.logic.guide.controller.GuideExceptionController", package.seeall)

local var_0_0 = class("GuideExceptionController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.guideId = nil
	arg_1_0.stepId = nil
	arg_1_0.checkFuncDict = {}
	arg_1_0.checkFuncDict.checkCurrency = GuideExceptionChecker.checkCurrency
	arg_1_0.checkFuncDict.checkDungeonUsePower = GuideExceptionChecker.checkDungeonUsePower
	arg_1_0.checkFuncDict.checkBuildingPut = GuideExceptionChecker.checkBuildingPut
	arg_1_0.checkFuncDict.checkBuildingPutMatchStep = GuideExceptionChecker.checkBuildingPutMatchStep
	arg_1_0.checkFuncDict.checkViewShow = GuideExceptionChecker.checkViewShow
	arg_1_0.checkFuncDict.checkViewNotShow = GuideExceptionChecker.checkViewNotShow
	arg_1_0.checkFuncDict.checkViewExist = GuideExceptionChecker.checkViewExist
	arg_1_0.checkFuncDict.checkViewNotExist = GuideExceptionChecker.checkViewNotExist
	arg_1_0.checkFuncDict.checkScene = GuideExceptionChecker.checkScene
	arg_1_0.checkFuncDict.checkMaterial = GuideExceptionChecker.checkMaterial
	arg_1_0.checkFuncDict.findTalentFirstChess = GuideExceptionChecker.findTalentFirstChess
	arg_1_0.checkFuncDict.checkTaskFinish = GuideExceptionChecker.checkTaskFinish
	arg_1_0.checkFuncDict.checkTaskNotFinish = GuideExceptionChecker.checkTaskNotFinish
	arg_1_0.checkFuncDict.checkBlockCountGE = GuideExceptionChecker.checkBlockCountGE
	arg_1_0.checkFuncDict.checkBlockCountL = GuideExceptionChecker.checkBlockCountL
	arg_1_0.checkFuncDict.checkRoomCanGetRes = GuideExceptionChecker.checkRoomCanGetRes
	arg_1_0.checkFuncDict.noRemainStars = GuideExceptionChecker.noRemainStars
	arg_1_0.checkFuncDict.noPointReward = GuideExceptionChecker.noPointReward
	arg_1_0.checkFuncDict.checkAllEquipLevel = GuideExceptionChecker.checkAllEquipLevel
	arg_1_0.checkFuncDict.checkHeroTalent = GuideExceptionChecker.checkHeroTalent
	arg_1_0.checkFuncDict.checkSummon = GuideExceptionChecker.checkSummon
	arg_1_0.checkFuncDict.check1_2DungeonHasNotCollectNote = GuideExceptionChecker.check1_2DungeonHasNotCollectNote
	arg_1_0.checkFuncDict.check1_2DungeonHasNotBonusFinisd = GuideExceptionChecker.check1_2DungeonHasNotBonusFinisd
	arg_1_0.checkFuncDict.check1_2DungeonBonusFinish = GuideExceptionChecker.check1_2DungeonBonusFinish
	arg_1_0.checkFuncDict.checkRoleStoryCanExchange = GuideExceptionChecker.checkRoleStoryCanExchange
	arg_1_0.checkFuncDict.checkCurBgmGearStateEqual = GuideExceptionChecker.checkCurBgmGearStateEqual
	arg_1_0.checkFuncDict.checkCurBgmDeviceNotShowingPPT = GuideExceptionChecker.checkCurBgmDeviceNotShowingPPT
	arg_1_0.checkFuncDict.checkReturnFalse = GuideExceptionChecker.checkReturnFalse
	arg_1_0.checkFuncDict.checkMaterialNotEnough = GuideExceptionChecker.checkMaterialNotEnough
	arg_1_0.checkFuncDict.checkCan174EnoughHpToBet = GuideExceptionChecker.checkCan174EnoughHpToBet
	arg_1_0.handlerFuncDict = {}
	arg_1_0.handlerFuncDict.finishStep = GuideExceptionHandler.finishStep
	arg_1_0.handlerFuncDict.finishGuide = GuideExceptionHandler.finishGuide
	arg_1_0.handlerFuncDict.gotoStep = GuideExceptionHandler.gotoStep
	arg_1_0.handlerFuncDict.openView = GuideExceptionHandler.openView
	arg_1_0.handlerFuncDict.closeView = GuideExceptionHandler.closeView
	arg_1_0._findBtn = GuideExceptionFindBtn.New()
end

function var_0_0.checkStep(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = GuideConfig.instance:getStepCO(arg_2_1, arg_2_2)

	if not var_2_0 then
		return
	end

	if string.nilorempty(var_2_0.exception) then
		if arg_2_0:_checkInterruptFinish(arg_2_1) then
			arg_2_0:_startInterruptFinish(arg_2_1, arg_2_2)
		end

		return
	end

	arg_2_0.guideId = arg_2_1
	arg_2_0.stepId = arg_2_2

	if var_2_0.exceptionDelay > 0 then
		TaskDispatcher.runDelay(arg_2_0._startCheck, arg_2_0, var_2_0.exceptionDelay)
	else
		arg_2_0:_startCheck()
	end
end

function var_0_0.stopCheck(arg_3_0)
	arg_3_0._findBtn:stopCheck()
	TaskDispatcher.cancelTask(arg_3_0._startCheck, arg_3_0)
end

function var_0_0._checkInterruptFinish(arg_4_0, arg_4_1)
	return GuideConfig.instance:getGuideCO(arg_4_1).interruptFinish == 1
end

function var_0_0._startInterruptFinish(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = GuideModel.instance:getStepGOPath(arg_5_1, arg_5_2)

	if string.nilorempty(var_5_0) then
		return
	end

	local var_5_1 = GuideConfig.instance:getGuideCO(arg_5_1)
	local var_5_2 = "4_1"
	local var_5_3 = {
		"finishGuide"
	}
	local var_5_4 = {}

	arg_5_0._findBtn:startCheck(arg_5_1, arg_5_2, var_5_2, var_5_3, var_5_4)
end

function var_0_0._startCheck(arg_6_0)
	local var_6_0 = arg_6_0.guideId
	local var_6_1 = arg_6_0.stepId

	arg_6_0.guideId = nil
	arg_6_0.stepId = nil

	local var_6_2 = GuideConfig.instance:getStepCO(var_6_0, var_6_1)
	local var_6_3 = string.split(var_6_2.exception, "|")

	if not string.find(var_6_2.exception, "findBtn") and arg_6_0:_checkInterruptFinish(var_6_0) then
		arg_6_0:_startInterruptFinish(var_6_0, var_6_1)
	end

	for iter_6_0 = 1, #var_6_3 do
		local var_6_4 = string.split(var_6_3[iter_6_0], "#")
		local var_6_5 = var_6_4[1]
		local var_6_6 = var_6_4[2]
		local var_6_7 = {}
		local var_6_8 = {}

		for iter_6_1 = 3, #var_6_4, 2 do
			table.insert(var_6_7, var_6_4[iter_6_1])
			table.insert(var_6_8, var_6_4[iter_6_1 + 1])
		end

		if var_6_5 == "findBtn" then
			arg_6_0._findBtn:startCheck(var_6_0, var_6_1, var_6_6, var_6_7, var_6_8)
		else
			if arg_6_0.checkFuncDict[var_6_5] == nil then
				logError("guide exception checker not exist: " .. var_6_5)
			end

			if not arg_6_0.checkFuncDict[var_6_5](var_6_0, var_6_1, var_6_6) then
				logNormal(string.format("<color=#FF0000>guide_%d_%d exception-> %s</color>", var_6_0, var_6_1, var_6_3[iter_6_0]))

				for iter_6_2 = 1, #var_6_7 do
					arg_6_0:handle(var_6_0, var_6_1, var_6_7[iter_6_2], var_6_8[iter_6_2])
				end

				break
			end
		end
	end
end

function var_0_0.handle(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.handlerFuncDict[arg_7_3](arg_7_1, arg_7_2, arg_7_4)
	GuideController.instance:statFinishStep(arg_7_1, arg_7_2, true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
