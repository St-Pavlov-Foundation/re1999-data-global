module("modules.configschecker.ConfigsCheckerMgr", package.seeall)

local var_0_0 = class("ConfigsCheckerMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._strBufListIndex = 0
	arg_1_0._strBufList = {}
end

function var_0_0.checkConfigAll()
	var_0_0.checkVoiceEndTime()
	var_0_0.checkCachotConfig()
end

function var_0_0.checkVoiceEndTime()
	print("===开始检查检查语音文本是否配置了结束时间===")

	for iter_3_0, iter_3_1 in ipairs(lua_character_voice.configList) do
		local var_3_0 = {}

		SpineVoiceText:_initContent(var_3_0, iter_3_1.content)

		for iter_3_2, iter_3_3 in ipairs(var_3_0) do
			if iter_3_3[1] and not iter_3_3[2] then
				logError("没有配置时间 audio:" .. iter_3_1.audio .. " " .. iter_3_3[1])
			end
		end

		local var_3_1 = {}

		SpineVoiceText:_initContent(var_3_1, iter_3_1.encontent)

		for iter_3_4, iter_3_5 in ipairs(var_3_1) do
			if iter_3_5[1] and not iter_3_5[2] then
				logError("没有配置时间 audio:" .. iter_3_1.audio .. " " .. iter_3_5[1])
			end
		end
	end

	print("===结束检查检查语音文本是否配置了结束时间===")
end

function var_0_0.checkCachotConfig()
	print("===开始检查肉鸽配置了结束时间===")

	for iter_4_0, iter_4_1 in ipairs(lua_rogue_event.configList) do
		if iter_4_1.type == V1a6_CachotEnum.EventType.Battle then
			if not lua_rogue_event_fight.configDict[iter_4_1.eventId] then
				logError("没有配置战斗事件:" .. iter_4_1.id .. " >>> " .. iter_4_1.eventId)
			end
		elseif iter_4_1.type == V1a6_CachotEnum.EventType.ChoiceSelect then
			if not lua_rogue_event_drama_choice.configDict[iter_4_1.eventId] then
				logError("没有配置选项事件:" .. iter_4_1.id .. " >>> " .. iter_4_1.eventId)
			end
		elseif iter_4_1.type == V1a6_CachotEnum.EventType.Store then
			if not lua_rogue_shop.configDict[iter_4_1.eventId] then
				logError("没有配置商店事件:" .. iter_4_1.id .. " >>> " .. iter_4_1.eventId)
			end
		elseif iter_4_1.type == V1a6_CachotEnum.EventType.CharacterCure then
			if not lua_rogue_event_life.configDict[iter_4_1.eventId] then
				logError("没有配置回血事件:" .. iter_4_1.id .. " >>> " .. iter_4_1.eventId)
			end
		elseif iter_4_1.type == V1a6_CachotEnum.EventType.CharacterRebirth then
			if not lua_rogue_event_revive.configDict[iter_4_1.eventId] then
				logError("没有配置复活事件:" .. iter_4_1.id .. " >>> " .. iter_4_1.eventId)
			end
		elseif iter_4_1.type == V1a6_CachotEnum.EventType.Tip and not lua_rogue_event_tips.configDict[iter_4_1.eventId] then
			logError("没有配置提示事件:" .. iter_4_1.id .. " >>> " .. iter_4_1.eventId)
		end

		local var_4_0 = 1

		while iter_4_1["event" .. var_4_0] do
			local var_4_1 = tonumber(iter_4_1["event" .. var_4_0])

			if var_4_1 and var_4_1 > 0 and not lua_rogue_event.configDict[var_4_1] then
				logError("掉落的事件配置不存在" .. iter_4_1.id .. " >> " .. var_4_0 .. " >> " .. iter_4_1["event" .. var_4_0])
			end

			var_4_0 = var_4_0 + 1
		end
	end

	local var_4_2 = {}

	for iter_4_2, iter_4_3 in ipairs(lua_rogue_event_drama_choice.configList) do
		if iter_4_3.type ~= 1 and iter_4_3.type ~= 2 then
			logError("选项类型错误" .. iter_4_3.id .. " >> " .. iter_4_3.type)
		end

		if iter_4_3.group == 0 then
			logError("选项没有配置组" .. iter_4_3.id)
		else
			if not var_4_2[iter_4_3.group] then
				var_4_2[iter_4_3.group] = {}
			end

			var_4_2[iter_4_3.group][iter_4_3.id] = iter_4_3

			local var_4_3 = lua_rogue_dialog.configDict[iter_4_3.dialogId]

			if not var_4_3 then
				logError("选项事件对话id 不存在 " .. iter_4_3.id .. " >>> " .. iter_4_3.dialogId)
			elseif var_4_3 and iter_4_3.type == 1 and (not var_4_3[1] or var_4_3[1].type ~= 1) then
				logError("选项事件对话id 配置错误 第一步应该是type1 " .. iter_4_3.id .. " >>> " .. iter_4_3.dialogId)
			end
		end
	end

	for iter_4_4, iter_4_5 in pairs(var_4_2) do
		local var_4_4 = 0
		local var_4_5 = 0

		for iter_4_6, iter_4_7 in pairs(iter_4_5) do
			if iter_4_7.type == 1 then
				var_4_4 = var_4_4 + 1
			end

			if iter_4_7.type == 2 then
				var_4_5 = var_4_5 + 1
			end
		end

		if var_4_4 ~= 1 then
			logError("选项配置组错误 组id" .. iter_4_4 .. " type = 1:" .. var_4_4)
		end

		if var_4_5 > 3 or var_4_5 <= 0 then
			logError("选项配置组错误 组id" .. iter_4_4 .. " type = 2:" .. var_4_5)
		end
	end

	local var_4_6 = {}

	setmetatable(var_4_6, {
		__index = function()
			return 0
		end
	})

	for iter_4_8, iter_4_9 in pairs(lua_rogue_goods.configDict) do
		if iter_4_9.creator > 0 then
			if not lua_rogue_collection.configDict[iter_4_9.creator] then
				logError("商品配置的藏品不存在" .. iter_4_9.id .. " >>> " .. iter_4_9.creator)
			end
		elseif iter_4_9.event > 0 then
			if not lua_rogue_event.configDict[iter_4_9.event] then
				logError("商品配置的事件不存在" .. iter_4_9.id .. " >>> " .. iter_4_9.event)
			end
		else
			logError("商品配置错误" .. iter_4_9.id)
		end

		var_4_6[iter_4_9.goodsGroup] = var_4_6[iter_4_9.goodsGroup] + 1
	end

	for iter_4_10, iter_4_11 in pairs(lua_rogue_shop.configDict) do
		local var_4_7 = {}

		setmetatable(var_4_7, {
			__index = function()
				return 0
			end
		})

		local var_4_8 = 1

		while iter_4_11["pos" .. var_4_8] do
			var_4_7[iter_4_11["pos" .. var_4_8]] = var_4_7[iter_4_11["pos" .. var_4_8]] + 1
			var_4_8 = var_4_8 + 1
		end

		for iter_4_12, iter_4_13 in pairs(var_4_7) do
			if iter_4_12 ~= 0 and iter_4_13 > var_4_6[iter_4_12] then
				logError("商店配置的事件组数量不足" .. iter_4_11.id .. " >>> " .. iter_4_12)
			end
		end
	end

	print("===结束检查肉鸽配置了结束时间===")
end

function var_0_0.createStrBuf(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._strBufListIndex + 1
	local var_7_1 = ConfigsCheckerStrBuf.New(arg_7_1)

	arg_7_0._strBufList[var_7_0] = var_7_1
	arg_7_0._strBufListIndex = var_7_0

	return var_7_1, var_7_0
end

function var_0_0.getStrBuf(arg_8_0, arg_8_1)
	return arg_8_0._strBufList[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
