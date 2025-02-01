module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateUseItem", package.seeall)

slot0 = class("YaXianStateUseItem", YaXianStateBase)

function slot0.start(slot0)
	logError("Ya Xian use Item, not realize")
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.ActivityChessGame then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
		slot0:startNotifyView()
	end
end

function slot0.startNotifyView(slot0)
	slot1 = slot0.originData.activityId
	slot2 = slot0.originData.interactId
	slot3 = slot0.originData.createId

	if not slot0.originData.range or not slot2 then
		logError("YaXianStateUseItem range = " .. tostring(slot4) .. ", interactId = " .. tostring(slot2))

		return
	end

	if ActivityChessGameController.instance.interacts and slot5:get(slot2) then
		slot7 = slot6.originData.posX
		slot8 = slot6.originData.posY
		slot0._centerY = slot8
		slot0._centerX = slot7

		slot0:packEventObjs(slot7, slot8, slot4)
	end
end

function slot0.packEventObjs(slot0, slot1, slot2, slot3)
	slot4 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = slot1,
		selfPosY = slot2
	}

	for slot8 = slot1 - slot3, slot1 + slot3 do
		for slot12 = slot2 - slot3, slot2 + slot3 do
			if slot0:checkCanThrow(slot1, slot2, slot8, slot12) then
				table.insert(slot4.posXList, slot8)
				table.insert(slot4.posYList, slot12)
			end
		end
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, slot4)
end

function slot0.checkCanThrow(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot3 or slot2 ~= slot4 then
		return ActivityChessGameController.instance:posCanWalk(slot3, slot4)
	end

	return false
end

function slot0.onClickPos(slot0, slot1, slot2)
	if not slot0._centerX then
		logError("YaXianStateUseItem no interact pos found !")

		return
	end

	slot3 = slot0.originData.range

	if slot0:checkCanThrow(slot0._centerX, slot0._centerY, slot1, slot2) and math.abs(slot1 - slot0._centerX) <= slot3 and math.abs(slot2 - slot0._centerY) <= slot3 then
		Activity109Rpc.instance:sendAct109UseItemRequest(slot0.originData.activityId, slot1, slot2, slot0.onReceiveReply, slot0)
	end
end

function slot0.onReceiveReply(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay, slot0)
end

function slot0.dispose(slot0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	uv0.super.dispose(slot0)
end

return slot0
