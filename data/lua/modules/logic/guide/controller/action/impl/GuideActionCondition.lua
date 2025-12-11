module("modules.logic.guide.controller.action.impl.GuideActionCondition", package.seeall)

local var_0_0 = class("GuideActionCondition", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = tonumber(var_1_0[2])
	local var_1_3 = tonumber(var_1_0[3])
	local var_1_4 = var_1_0[4]
	local var_1_5 = arg_1_0[var_1_1]
	local var_1_6 = GuideModel.instance:getById(arg_1_0.guideId)

	if var_1_5 and var_1_5(arg_1_0, var_1_4) then
		if var_1_6 then
			var_1_6.currStepId = var_1_3 - 1
		end
	elseif var_1_6 then
		var_1_6.currStepId = var_1_2 - 1
	end

	arg_1_0:onDone(true)
end

function var_0_0.checkRoomTransport(arg_2_0)
	local var_2_0 = false
	local var_2_1 = RoomModel.instance:getBuildingInfoList()

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_2 = RoomConfig.instance:getBuildingConfig(iter_2_1.buildingId)

		if var_2_2 and var_2_2.buildingType == RoomBuildingEnum.BuildingType.Collect and iter_2_1.use then
			var_2_0 = true

			break
		end
	end

	if not var_2_0 then
		return false
	end

	local var_2_3 = false

	for iter_2_2, iter_2_3 in ipairs(var_2_1) do
		local var_2_4 = RoomConfig.instance:getBuildingConfig(iter_2_3.buildingId)

		if var_2_4 and var_2_4.buildingType == RoomBuildingEnum.BuildingType.Process and iter_2_3.use then
			var_2_3 = true

			break
		end
	end

	return var_2_3
end

function var_0_0.checkRoomTaskHasFinished(arg_3_0)
	local var_3_0, var_3_1 = RoomSceneTaskController.instance:isFirstTaskFinished()

	return var_3_0
end

function var_0_0.checkSurvivalWeekDay(arg_4_0)
	return SurvivalShelterModel.instance:getWeekInfo().day > 1
end

return var_0_0
