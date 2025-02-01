module("modules.configschecker.ConfigsCheckerMgr", package.seeall)

slot0 = class("ConfigsCheckerMgr")

function slot0.checkConfigAll()
	uv0.checkVoiceEndTime()
	uv0.checkCachotConfig()
end

function slot0.checkVoiceEndTime()
	print("===开始检查检查语音文本是否配置了结束时间===")

	for slot3, slot4 in ipairs(lua_character_voice.configList) do
		slot5 = {}
		slot9 = slot4.content

		SpineVoiceText:_initContent(slot5, slot9)

		for slot9, slot10 in ipairs(slot5) do
			if slot10[1] and not slot10[2] then
				logError("没有配置时间 audio:" .. slot4.audio .. " " .. slot10[1])
			end
		end

		slot5 = {}
		slot9 = slot4.encontent

		SpineVoiceText:_initContent(slot5, slot9)

		for slot9, slot10 in ipairs(slot5) do
			if slot10[1] and not slot10[2] then
				logError("没有配置时间 audio:" .. slot4.audio .. " " .. slot10[1])
			end
		end
	end

	print("===结束检查检查语音文本是否配置了结束时间===")
end

function slot0.checkCachotConfig()
	print("===开始检查肉鸽配置了结束时间===")

	for slot3, slot4 in ipairs(lua_rogue_event.configList) do
		if slot4.type == V1a6_CachotEnum.EventType.Battle then
			if not lua_rogue_event_fight.configDict[slot4.eventId] then
				logError("没有配置战斗事件:" .. slot4.id .. " >>> " .. slot4.eventId)
			end
		elseif slot4.type == V1a6_CachotEnum.EventType.ChoiceSelect then
			if not lua_rogue_event_drama_choice.configDict[slot4.eventId] then
				logError("没有配置选项事件:" .. slot4.id .. " >>> " .. slot4.eventId)
			end
		elseif slot4.type == V1a6_CachotEnum.EventType.Store then
			if not lua_rogue_shop.configDict[slot4.eventId] then
				logError("没有配置商店事件:" .. slot4.id .. " >>> " .. slot4.eventId)
			end
		elseif slot4.type == V1a6_CachotEnum.EventType.CharacterCure then
			if not lua_rogue_event_life.configDict[slot4.eventId] then
				logError("没有配置回血事件:" .. slot4.id .. " >>> " .. slot4.eventId)
			end
		elseif slot4.type == V1a6_CachotEnum.EventType.CharacterRebirth then
			if not lua_rogue_event_revive.configDict[slot4.eventId] then
				logError("没有配置复活事件:" .. slot4.id .. " >>> " .. slot4.eventId)
			end
		elseif slot4.type == V1a6_CachotEnum.EventType.Tip and not lua_rogue_event_tips.configDict[slot4.eventId] then
			logError("没有配置提示事件:" .. slot4.id .. " >>> " .. slot4.eventId)
		end

		slot5 = 1

		while slot4["event" .. slot5] do
			if tonumber(slot4["event" .. slot5]) and slot6 > 0 and not lua_rogue_event.configDict[slot6] then
				logError("掉落的事件配置不存在" .. slot4.id .. " >> " .. slot5 .. " >> " .. slot4["event" .. slot5])
			end

			slot5 = slot5 + 1
		end
	end

	slot0 = {}

	for slot4, slot5 in ipairs(lua_rogue_event_drama_choice.configList) do
		if slot5.type ~= 1 and slot5.type ~= 2 then
			logError("选项类型错误" .. slot5.id .. " >> " .. slot5.type)
		end

		if slot5.group == 0 then
			logError("选项没有配置组" .. slot5.id)
		else
			if not slot0[slot5.group] then
				slot0[slot5.group] = {}
			end

			slot0[slot5.group][slot5.id] = slot5

			if not lua_rogue_dialog.configDict[slot5.dialogId] then
				logError("选项事件对话id 不存在 " .. slot5.id .. " >>> " .. slot5.dialogId)
			elseif slot6 and slot5.type == 1 and (not slot6[1] or slot6[1].type ~= 1) then
				logError("选项事件对话id 配置错误 第一步应该是type1 " .. slot5.id .. " >>> " .. slot5.dialogId)
			end
		end
	end

	for slot4, slot5 in pairs(slot0) do
		slot7 = 0

		for slot11, slot12 in pairs(slot5) do
			if slot12.type == 1 then
				slot6 = 0 + 1
			end

			if slot12.type == 2 then
				slot7 = slot7 + 1
			end
		end

		if slot6 ~= 1 then
			logError("选项配置组错误 组id" .. slot4 .. " type = 1:" .. slot6)
		end

		if slot7 > 3 or slot7 <= 0 then
			logError("选项配置组错误 组id" .. slot4 .. " type = 2:" .. slot7)
		end
	end

	function slot5()
		return 0
	end

	setmetatable({}, {
		__index = slot5
	})

	for slot5, slot6 in pairs(lua_rogue_goods.configDict) do
		if slot6.creator > 0 then
			if not lua_rogue_collection.configDict[slot6.creator] then
				logError("商品配置的藏品不存在" .. slot6.id .. " >>> " .. slot6.creator)
			end
		elseif slot6.event > 0 then
			if not lua_rogue_event.configDict[slot6.event] then
				logError("商品配置的事件不存在" .. slot6.id .. " >>> " .. slot6.event)
			end
		else
			logError("商品配置错误" .. slot6.id)
		end

		slot1[slot6.goodsGroup] = slot1[slot6.goodsGroup] + 1
	end

	for slot5, slot6 in pairs(lua_rogue_shop.configDict) do
		setmetatable({}, {
			__index = function ()
				return 0
			end
		})

		slot8 = 1

		while slot6["pos" .. slot8] do
			slot7[slot6["pos" .. slot8]] = slot7[slot6["pos" .. slot8]] + 1
			slot8 = slot8 + 1
		end

		for slot12, slot13 in pairs(slot7) do
			if slot12 ~= 0 and slot1[slot12] < slot13 then
				logError("商店配置的事件组数量不足" .. slot6.id .. " >>> " .. slot12)
			end
		end
	end

	print("===结束检查肉鸽配置了结束时间===")
end

slot0.instance = slot0.New()

return slot0
