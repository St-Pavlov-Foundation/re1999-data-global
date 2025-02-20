module("modules.logic.rouge.config.RougeMapConfig", package.seeall)

slot0 = class("RougeMapConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
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

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rouge_middle_layer" then
		slot0:initRougeMiddleLayerCo()
	elseif slot1 == "rouge_short_voice" then
		slot0:initMapVoiceCo()
	elseif slot1 == "rouge_effect" then
		slot0:initRougeEffect()
	end
end

function slot0.initRougeEffect(slot0)
	slot0.dropMaxRefreshNumDict = {}

	for slot5, slot6 in ipairs(lua_rouge_effect.configList) do
		if slot6.type == RougeMapEnum.EffectType.UnlockFightDropRefresh then
			slot7 = string.splitToNumber(slot6.typeParam, "#")
			slot0.dropMaxRefreshNumDict[slot7[1]] = slot7[2]
		end
	end
end

function slot0.initMapVoiceCo(slot0)
	slot0.groupVoiceList = {}
	slot0.groupTotalWeight = {}

	for slot4, slot5 in ipairs(lua_rouge_short_voice.configList) do
		if not slot0.groupVoiceList[slot5.groupId] then
			slot0.groupVoiceList[slot6] = {}
		end

		slot0.groupTotalWeight[slot6] = (slot0.groupTotalWeight[slot6] or 0) + slot5.weight

		table.insert(slot7, slot5)
	end
end

function slot0.initRougeMiddleLayerCo(slot0)
	slot1 = {
		pointPos = uv0.pointPosHandle,
		pathPointPos = uv0.pathPointPosHandle,
		path = uv0.pathHandle,
		pathDict = uv0.pathDictHandle,
		leavePos = uv0.leavePosHandle,
		nextLayerList = uv0.nextLayerListHandle,
		pathSelectList = uv0.pathSelectListHandle
	}
	slot2 = getmetatable(lua_rouge_middle_layer.configList[1])
	slot3 = slot2.__index

	function slot2.__index(slot0, slot1)
		if uv0[slot1] then
			return slot2(slot0, slot1, uv1)
		end

		return uv1(slot0, slot1)
	end
end

function slot0.pointPosHandle(slot0, slot1, slot2)
	if not rawget(slot0, "pointPosList") then
		rawset(slot0, "pointPosList", {})

		if not string.nilorempty(slot2(slot0, slot1)) then
			slot9 = slot4

			for slot8, slot9 in ipairs(string.split(slot9, "|")) do
				slot10 = string.splitToNumber(slot9, "#")

				table.insert(slot3, Vector3.New(slot10[1], slot10[2], slot10[3]))
			end
		end
	end

	return slot3
end

function slot0.pathPointPosHandle(slot0, slot1, slot2)
	if not rawget(slot0, "pathPointPosList") then
		rawset(slot0, "pathPointPos", {})

		if not string.nilorempty(slot2(slot0, slot1)) then
			slot9 = slot4

			for slot8, slot9 in ipairs(string.split(slot9, "|")) do
				slot10 = string.splitToNumber(slot9, "#")

				table.insert(slot3, Vector2.New(slot10[1], slot10[2]))
			end
		end
	end

	return slot3
end

function slot0.pathHandle(slot0, slot1, slot2)
	if not rawget(slot0, "pathList") then
		rawset(slot0, "pathList", {})

		if not string.nilorempty(slot2(slot0, slot1)) then
			slot9 = slot4

			for slot8, slot9 in ipairs(string.split(slot9, "|")) do
				slot10 = string.splitToNumber(slot9, "#")

				table.insert(slot3, Vector2.New(slot10[1], slot10[2]))
			end
		end
	end

	return slot3
end

function slot0.pathDictHandle(slot0, slot1, slot2)
	if not rawget(slot0, "pathDict") then
		rawset(slot0, "pathDict", {})

		if not string.nilorempty(slot2(slot0, "path")) then
			slot9 = slot4

			for slot8, slot9 in ipairs(string.split(slot9, "|")) do
				slot10 = string.splitToNumber(slot9, "#")
				slot12 = slot10[2]
				slot3[slot11] = slot3[slot10[1]] or {}
				slot3[slot12] = slot3[slot12] or {}
				slot3[slot11][slot12] = true
				slot3[slot12][slot11] = true
			end
		end
	end

	return slot3
end

function slot0.leavePosHandle(slot0, slot1, slot2)
	if not rawget(slot0, slot1) then
		if string.nilorempty(slot2(slot0, slot1)) then
			return
		end

		slot3 = string.splitToNumber(slot3, "#")

		rawset(slot0, slot1, Vector3.New(slot3[1], slot3[2], slot3[3]))
	end

	return slot3
end

function slot0.nextLayerListHandle(slot0, slot1, slot2)
	if not rawget(slot0, slot1) then
		if string.nilorempty(slot2(slot0, "nextLayer")) then
			return
		end

		rawset(slot0, slot1, string.splitToNumber(slot4, "#"))
	end

	return slot3
end

function slot0.pathSelectListHandle(slot0, slot1, slot2)
	if not rawget(slot0, slot1) then
		if string.nilorempty(slot2(slot0, "pathSelect")) then
			return
		end

		rawset(slot0, slot1, string.splitToNumber(slot4, "#"))
	end

	return slot3
end

function slot0.getPathIndexList(slot0, slot1, slot2, slot3, slot4, slot5)
	slot4 = slot4 or {}

	if (slot5 or 1) > 20 then
		logError("房间配置死循环了！！！！！！请检查配置")

		return false
	end

	if tabletool.indexOf(slot4, slot2) then
		return false
	end

	table.insert(slot4, slot2)

	if slot1[slot2] then
		for slot10, slot11 in pairs(slot6) do
			if slot10 == slot3 then
				table.insert(slot4, slot3)

				return true
			elseif slot0:getPathIndexList(slot1, slot10, slot3, slot4, slot5 + 1) then
				return true
			end
		end
	end

	table.remove(slot4)

	return false
end

function slot0.getNextLayerList(slot0, slot1)
	if not lua_rouge_middle_layer.configDict[slot1] then
		logError("not found middle layer co .. " .. tostring(slot1))

		return
	end

	return slot2.nextLayerList
end

function slot0.getPathSelectList(slot0, slot1)
	if not lua_rouge_middle_layer.configDict[slot1] then
		logError("not found middle layer co .. " .. tostring(slot1))

		return
	end

	return slot2.pathSelectList
end

function slot0.getMapResPath(slot0, slot1)
	return lua_rouge_layer.configDict[slot1].mapRes
end

function slot0.getMiddleMapResPath(slot0, slot1)
	return lua_rouge_middle_layer.configDict[slot1].mapRes
end

function slot0.getMiddleLayerCo(slot0, slot1)
	return lua_rouge_middle_layer.configDict[slot1]
end

function slot0.getRougeEvent(slot0, slot1)
	if not lua_rouge_event.configDict[slot1] then
		logError("找不到肉鸽事件配置 ID : " .. tostring(slot1))
	end

	return slot2
end

function slot0.getFightEvent(slot0, slot1)
	if not lua_rouge_fight_event.configDict[slot1] then
		logError("找不到肉鸽战斗事件配置 ID : " .. tostring(slot1))
	end

	return slot2
end

function slot0.getPathSelectInitCameraSize(slot0)
	return tonumber(lua_rouge_const.configDict[RougeMapEnum.ConstKey.PathSelectCameraSize].value)
end

function slot0.getStoreRefreshCost(slot0)
	slot2 = string.splitToNumber(lua_rouge_const.configDict[RougeMapEnum.ConstKey.StoreRefreshCost].value, "#")

	return slot2[1], slot2[2]
end

function slot0.getRestStoreRefreshCount(slot0)
	return tonumber(lua_rouge_const.configDict[RougeMapEnum.ConstKey.RestStoreRefreshCount].value)
end

function slot0.getRestExchangeCount(slot0)
	return tonumber(lua_rouge_const.configDict[RougeMapEnum.ConstKey.ExchangeCount].value)
end

function slot0.getFightRetryNum(slot0)
	return tonumber(lua_rouge_const.configDict[RougeMapEnum.ConstKey.FightRetryNum].value)
end

function slot0.getRandomVoice(slot0, slot1)
	if not slot0.groupVoiceList[slot1] then
		return
	end

	if #slot2 == 1 then
		return slot2[1]
	end

	for slot10, slot11 in ipairs(slot2) do
		if math.random(slot0.groupTotalWeight[slot1]) <= 0 + slot11.weight then
			return slot11
		end
	end

	return slot2[slot3]
end

function slot0.getVoiceGroupList(slot0)
	return lua_rouge_short_voice_group.configList
end

function slot0.getRougeEffect(slot0, slot1)
	if not lua_rouge_effect.configDict[slot1] then
		logError("rouge effect not find effectId : " .. slot1)
	end

	return slot2
end

function slot0.getFightDropMaxRefreshNum(slot0, slot1)
	return slot0.dropMaxRefreshNumDict[slot1] or 0
end

function slot0.getPieceCo(slot0, slot1)
	if not slot1 then
		logError("piece id is nil")

		return
	end

	if not lua_rouge_piece.configDict[slot1] then
		logError("piece config not exist, id : " .. tostring(slot1))

		return
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
