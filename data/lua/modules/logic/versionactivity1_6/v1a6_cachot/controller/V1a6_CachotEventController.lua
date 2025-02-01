module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotEventController", package.seeall)

slot0 = class("V1a6_CachotEventController", BaseController)
slot1 = {
	[V1a6_CachotEnum.EventType.CollectionSelect] = true
}

function slot0.onInit(slot0)
	slot0._pauseType = {}
end

function slot0.reInit(slot0)
	slot0._pauseType = {}
end

function slot0.addConstEvents(slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerTriggerInteract, slot0.triggerEvent, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectEventChange, slot0.selectEventChange, slot0)
end

function slot0.triggerEvent(slot0, slot1, ...)
	if not slot0._eventFuncs then
		slot0:_buildEventFuncs()
	end

	if slot0:isPause() then
		slot0._nextEventList = slot0._nextEventList or {}

		table.insert(slot0._nextEventList, {
			slot1,
			...
		})

		return
	end

	if not lua_rogue_event.configDict[slot1.eventId] then
		return
	end

	if slot0._eventFuncs[slot2.type] then
		slot3(slot0, slot1, ...)
	else
		logError("未处理事件类型 " .. slot2.type .. " id:" .. slot1.eventId)
	end
end

function slot0.selectEventChange(slot0, slot1)
	if not lua_rogue_event.configDict[slot1.eventId] then
		return
	end

	if uv0[slot2.type] then
		slot0:triggerEvent(slot1)
	end
end

function slot0.isPause(slot0)
	return next(slot0._pauseType) and true or false
end

function slot0.setPause(slot0, slot1, slot2)
	slot0._pauseType[slot2 or V1a6_CachotEnum.EventPauseType.Normal] = slot1 and true or nil

	if not slot0:isPause() and slot0._nextEventList then
		for slot6, slot7 in ipairs(slot0._nextEventList) do
			slot0:triggerEvent(unpack(slot7))
		end

		slot0._nextEventList = nil
	end
end

function slot0.getNoCloseViews(slot0)
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

function slot0._buildEventFuncs(slot0)
	slot0._eventFuncs = {
		[V1a6_CachotEnum.EventType.Battle] = slot0.triggerBattle,
		[V1a6_CachotEnum.EventType.HeroPosUpgrade] = slot0.triggerHeroPosUpgrade,
		[V1a6_CachotEnum.EventType.ChoiceSelect] = slot0.triggerChoiceSelect,
		[V1a6_CachotEnum.EventType.CharacterGet] = slot0.triggerCharacterGet,
		[V1a6_CachotEnum.EventType.CharacterCure] = slot0.triggerCharacterCure,
		[V1a6_CachotEnum.EventType.CharacterRebirth] = slot0.triggerCharacterRebirth,
		[V1a6_CachotEnum.EventType.Store] = slot0.triggerStore,
		[V1a6_CachotEnum.EventType.CollectionSelect] = slot0.triggerCollectionSelect
	}
end

function slot0.triggerBattle(slot0, slot1)
	if not lua_rogue_event.configDict[slot1.eventId] then
		return
	end

	if slot1:isBattleSuccess() then
		V1a6_CachotController.instance:openV1a6_CachotRewardView(slot1)

		return
	end

	if not lua_rogue_event_fight.configDict[slot2.eventId] then
		return
	end

	slot4 = slot3.episode

	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot4).chapterId, slot4)
end

function slot0.triggerCollectionSelect(slot0, slot1)
	if not slot1:getDropList() or #slot2 <= 0 then
		return
	end

	if slot2[1].type == "COLLECTION" then
		slot0._dropIndex = slot3.idx

		V1a6_CachotController.instance:openV1a6_CachotCollectionSelectView({
			selectCallback = slot0._onCollectionSelect,
			selectCallbackObj = slot0,
			collectionList = slot3.colletionList
		})
	end
end

function slot0._onCollectionSelect(slot0, slot1)
	if not V1a6_CachotRoomModel.instance:getNowTopEventMo() or not slot0._dropIndex then
		return
	end

	RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, slot2.eventId, slot0._dropIndex, slot1)
end

function slot0.triggerHeroPosUpgrade(slot0, slot1)
	V1a6_CachotController.instance:openV1a6_CachotUpgradeView(slot1)
end

function slot0.triggerChoiceSelect(slot0, slot1)
	V1a6_CachotController.instance:openV1a6_CachotEpisodeView(slot1)
end

function slot0.triggerCharacterGet(slot0, slot1)
	V1a6_CachotController.instance:selectHeroFromEvent(slot1)
end

function slot0.triggerCharacterCure(slot0, slot1)
	V1a6_CachotController.instance:openV1a6_CachotRoleRecoverView(slot1)
end

function slot0.triggerCharacterRebirth(slot0, slot1)
	V1a6_CachotController.instance:openV1a6_CachotRoleRevivalView(slot1)
end

function slot0.triggerStore(slot0, slot1)
	V1a6_CachotController.instance:openV1a6_CachotStoreView(slot1)
end

slot0.instance = slot0.New()

return slot0
