module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractPlayer", package.seeall)

slot0 = class("Va3ChessInteractPlayer", Va3ChessInteractBase)

function slot0.onSelected(slot0)
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.SelectObjWaitPos)

	slot1 = slot0._target.originData.posX
	slot2 = slot0._target.originData.posY
	slot3 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = slot1,
		selfPosY = slot2,
		selectType = Va3ChessEnum.ChessSelectType.Normal
	}

	slot0:insertPosToList(slot1 + 1, slot2, slot3.posXList, slot3.posYList)
	slot0:insertPosToList(slot1 - 1, slot2, slot3.posXList, slot3.posYList)
	slot0:insertPosToList(slot1, slot2 + 1, slot3.posXList, slot3.posYList)
	slot0:insertPosToList(slot1, slot2 - 1, slot3.posXList, slot3.posYList)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, slot3)

	slot0._isPlayerSelected = true

	slot0:refreshPlayerSelected()
end

function slot0.insertPosToList(slot0, slot1, slot2, slot3, slot4)
	if Va3ChessGameController.instance:posCanWalk(slot1, slot2, Va3ChessMapUtils.ToDirection(slot0._target.originData.posX, slot0._target.originData.posY, slot1, slot2), slot0._target.objType) then
		table.insert(slot3, slot1)
		table.insert(slot4, slot2)
	end
end

function slot0.onCancelSelect(slot0)
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.None)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})

	slot0._isPlayerSelected = false

	slot0:refreshPlayerSelected()
end

function slot0.onSelectPos(slot0, slot1, slot2)
	slot3 = slot0._target.originData.posX
	slot5 = Va3ChessGameModel.instance:getBaseTile(slot1, slot2)

	if (slot3 == slot1 and math.abs(slot4 - slot2) == 1 or slot4 == slot2 and math.abs(slot3 - slot1) == 1) and Va3ChessGameController.instance:posCanWalk(slot1, slot2, Va3ChessMapUtils.ToDirection(slot3, slot0._target.originData.posY, slot1, slot2), slot0._target.objType) then
		Va3ChessGameModel.instance:appendOpt({
			id = slot0._target.originData.id,
			dir = Va3ChessMapUtils.ToDirection(slot3, slot4, slot1, slot2)
		})
		Va3ChessRpcController.instance:sendActBeginRoundRequest(Va3ChessGameModel.instance:getActId(), Va3ChessGameModel.instance:getOptList(), slot0.onMoveSuccess, slot0)
		Va3ChessGameController.instance:saveTempSelectObj()
		Va3ChessGameController.instance:setSelectObj(nil)

		if Va3ChessGameController.instance.event then
			slot10:setLockEvent()
		end
	else
		slot7, slot8 = Va3ChessGameController.instance:searchInteractByPos(slot1, slot2)

		if slot7 > 1 and slot8[1] or slot8 then
			if not slot9.config or slot9.config.interactType == Va3ChessEnum.InteractType.Player or slot9.config.interactType == Va3ChessEnum.InteractType.AssistPlayer then
				Va3ChessGameController.instance:setSelectObj(nil)

				return true
			end

			GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)
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

function slot0.showHitAni(slot0)
	if slot0._animSelf then
		slot0._animSelf:Play("hit", 0, 0)
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
