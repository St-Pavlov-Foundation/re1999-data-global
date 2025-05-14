module("modules.logic.rouge.config.RougeMapConfig", package.seeall)

local var_0_0 = class("RougeMapConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"rouge_layer",
		"rouge_middle_layer",
		"rouge_event",
		"rouge_fight_event",
		"rouge_choice_event",
		"rouge_choice",
		"rouge_shop_event",
		"rouge_interactive",
		"rouge_path_select",
		"rouge_piece",
		"rouge_piece_talk",
		"rouge_piece_select",
		"rouge_effect",
		"rouge_entrust_desc",
		"rouge_entrust",
		"rouge_unlock_desc",
		"rouge_repair_shop_price",
		"rouge_repair_shop",
		"rouge_event_type",
		"rouge_short_voice_group",
		"rouge_short_voice"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "rouge_middle_layer" then
		arg_3_0:initRougeMiddleLayerCo()
	elseif arg_3_1 == "rouge_short_voice" then
		arg_3_0:initMapVoiceCo()
	elseif arg_3_1 == "rouge_effect" then
		arg_3_0:initRougeEffect()
	end
end

function var_0_0.initRougeEffect(arg_4_0)
	arg_4_0.dropMaxRefreshNumDict = {}

	local var_4_0 = lua_rouge_effect.configList

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1.type == RougeMapEnum.EffectType.UnlockFightDropRefresh then
			local var_4_1 = string.splitToNumber(iter_4_1.typeParam, "#")
			local var_4_2 = var_4_1[1]
			local var_4_3 = var_4_1[2]

			arg_4_0.dropMaxRefreshNumDict[var_4_2] = var_4_3
		end
	end
end

function var_0_0.initMapVoiceCo(arg_5_0)
	arg_5_0.groupVoiceList = {}
	arg_5_0.groupTotalWeight = {}

	for iter_5_0, iter_5_1 in ipairs(lua_rouge_short_voice.configList) do
		local var_5_0 = iter_5_1.groupId
		local var_5_1 = arg_5_0.groupVoiceList[var_5_0]

		if not var_5_1 then
			var_5_1 = {}
			arg_5_0.groupVoiceList[var_5_0] = var_5_1
		end

		local var_5_2 = arg_5_0.groupTotalWeight[var_5_0] or 0

		arg_5_0.groupTotalWeight[var_5_0] = var_5_2 + iter_5_1.weight

		table.insert(var_5_1, iter_5_1)
	end
end

function var_0_0.initRougeMiddleLayerCo(arg_6_0)
	local var_6_0 = {
		pointPos = var_0_0.pointPosHandle,
		pathPointPos = var_0_0.pathPointPosHandle,
		path = var_0_0.pathHandle,
		pathDict = var_0_0.pathDictHandle,
		leavePos = var_0_0.leavePosHandle,
		nextLayerList = var_0_0.nextLayerListHandle,
		pathSelectList = var_0_0.pathSelectListHandle
	}
	local var_6_1 = getmetatable(lua_rouge_middle_layer.configList[1])
	local var_6_2 = var_6_1.__index

	function var_6_1.__index(arg_7_0, arg_7_1)
		local var_7_0 = var_6_0[arg_7_1]

		if var_7_0 then
			return var_7_0(arg_7_0, arg_7_1, var_6_2)
		end

		return var_6_2(arg_7_0, arg_7_1)
	end
end

function var_0_0.pointPosHandle(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = rawget(arg_8_0, "pointPosList")

	if not var_8_0 then
		var_8_0 = {}

		rawset(arg_8_0, "pointPosList", var_8_0)

		local var_8_1 = arg_8_2(arg_8_0, arg_8_1)

		if not string.nilorempty(var_8_1) then
			for iter_8_0, iter_8_1 in ipairs(string.split(var_8_1, "|")) do
				local var_8_2 = string.splitToNumber(iter_8_1, "#")

				table.insert(var_8_0, Vector3.New(var_8_2[1], var_8_2[2], var_8_2[3]))
			end
		end
	end

	return var_8_0
end

function var_0_0.pathPointPosHandle(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = rawget(arg_9_0, "pathPointPosList")

	if not var_9_0 then
		var_9_0 = {}

		rawset(arg_9_0, "pathPointPos", var_9_0)

		local var_9_1 = arg_9_2(arg_9_0, arg_9_1)

		if not string.nilorempty(var_9_1) then
			for iter_9_0, iter_9_1 in ipairs(string.split(var_9_1, "|")) do
				local var_9_2 = string.splitToNumber(iter_9_1, "#")

				table.insert(var_9_0, Vector2.New(var_9_2[1], var_9_2[2]))
			end
		end
	end

	return var_9_0
end

function var_0_0.pathHandle(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = rawget(arg_10_0, "pathList")

	if not var_10_0 then
		var_10_0 = {}

		rawset(arg_10_0, "pathList", var_10_0)

		local var_10_1 = arg_10_2(arg_10_0, arg_10_1)

		if not string.nilorempty(var_10_1) then
			for iter_10_0, iter_10_1 in ipairs(string.split(var_10_1, "|")) do
				local var_10_2 = string.splitToNumber(iter_10_1, "#")

				table.insert(var_10_0, Vector2.New(var_10_2[1], var_10_2[2]))
			end
		end
	end

	return var_10_0
end

function var_0_0.pathDictHandle(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = rawget(arg_11_0, "pathDict")

	if not var_11_0 then
		var_11_0 = {}

		rawset(arg_11_0, "pathDict", var_11_0)

		local var_11_1 = arg_11_2(arg_11_0, "path")

		if not string.nilorempty(var_11_1) then
			for iter_11_0, iter_11_1 in ipairs(string.split(var_11_1, "|")) do
				local var_11_2 = string.splitToNumber(iter_11_1, "#")
				local var_11_3 = var_11_2[1]
				local var_11_4 = var_11_2[2]

				var_11_0[var_11_3] = var_11_0[var_11_3] or {}
				var_11_0[var_11_4] = var_11_0[var_11_4] or {}
				var_11_0[var_11_3][var_11_4] = true
				var_11_0[var_11_4][var_11_3] = true
			end
		end
	end

	return var_11_0
end

function var_0_0.leavePosHandle(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = rawget(arg_12_0, arg_12_1)

	if not var_12_0 then
		var_12_0 = arg_12_2(arg_12_0, arg_12_1)

		if string.nilorempty(var_12_0) then
			return
		end

		var_12_0 = string.splitToNumber(var_12_0, "#")
		var_12_0 = Vector3.New(var_12_0[1], var_12_0[2], var_12_0[3])

		rawset(arg_12_0, arg_12_1, var_12_0)
	end

	return var_12_0
end

function var_0_0.nextLayerListHandle(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = rawget(arg_13_0, arg_13_1)

	if not var_13_0 then
		local var_13_1 = arg_13_2(arg_13_0, "nextLayer")

		if string.nilorempty(var_13_1) then
			return
		end

		var_13_0 = string.splitToNumber(var_13_1, "#")

		rawset(arg_13_0, arg_13_1, var_13_0)
	end

	return var_13_0
end

function var_0_0.pathSelectListHandle(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = rawget(arg_14_0, arg_14_1)

	if not var_14_0 then
		local var_14_1 = arg_14_2(arg_14_0, "pathSelect")

		if string.nilorempty(var_14_1) then
			return
		end

		var_14_0 = string.splitToNumber(var_14_1, "#")

		rawset(arg_14_0, arg_14_1, var_14_0)
	end

	return var_14_0
end

function var_0_0.getPathIndexList(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	arg_15_4 = arg_15_4 or {}
	arg_15_5 = arg_15_5 or 1

	if arg_15_5 > 20 then
		logError("房间配置死循环了！！！！！！请检查配置")

		return false
	end

	if tabletool.indexOf(arg_15_4, arg_15_2) then
		return false
	end

	table.insert(arg_15_4, arg_15_2)

	local var_15_0 = arg_15_1[arg_15_2]

	if var_15_0 then
		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			if iter_15_0 == arg_15_3 then
				table.insert(arg_15_4, arg_15_3)

				return true
			elseif arg_15_0:getPathIndexList(arg_15_1, iter_15_0, arg_15_3, arg_15_4, arg_15_5 + 1) then
				return true
			end
		end
	end

	table.remove(arg_15_4)

	return false
end

function var_0_0.getNextLayerList(arg_16_0, arg_16_1)
	local var_16_0 = lua_rouge_middle_layer.configDict[arg_16_1]

	if not var_16_0 then
		logError("not found middle layer co .. " .. tostring(arg_16_1))

		return
	end

	return var_16_0.nextLayerList
end

function var_0_0.getPathSelectList(arg_17_0, arg_17_1)
	local var_17_0 = lua_rouge_middle_layer.configDict[arg_17_1]

	if not var_17_0 then
		logError("not found middle layer co .. " .. tostring(arg_17_1))

		return
	end

	return var_17_0.pathSelectList
end

function var_0_0.getMapResPath(arg_18_0, arg_18_1)
	return lua_rouge_layer.configDict[arg_18_1].mapRes
end

function var_0_0.getMiddleMapResPath(arg_19_0, arg_19_1)
	return lua_rouge_middle_layer.configDict[arg_19_1].mapRes
end

function var_0_0.getMiddleLayerCo(arg_20_0, arg_20_1)
	return lua_rouge_middle_layer.configDict[arg_20_1]
end

function var_0_0.getRougeEvent(arg_21_0, arg_21_1)
	local var_21_0 = lua_rouge_event.configDict[arg_21_1]

	if not var_21_0 then
		logError("找不到肉鸽事件配置 ID : " .. tostring(arg_21_1))
	end

	return var_21_0
end

function var_0_0.getFightEvent(arg_22_0, arg_22_1)
	local var_22_0 = lua_rouge_fight_event.configDict[arg_22_1]

	if not var_22_0 then
		logError("找不到肉鸽战斗事件配置 ID : " .. tostring(arg_22_1))
	end

	return var_22_0
end

function var_0_0.getPathSelectInitCameraSize(arg_23_0)
	return tonumber(lua_rouge_const.configDict[RougeMapEnum.ConstKey.PathSelectCameraSize].value)
end

function var_0_0.getStoreRefreshCost(arg_24_0)
	local var_24_0 = lua_rouge_const.configDict[RougeMapEnum.ConstKey.StoreRefreshCost]
	local var_24_1 = string.splitToNumber(var_24_0.value, "#")
	local var_24_2 = var_24_1[1]
	local var_24_3 = var_24_1[2]

	return var_24_2, var_24_3
end

function var_0_0.getRestStoreRefreshCount(arg_25_0)
	local var_25_0 = lua_rouge_const.configDict[RougeMapEnum.ConstKey.RestStoreRefreshCount]

	return tonumber(var_25_0.value)
end

function var_0_0.getRestExchangeCount(arg_26_0)
	local var_26_0 = lua_rouge_const.configDict[RougeMapEnum.ConstKey.ExchangeCount]

	return tonumber(var_26_0.value)
end

function var_0_0.getFightRetryNum(arg_27_0)
	local var_27_0 = lua_rouge_const.configDict[RougeMapEnum.ConstKey.FightRetryNum]

	return tonumber(var_27_0.value)
end

function var_0_0.getRandomVoice(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.groupVoiceList[arg_28_1]

	if not var_28_0 then
		return
	end

	local var_28_1 = #var_28_0

	if var_28_1 == 1 then
		return var_28_0[1]
	end

	local var_28_2 = arg_28_0.groupTotalWeight[arg_28_1]
	local var_28_3 = math.random(var_28_2)
	local var_28_4 = 0

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		var_28_4 = var_28_4 + iter_28_1.weight

		if var_28_3 <= var_28_4 then
			return iter_28_1
		end
	end

	return var_28_0[var_28_1]
end

function var_0_0.getVoiceGroupList(arg_29_0)
	return lua_rouge_short_voice_group.configList
end

function var_0_0.getRougeEffect(arg_30_0, arg_30_1)
	local var_30_0 = lua_rouge_effect.configDict[arg_30_1]

	if not var_30_0 then
		logError("rouge effect not find effectId : " .. arg_30_1)
	end

	return var_30_0
end

function var_0_0.getFightDropMaxRefreshNum(arg_31_0, arg_31_1)
	return arg_31_0.dropMaxRefreshNumDict[arg_31_1] or 0
end

function var_0_0.getPieceCo(arg_32_0, arg_32_1)
	if not arg_32_1 then
		logError("piece id is nil")

		return
	end

	local var_32_0 = lua_rouge_piece.configDict[arg_32_1]

	if not var_32_0 then
		logError("piece config not exist, id : " .. tostring(arg_32_1))

		return
	end

	return var_32_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
