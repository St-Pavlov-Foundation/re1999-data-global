module("modules.logic.activity.controller.chessmap.step.ActivityChessStepSyncObject", package.seeall)

local var_0_0 = class("ActivityChessStepSyncObject", ActivityChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.object
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.data
	local var_1_3 = ActivityChessGameModel.instance:getObjectDataById(var_1_1)
	local var_1_4 = var_1_3.data
	local var_1_5 = ActivityChessGameModel.instance:syncObjectData(var_1_1, var_1_2)

	if var_1_5 ~= nil then
		local var_1_6 = var_1_3.data

		if arg_1_0:dataHasChanged(var_1_5, "alertArea") then
			ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
		end

		if arg_1_0:dataHasChanged(var_1_5, "goToObject") then
			local var_1_7 = ActivityChessGameController.instance.interacts:get(var_1_1)

			if var_1_7 then
				var_1_7.goToObject:updateGoToObject()
			end
		end

		if arg_1_0:dataHasChanged(var_1_5, "lostTarget") then
			local var_1_8 = ActivityChessGameController.instance.interacts:get(var_1_1)

			if var_1_8 then
				var_1_8.effect:refreshSearchFailed()
				var_1_8.goToObject:refreshTarget()
			end
		end
	end

	arg_1_0:finish()
end

function var_0_0.dataHasChanged(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1[arg_2_2] ~= nil or arg_2_1.__deleteFields and arg_2_1.__deleteFields[arg_2_2] then
		return true
	end

	return false
end

function var_0_0.finish(arg_3_0)
	var_0_0.super.finish(arg_3_0)
end

return var_0_0
