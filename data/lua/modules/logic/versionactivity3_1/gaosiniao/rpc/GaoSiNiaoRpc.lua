module("modules.logic.versionactivity3_1.gaosiniao.rpc.GaoSiNiaoRpc", package.seeall)

local var_0_0 = class("GaoSiNiaoRpc", Activity210Rpc)

function var_0_0.ctor(arg_1_0)
	Activity210Rpc.instance = arg_1_0
end

function var_0_0._actId(arg_2_0)
	return GaoSiNiaoController.instance:actId()
end

function var_0_0._taskType(arg_3_0)
	return GaoSiNiaoController.instance:taskType()
end

function var_0_0._isValid(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2.activityId

	if arg_4_0:_actId() ~= var_4_0 then
		return false
	end

	if arg_4_1 ~= 0 then
		return false
	end

	return true
end

function var_0_0.sendGetAct210InfoRequest(arg_5_0, arg_5_1, arg_5_2)
	return var_0_0.super.sendGetAct210InfoRequest(arg_5_0, arg_5_0:_actId(), arg_5_1, arg_5_2)
end

function var_0_0._onReceiveGetAct210InfoReply(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0:_isValid(arg_6_1, arg_6_2) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveGetAct210InfoReply(arg_6_2)
end

function var_0_0.sendAct210SaveEpisodeProgressRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return var_0_0.super.sendAct210SaveEpisodeProgressRequest(arg_7_0, arg_7_0:_actId(), arg_7_1, arg_7_2, arg_7_3, arg_7_4)
end

function var_0_0._onReceiveAct210SaveEpisodeProgressReply(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0:_isValid(arg_8_1, arg_8_2) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveAct210SaveEpisodeProgressReply(arg_8_2)
end

function var_0_0.sendAct210FinishEpisodeRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	return var_0_0.super.sendAct210FinishEpisodeRequest(arg_9_0, arg_9_0:_actId(), arg_9_1, arg_9_2, arg_9_3, arg_9_4)
end

function var_0_0._onReceiveAct210FinishEpisodeReply(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0:_isValid(arg_10_1, arg_10_2) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveAct210FinishEpisodeReply(arg_10_2)
end

function var_0_0.sendAct210ChooseEpisodeBranchRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	return var_0_0.super.sendAct210ChooseEpisodeBranchRequest(arg_11_0, arg_11_0:_actId(), arg_11_1, arg_11_2, arg_11_3, arg_11_4)
end

function var_0_0._onReceiveAct210ChooseEpisodeBranchReply(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0:_isValid(arg_12_1, arg_12_2) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveAct210ChooseEpisodeBranchReply(arg_12_2)
end

function var_0_0._onReceiveAct210EpisodePush(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0:_isValid(arg_13_1, arg_13_2) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveAct210EpisodePush(arg_13_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
