module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessSoldierUnit", package.seeall)

slot0 = class("TeamChessSoldierUnit", TeamChessUnitEntityBase)
slot1 = UnityEngine.Input

function slot0.refreshTransform(slot0, slot1, slot2, slot3)
	slot0._lastTr = slot0._tr
	slot0._tr = slot1
	slot0._unitParentPosition = slot2

	slot0:updatePosByTr()
	slot0:refreshShowModeState()
end

function slot0.getPosByTr(slot0)
	if slot0._tr == nil then
		return 0, 0, 0
	end

	slot2, slot3 = recthelper.uiPosToScreenPos2(slot0._tr, EliminateTeamChessModel.instance:getViewCanvas())
	slot4, slot5, slot6 = recthelper.screenPosToWorldPos3(Vector2(slot2, slot3), nil, slot0._unitParentPosition)

	return slot4, slot5, slot6
end

function slot0.updatePosByTr(slot0)
	slot1, slot2, slot3 = slot0:getPosByTr()

	slot0:updatePos(slot1, slot2, slot3)

	if slot0._lastTr == nil or slot0._lastTr ~= slot0._tr then
		slot0:playAnimator("in")
	end
end

function slot0.movePosByTr(slot0)
	slot1, slot2, slot3 = slot0:getPosByTr()

	slot0:moveToPos(slot1, slot2, slot3)
end

function slot0.moveToPosByTargetTr(slot0, slot1, slot2, slot3)
	if slot1 == nil then
		return
	end

	slot4, slot5, slot6 = slot0:getPosXYZ()

	if slot0._unitMo.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot4 = slot4 + EliminateTeamChessEnum.chessMoveOffsetX
		slot5 = slot5 + EliminateTeamChessEnum.chessMoveOffsetY
	end

	if slot0._unitMo.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot4 = slot4 - EliminateTeamChessEnum.chessMoveOffsetX
		slot5 = slot5 - EliminateTeamChessEnum.chessMoveOffsetY
	end

	slot0:moveToPos(slot4, slot5, slot6)
end

function slot0._onResLoaded(slot0)
	uv0.super._onResLoaded(slot0)

	if slot0._resGo.transform.childCount ~= 6 then
		logError("TeamChessSoldierUnit:_onResLoaded() childCount ~= 6, resName: " .. slot0._resGo.name)
	end

	for slot5 = 1, slot0._resGo.transform.childCount do
		if not gohelper.isNil(slot0._resGo.transform:GetChild(slot5 - 1).gameObject) then
			if GameUtil.endsWith(slot6.name, "1") then
				slot0._frontGo = slot6
			end

			if GameUtil.endsWith(slot7, "2") then
				slot0._backGo = slot6
			end

			if GameUtil.endsWith(slot7, "1_outline") then
				slot0._frontOutLineGo = slot6
			end

			if GameUtil.endsWith(slot7, "2_outline") then
				slot0._backOutLineGo = slot6
			end

			if GameUtil.endsWith(slot7, "1_grayscale") then
				slot0._frontGrayGo = slot6
			end

			if GameUtil.endsWith(slot7, "2_grayscale") then
				slot0._backGrayGo = slot6
			end
		end
	end

	if not gohelper.isNil(slot0._frontGo) and not gohelper.isNil(slot0._backGo) then
		gohelper.setActive(slot0._frontGo, false)
		gohelper.setActive(slot0._backGo, false)
	end

	if not gohelper.isNil(slot0._frontOutLineGo) and not gohelper.isNil(slot0._backOutLineGo) then
		gohelper.setActive(slot0._frontOutLineGo, false)
		gohelper.setActive(slot0._backOutLineGo, false)
	end

	if not gohelper.isNil(slot0._frontGrayGo) and not gohelper.isNil(slot0._backGrayGo) then
		gohelper.setActive(slot0._frontGrayGo, false)
		gohelper.setActive(slot0._backGrayGo, false)
	end

	slot0.ani = slot0._resGo:GetComponent(typeof(UnityEngine.Animator))
	slot0._goClick = ZProj.BoxColliderClickListener.Get(slot0._resGo)

	slot0._goClick:SetIgnoreUI(true)
	slot0._goClick:AddMouseUpListener(slot0._onMouseUp, slot0)
	slot0._goClick:AddDragListener(slot0._onDrag, slot0)

	slot0._isDrag = false

	transformhelper.setLocalPos(slot0._resGo.transform, 0, 0.4, 0)
	slot0:setShowModeType(EliminateTeamChessEnum.ModeType.Normal)
