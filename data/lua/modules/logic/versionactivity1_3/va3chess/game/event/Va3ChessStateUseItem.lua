module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateUseItem", package.seeall)

slot0 = class("Va3ChessStateUseItem", Va3ChessStateBase)

function slot0.start(slot0)
	logNormal("Va3ChessStateUseItem start")
	slot0:startNotifyView()
end

function slot0.startNotifyView(slot0)
	slot1 = slot0.originData.activityId
	slot2 = slot0.originData.interactId
	slot3 = slot0.originData.createId

	if not slot0.originData.range or not slot2 then
		logError("Va3ChessStateUseItem range = " .. tostring(slot4) .. ", interactId = " .. tostring(slot2))

		return
	end

	if Va3ChessGameController.instance.interacts and slot5:get(slot2) then
		if not gohelper.isNil(slot6:tryGetGameObject()) then
			gohelper.setActive(gohelper.findChild(slot7, "vx_daoju"), true)
		end

		if slot6.goToObject then
			slot6.goToObject:setMarkAttract(true)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)
	TaskDispatcher.runDelay(slot0.delayCallChoosePos, slot0, 1)
end

function slot0.delayCallChoosePos(slot0)
	TaskDispatcher.cancelTask(slot0.delayCallChoosePos, slot0)

	slot1 = slot0.originData.activityId
	slot3 = slot0.originData.createId

	if Va3ChessGameController.instance.interacts and slot5:get(slot0.originData.interactId) then
		slot7 = slot6.originData.posX
		slot8 = slot6.originData.posY
		slot0._centerY = slot8
		slot0._centerX = slot7

		slot0:packEventObjs(slot7, slot8, slot0.originData.range)
	end
end

function slot0.packEventObjs(slot0, slot1, slot2, slot3)
	slot4 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = slot1,
		selfPosY = slot2,
		selectType = Va3ChessEnum.ChessSelectType.UseItem
	}

	for slot8 = slot1 - slot3, slot1 + slot3 do
		for slot12 = slot2 - slot3, slot2 + slot3 do
			if slot0:checkCanThrow(slot1, slot2, slot8, slot12) then
				table.insert(slot4.posXList, slot8)
				table.insert(slot4.posYList, slot12)
			end
		end
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetCenterHintText, {
		visible = true,
		text = luaLang("versionact_109_itemplace_hint")
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, slot4)
end

function slot0.checkCanThrow(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot3 or slot2 ~= slot4 then
		return Va3ChessGameController.instance:posCanWalk(slot3, slot4)
	end

	return false
end

function slot0.onClickPos(slot0, slot1, slot2, slot3)
	if not slot0._centerX then
		logNormal("Va3ChessStateUseItem no interact pos found !")

		return
	end

	slot4 = slot0.originData.range

	if slot0:checkCanThrow(slot0._centerX, slot0._centerY, slot1, slot2) and math.abs(slot1 - slot0._centerX) <= slot4 and math.abs(slot2 - slot0._centerY) <= slot4 then
		Va3ChessRpcController.instance:sendActUseItemRequest(slot0.originData.activityId, slot1, slot2, slot0.onReceiveReply, slot0)
	end
end

function slot0.onReceiveReply(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetCenterHintText, {
		visible = false
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay, slot0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.SetItem)
end

function slot0.hideAttractEffect(slot0)
	if Va3ChessGameController.instance.interacts:get(slot0.originData.interactId) and slot3.goToObject then
		slot3.goToObject:setMarkAttract(false)
	end
end

function slot0.dispose(slot0)
	slot0:hideAttractEffect()
	TaskDispatcher.cancelTask(slot0.delayCallChoosePos, slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetCenterHintText, {
		visible = false
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	uv0.super.dispose(slot0)
end

return slot0
