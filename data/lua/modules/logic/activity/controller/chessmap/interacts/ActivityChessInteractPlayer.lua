module("modules.logic.activity.controller.chessmap.interacts.ActivityChessInteractPlayer", package.seeall)

slot0 = class("ActivityChessInteractPlayer", ActivityChessInteractBase)

function slot0.onSelectCall(slot0)
	ActivityChessGameController.instance:setClickStatus(ActivityChessEnum.SelectPosStatus.SelectObjWaitPos)

	slot1 = slot0._target.originData.posX
	slot2 = slot0._target.originData.posY
	slot3 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = slot1,
		selfPosY = slot2,
		selectType = ActivityChessEnum.ChessSelectType.Normal
	}

	uv0.insertPosToList(slot1 + 1, slot2, slot3.posXList, slot3.posYList)
	uv0.insertPosToList(slot1 - 1, slot2, slot3.posXList, slot3.posYList)
	uv0.insertPosToList(slot1, slot2 + 1, slot3.posXList, slot3.posYList)
	uv0.insertPosToList(slot1, slot2 - 1, slot3.posXList, slot3.posYList)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, slot3)

	slot0._isPlayerSelected = true

	slot0:refreshPlayerSelected()
end

function slot0.insertPosToList(slot0, slot1, slot2, slot3)
	if ActivityChessGameController.instance:posCanWalk(slot0, slot1) then
		table.insert(slot2, slot0)
		table.insert(slot3, slot1)
	end
end

function slot0.onCancelSelect(slot0)
	ActivityChessGameController.instance:setClickStatus(ActivityChessEnum.SelectPosStatus.None)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})

	slot0._isPlayerSelected = false

	slot0:refreshPlayerSelected()
end

function slot0.onSelectPos(slot0, slot1, slot2)
	slot4 = slot0._target.originData.posY
	slot5 = ActivityChessGameModel.instance:getBaseTile(slot1, slot2)

	if (slot0._target.originData.posX == slot1 and math.abs(slot4 - slot2) == 1 or slot4 == slot2 and math.abs(slot3 - slot1) == 1) and ActivityChessGameController.instance:posCanWalk(slot1, slot2) then
		ActivityChessGameModel.instance:appendOpt({
			id = slot0._target.originData.id,
			dir = ActivityChessMapUtils.ToDirection(slot3, slot4, slot1, slot2)
		})
		Activity109Rpc.instance:sendAct109BeginRoundRequest(ActivityChessGameModel.instance:getActId(), ActivityChessGameModel.instance:getOptList(), slot0.onMoveSuccess, slot0)
		ActivityChessGameController.instance:saveTempSelectObj()
		ActivityChessGameController.instance:setSelectObj(nil)

		if ActivityChessGameController.instance.event then
			slot9:setLockEvent()
		end
	else
		slot6, slot7 = ActivityChessGameController.instance:searchInteractByPos(slot1, slot2)

		if slot6 > 1 and slot7[1] or slot7 then
			if not slot8.config or slot8.config.interactType == ActivityChessEnum.InteractType.Player then
				ActivityChessGameController.instance:setSelectObj(nil)

				return true
			end
		else
			GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)
		end
	end
end

function slot0.onMoveSuccess(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	uv0.super.moveTo(slot0, slot1, slot2, slot3, slot4)

	if slot0._animSelf then
		slot0._animSelf:Play("jump", 0, 0)
	end
end

function slot0.refreshPlayerSelected(slot0)
end

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)

	if not slot0._target.avatar.loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot0._animSelf = slot2:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0._target.avatar.goSelected = gohelper.findChild(slot1:getInstGO(), "piecea/vx_select")

	gohelper.setActive(slot0._target.avatar.goSelected, true)
	slot0:refreshPlayerSelected()
end

return slot0
