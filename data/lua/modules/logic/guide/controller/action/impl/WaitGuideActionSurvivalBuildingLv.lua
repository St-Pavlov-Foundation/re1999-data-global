module("modules.logic.guide.controller.action.impl.WaitGuideActionSurvivalBuildingLv", package.seeall)

local var_0_0 = class("WaitGuideActionSurvivalBuildingLv", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")

	arg_1_0.buildingType = var_1_0[1]
	arg_1_0.buildingLv = var_1_0[2] or 0

	if arg_1_0:checkDone() then
		return
	end

	SurvivalController.instance:registerCallback(SurvivalEvent.OnBuildingInfoUpdate, arg_1_0.onBuildingInfoUpdate, arg_1_0)
end

function var_0_0.checkDone(arg_2_0)
	local var_2_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_2_0 then
		return
	end

	if var_2_0:checkBuildingTypeLev(arg_2_0.buildingType, arg_2_0.buildingLv) then
		arg_2_0:onDone(true)

		return true
	end

	return false
end

function var_0_0.onBuildingInfoUpdate(arg_3_0)
	arg_3_0:checkDone()
end

function var_0_0.clearWork(arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnBuildingInfoUpdate, arg_4_0.onBuildingInfoUpdate, arg_4_0)
end

return var_0_0
