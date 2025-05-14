module("modules.logic.chessgame.controller.ChessRpcController", package.seeall)

local var_0_0 = class("ChessRpcController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0._registerRcp(arg_5_0)
	return {
		[VersionActivity2_1Enum.ActivityId.LanShouPa] = Activity164Rpc.instance
	}
end

function var_0_0._getActiviyXRcpIns(arg_6_0, arg_6_1)
	if not arg_6_0._acXRcpInsMap then
		arg_6_0._acXRcpInsMap = arg_6_0:_registerRcp()

		local var_6_0 = {
			"sendGetActInfoRequest",
			"sendActStartEpisodeRequest",
			"sendActReStartEpisodeRequest",
			"sendActBeginRoundRequest",
			"sendActAbortRequest",
			"sendActRollBackRequest"
		}

		for iter_6_0, iter_6_1 in pairs(arg_6_0._acXRcpInsMap) do
			for iter_6_2, iter_6_3 in ipairs(var_6_0) do
				if not iter_6_1[iter_6_3] or type(iter_6_1[iter_6_3]) ~= "function" then
					logError(string.format("[%s] can not find function [%s]", iter_6_1.__cname, iter_6_3))
				end
			end
		end
	end

	local var_6_1 = arg_6_0._acXRcpInsMap[arg_6_1]

	if not var_6_1 then
		logError(string.format("棋盘小游戏Rpc没注册，activityId[%s]", arg_6_1))
	end

	return var_6_1
end

function var_0_0.sendGetActInfoRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:_getActiviyXRcpIns(arg_7_1)

	if var_7_0 then
		var_7_0:sendGetActInfoRequest(arg_7_1, arg_7_2, arg_7_3)
	end
end

function var_0_0.sendActStartEpisodeRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if not arg_8_1 or not arg_8_2 then
		return
	end

	local var_8_0 = arg_8_0:_getActiviyXRcpIns(arg_8_1)

	if var_8_0 then
		var_8_0:sendActStartEpisodeRequest(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	end
end

function var_0_0.onReceiveActStartEpisodeReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		ChessController.instance:initMapData(arg_9_2.activityId, arg_9_2.episodeId, arg_9_2.scene)
	end
end

function var_0_0.sendActReStartEpisodeRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not arg_10_1 or not arg_10_2 then
		return
	end

	local var_10_0 = arg_10_0:_getActiviyXRcpIns(arg_10_1)

	if var_10_0 then
		var_10_0:sendActReStartEpisodeRequest(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	end
end

function var_0_0.sendActBeginRoundRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = arg_11_0:_getActiviyXRcpIns(arg_11_1)

	if var_11_0 then
		var_11_0:sendActBeginRoundRequest(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	end
end

function var_0_0.onReceiveActBeginRoundReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		-- block empty
	end

	ChessGameModel.instance:cleanOptList()
end

function var_0_0.onReceiveActStepPush(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 and Va3ChessModel.instance:getActId() == arg_13_2.activityId then
		local var_13_0 = Va3ChessGameController.instance.event

		if var_13_0 then
			var_13_0:insertStepList(arg_13_2.steps)
		end
	end
end

function var_0_0.sendActEventEndRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:_getActiviyXRcpIns(arg_14_1)

	if var_14_0 then
		var_14_0:sendActEventEndRequest(arg_14_1, arg_14_2, arg_14_3)
	end
end

function var_0_0.onReceiveActEventEndReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendActAbortRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_0:_getActiviyXRcpIns(arg_16_1, arg_16_2)

	if var_16_0 then
		var_16_0:sendActAbortRequest(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	end
end

function var_0_0.onReceiveActAbortReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendActRollBackRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = arg_18_0:_getActiviyXRcpIns(arg_18_1)

	if var_18_0 then
		var_18_0:sendActRollBackRequest(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
