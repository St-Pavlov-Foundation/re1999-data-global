module("modules.logic.store.config.ActivityStoreConfig", package.seeall)

slot0 = class("ActivityStoreConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity107",
		"activity107_bubble_group",
		"activity107_bubble_talk",
		"activity107_bubble_talk_step"
	}
end

function slot0.onInit(slot0)
	slot0.activityStoreGroupConfigDict = nil
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity107" then
		slot0:initActivityStoreGroupConfig()
	elseif slot1 == "activity107_bubble_group" then
		slot0:initBubbleConfig()
	elseif slot1 == "activity107_bubble_talk" then
		slot0:initBubbleTalkConfig()
	end
end

function slot0.initActivityStoreGroupConfig(slot0)
	slot0._skin2ActivityIdDict = {}
	slot0.activityStoreGroupConfigDict = {}
	slot1, slot2 = nil

	for slot6, slot7 in ipairs(lua_activity107.configList) do
		if not slot0.activityStoreGroupConfigDict[slot7.activityId] then
			slot0.activityStoreGroupConfigDict[slot7.activityId] = {}
		end

		if not slot2[slot7.group] then
			slot2[slot7.group] = {}
		end

		table.insert(slot1, slot7)

		slot8 = string.splitToNumber(slot7.product, "#")

		if slot8[1] == MaterialEnum.MaterialType.HeroSkin then
			slot0._skin2ActivityIdDict[slot8[2]] = slot7.activityId
		end
	end
end

function slot0.initBubbleConfig(slot0)
	slot0.actId2GroupList = {}

	for slot4, slot5 in ipairs(lua_activity107_bubble_group.configList) do
		if not slot0.actId2GroupList[slot5.actId] then
			slot0.actId2GroupList[slot5.actId] = {}
		end

		table.insert(slot6, slot5)
	end
end

function slot0.initBubbleTalkConfig(slot0)
	slot0.groupId2TalkList = {}
	slot1 = {
		__index = function (slot0, slot1)
			return rawget(slot0, slot1) or rawget(slot0, "_srcCo")[slot1]
		end
	}

	for slot5, slot6 in ipairs(lua_activity107_bubble_talk.configList) do
		if not slot0.groupId2TalkList[slot6.groupId] then
			slot0.groupId2TalkList[slot6.groupId] = {}
		end

		slot8 = {
			_srcCo = slot6,
			triggerType = slot9[1],
			triggerParam = slot9
		}
		slot9 = string.splitToNumber(slot6.condition, "#")

		if slot9[2] then
			table.remove(slot9, 1)
		end

		setmetatable(slot8, slot1)
		table.insert(slot7, slot8)
	end
end

function slot0.getActivityStoreGroupDict(slot0, slot1)
	return slot0.activityStoreGroupConfigDict[slot1]
end

function slot0.getStoreConfig(slot0, slot1, slot2)
	return lua_activity107.configDict[slot1] and slot3[slot2]
end

slot0.TagEnum = {
	TimeLimit = 1
}

function slot0.initTag(slot0)
	slot0.tagDict = {
		[uv0.TagEnum.TimeLimit] = "versionactivity_store_goods_tag_1"
	}
end

function slot0.getTagName(slot0, slot1)
	slot0:initTag()

	if string.nilorempty(slot0.tagDict[slot1]) then
		return ""
	end

	return luaLang(slot2)
end

function slot0.getTalkGroupList(slot0, slot1)
	return slot0.actId2GroupList[slot1]
end

function slot0.getUnlockGroupList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0:getTalkGroupList(slot1)) do
		if slot8.unlockCondition == 0 or DungeonModel.instance:hasPassLevelAndStory(slot9) then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.getGroupTalkCoList(slot0, slot1)
	return slot0.groupId2TalkList[slot1]
end

slot0.BubbleTalkTriggerType = {
	ClickStageArea = 2,
	BuyGoodsById = 5,
	SellOutGoodsByRare = 4,
	BuyGoodsByRare = 3,
	EnterActivityStore = 1,
	FirstEnterActivityStore = 7,
	SellOutGoodsById = 6,
	None = 0
}

function slot0.checkTalkCanTrigger(slot0, slot1, slot2, slot3)
	slot0:initTypeCheckHandle()

	if not slot0.typeHandle[slot2.triggerType] then
		return true
	end

	return slot5(slot0, slot1, slot2, slot3)
end

function slot0.initTypeCheckHandle(slot0)
	if not slot0.typeHandle then
		slot0.typeHandle = {
			[uv0.BubbleTalkTriggerType.BuyGoodsByRare] = slot0.checkGoodsRareHandle,
			[uv0.BubbleTalkTriggerType.BuyGoodsById] = slot0.checkGoodsIdHandle,
			[uv0.BubbleTalkTriggerType.SellOutGoodsByRare] = slot0.checkGoodsRareHandle,
			[uv0.BubbleTalkTriggerType.SellOutGoodsById] = slot0.checkGoodsIdHandle
		}
	end
end

function slot0.checkGoodsRareHandle(slot0, slot1, slot2, slot3)
	if not slot2.triggerParam then
		logError("type param is nil, talkId : " .. tostring(slot2.id))

		return false
	end

	slot6 = string.splitToNumber(lua_activity107.configDict[slot1][slot3].product, "#")

	return tabletool.indexOf(slot4, ItemConfig.instance:getItemConfig(slot6[1], slot6[2]).rare)
end

function slot0.checkGoodsIdHandle(slot0, slot1, slot2, slot3)
	if not slot2.triggerParam then
		logError("type param is nil, talkId : " .. tostring(slot2.id))

		return false
	end

	return tabletool.indexOf(slot4, slot3)
end

function slot0.getSkinApproachActivity(slot0, slot1)
	if slot0._skin2ActivityIdDict and slot0._skin2ActivityIdDict[slot1] then
		return slot0._skin2ActivityIdDict[slot1]
	end

	return -1
end

slot0.instance = slot0.New()

return slot0
