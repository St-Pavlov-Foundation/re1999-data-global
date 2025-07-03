module("modules.logic.versionactivity2_7.lengzhou6.view.EliminateChessItem2_7", package.seeall)

local var_0_0 = class("EliminateChessItem2_7", EliminateChessItem)
local var_0_1 = {
	store = "smoke",
	fire = "fire",
	idle = "idle",
	tip = "tips",
	die = "succees"
}
local var_0_2 = ZProj.TweenHelper
local var_0_3 = SLFramework.UGUI.UIDragListener

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tr = arg_1_1.transform
	arg_1_0._select = false
	arg_1_0._ani = arg_1_1:GetComponent(gohelper.Type_Animator)

	if arg_1_0._ani then
		arg_1_0._ani.enabled = true
	end

	arg_1_0._img_select = gohelper.findChild(arg_1_0._go, "#img_select")
	arg_1_0._img_chess = gohelper.findChildImage(arg_1_0._go, "#img_sprite")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0._go, "#btn_click")

	arg_1_0._btnClick:AddClickListener(arg_1_0.onClick, arg_1_0)

	arg_1_0._drag = UIDragListenerHelper.New()
	arg_1_0._drag = var_0_3.Get(arg_1_0._btnClick.gameObject)
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
		local var_4_0 = LengZhou6EliminateConfig.instance:getChessIconPath(arg_4_0._data.id)
		local var_4_1 = not string.nilorempty(var_4_0)

		recthelper.setSize(arg_4_0._tr, EliminateEnum_2_7.ChessWidth, EliminateEnum_2_7.ChessHeight)

		if var_4_1 then
			UISpriteSetMgr.instance:setHisSaBethSprite(arg_4_0._img_chess, var_4_0, false)
		end

		gohelper.setActiveCanvasGroup(arg_4_0._go, var_4_1)
		arg_4_0:updatePos()
		arg_4_0:_checkSpecialSkillState()
		arg_4_0:setNormalAnimation()
		gohelper.setActive(arg_4_0._go, var_4_1)
	end
end

function var_0_0.setNormalAnimation(arg_5_0)
	if arg_5_0._data == nil then
		return
	end

	if arg_5_0._data:getEliminateID() ~= EliminateEnum_2_7.ChessType.stone then
		arg_5_0:playAnimation(var_0_1.idle)
	else
		arg_5_0:playAnimation(var_0_1.store)
	end
end

function var_0_0.updatePos(arg_6_0)
	if arg_6_0._data then
		local var_6_0, var_6_1 = LocalEliminateChessUtils.instance.getChessPos(arg_6_0._data.startX, arg_6_0._data.startY)

		transformhelper.setLocalPosXY(arg_6_0._tr, var_6_0, var_6_1)
	end
end

function var_0_0.onClick(arg_7_0)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.OnChessSelect, arg_7_0._data.x, arg_7_0._data.y, true)
end

function var_0_0.setSelect(arg_8_0, arg_8_1)
	arg_8_0._select = arg_8_1

	gohelper.setActiveCanvasGroup(arg_8_0._img_select, arg_8_0._select)
end

function var_0_0.toTip(arg_9_0, arg_9_1)
	if not arg_9_1 then
		arg_9_0:setNormalAnimation()
	else
		arg_9_0:playAnimation(var_0_1.tip)
	end
end

function var_0_0.getGoPos(arg_10_0)
	arg_10_0._chessPosX, arg_10_0._chessPosY = transformhelper.getPos(arg_10_0._img_chess.transform)

	return arg_10_0._chessPosX, arg_10_0._chessPosY
end

function var_0_0.toDie(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == nil or arg_11_2 == LengZhou6Enum.NormalEliminateEffect then
		arg_11_0:playAnimation(var_0_1.die)
	elseif arg_11_2 == LengZhou6Enum.SkillEffect.EliminationCross then
		arg_11_0:playAnimation(var_0_1.fire)
	else
		arg_11_0:playAnimation(var_0_1.die)
	end

	TaskDispatcher.runDelay(arg_11_0.onDestroy, arg_11_0, arg_11_1)
end

function var_0_0.toMove(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0._data == nil then
		logNormal("EliminateChessItem2_7:toMove self._data == nil" .. arg_12_0._go.name)
	end

	local var_12_0, var_12_1 = LocalEliminateChessUtils.instance.getChessPos(arg_12_0._data.x, arg_12_0._data.y)

	arg_12_0._tweenId = var_0_2.DOLocalMove(arg_12_0._tr, var_12_0, var_12_1, 0, arg_12_1, arg_12_0._onMoveEnd, arg_12_0, {
		cb = arg_12_3,
		cbTarget = arg_12_4,
		animType = arg_12_2
	}, EaseType.OutQuart)
end

function var_0_0._onMoveEnd(arg_13_0, arg_13_1)
	if arg_13_0._data ~= nil then
		arg_13_0._data:setStartXY(arg_13_0._data.x, arg_13_0._data.y)
	end

	if arg_13_1.cb then
		arg_13_1.cb(arg_13_1.cbTarget)
	end
end

function var_0_0.playAnimation(arg_14_0, arg_14_1)
	if arg_14_0._ani then
		arg_14_0._ani:Play(arg_14_1, 0, 0)
	end
end

function var_0_0.clear(arg_15_0)
	if arg_15_0._go then
		LengZhou6EliminateChessItemController.instance:putChessItemGo(arg_15_0._go)
	end

	arg_15_0._img_select = nil
	arg_15_0._img_chess = nil
	arg_15_0._goClick = nil
	arg_15_0._data = nil
	arg_15_0._select = false
	arg_15_0._drag = nil
end

function var_0_0.changeState(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_0._data == nil then
		return
	end

	arg_16_0:_checkFrostState(arg_16_1, arg_16_2, arg_16_3)
	arg_16_0:_checkSpecialSkillState(arg_16_1)
end

function var_0_0._checkFrostState(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0._data:haveStatus(EliminateEnum_2_7.ChessState.Frost) and LengZhou6Event.ShowEffect or LengZhou6Event.HideEffect

	LengZhou6EliminateController.instance:dispatchEvent(var_17_0, arg_17_2, arg_17_3, EliminateEnum_2_7.ChessEffect.frost)
end

function var_0_0._checkSpecialSkillState(arg_18_0)
	if arg_18_0._data:haveStatus(EliminateEnum_2_7.ChessState.SpecialSkill) then
		local var_18_0 = arg_18_0._data:getEliminateID()
		local var_18_1 = EliminateEnum_2_7.SpecialChessImage[var_18_0]

		if not string.nilorempty(var_18_1) then
			UISpriteSetMgr.instance:setHisSaBethSprite(arg_18_0._img_chess, var_18_1, false)
		end
	end
end

function var_0_0.onDestroy(arg_19_0)
	if arg_19_0._tweenId then
		ZProj.TweenHelper.KillById(arg_19_0._tweenId)

		arg_19_0._tweenId = nil
	end

	if arg_19_0._btnClick then
		arg_19_0._btnClick:RemoveClickListener()
	end

	if arg_19_0._ani then
		arg_19_0._ani = nil
	end

	arg_19_0:clear()
	var_0_0.super.onDestroy(arg_19_0)
end

return var_0_0
