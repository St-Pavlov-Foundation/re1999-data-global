module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotEventConfig", package.seeall)

slot0 = class("V1a6_CachotEventConfig", BaseConfig)

function slot0.onInit(slot0)
	slot0._dramaChoiceDict = {}
	slot0._dramaChoiceGroupToId = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"rogue_collection_drop",
		"rogue_collection_group",
		"rogue_dialog",
		"rogue_event",
		"rogue_event_drama_choice",
		"rogue_event_fight",
		"rogue_event_hint",
		"rogue_event_life",
		"rogue_event_revive",
		"rogue_goods",
		"rogue_shop",
		"rogue_ending",
		"rogue_event_drop_desc",
		"rogue_event_tips"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rogue_event_drama_choice" then
		for slot6, slot7 in pairs(slot2.configList) do
			if slot7.type == 1 then
				slot0._dramaChoiceGroupToId[slot7.group] = slot7.id
			elseif slot7.type == 2 then
				if not slot0._dramaChoiceDict[slot7.group] then
					slot0._dramaChoiceDict[slot7.group] = {}
				end

				table.insert(slot0._dramaChoiceDict[slot7.group], slot7)
			end
		end
	elseif slot1 == "rogue_collection_drop" then
		slot0:onCollectionDropConfigLoaded(slot2)
	end
end

function slot0.onCollectionDropConfigLoaded(slot0, slot1)
	slot0._collectionDropMap = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		if not slot0._collectionDropMap[slot6.groupId] then
			slot0._collectionDropMap[slot6.groupId] = {}
		end

		table.insert(slot0._collectionDropMap[slot6.groupId], slot6)
	end
end

function slot0.getChoiceCos(slot0, slot1)
	return slot0._dramaChoiceDict[slot1]
end

function slot0.getDramaId(slot0, slot1)
	return slot0._dramaChoiceGroupToId[slot1]
end

function slot0.getEventHeartShow(slot0, slot1, slot2)
	if not lua_rogue_event.configDict[slot1] then
		return
	end

	slot4 = nil
	slot5 = 0

	if slot3.type == V1a6_CachotEnum.EventType.Battle and lua_rogue_event_fight.configDict[slot3.eventId] and not string.nilorempty(slot6["heartChange" .. slot2]) then
		slot8 = string.split(slot7, "|") or {}

		for slot12 = 1, #slot8 do
			if string.match(slot8[slot12], "^1#1#(-?[0-9]+)$") then
				slot5 = tonumber(slot13)

				break
			end
		end
	end

	slot7 = string.split(slot3["dropGroup" .. slot2] or slot3.dropGroup or "", "|") or {}

	for slot11 = 1, #slot7 do
		if string.match(slot7[slot11], "^[0-9]+#(heart[1-3])$") and not string.nilorempty(slot3[slot12]) then
			if slot4 then
				slot4 = "?"

				break
			else
				slot4 = string.format("%+d", (tonumber(slot3[slot12]) or 0) + slot5)
			end
		end
	end

	if not slot4 and slot5 ~= 0 then
		slot4 = string.format("%+d", slot5)
	end

	return slot4
end

function slot0.getCollectionDropListByGroupId(slot0, slot1)
	return slot0._collectionDropMap and slot0._collectionDropMap[slot1]
end

function slot0.getBgmIdByLayer(slot0, slot1)
	if not slot0._bgmIdDict then
		slot0._bgmIdDict = {}

		for slot6, slot7 in ipairs(GameUtil.splitString2(lua_rogue_const.configDict[V1a6_CachotEnum.Const.LayerBGM].value, true)) do
			slot0._bgmIdDict[slot7[1]] = slot7[2]
		end
	end

	return slot0._bgmIdDict[slot1] or slot0._bgmIdDict[0]
end

function slot0.getSceneIdByLayer(slot0, slot1)
	if not slot0._sceneIdDict then
		slot0._sceneIdDict = {}

		for slot6, slot7 in ipairs(GameUtil.splitString2(lua_rogue_const.configDict[V1a6_CachotEnum.Const.LayerFightScene].value, true)) do
			slot0._sceneIdDict[slot7[1]] = {
				sceneId = slot7[2],
				levelId = slot7[3]
			}
		end
	end

	return slot0._sceneIdDict[slot1] or slot0._sceneIdDict[1]
end

function slot0.getDescCoByEventId(slot0, slot1)
	slot2, slot3 = nil

	if lua_rogue_event.configDict[slot1] then
		if slot4.type == V1a6_CachotEnum.EventType.CharacterCure then
			slot6 = string.splitToNumber(lua_rogue_event_life.configDict[slot4.eventId].num, "#")
			slot7 = slot6[1]

			if slot7 == 1 then
				slot3 = GameUtil.getSubPlaceholderLuaLang(lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.CureEvent][slot7].desc, {
					slot6[2] or 1,
					slot5.lifeAdd / 10
				})
			elseif slot7 == 2 then
				slot3 = GameUtil.getSubPlaceholderLuaLang(slot2.desc, {
					slot8,
					slot9
				})
			elseif slot7 == 3 then
				slot3 = GameUtil.getSubPlaceholderLuaLang(slot2.desc, {
					slot9
				})
			end
		elseif slot4.type == V1a6_CachotEnum.EventType.CharacterRebirth then
			slot2 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.ReviveEvent][string.splitToNumber(lua_rogue_event_revive.configDict[slot4.eventId].num, "#")[1]]
		elseif slot4.type == V1a6_CachotEnum.EventType.CharacterGet then
			slot2 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.CharacterGet][1]
		elseif slot4.type == V1a6_CachotEnum.EventType.HeroPosUpgrade then
			slot2 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.HeroPosUpgrade][1]
		end
	end

	return slot2, slot3
end

slot0.instance = slot0.New()

return slot0
