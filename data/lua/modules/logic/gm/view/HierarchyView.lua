module("modules.logic.gm.view.HierarchyView", package.seeall)

local var_0_0 = class("HierarchyView", BaseView)
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go/btnClose")
	arg_1_0._btnShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go/btnShow")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go/btnHide")
	arg_1_0._rect = gohelper.findChild(arg_1_0.viewGO, "go").transform
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnShow:AddClickListener(arg_2_0._onClickShow, arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._onClickHide, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0._onTouch, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnShow:RemoveClickListener()
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_3_0._onTouch, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._state = var_0_1

	arg_4_0:_updateBtns()
end

function var_0_0.onClose(arg_5_0)
	if arg_5_0._tweenId then
		ZProj.TweenHelper.KillById(arg_5_0._tweenId)

		arg_5_0._tweenId = nil
	end
end

function var_0_0._onTouch(arg_6_0)
	gohelper.setLayer(arg_6_0.viewGO, UnityLayer.UITop, true)
end

function var_0_0._onClickShow(arg_7_0)
	if arg_7_0._state == var_0_2 then
		arg_7_0._state = var_0_3
		arg_7_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_7_0._rect, 0, 0.2, arg_7_0._onShow, arg_7_0)
	end
end

function var_0_0._onShow(arg_8_0)
	arg_8_0._tweenId = nil
	arg_8_0._state = var_0_1

	arg_8_0:_updateBtns()
end

function var_0_0._onClickHide(arg_9_0)
	if arg_9_0._state == var_0_1 then
		arg_9_0._state = var_0_3
		arg_9_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_9_0._rect, 800, 0.2, arg_9_0._onHide, arg_9_0)
	end
end

function var_0_0._onHide(arg_10_0)
	arg_10_0._tweenId = nil
	arg_10_0._state = var_0_2

	arg_10_0:_updateBtns()
end

function var_0_0._updateBtns(arg_11_0)
	gohelper.setActive(arg_11_0._btnShow.gameObject, arg_11_0._state == var_0_2)
	gohelper.setActive(arg_11_0._btnHide.gameObject, arg_11_0._state == var_0_1)
end

return var_0_0
