module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateTeamChessItem", package.seeall)

local var_0_0 = class("EliminateTeamChessItem", EliminateTeamChessDetailItem)
local var_0_1 = SLFramework.UGUI.UILongPressListener
local var_0_2 = SLFramework.UGUI.UIDragListener

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._longClick = var_0_1.Get(arg_1_0.viewGO)

	arg_1_0._longClick:SetLongPressTime({
		0.5,
		99999
	})

	arg_1_0._dragClick = var_0_2.Get(arg_1_0.viewGO)
end

function var_0_0._editableAddEvents(arg_2_0)
	arg_2_0._longClick:AddClickListener(arg_2_0._onLongClick, arg_2_0)
	arg_2_0._longClick:AddLongPressListener(arg_2_0._onLongPress, arg_2_0)
	arg_2_0._dragClick:AddDragListener(arg_2_0._onDrag, arg_2_0)
	arg_2_0._dragClick:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._dragClick:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
end

function var_0_0._editableRemoveEvents(arg_3_0)
	if arg_3_0._longClick then
		arg_3_0._longClick:RemoveClickListener()
		arg_3_0._longClick:RemoveLongPressListener()
	end

	if arg_3_0._dragClick then
		arg_3_0._dragClick:RemoveDragBeginListener()
		arg_3_0._dragClick:RemoveDragEndListener()
		arg_3_0._dragClick:RemoveDragListener()
	end
end

function var_0_0._onDragBegin(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._canUse or not arg_4_0._isLongPress then
		return
	end

	arg_4_0._beginDragX = arg_4_2.position.x
	arg_4_0._beginDragY = arg_4_2.position.y

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_mln_drag)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemBeginDrag, arg_4_0._soliderId, arg_4_0._beginDragX, arg_4_0._beginDragY)
end

function var_0_0._onDrag(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._canUse or not arg_5_0._isLongPress or not arg_5_0._beginDragX or not arg_5_0._beginDragY then
		return
	end

	local var_5_0 = arg_5_2.position
	local var_5_1 = var_5_0.x
	local var_5_2 = var_5_0.y
	local var_5_3 = var_5_1 - arg_5_0._beginDragX
	local var_5_4 = var_5_2 - arg_5_0._beginDragY

	if math.abs(var_5_3) < 10 and math.abs(var_5_4) < 10 then
		return
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDrag, arg_5_0._soliderId, nil, nil, var_5_1, var_5_2)
end

function var_0_0._onDragEnd(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._canUse or not arg_6_0._isLongPress or not arg_6_0._beginDragX or not arg_6_0._beginDragY then
		return
	end

	local var_6_0 = arg_6_2.position
	local var_6_1 = var_6_0.x
	local var_6_2 = var_6_0.y

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragEnd, arg_6_0._soliderId, nil, nil, var_6_1, var_6_2)
end

function var_0_0._onLongClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessView, arg_7_0._soliderId, nil, nil, EliminateTeamChessEnum.ChessTipType.showDesc, arg_7_0, {
		soliderTipOffsetX = EliminateTeamChessEnum.soliderItemTipOffsetX,
		soliderTipOffsetY = EliminateTeamChessEnum.soliderItemTipOffsetY
	})
end

function var_0_0.getPosXYZ(arg_8_0)
	return transformhelper.getPos(arg_8_0.viewGO.transform)
end

function var_0_0._onLongPress(arg_9_0)
	if not arg_9_0._canUse then
		return
	end

	logNormal("EliminateTeamChessItem:_onLongPress")
end

function var_0_0.setSoliderId(arg_10_0, arg_10_1)
	var_0_0.super.setSoliderId(arg_10_0, arg_10_1)

	arg_10_0._isLongPress = true
end

function var_0_0.setChildIndex(arg_11_0, arg_11_1)
	arg_11_0.viewGO.transform:SetSiblingIndex(arg_11_1)
end

function var_0_0.onDestroyView(arg_12_0)
	var_0_0.super.onDestroyView(arg_12_0)

	arg_12_0._effectCollection = nil
end

return var_0_0
