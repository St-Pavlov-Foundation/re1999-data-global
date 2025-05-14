module("modules.logic.versionactivity2_4.pinball.view.PinballGameBallItem", package.seeall)

local var_0_0 = class("PinballGameBallItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._root = gohelper.findChild(arg_1_1, "drag_root")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "drag_root/#image_icon")
	arg_1_0.trans = arg_1_0._root.transform
	arg_1_0._click = gohelper.findChildClickWithDefaultAudio(arg_1_0._root, "")
	arg_1_0._outParent = arg_1_1.transform.parent.parent
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._root, arg_2_0._onBeginDrag, nil, arg_2_0._onEndDrag, arg_2_0._check, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._root)
end

function var_0_0._onBeginDrag(arg_4_0)
	arg_4_0.trans:SetParent(arg_4_0._outParent)
	CommonDragHelper.instance:refreshParent(arg_4_0._root)

	arg_4_0._isDrag = true
end

function var_0_0._onEndDrag(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.trans:SetParent(arg_5_0.go.transform)
	CommonDragHelper.instance:refreshParent(arg_5_0._root)

	arg_5_0._isDrag = false

	PinballController.instance:dispatchEvent(PinballEvent.DragMarblesEnd, arg_5_0._index)
end

function var_0_0._onClickThis(arg_6_0)
	if arg_6_0._isDrag then
		return
	end

	if arg_6_0._curResType == 0 then
		return
	end

	PinballController.instance:dispatchEvent(PinballEvent.ClickMarbles, arg_6_0._index)
end

function var_0_0._check(arg_7_0)
	return arg_7_0._curResType == 0 or not arg_7_0._canDrag or PinballHelper.isBanOper()
end

function var_0_0.setInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._index = arg_8_2
	arg_8_0._curResType = arg_8_1
	arg_8_0._canDrag = arg_8_3

	if arg_8_1 > 0 then
		local var_8_0 = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_8_1]

		UISpriteSetMgr.instance:setAct178Sprite(arg_8_0._imageicon, var_8_0.icon, true)
		ZProj.UGUIHelper.SetColorAlpha(arg_8_0._imageicon, arg_8_3 and 1 or 0.5)
	end

	gohelper.setActive(arg_8_0._root, arg_8_1 > 0)
	ZProj.TweenHelper.KillByObj(arg_8_0.trans)
	transformhelper.setLocalPos(arg_8_0.trans, 0, 0, 0)
end

function var_0_0.getIndex(arg_9_0)
	return arg_9_0._index
end

function var_0_0.isMouseOver(arg_10_0)
	if arg_10_0._curResType == 0 then
		return false
	end

	if not arg_10_0._canDrag then
		return false
	end

	return gohelper.isMouseOverGo(arg_10_0.go)
end

function var_0_0.getRootPos(arg_11_0)
	return Vector3(transformhelper.getPos(arg_11_0.go.transform))
end

function var_0_0.moveBack(arg_12_0)
	UIBlockMgr.instance:startBlock("PinballGameBallItem_moveBack")
	ZProj.TweenHelper.DOLocalMove(arg_12_0.trans, 0, 0, 0, 0.2, arg_12_0.onMoveBackEnd, arg_12_0)
end

function var_0_0.onMoveBackEnd(arg_13_0)
	UIBlockMgr.instance:endBlock("PinballGameBallItem_moveBack")
end

function var_0_0.moveTo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	ZProj.TweenHelper.DOMove(arg_14_0.trans, arg_14_1.x, arg_14_1.y, arg_14_1.z, 0.2, arg_14_2, arg_14_3)
end

function var_0_0.onDestroy(arg_15_0)
	ZProj.TweenHelper.KillByObj(arg_15_0.trans)
	UIBlockMgr.instance:endBlock("PinballGameBallItem_moveBack")
end

return var_0_0