end

function slot0.setOutlineActive(slot0, slot1)
	slot0:playAnimator(slot1 and "select" or "idle")
end

function slot0.setGrayActive(slot0, slot1)
	slot0:playAnimator(slot1 and "gray" or "idle")
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0._resGo, slot1)
end

function slot0.setNormalActive(slot0, slot1)
	slot0:playAnimator("idle")
end

function slot0.setShowModeType(slot0, slot1)
	if gohelper.isNil(slot0._resGo) then
		return
	end

	if slot0._lastModelType ~= nil and slot0._lastModelType == slot1 then
		return
	end

	slot0._lastModelType = slot1
	slot2 = false
	slot3 = false
	slot4 = false
	slot5 = "idle"

	if slot1 ~= nil then
		if slot1 == EliminateTeamChessEnum.ModeType.Gray then
			slot3 = true
			slot5 = "gray"
		end

		if slot1 == EliminateTeamChessEnum.ModeType.Normal then
			slot4 = true
			slot5 = "idle"
		end

		if slot1 == EliminateTeamChessEnum.ModeType.Outline then
			slot2 = true
			slot5 = "select"
		end

		slot0._modeType = slot1
	end

	slot0:setNormalActive(slot4)
	slot0:setOutlineActive(slot2)
	slot0:setGrayActive(slot3)
	slot0:playAnimator(slot5)
end

function slot0.getShowModeType(slot0)
	return slot0._modeType
end

function slot0.cacheModel(slot0)
	slot0.cacheModelType = slot0:getShowModeType()
end

function slot0.restoreModel(slot0)
	if slot0.cacheModelType == nil then
		return
	end

	slot0:setShowModeType(slot0.cacheModelType)
end

function slot0.setActiveAndPlayAni(slot0, slot1)
	slot0:setActive(slot1)

	if slot1 then
		slot0:playAnimator("fadein")
	else
		slot0:playAnimator("fadeout")
	end
end

function slot0.playAnimator(slot0, slot1)
	if slot0.ani then
		slot0.ani:Play(slot1, 0, 0)
	end
end

function slot0._onMouseUp(slot0)
	if not slot0:_needResponseClick(UnityEngine.Input.mousePosition) then
		return
	end

	if slot0._isDrag then
		slot0:_dragEnd()

		return
	end

	slot0:_onClick()
end

function slot0._onDrag(slot0)
	if EliminateTeamChessModel.instance:getTeamChessSkillState() then
		return
	end

	if not slot0:_needResponseClick(UnityEngine.Input.mousePosition) then
		return
	end

	if not slot0._canDrag or slot0._unitMo == nil then
		return
	end

	if not slot0._isDrag and (uv0.GetAxis("Mouse X") ~= 0 or uv0.GetAxis("Mouse Y") ~= 0) then
		slot0._isDrag = true
	end

	if not slot0._isDrag then
		return
	end

	slot2 = UnityEngine.Input.mousePosition

	slot0:onDrag(slot2.x, slot2.y)
end

function slot0._onClick(slot0)
	if not slot0:_needResponseClick(UnityEngine.Input.mousePosition) then
		return
	end

	if not slot0._canClick or slot0._unitMo == nil then
		return
	end

	slot0:onClick()
end

function slot0._needResponseClick(slot0, slot1)
	if slot0._pointerEventData == nil then
		slot0._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		slot0._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
		slot0._uiRootGO = EliminateTeamChessModel.instance:getTipViewParent()
	end

	slot0._pointerEventData.position = slot1

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(slot0._pointerEventData, slot0._raycastResults)

	slot2 = slot0._raycastResults:GetEnumerator()

	while slot2:MoveNext() do
		slot3 = slot2.Current

		if slot0:_isRaycaster2d(slot3.module, slot3.gameObject) then
			return false
		end
	end

	return true
end

slot2 = {
	"#btn_click_2",
	"#btn_click",
	"#btn_mask"
}

