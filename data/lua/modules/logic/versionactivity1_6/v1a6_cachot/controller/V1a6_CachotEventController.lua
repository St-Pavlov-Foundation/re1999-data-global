module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotEventController", package.seeall)

local var_0_0 = class("V1a6_CachotEventController", BaseController)
local var_0_1 = {
	[V1a6_CachotEnum.EventType.CollectionSelect] = true
}

function var_0_0.onInit(arg_1_0)
	arg_1_0._pauseType = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._pauseType = {}
end

function var_0_0.addConstEvents(arg_3_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerTriggerInteract, arg_3_0.triggerEvent, arg_3_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectEventChange, arg_3_0.selectEventChange, arg_3_0)
end

function var_0_0.triggerEvent(arg_4_0, arg_4_1, ...)
	if not arg_4_0._eventFuncs then
		arg_4_0:_buildEventFuncs()
	end

	if arg_4_0:isPause() then
		arg_4_0._nextEventList = arg_4_0._nextEventList or {}

		table.insert(arg_4_0._nextEventList, {
			arg_4_1,
			...
		})

		return
	end

	local var_4_0 = lua_rogue_event.configDict[arg_4_1.eventId]

	if not var_4_0 then
		return
	end

	local var_4_1 = arg_4_0._eventFuncs[var_4_0.type]

	if var_4_1 then
		var_4_1(arg_4_0, arg_4_1, ...)
	else
		logError("未处理事件类型 " .. var_4_0.type .. " id:" .. arg_4_1.eventId)
	end
end

function var_0_0.selectEventChange(arg_5_0, arg_5_1)
	local var_5_0 = lua_rogue_event.configDict[arg_5_1.eventId]

	if not var_5_0 then
		return
	end

	if var_0_1[var_5_0.type] then
		arg_5_0:triggerEvent(arg_5_1)
	end
end

function var_0_0.isPause(arg_6_0)
	return next(arg_6_0._pauseType) and true or false
end

function var_0_0.setPause(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 or V1a6_CachotEnum.EventPauseType.Normal
	arg_7_0._pauseType[arg_7_2] = arg_7_1 and true or nil

	if not arg_7_0:isPause() and arg_7_0._nextEventList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._nextEventList) do
			arg_7_0:triggerEvent(unpack(iter_7_1))
		end

		arg_7_0._nextEventList = nil
	end
end

function var_0_0.getNoCloseViews(arg_8_0)
	return {
		ViewName.V1a6_CachotStoreView,
		ViewName.V1a6_CachotRewardView,
		ViewName.V1a6_CachotEpisodeView,
		ViewName.V1a6_CachotInteractView,
		ViewName.V1a6_CachotCollectionSelectView,
		ViewName.V1a6_CachotUpgradeView,
		ViewName.V1a6_CachotRoleRecoverView,
		ViewName.V1a6_CachotRoleRevivalView
	}
end

function var_0_0._buildEventFuncs(arg_9_0)
	arg_9_0._eventFuncs = {}
	arg_9_0._eventFuncs[V1a6_CachotEnum.EventType.Battle] = arg_9_0.triggerBattle
	arg_9_0._eventFuncs[V1a6_CachotEnum.EventType.HeroPosUpgrade] = arg_9_0.triggerHeroPosUpgrade
	arg_9_0._eventFuncs[V1a6_CachotEnum.EventType.ChoiceSelect] = arg_9_0.triggerChoiceSelect
	arg_9_0._eventFuncs[V1a6_CachotEnum.EventType.CharacterGet] = arg_9_0.triggerCharacterGet
	arg_9_0._eventFuncs[V1a6_CachotEnum.EventType.CharacterCure] = arg_9_0.triggerCharacterCure
	arg_9_0._eventFuncs[V1a6_CachotEnum.EventType.CharacterRebirth] = arg_9_0.triggerCharacterRebirth
	arg_9_0._eventFuncs[V1a6_CachotEnum.EventType.Store] = arg_9_0.triggerStore
	arg_9_0._eventFuncs[V1a6_CachotEnum.EventType.CollectionSelect] = arg_9_0.triggerCollectionSelect
end

function var_0_0.triggerBattle(arg_10_0, arg_10_1)
	local var_10_0 = lua_rogue_event.configDict[arg_10_1.eventId]

	if not var_10_0 then
		return
	end

	if arg_10_1:isBattleSuccess() then
		V1a6_CachotController.instance:openV1a6_CachotRewardView(arg_10_1)

		return
	end

	local var_10_1 = lua_rogue_event_fight.configDict[var_10_0.eventId]

	if not var_10_1 then
		return
	end

	local var_10_2 = var_10_1.episode
	local var_10_3 = DungeonConfig.instance:getEpisodeCO(var_10_2)

	DungeonFightController.instance:enterFight(var_10_3.chapterId, var_10_2)
end

function var_0_0.triggerCollectionSelect(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getDropList()

	if not var_11_0 or #var_11_0 <= 0 then
		return
	end

	local var_11_1 = var_11_0[1]

	if var_11_1.type == "COLLECTION" then
		arg_11_0._dropIndex = var_11_1.idx

		local var_11_2 = var_11_1.colletionList
		local var_11_3 = {
			selectCallback = arg_11_0._onCollectionSelect,
			selectCallbackObj = arg_11_0,
			collectionList = var_11_2
		}

		V1a6_CachotController.instance:openV1a6_CachotCollectionSelectView(var_11_3)
	end
end

function var_0_0._onCollectionSelect(arg_12_0, arg_12_1)
	local var_12_0 = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if not var_12_0 or not arg_12_0._dropIndex then
		return
	end

	RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, var_12_0.eventId, arg_12_0._dropIndex, arg_12_1)
end

function var_0_0.triggerHeroPosUpgrade(arg_13_0, arg_13_1)
	V1a6_CachotController.instance:openV1a6_CachotUpgradeView(arg_13_1)
end

function var_0_0.triggerChoiceSelect(arg_14_0, arg_14_1)
	V1a6_CachotController.instance:openV1a6_CachotEpisodeView(arg_14_1)
end

function var_0_0.triggerCharacterGet(arg_15_0, arg_15_1)
	V1a6_CachotController.instance:selectHeroFromEvent(arg_15_1)
end

function var_0_0.triggerCharacterCure(arg_16_0, arg_16_1)
	V1a6_CachotController.instance:openV1a6_CachotRoleRecoverView(arg_16_1)
end

function var_0_0.triggerCharacterRebirth(arg_17_0, arg_17_1)
	V1a6_CachotController.instance:openV1a6_CachotRoleRevivalView(arg_17_1)
end

function var_0_0.triggerStore(arg_18_0, arg_18_1)
	V1a6_CachotController.instance:openV1a6_CachotStoreView(arg_18_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
