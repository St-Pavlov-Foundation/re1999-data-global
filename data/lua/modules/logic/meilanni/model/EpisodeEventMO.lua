module("modules.logic.meilanni.model.EpisodeEventMO", package.seeall)

local var_0_0 = pureTable("EpisodeEventMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.eventId = arg_1_1.eventId
	arg_1_0.isFinish = arg_1_1.isFinish
	arg_1_0.option = arg_1_1.option
	arg_1_0.index = arg_1_1.index

	arg_1_0:_initHistorySelect(arg_1_1)
	arg_1_0:_initHistorylist(arg_1_1)

	arg_1_0.config = MeilanniConfig.instance:getElementConfig(arg_1_0.eventId)

	if not arg_1_0.config then
		logError(string.format("EpisodeEventMO no config id:%s", arg_1_0.eventId))

		return
	end

	arg_1_0.interactParam = GameUtil.splitString2(arg_1_0.config.interactParam, true, "|", "#")
end

function var_0_0._initHistorySelect(arg_2_0, arg_2_1)
	arg_2_0.historySelect = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.historySelect) do
		arg_2_0.historySelect[iter_2_1] = iter_2_1
	end
end

function var_0_0.optionIsSelected(arg_3_0, arg_3_1)
	return arg_3_0.historySelect[arg_3_1]
end

function var_0_0._initHistorylist(arg_4_0, arg_4_1)
	arg_4_0.historylist = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.historylist) do
		local var_4_0 = EventHistoryMO.New()

		var_4_0:init(iter_4_1)

		arg_4_0.historylist[var_4_0.index] = var_4_0
	end
end

function var_0_0.getSkipDialog(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.interactParam) do
		if iter_5_1[1] == MeilanniEnum.ElementType.Dialog then
			local var_5_0 = iter_5_1[2]
			local var_5_1 = lua_activity108_dialog.configDict[var_5_0]
			local var_5_2 = var_5_1 and var_5_1[-1]

			if var_5_2 then
				return var_5_2
			end
		end
	end
end

function var_0_0.getType(arg_6_0)
	local var_6_0 = arg_6_0.interactParam[arg_6_0.index + 1]

	return var_6_0 and var_6_0[1]
end

function var_0_0.getNextType(arg_7_0)
	local var_7_0 = arg_7_0.interactParam[arg_7_0.index + 2]

	return var_7_0 and var_7_0[1]
end

function var_0_0.getParam(arg_8_0)
	local var_8_0 = arg_8_0.interactParam[arg_8_0.index + 1]

	return var_8_0 and var_8_0[2]
end

function var_0_0.getPrevParam(arg_9_0)
	local var_9_0 = arg_9_0.interactParam[arg_9_0.index]

	return var_9_0 and var_9_0[2]
end

function var_0_0.getBattleId(arg_10_0)
	local var_10_0 = arg_10_0:getParam()

	return tonumber(var_10_0)
end

function var_0_0.getConfigBattleId(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.interactParam) do
		if iter_11_1[1] == MeilanniEnum.ElementType.Battle then
			local var_11_0 = iter_11_1[2]

			return tonumber(var_11_0)
		end
	end
end

return var_0_0