function slot0._isRaycaster2d(slot0, slot1, slot2)
	for slot6 = 1, #uv0 do
		if slot2.name == uv0[slot6] then
			return true
		end
	end

	return slot1.gameObject.transform:IsChildOf(slot0._uiRootGO.transform)
end

function slot0._dragEnd(slot0)
	if slot0._unitMo == nil then
		return
	end

	slot0._isDrag = false
	slot1 = UnityEngine.Input.mousePosition

	slot0:onDragEnd(slot1.x, slot1.y)
end

function slot0.onDrag(slot0, slot1, slot2)
end

function slot0.onDragEnd(slot0, slot1, slot2)
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)

	slot1 = slot0._unitMo.stronghold
	slot2 = slot0._unitMo.uid
	slot3 = slot0._unitMo.soldierId
	slot4 = EliminateTeamChessEnum.ChessTipType.showDesc
	slot5 = nil

	if slot0._unitMo.teamType ~= EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot4 = EliminateTeamChessEnum.ChessTipType.showSell
	else
		slot5 = {
			soliderTipOffsetX = EliminateTeamChessEnum.soliderSellTipOffsetX,
			soliderTipOffsetY = -EliminateTeamChessEnum.soliderSellTipOffsetY
		}
	end

	if not EliminateLevelModel.instance:sellChessIsUnLock() or EliminateLevelModel.instance:getIsWatchTeamChess() then
		slot4 = EliminateTeamChessEnum.ChessTipType.showDesc

		if slot0._unitMo.teamType ~= EliminateTeamChessEnum.TeamChessTeamType.enemy then
			slot5 = {
				soliderTipOffsetX = EliminateTeamChessEnum.playerSoliderWatchTipOffsetX,
				soliderTipOffsetY = EliminateTeamChessEnum.playerSoliderWatchTipOffsetY
			}
		end
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.SoliderChessModelClick, slot3, slot2, slot1, slot4, slot0, slot5)
end

function slot0.setAllMeshRenderOrderInLayer(slot0, slot1)
	if not gohelper.isNil(slot0._frontGo) then
		slot0._frontGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = slot1
	end

	if not gohelper.isNil(slot0._backGo) then
		slot0._backGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = slot1
	end

	if not gohelper.isNil(slot0._frontOutLineGo) then
		slot0._frontOutLineGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = slot1
	end

	if not gohelper.isNil(slot0._backOutLineGo) then
		slot0._backOutLineGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = slot1
	end

	if not gohelper.isNil(slot0._frontGrayGo) then
		slot0._frontGrayGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = slot1
	end

	if not gohelper.isNil(slot0._backGrayGo) then
		slot0._backGrayGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = slot1
	end
end

function slot0.dispose(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_enemy_move)

	if slot0._unitMo ~= nil and slot0._unitMo.uid == EliminateTeamChessEnum.tempPieceUid then
		slot0:onDestroy()
	else
		slot0:playAnimator("out")
		TaskDispatcher.runDelay(slot0.onDestroy, slot0, 0.33)
	end
end

function slot0.refreshShowModeState(slot0)
	slot1 = EliminateTeamChessEnum.ModeType.Normal

	if slot0._unitMo ~= nil and slot0._unitMo:canActiveMove() then
		slot1 = EliminateTeamChessEnum.ModeType.Outline
	end

	slot0:setShowModeType(slot1)
end

function slot0.refreshMeshOrder(slot0)
	if slot0._unitMo ~= nil then
		slot0:setAllMeshRenderOrderInLayer(slot0._unitMo:getOrder())
	end
end

function slot0.onDestroy(slot0)
	if slot0._goClick then
		slot0._goClick:RemoveMouseUpListener()
		slot0._goClick:RemoveDragListener()

		slot0._goClick = nil
	end

	slot0._pointerEventData = nil
	slot0._raycastResults = nil
	slot0._uiRootGO = nil
	slot0._frontGo = nil
	slot0._backGo = nil
	slot0._frontOutLineGo = nil
	slot0._backOutLineGo = nil
	slot0._frontGrayGo = nil
	slot0._backGrayGo = nil
	slot0._tr = nil
	slot0._unitParentPosition = nil

	TaskDispatcher.cancelTask(slot0.onDestroy, slot0)
	TaskDispatcher.cancelTask(slot0.setActiveByCache, slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
