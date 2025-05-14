module("modules.logic.chessgame.model.ChessModel", package.seeall)

local var_0_0 = class("ChessModel", BaseModel)

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

	local var_3_0 = ChessConfig.instance:getEpisodeCo(arg_3_0._activityId, arg_3_1)

	if var_3_0 then
		if var_3_0.mapIds then
			arg_3_0._currentMapId = var_3_0.mapIds
		elseif var_3_0.mapIds then
			local var_3_1 = string.split(var_3_0.mapIds, "#")

			arg_3_0._currentMapId = tonumber(var_3_1[1])
		end
	else
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

function var_0_0.getCurrMapId(arg_7_0)
	return arg_7_0._currentMapId
end

function var_0_0.setNowMapIndex(arg_8_0, arg_8_1)
	arg_8_0._currMapIndex = arg_8_1
end

function var_0_0.getNowMapIndex(arg_9_0)
	return arg_9_0._currMapIndex
end

function var_0_0.getEpisodeData(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:_getModelIns(arg_10_0._activityId)

	if var_10_0 then
		return var_10_0:getEpisodeData(arg_10_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
