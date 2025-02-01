module("modules.logic.scene.cachot.comp.CachotSceneViewComp", package.seeall)

slot0 = class("CachotSceneViewComp", BaseSceneComp)

function slot0.onScenePrepared(slot0, slot1, slot2)
	if not V1a6_CachotModel.instance:isInRogue() then
		ViewMgr.instance:openView(ViewName.V1a6_CachotMainView)

		if V1a6_CachotModel.instance:getRogueEndingInfo() then
			V1a6_CachotController.instance:openV1a6_CachotFinishView()
		end
	else
		ViewMgr.instance:openView(ViewName.V1a6_CachotRoomView)

		if V1a6_CachotRoomModel.instance:getNowTopEventMo() then
			if not lua_rogue_event.configDict[slot3.eventId] or slot4.type == V1a6_CachotEnum.EventType.Battle and not slot3:isBattleSuccess() then
				return
			end

			for slot9, slot10 in ipairs(V1a6_CachotModel.instance:getRogueInfo().selectedEvents) do
				V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, slot10)
			end
		end
	end
end

function slot0.getRoot(slot0)
	return slot0._uiRoot
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0._uiRoot, slot1)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotMainView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotRoomView)
end

return slot0
