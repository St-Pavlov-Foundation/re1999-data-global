module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateChessItem", package.seeall)

local var_0_0 = class("EliminateChessItem", LuaCompBase)
local var_0_1 = ZProj.TweenHelper
local var_0_2 = SLFramework.UGUI.UIDragListener

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tr = arg_1_1.transform
	arg_1_0._select = false
	arg_1_0._ani = arg_1_1:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._ani then
		arg_1_0._ani.enabled = true
	end

	arg_1_0._img_select = gohelper.findChild(arg_1_0._go, "#img_select")
	arg_1_0._img_chess = gohelper.findChildImage(arg_1_0._go, "#img_sprite")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0._go, "#btn_click")

	arg_1_0._btnClick:AddClickListener(arg_1_0.onClick, arg_1_0)

	arg_1_0._drag = UIDragListenerHelper.New()
	arg_1_0._drag = var_0_2.Get(arg_1_0._btnClick.gameObject)

	arg_1_0._drag:AddDragBeginListener(arg_1_0._onDragBegin, arg_1_0)
	arg_1_0._drag:AddDragEndListener(arg_1_0._onDragEnd, arg_1_0)
end

function var_0_0.initData(arg_2_0, arg_2_1)
	arg_2_0._data = arg_2_1

	arg_2_0:updateInfo()
end

function var_0_0.getData(arg_3_0)
	return arg_3_0._data
end

function var_0_0.updateInfo(arg_4_0)
	if arg_4_0._data then
		local var_4_0 = EliminateConfig.instance:getChessIconPath(arg_4_0._data.id)
		local var_4_1 = not string.nilorempty(var_4_0)

		recthelper.setSize(arg_4_0._tr, EliminateEnum.ChessWidth, EliminateEnum.ChessHeight)

		if var_4_1 then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_4_0._img_chess, var_4_0, false)
		end

		gohelper.setActiveCanvasGroup(arg_4_0._go, var_4_1)
		arg_4_0:updatePos()
	end
end

function var_0_0.updatePos(arg_5_0)
	if arg_5_0._data then
		local var_5_0 = (arg_5_0._data.startX - 1) * EliminateEnum.ChessWidth
		local var_5_1 = (arg_5_0._data.startY - 1) * EliminateEnum.ChessHeight

		transformhelper.setLocalPosXY(arg_5_0._tr, var_5_0, var_5_1)
	end
end

function var_0_0.onClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_switch)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.OnChessSelect, arg_6_0._data.x, arg_6_0._data.y, true)
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._beginDragX = arg_7_2.position.x
	arg_7_0._beginDragY = arg_7_2.position.y

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.OnChessSelect, arg_7_0._data.x, arg_7_0._data.y, false)
end

local function var_0_3(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2 - arg_8_0
	local var_8_1 = arg_8_3 - arg_8_1

	return math.deg(math.atan2(var_8_1, var_8_0))
end

function var_0_0.getEndXYByAngle(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._data.x
	local var_9_1 = arg_9_0._data.y

	if arg_9_2 >= math.abs(arg_9_1) then
		return var_9_0 + 1, var_9_1
	elseif arg_9_2 >= math.abs(arg_9_1 - 180) or arg_9_2 >= math.abs(arg_9_1 + 180) then
		return var_9_0 - 1, var_9_1
	elseif math.abs(arg_9_1 - 90) <= 90 - arg_9_2 then
		return var_9_0, var_9_1 + 1
	elseif math.abs(arg_9_1 + 90) <= 90 - arg_9_2 then
		return var_9_0, var_9_1 - 1
	end

	return var_9_0, var_9_1
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.position.x
	local var_10_1 = arg_10_2.position.y
	local var_10_2 = var_0_3(arg_10_0._beginDragX, arg_10_0._beginDragY, var_10_0, var_10_1)
	local var_10_3, var_10_4 = arg_10_0:getEndXYByAngle(var_10_2, EliminateEnum.ChessDropAngleThreshold)

	if EliminateChessModel.instance:posIsValid(var_10_3, var_10_4) then
		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.OnChessSelect, var_10_3, var_10_4, false)
	end
end

function var_0_0.setSelect(arg_11_0, arg_11_1)
	arg_11_0._select = arg_11_1

	gohelper.setActiveCanvasGroup(arg_11_0._img_select, arg_11_0._select)
end

function var_0_0.toTip(arg_12_0, arg_12_1)
	if not arg_12_1 then
		arg_12_0:playAnimation("idle")
	else
		arg_12_0:playAnimation("hint")
	end
end

function var_0_0.getGoPos(arg_13_0)
	arg_13_0._chessPosX, arg_13_0._chessPosY = transformhelper.getPos(arg_13_0._img_chess.transform)

	return arg_13_0._chessPosX, arg_13_0._chessPosY
end

function var_0_0.toDie(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 == 1 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sufubi_skill)
		arg_14_0:playAnimation("skill_sufubi")
	else
		arg_14_0:playAnimation("disappear")
	end

	arg_14_0:getGoPos()
	TaskDispatcher.runDelay(arg_14_0.onDestroy, arg_14_0, arg_14_1)
end

function var_0_0.toFlyResource(arg_15_0, arg_15_1)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ChessResourceFlyEffect, arg_15_1, arg_15_0._chessPosX, arg_15_0._chessPosY)
end

function var_0_0.toMove(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = (arg_16_0._data.x - 1) * EliminateEnum.ChessWidth
	local var_16_1 = (arg_16_0._data.y - 1) * EliminateEnum.ChessHeight

	var_0_1.DOLocalMove(arg_16_0._tr, var_16_0, var_16_1, 0, arg_16_1, arg_16_0._onMoveEnd, arg_16_0, {
		cb = arg_16_3,
		cbTarget = arg_16_4,
		animType = arg_16_2
	}, EaseType.OutQuart)
end

function var_0_0._onMoveEnd(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.animType

	if var_17_0 and var_17_0 == EliminateEnum.AnimType.init then
		arg_17_0:playAnimation("in")
	end

	if var_17_0 and var_17_0 == EliminateEnum.AnimType.drop then
		arg_17_0:playAnimation("add")
	end

	if arg_17_1.cb then
		arg_17_1.cb(arg_17_1.cbTarget)
	end
end

function var_0_0.playAnimation(arg_18_0, arg_18_1)
	if arg_18_0._ani then
		arg_18_0._ani:Play(arg_18_1, 0, 0)
	end
end

function var_0_0.clear(arg_19_0)
	if arg_19_0._go then
		EliminateChessItemController.instance:putChessItemGo(arg_19_0._go)
	end

	arg_19_0._img_select = nil
	arg_19_0._img_chess = nil
	arg_19_0._goClick = nil
	arg_19_0._data = nil
	arg_19_0._select = false
	arg_19_0._drag = nil
end

function var_0_0.onDestroy(arg_20_0, arg_20_1)
	TaskDispatcher.cancelTask(arg_20_0.onDestroy, arg_20_0)

	if arg_20_0._btnClick then
		arg_20_0._btnClick:RemoveClickListener()
	end

	if arg_20_0._drag then
		arg_20_0._drag:RemoveDragEndListener()
		arg_20_0._drag:RemoveDragBeginListener()

		arg_20_0._drag = nil
	end

	if arg_20_0._ani then
		arg_20_0._ani = nil
	end

	arg_20_0:clear()

	if arg_20_1 and arg_20_1.cb then
		arg_20_1.cb(arg_20_1.cbTarget)
	end

	var_0_0.super.onDestroy(arg_20_0)
end

return var_0_0
