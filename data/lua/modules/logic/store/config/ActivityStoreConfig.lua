module("modules.logic.store.config.ActivityStoreConfig", package.seeall)

local var_0_0 = class("ActivityStoreConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity107",
		"activity107_bubble_group",
		"activity107_bubble_talk",
		"activity107_bubble_talk_step"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0.activityStoreGroupConfigDict = nil
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity107" then
		arg_3_0:initActivityStoreGroupConfig()
	elseif arg_3_1 == "activity107_bubble_group" then
		arg_3_0:initBubbleConfig()
	elseif arg_3_1 == "activity107_bubble_talk" then
		arg_3_0:initBubbleTalkConfig()
	end
end

function var_0_0.initActivityStoreGroupConfig(arg_4_0)
	arg_4_0._skin2ActivityIdDict = {}
	arg_4_0.activityStoreGroupConfigDict = {}

	local var_4_0
	local var_4_1

	for iter_4_0, iter_4_1 in ipairs(lua_activity107.configList) do
		local var_4_2 = arg_4_0.activityStoreGroupConfigDict[iter_4_1.activityId]

		if not var_4_2 then
			var_4_2 = {}
			arg_4_0.activityStoreGroupConfigDict[iter_4_1.activityId] = var_4_2
		end

		local var_4_3 = var_4_2[iter_4_1.group]

		if not var_4_3 then
			var_4_3 = {}
			var_4_2[iter_4_1.group] = var_4_3
		end

		table.insert(var_4_3, iter_4_1)

		local var_4_4 = string.splitToNumber(iter_4_1.product, "#")
		local var_4_5 = var_4_4[1]
		local var_4_6 = var_4_4[2]

		if var_4_5 == MaterialEnum.MaterialType.HeroSkin then
			arg_4_0._skin2ActivityIdDict[var_4_6] = iter_4_1.activityId
		end
	end
end

function var_0_0.initBubbleConfig(arg_5_0)
	arg_5_0.actId2GroupList = {}

	for iter_5_0, iter_5_1 in ipairs(lua_activity107_bubble_group.configList) do
		local var_5_0 = arg_5_0.actId2GroupList[iter_5_1.actId]

		if not var_5_0 then
			var_5_0 = {}
			arg_5_0.actId2GroupList[iter_5_1.actId] = var_5_0
		end

		table.insert(var_5_0, iter_5_1)
	end
end

function var_0_0.initBubbleTalkConfig(arg_6_0)
	arg_6_0.groupId2TalkList = {}

	local var_6_0 = {
		__index = function(arg_7_0, arg_7_1)
			return rawget(arg_7_0, arg_7_1) or rawget(arg_7_0, "_srcCo")[arg_7_1]
		end
	}

	for iter_6_0, iter_6_1 in ipairs(lua_activity107_bubble_talk.configList) do
		local var_6_1 = arg_6_0.groupId2TalkList[iter_6_1.groupId]

		if not var_6_1 then
			var_6_1 = {}
			arg_6_0.groupId2TalkList[iter_6_1.groupId] = var_6_1
		end

		local var_6_2 = {}
		local var_6_3 = string.splitToNumber(iter_6_1.condition, "#")

		var_6_2._srcCo = iter_6_1
		var_6_2.triggerType = var_6_3[1]

		if var_6_3[2] then
			table.remove(var_6_3, 1)

			var_6_2.triggerParam = var_6_3
		end

		setmetatable(var_6_2, var_6_0)
		table.insert(var_6_1, var_6_2)
	end
end

function var_0_0.getActivityStoreGroupDict(arg_8_0, arg_8_1)
	return arg_8_0.activityStoreGroupConfigDict[arg_8_1]
end

function var_0_0.getStoreConfig(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = lua_activity107.configDict[arg_9_1]

	return var_9_0 and var_9_0[arg_9_2]
end

var_0_0.TagEnum = {
	TimeLimit = 1
}

function var_0_0.initTag(arg_10_0)
	arg_10_0.tagDict = {
		[var_0_0.TagEnum.TimeLimit] = "versionactivity_store_goods_tag_1"
	}
end

function var_0_0.getTagName(arg_11_0, arg_11_1)
	arg_11_0:initTag()

	local var_11_0 = arg_11_0.tagDict[arg_11_1]

	if string.nilorempty(var_11_0) then
		return ""
	end

	return luaLang(var_11_0)
end

function var_0_0.getTalkGroupList(arg_12_0, arg_12_1)
	return arg_12_0.actId2GroupList[arg_12_1]
end

function var_0_0.getUnlockGroupList(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getTalkGroupList(arg_13_1)
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_2 = iter_13_1.unlockCondition

		if var_13_2 == 0 or DungeonModel.instance:hasPassLevelAndStory(var_13_2) then
			table.insert(var_13_1, iter_13_1)
		end
	end

	return var_13_1
end

function var_0_0.getGroupTalkCoList(arg_14_0, arg_14_1)
	return arg_14_0.groupId2TalkList[arg_14_1]
end

var_0_0.BubbleTalkTriggerType = {
	ClickStageArea = 2,
	BuyGoodsById = 5,
	SellOutGoodsByRare = 4,
	BuyGoodsByRare = 3,
	EnterActivityStore = 1,
	FirstEnterActivityStore = 7,
	SellOutGoodsById = 6,
	None = 0
}

function var_0_0.checkTalkCanTrigger(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:initTypeCheckHandle()

	local var_15_0 = arg_15_2.triggerType
	local var_15_1 = arg_15_0.typeHandle[var_15_0]

	if not var_15_1 then
		return true
	end

	return var_15_1(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
end

function var_0_0.initTypeCheckHandle(arg_16_0)
	if not arg_16_0.typeHandle then
		arg_16_0.typeHandle = {
			[var_0_0.BubbleTalkTriggerType.BuyGoodsByRare] = arg_16_0.checkGoodsRareHandle,
			[var_0_0.BubbleTalkTriggerType.BuyGoodsById] = arg_16_0.checkGoodsIdHandle,
			[var_0_0.BubbleTalkTriggerType.SellOutGoodsByRare] = arg_16_0.checkGoodsRareHandle,
			[var_0_0.BubbleTalkTriggerType.SellOutGoodsById] = arg_16_0.checkGoodsIdHandle
		}
	end
end

function var_0_0.checkGoodsRareHandle(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_2.triggerParam

	if not var_17_0 then
		logError("type param is nil, talkId : " .. tostring(arg_17_2.id))

		return false
	end

	local var_17_1 = lua_activity107.configDict[arg_17_1][arg_17_3]
	local var_17_2 = string.splitToNumber(var_17_1.product, "#")
	local var_17_3 = var_17_2[1]
	local var_17_4 = var_17_2[2]
	local var_17_5 = ItemConfig.instance:getItemConfig(var_17_3, var_17_4)

	return tabletool.indexOf(var_17_0, var_17_5.rare)
end

function var_0_0.checkGoodsIdHandle(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_2.triggerParam

	if not var_18_0 then
		logError("type param is nil, talkId : " .. tostring(arg_18_2.id))

		return false
	end

	return tabletool.indexOf(var_18_0, arg_18_3)
end

function var_0_0.getSkinApproachActivity(arg_19_0, arg_19_1)
	if arg_19_0._skin2ActivityIdDict and arg_19_0._skin2ActivityIdDict[arg_19_1] then
		return arg_19_0._skin2ActivityIdDict[arg_19_1]
	end

	return -1
end

var_0_0.instance = var_0_0.New()

return var_0_0
