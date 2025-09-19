module("modules.logic.versionactivity2_5.autochess.model.AutoChessModel", package.seeall)

local var_0_0 = class("AutoChessModel", BaseModel)

function var_0_0.enterSceneReply(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.actId = arg_1_3
	arg_1_0.moduleId = arg_1_1

	local var_1_0 = AutoChessMO.New()

	var_1_0:updateSvrScene(arg_1_2)

	arg_1_0.chessMo = var_1_0
end

function var_0_0.setEpisodeId(arg_2_0, arg_2_1)
	arg_2_0.episodeId = arg_2_1
end

function var_0_0.getChessMo(arg_3_0, arg_3_1)
	if arg_3_0.chessMo then
		return arg_3_0.chessMo
	end

	if not arg_3_1 then
		logError("异常:不存在游戏数据%s")
	end
end

function var_0_0.svrResultData(arg_4_0, arg_4_1)
	arg_4_0.resultData = arg_4_1
end

function var_0_0.svrSettleData(arg_5_0, arg_5_1)
	arg_5_0.settleData = arg_5_1
end

function var_0_0.clearData(arg_6_0)
	arg_6_0.actId = nil
	arg_6_0.moduleId = nil
	arg_6_0.episodeId = nil
	arg_6_0.chessMo = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
