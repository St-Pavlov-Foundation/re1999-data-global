module("modules.logic.versionactivity2_5.autochess.model.AutoChessModel", package.seeall)

local var_0_0 = class("AutoChessModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.chessMoDic = {}
end

function var_0_0.enterSceneReply(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.curModuleId = arg_3_1

	local var_3_0 = AutoChessMO.New()

	var_3_0:updateSvrScene(arg_3_2)

	arg_3_0.chessMoDic[arg_3_1] = var_3_0
end

function var_0_0.setEpisodeId(arg_4_0, arg_4_1)
	arg_4_0.episodeId = arg_4_1
end

function var_0_0.getCurModuleId(arg_5_0)
	return arg_5_0.curModuleId
end

function var_0_0.getChessMo(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1 = arg_6_1 or arg_6_0.curModuleId

	local var_6_0 = arg_6_0.chessMoDic[arg_6_1]

	if var_6_0 then
		return var_6_0
	end

	if not arg_6_2 then
		logError(string.format("异常:不存在游戏数据%s", arg_6_1))
	end
end

function var_0_0.svrResultData(arg_7_0, arg_7_1)
	arg_7_0.resultData = arg_7_1
end

function var_0_0.svrSettleData(arg_8_0, arg_8_1)
	arg_8_0.settleData = arg_8_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
