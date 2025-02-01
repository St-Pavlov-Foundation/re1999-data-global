module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomGuide", package.seeall)

slot0 = class("V1a6_CachotRoomGuide", BaseView)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.CheckGuideEnterLayerRoom, slot0._checkGuideEnterLayerRoom, slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.CheckPlayStory, slot0._onRoomViewOpenAnimEnd, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.GuideMoveCollection, slot0._onGuideMoveCollection, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0._heartNum = V1a6_CachotController.instance.heartNum
	V1a6_CachotController.instance.heartNum = nil
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._guideEnterLayerRoom, slot0)
end

function slot0._onFinishGuide(slot0, slot1)
	if slot1 == 16508 then
		slot0:_guideEnterLayerRoom()
	end
end

function slot0._onGuideMoveCollection(slot0)
	V1a6_CachotCollectionBagController.instance.guideMoveCollection = true
end

function slot0._checkGuideEnterLayerRoom(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) then
		return
	end

	TaskDispatcher.cancelTask(slot0._guideEnterLayerRoom, slot0)
	TaskDispatcher.runDelay(slot0._guideEnterLayerRoom, slot0, 0.5)
end

function slot0._guideEnterLayerRoom(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) then
		return
	end

	slot0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not slot0._rogueInfo then
		return
	end

	slot2, slot3 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(slot0._rogueInfo.room)
	slot5 = slot0._heartNum
	slot0._heartNum = slot0._rogueInfo.heart

	if slot0._rogueInfo.layer ~= 1 or slot2 >= 3 then
		if slot5 and slot5 ~= slot4 then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideHeartChange)
		end

		if V1a6_CachotCollectionHelper.isCollectionBagCanEnchant() then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideCanEnchant)
		end
	end

	if slot1 == 3 and slot2 == 3 then
		slot7 = slot0._rogueInfo.collectionCfgMap and slot6[V1a6_CachotEnum.SpecialCollection]

		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideEnterLayerRoom, string.format("%s_%s_%s", slot1, slot2, slot7 and #slot7 > 0 and 1 or 0))

		return
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideEnterLayerRoom, string.format("%s_%s", slot1, slot2))
end

function slot0._onRoomViewOpenAnimEnd(slot0)
	slot0:_guideEnterLayerRoom()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.StoryBackgroundView or string.find(slot1, "V1a6_CachotCollection") then
		slot0:_guideEnterLayerRoom()
	end
end

return slot0
