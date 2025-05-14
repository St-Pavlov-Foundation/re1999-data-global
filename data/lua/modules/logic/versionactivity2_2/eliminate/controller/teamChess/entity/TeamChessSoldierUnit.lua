module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessSoldierUnit", package.seeall)

local var_0_0 = class("TeamChessSoldierUnit", TeamChessUnitEntityBase)
local var_0_1 = UnityEngine.Input

function var_0_0.refreshTransform(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._lastTr = arg_1_0._tr
	arg_1_0._tr = arg_1_1
	arg_1_0._unitParentPosition = arg_1_2

	arg_1_0:updatePosByTr()
	arg_1_0:refreshShowModeState()
end

function var_0_0.getPosByTr(arg_2_0)
	if arg_2_0._tr == nil then
		return 0, 0, 0
	end

	local var_2_0 = EliminateTeamChessModel.instance:getViewCanvas()
	local var_2_1, var_2_2 = recthelper.uiPosToScreenPos2(arg_2_0._tr, var_2_0)
	local var_2_3, var_2_4, var_2_5 = recthelper.screenPosToWorldPos3(Vector2(var_2_1, var_2_2), nil, arg_2_0._unitParentPosition)

	return var_2_3, var_2_4, var_2_5
end

function var_0_0.updatePosByTr(arg_3_0)
	local var_3_0, var_3_1, var_3_2 = arg_3_0:getPosByTr()

	arg_3_0:updatePos(var_3_0, var_3_1, var_3_2)

	if arg_3_0._lastTr == nil or arg_3_0._lastTr ~= arg_3_0._tr then
		arg_3_0:playAnimator("in")
	end
end

function var_0_0.movePosByTr(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = arg_4_0:getPosByTr()

	arg_4_0:moveToPos(var_4_0, var_4_1, var_4_2)
end

function var_0_0.moveToPosByTargetTr(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 == nil then
		return
	end

	local var_5_0, var_5_1, var_5_2 = arg_5_0:getPosXYZ()

	if arg_5_0._unitMo.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		var_5_0 = var_5_0 + EliminateTeamChessEnum.chessMoveOffsetX
		var_5_1 = var_5_1 + EliminateTeamChessEnum.chessMoveOffsetY
	end

	if arg_5_0._unitMo.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		var_5_0 = var_5_0 - EliminateTeamChessEnum.chessMoveOffsetX
		var_5_1 = var_5_1 - EliminateTeamChessEnum.chessMoveOffsetY
	end

	arg_5_0:moveToPos(var_5_0, var_5_1, var_5_2)
end

function var_0_0._onResLoaded(arg_6_0)
	var_0_0.super._onResLoaded(arg_6_0)

	if arg_6_0._resGo.transform.childCount ~= 6 then
		logError("TeamChessSoldierUnit:_onResLoaded() childCount ~= 6, resName: " .. arg_6_0._resGo.name)
	end

	local var_6_0 = arg_6_0._resGo.transform.childCount

	for iter_6_0 = 1, var_6_0 do
		local var_6_1 = arg_6_0._resGo.transform:GetChild(iter_6_0 - 1).gameObject

		if not gohelper.isNil(var_6_1) then
			local var_6_2 = var_6_1.name

			if GameUtil.endsWith(var_6_2, "1") then
				arg_6_0._frontGo = var_6_1
			end

			if GameUtil.endsWith(var_6_2, "2") then
				arg_6_0._backGo = var_6_1
			end

			if GameUtil.endsWith(var_6_2, "1_outline") then
				arg_6_0._frontOutLineGo = var_6_1
			end

			if GameUtil.endsWith(var_6_2, "2_outline") then
				arg_6_0._backOutLineGo = var_6_1
			end

			if GameUtil.endsWith(var_6_2, "1_grayscale") then
				arg_6_0._frontGrayGo = var_6_1
			end

			if GameUtil.endsWith(var_6_2, "2_grayscale") then
				arg_6_0._backGrayGo = var_6_1
			end
		end
	end

	if not gohelper.isNil(arg_6_0._frontGo) and not gohelper.isNil(arg_6_0._backGo) then
		gohelper.setActive(arg_6_0._frontGo, false)
		gohelper.setActive(arg_6_0._backGo, false)
	end

	if not gohelper.isNil(arg_6_0._frontOutLineGo) and not gohelper.isNil(arg_6_0._backOutLineGo) then
		gohelper.setActive(arg_6_0._frontOutLineGo, false)
		gohelper.setActive(arg_6_0._backOutLineGo, false)
	end

	if not gohelper.isNil(arg_6_0._frontGrayGo) and not gohelper.isNil(arg_6_0._backGrayGo) then
		gohelper.setActive(arg_6_0._frontGrayGo, false)
		gohelper.setActive(arg_6_0._backGrayGo, false)
	end

	arg_6_0.ani = arg_6_0._resGo:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._goClick = ZProj.BoxColliderClickListener.Get(arg_6_0._resGo)

	arg_6_0._goClick:SetIgnoreUI(true)
	arg_6_0._goClick:AddMouseUpListener(arg_6_0._onMouseUp, arg_6_0)
	arg_6_0._goClick:AddDragListener(arg_6_0._onDrag, arg_6_0)

	arg_6_0._isDrag = false

	transformhelper.setLocalPos(arg_6_0._resGo.transform, 0, 0.4, 0)
	arg_6_0:setShowModeType(EliminateTeamChessEnum.ModeType.Normal)
end

function var_0_0.setOutlineActive(arg_7_0, arg_7_1)
	arg_7_0:playAnimator(arg_7_1 and "select" or "idle")
end

function var_0_0.setGrayActive(arg_8_0, arg_8_1)
	arg_8_0:playAnimator(arg_8_1 and "gray" or "idle")
end

function var_0_0.setActive(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._resGo, arg_9_1)
end

function var_0_0.setNormalActive(arg_10_0, arg_10_1)
	arg_10_0:playAnimator("idle")
end

function var_0_0.setShowModeType(arg_11_0, arg_11_1)
	if gohelper.isNil(arg_11_0._resGo) then
		return
	end

	if arg_11_0._lastModelType ~= nil and arg_11_0._lastModelType == arg_11_1 then
		return
	end

	arg_11_0._lastModelType = arg_11_1

	local var_11_0 = false
	local var_11_1 = false
	local var_11_2 = false
	local var_11_3 = "idle"

	if arg_11_1 ~= nil then
		if arg_11_1 == EliminateTeamChessEnum.ModeType.Gray then
			var_11_1 = true
			var_11_3 = "gray"
		end

		if arg_11_1 == EliminateTeamChessEnum.ModeType.Normal then
			var_11_2 = true
			var_11_3 = "idle"
		end

		if arg_11_1 == EliminateTeamChessEnum.ModeType.Outline then
			var_11_0 = true
			var_11_3 = "select"
		end

		arg_11_0._modeType = arg_11_1
	end

	arg_11_0:setNormalActive(var_11_2)
	arg_11_0:setOutlineActive(var_11_0)
	arg_11_0:setGrayActive(var_11_1)
	arg_11_0:playAnimator(var_11_3)
end

function var_0_0.getShowModeType(arg_12_0)
	return arg_12_0._modeType
end

function var_0_0.cacheModel(arg_13_0)
	arg_13_0.cacheModelType = arg_13_0:getShowModeType()
end

function var_0_0.restoreModel(arg_14_0)
	if arg_14_0.cacheModelType == nil then
		return
	end

	arg_14_0:setShowModeType(arg_14_0.cacheModelType)
end

function var_0_0.setActiveAndPlayAni(arg_15_0, arg_15_1)
	arg_15_0:setActive(arg_15_1)

	if arg_15_1 then
		arg_15_0:playAnimator("fadein")
	else
		arg_15_0:playAnimator("fadeout")
	end
end

function var_0_0.playAnimator(arg_16_0, arg_16_1)
	if arg_16_0.ani then
		arg_16_0.ani:Play(arg_16_1, 0, 0)
	end
end

function var_0_0._onMouseUp(arg_17_0)
	local var_17_0 = UnityEngine.Input.mousePosition

	if not arg_17_0:_needResponseClick(var_17_0) then
		return
	end

	if arg_17_0._isDrag then
		arg_17_0:_dragEnd()

		return
	end

	arg_17_0:_onClick()
end

function var_0_0._onDrag(arg_18_0)
	if EliminateTeamChessModel.instance:getTeamChessSkillState() then
		return
	end

	local var_18_0 = UnityEngine.Input.mousePosition

	if not arg_18_0:_needResponseClick(var_18_0) then
		return
	end

	if not arg_18_0._canDrag or arg_18_0._unitMo == nil then
		return
	end

	if not arg_18_0._isDrag and (var_0_1.GetAxis("Mouse X") ~= 0 or var_0_1.GetAxis("Mouse Y") ~= 0) then
		arg_18_0._isDrag = true
	end

	if not arg_18_0._isDrag then
		return
	end

	local var_18_1 = UnityEngine.Input.mousePosition

	arg_18_0:onDrag(var_18_1.x, var_18_1.y)
end

function var_0_0._onClick(arg_19_0)
	local var_19_0 = UnityEngine.Input.mousePosition

	if not arg_19_0:_needResponseClick(var_19_0) then
		return
	end

	if not arg_19_0._canClick or arg_19_0._unitMo == nil then
		return
	end

	arg_19_0:onClick()
end

function var_0_0._needResponseClick(arg_20_0, arg_20_1)
	if arg_20_0._pointerEventData == nil then
		arg_20_0._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		arg_20_0._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
		arg_20_0._uiRootGO = EliminateTeamChessModel.instance:getTipViewParent()
	end

	arg_20_0._pointerEventData.position = arg_20_1

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(arg_20_0._pointerEventData, arg_20_0._raycastResults)

	local var_20_0 = arg_20_0._raycastResults:GetEnumerator()

	while var_20_0:MoveNext() do
		local var_20_1 = var_20_0.Current
		local var_20_2 = var_20_1.module

		if arg_20_0:_isRaycaster2d(var_20_2, var_20_1.gameObject) then
			return false
		end
	end

	return true
end

local var_0_2 = {
	"#btn_click_2",
	"#btn_click",
	"#btn_mask"
}

function var_0_0._isRaycaster2d(arg_21_0, arg_21_1, arg_21_2)
	for iter_21_0 = 1, #var_0_2 do
		local var_21_0 = var_0_2[iter_21_0]

		if arg_21_2.name == var_21_0 then
			return true
		end
	end

	return (arg_21_1.gameObject.transform:IsChildOf(arg_21_0._uiRootGO.transform))
end

function var_0_0._dragEnd(arg_22_0)
	if arg_22_0._unitMo == nil then
		return
	end

	arg_22_0._isDrag = false

	local var_22_0 = UnityEngine.Input.mousePosition

	arg_22_0:onDragEnd(var_22_0.x, var_22_0.y)
end

function var_0_0.onDrag(arg_23_0, arg_23_1, arg_23_2)
	return
end

function var_0_0.onDragEnd(arg_24_0, arg_24_1, arg_24_2)
	return
end

function var_0_0.onClick(arg_25_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)

	local var_25_0 = arg_25_0._unitMo.stronghold
	local var_25_1 = arg_25_0._unitMo.uid
	local var_25_2 = arg_25_0._unitMo.soldierId
	local var_25_3 = EliminateTeamChessEnum.ChessTipType.showDesc
	local var_25_4

	if arg_25_0._unitMo.teamType ~= EliminateTeamChessEnum.TeamChessTeamType.enemy then
		var_25_3 = EliminateTeamChessEnum.ChessTipType.showSell
	else
		var_25_4 = {
			soliderTipOffsetX = EliminateTeamChessEnum.soliderSellTipOffsetX,
			soliderTipOffsetY = -EliminateTeamChessEnum.soliderSellTipOffsetY
		}
	end

	if not EliminateLevelModel.instance:sellChessIsUnLock() or EliminateLevelModel.instance:getIsWatchTeamChess() then
		var_25_3 = EliminateTeamChessEnum.ChessTipType.showDesc

		if arg_25_0._unitMo.teamType ~= EliminateTeamChessEnum.TeamChessTeamType.enemy then
			var_25_4 = {
				soliderTipOffsetX = EliminateTeamChessEnum.playerSoliderWatchTipOffsetX,
				soliderTipOffsetY = EliminateTeamChessEnum.playerSoliderWatchTipOffsetY
			}
		end
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.SoliderChessModelClick, var_25_2, var_25_1, var_25_0, var_25_3, arg_25_0, var_25_4)
end

function var_0_0.setAllMeshRenderOrderInLayer(arg_26_0, arg_26_1)
	if not gohelper.isNil(arg_26_0._frontGo) then
		arg_26_0._frontGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = arg_26_1
	end

	if not gohelper.isNil(arg_26_0._backGo) then
		arg_26_0._backGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = arg_26_1
	end

	if not gohelper.isNil(arg_26_0._frontOutLineGo) then
		arg_26_0._frontOutLineGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = arg_26_1
	end

	if not gohelper.isNil(arg_26_0._backOutLineGo) then
		arg_26_0._backOutLineGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = arg_26_1
	end

	if not gohelper.isNil(arg_26_0._frontGrayGo) then
		arg_26_0._frontGrayGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = arg_26_1
	end

	if not gohelper.isNil(arg_26_0._backGrayGo) then
		arg_26_0._backGrayGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = arg_26_1
	end
end

function var_0_0.dispose(arg_27_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_enemy_move)

	if arg_27_0._unitMo ~= nil and arg_27_0._unitMo.uid == EliminateTeamChessEnum.tempPieceUid then
		arg_27_0:onDestroy()
	else
		arg_27_0:playAnimator("out")
		TaskDispatcher.runDelay(arg_27_0.onDestroy, arg_27_0, 0.33)
	end
end

function var_0_0.refreshShowModeState(arg_28_0)
	local var_28_0 = EliminateTeamChessEnum.ModeType.Normal

	if arg_28_0._unitMo ~= nil and arg_28_0._unitMo:canActiveMove() then
		var_28_0 = EliminateTeamChessEnum.ModeType.Outline
	end

	arg_28_0:setShowModeType(var_28_0)
end

function var_0_0.refreshMeshOrder(arg_29_0)
	if arg_29_0._unitMo ~= nil then
		arg_29_0:setAllMeshRenderOrderInLayer(arg_29_0._unitMo:getOrder())
	end
end

function var_0_0.onDestroy(arg_30_0)
	if arg_30_0._goClick then
		arg_30_0._goClick:RemoveMouseUpListener()
		arg_30_0._goClick:RemoveDragListener()

		arg_30_0._goClick = nil
	end

	arg_30_0._pointerEventData = nil
	arg_30_0._raycastResults = nil
	arg_30_0._uiRootGO = nil
	arg_30_0._frontGo = nil
	arg_30_0._backGo = nil
	arg_30_0._frontOutLineGo = nil
	arg_30_0._backOutLineGo = nil
	arg_30_0._frontGrayGo = nil
	arg_30_0._backGrayGo = nil
	arg_30_0._tr = nil
	arg_30_0._unitParentPosition = nil

	TaskDispatcher.cancelTask(arg_30_0.onDestroy, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.setActiveByCache, arg_30_0)
	var_0_0.super.onDestroy(arg_30_0)
end

return var_0_0
