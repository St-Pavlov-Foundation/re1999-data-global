module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpGachaRoundMO", package.seeall)

local var_0_0 = class("V2a4_WarmUpGachaRoundMO")
local var_0_1 = string.format
local var_0_2 = table.insert

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._index = arg_1_2
	arg_1_0._waveMO = arg_1_1
	arg_1_0._CO = arg_1_3
	arg_1_0._ansIsYes = not arg_1_4
	arg_1_0._ansIndex = arg_1_5
	arg_1_0._yesOrNoDialogId = arg_1_3[arg_1_0:yesOrNoFieldName()]
end

function var_0_0.index(arg_2_0)
	return arg_2_0._index
end

function var_0_0.yesOrNoFieldName(arg_3_0)
	return (arg_3_0._ansIsYes and "yes" or "no") .. arg_3_0._ansIndex
end

function var_0_0.srcloc(arg_4_0)
	local var_4_0 = arg_4_0:type()

	if var_4_0 == V2a4_WarmUpEnum.AskType.Text then
		return var_0_1("[logError]2 .4预热活动_接听电话.xlsx - export_文字型题库集（路人）: id=%s, level=%s, %s=%s", arg_4_0:cfgId(), arg_4_0:level(), arg_4_0:yesOrNoFieldName(), arg_4_0._yesOrNoDialogId)
	elseif var_4_0 == V2a4_WarmUpEnum.AskType.Photo then
		return var_0_1("[logError] 2.4预热活动_接听电话.xlsx - export_图片型题库集: id=%s, level=%s, %s=%s", arg_4_0:cfgId(), arg_4_0:level(), arg_4_0:yesOrNoFieldName(), arg_4_0._yesOrNoDialogId)
	else
		return "[Unknown]"
	end
end

function var_0_0.getDialogCOList(arg_5_0, arg_5_1)
	local var_5_0 = {}

	arg_5_0:appendDialogCOList(var_5_0, arg_5_1)

	return var_5_0
end

function var_0_0.appendDialogCOList(arg_6_0, arg_6_1, arg_6_2)
	if isDebugBuild then
		V2a4_WarmUpConfig.instance:appendDialogCOList(arg_6_1, arg_6_0:srcloc(), arg_6_2)
	else
		V2a4_WarmUpConfig.instance:appendDialogCOList(arg_6_1, nil, arg_6_2)
	end
end

function var_0_0.getDialogCOList_yesorno(arg_7_0)
	return arg_7_0:getDialogCOList(arg_7_0._yesOrNoDialogId)
end

function var_0_0.getDialogCOList_preTalk(arg_8_0)
	return arg_8_0:getDialogCOList(arg_8_0._CO.preTalk)
end

function var_0_0.getDialogCOList_passTalk(arg_9_0)
	return arg_9_0:getDialogCOList(arg_9_0._CO.passTalk)
end

function var_0_0.getDialogCOList_failTalk(arg_10_0)
	return arg_10_0:getDialogCOList(arg_10_0._CO.failTalk)
end

function var_0_0.getDialogCOList_passTalkAllYes(arg_11_0)
	return arg_11_0:getDialogCOList(arg_11_0._CO.passTalkAllYes)
end

function var_0_0.getDialogCOList_prefaceAndPreTalk(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = V2a4_WarmUpConfig.instance:prefaceDialogListCO()

	for iter_12_0, iter_12_1 in ipairs(var_12_1 or {}) do
		var_0_2(var_12_0, iter_12_1)
	end

	arg_12_0:appendDialogCOList(var_12_0, arg_12_0._CO.preTalk)

	return var_12_0
end

function var_0_0.type(arg_13_0)
	return arg_13_0._waveMO:type()
end

function var_0_0.ansIsYes(arg_14_0)
	return arg_14_0._ansIsYes
end

function var_0_0.ansIndex(arg_15_0)
	return arg_15_0._ansIndex
end

function var_0_0.cfgId(arg_16_0)
	return arg_16_0._CO.id
end

function var_0_0.level(arg_17_0)
	return arg_17_0._CO.level
end

function var_0_0.imgName(arg_18_0)
	return arg_18_0._CO.imgName
end

function var_0_0.s_type(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(V2a4_WarmUpEnum.AskType) do
		if arg_19_0 == iter_19_1 then
			return iter_19_0
		end
	end

	return "[V2a4_WarmUpBattleWaveMO - s_type] error !"
end

function var_0_0.dump(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2 = arg_20_2 or 0

	local var_20_0 = string.rep("\t", arg_20_2)

	var_0_2(arg_20_1, var_20_0 .. var_0_1("index = %s", arg_20_0._index))
	var_0_2(arg_20_1, var_20_0 .. var_0_1("issue id = %s", arg_20_0:cfgId()))
	var_0_2(arg_20_1, var_20_0 .. var_0_1("level = %s", arg_20_0:level()))
	var_0_2(arg_20_1, var_20_0 .. var_0_1("ansIsYes? %s", arg_20_0:ansIsYes()))
	var_0_2(arg_20_1, var_20_0 .. var_0_1("type = %s", var_0_0.s_type(arg_20_0:type())))
	var_0_2(arg_20_1, var_20_0 .. var_0_1("whichAns? %s(%s)", arg_20_0:yesOrNoFieldName(), arg_20_0._yesOrNoDialogId))
	var_0_2(arg_20_1, var_20_0 .. var_0_1("preTalk(%s), passTalk(%s), failTalk(%s)", arg_20_0._CO.preTalk, arg_20_0._CO.passTalk, arg_20_0._CO.failTalk))
end

return var_0_0
