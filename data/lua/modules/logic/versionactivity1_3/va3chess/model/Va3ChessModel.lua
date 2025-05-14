module("modules.logic.versionactivity1_3.va3chess.model.Va3ChessModel", package.seeall)

local var_0_0 = class("Va3ChessModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0._registerModelIns(arg_3_0)
	return {
		[Va3ChessEnum.ActivityId.Act120] = Activity120Model.instance,
		[Va3ChessEnum.ActivityId.Act122] = Activity122Model.instance,
		[Va3ChessEnum.ActivityId.Act142] = Activity142Model.instance
	}
end

function var_0_0._getModelIns(arg_4_0, arg_4_1)
	if not arg_4_0._acModelInsMap then
		arg_4_0._acModelInsMap = arg_4_0:_registerModelIns()

		local var_4_0 = {
			"getEpisodeData"
		}

		for iter_4_0, iter_4_1 in pairs(arg_4_0._acModelInsMap) do
			for iter_4_2, iter_4_3 in ipairs(var_4_0) do
				if not iter_4_1[iter_4_3] or type(iter_4_1[iter_4_3]) ~= "function" then
					logError(string.format("[%s] can not find function [%s]", iter_4_1.__cname, iter_4_3))
				end
			end
		end
	end

	local var_4_1 = arg_4_0._acModelInsMap[arg_4_1]

	if not var_4_1 then
		logError(string.format("棋盘小游戏Model没注册，activityId[%s]", arg_4_1))
	end

	return var_4_1
end

function var_0_0.setEpisodeId(arg_5_0, arg_5_1)
	arg_5_0._currentEpisodeId = arg_5_1

	if not arg_5_1 then
		arg_5_0._currentMapId = nil

		return
	end

	local var_5_0 = Va3ChessConfig.instance:getEpisodeCo(arg_5_0._activityId, arg_5_1)

	if var_5_0 then
		if var_5_0.mapId then
			arg_5_0._currentMapId = var_5_0.mapId
		elseif var_5_0.mapIds then
			local var_5_1 = string.split(var_5_0.mapIds, "#")

			arg_5_0._currentMapId = tonumber(var_5_1[1])
		end
	else
		logError("activity109_episode not found! id = " .. tostring(arg_5_1) .. ", in act = " .. tostring(arg_5_0._activityId))

		arg_5_0._currentMapId = nil
	end
end

function var_0_0.setActId(arg_6_0, arg_6_1)
	arg_6_0._activityId = arg_6_1
end

function var_0_0.getActId(arg_7_0)
	return arg_7_0._activityId
end

function var_0_0.getEpisodeId(arg_8_0)
	return arg_8_0._currentEpisodeId
end

function var_0_0.getMapId(arg_9_0)
	return arg_9_0._currentMapId
end

function var_0_0.getEpisodeData(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:_getModelIns(arg_10_0._activityId)

	if var_10_0 then
		return var_10_0:getEpisodeData(arg_10_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
