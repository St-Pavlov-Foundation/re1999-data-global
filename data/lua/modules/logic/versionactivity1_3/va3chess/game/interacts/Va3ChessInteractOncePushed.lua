module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractOncePushed", package.seeall)

slot0 = class("Va3ChessInteractOncePushed", Va3ChessInteractBase)

function slot0.checkCanBlock(slot0, slot1, slot2)
	if slot2 == Va3ChessEnum.InteractType.AssistPlayer then
		return true
	end

	if slot0._target.originData.data.status then
		return true
	end

	slot3, slot4 = Va3ChessMapUtils.CalNextCellPos(slot0._target.originData.posX, slot0._target.originData.posY, slot1)

	if slot0:checkNoTileByXY(slot3, slot4) then
		return true
	end

	slot6, slot7 = Va3ChessGameController.instance:searchInteractByPos(slot3, slot4)

	if slot6 > 0 then
		if slot6 == 1 then
			return slot7 and slot7:getObjType() ~= Va3ChessEnum.InteractType.DestroyableTrap
		else
			return true
		end
	end
end

function slot0.checkNoTileByXY(slot0, slot1, slot2)
	if not Va3ChessGameModel.instance:isPosInChessBoard(slot1, slot2) then
		return true
	end

	if not Va3ChessGameModel.instance:getTileMO(slot1, slot2) or slot3.tileType == Va3ChessEnum.TileBaseType.None or slot3:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		return true
	end

	return false
end

function slot0.showStateView(slot0, slot1, slot2)
	if slot1 == Va3ChessEnum.ObjState.Idle then
		slot0:showIdleStateView()
	elseif slot1 == Va3ChessEnum.ObjState.Interoperable then
		slot0:showPushableStateView(slot2)
	end
end

function slot0.showIdleStateView(slot0)
	slot0:setArrawDir(0)
end

function slot0.showPushableStateView(slot0, slot1)
	slot0:setArrawDir(slot1.dir)
end

function slot0.setArrawDir(slot0, slot1)
	if slot0._target.avatar then
		for slot5, slot6 in ipairs(Va3ChessInteractObject.DirectionList) do
			if not gohelper.isNil(slot0._target.avatar["arraw" .. slot6]) then
				gohelper.setActive(slot7, slot1 == slot6)
			end
		end
	end
end

slot1 = "idle_b"

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)

	if not slot0._target.avatar.loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot6 = UnityEngine.Animator
		slot0._animator = slot2:GetComponent(typeof(slot6))

		for slot6, slot7 in ipairs(Va3ChessInteractObject.DirectionList) do
			slot0._target.avatar["arraw" .. slot7] = gohelper.findChild(slot2, "icon/icon_direction/dir_" .. slot7)
		end
	end

	if slot0._target.originData.data.status and slot0._animator then
		slot0._animator:Play(uv1)
	end
end

function slot0.onMoveCompleted(slot0)
	uv0.super.onMoveCompleted(slot0)
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.VatPushDown)

	if slot0._animator then
		slot0._animator:Play(UIAnimationName.Close, 0, 0)
	end
end

return slot0
