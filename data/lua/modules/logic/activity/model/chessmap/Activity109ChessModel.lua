module("modules.logic.activity.model.chessmap.Activity109ChessModel", package.seeall)

local var_0_0 = class("Activity109ChessModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.setEpisodeId(arg_3_0, arg_3_1)
	arg_3_0._currentEpisodeId = arg_3_1

	if not arg_3_1 then
		arg_3_0._currentMapId = nil

		return
	end

	local var_3_0 = Activity109Config.instance:getEpisodeCo(arg_3_0._activityId, arg_3_1)

	if var_3_0 then
		arg_3_0._currentMapId = var_3_0.mapId
	else
		logError("activity109_episode not found! id = " .. tostring(arg_3_1) .. ", in act = " .. tostring(arg_3_0._activityId))

		arg_3_0._currentMapId = nil
	end
end

function var_0_0.setActId(arg_4_0, arg_4_1)
	arg_4_0._activityId = arg_4_1
end

function var_0_0.getActId(arg_5_0)
	return arg_5_0._activityId
end

function var_0_0.getEpisodeId(arg_6_0)
	return arg_6_0._currentEpisodeId
end

function var_0_0.getMapId(arg_7_0)
	return arg_7_0._currentMapId
end

var_0_0.instance = var_0_0.New()

return var_0_0
