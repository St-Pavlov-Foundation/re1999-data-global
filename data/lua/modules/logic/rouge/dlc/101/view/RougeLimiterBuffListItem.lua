module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffListItem", package.seeall)

local var_0_0 = class("RougeLimiterBuffListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagebuffbg = gohelper.findChildImage(arg_1_0.viewGO, "#image_buffbg")
	arg_1_0._imagebufficon = gohelper.findChildImage(arg_1_0.viewGO, "#image_bufficon")
	arg_1_0._goequiped = gohelper.findChild(arg_1_0.viewGO, "#go_equiped")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0._gounnecessary = gohelper.findChild(arg_1_0.viewGO, "#go_unnecessary")
	arg_1_0._txtunnecessary = gohelper.findChildText(arg_1_0.viewGO, "#go_unnecessary/txt_unnecessary")
	arg_1_0._gocd = gohelper.findChild(arg_1_0.viewGO, "#go_cd")
	arg_1_0._txtcd = gohelper.findChildText(arg_1_0.viewGO, "#go_cd/#txt_cd")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._lockedAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0._golocked)
	arg_1_0._isSelect = false
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateBuffState, arg_2_0._onUpdateBuffState, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	local var_4_0 = not arg_4_0._isSelect

	arg_4_0._view:selectCell(arg_4_0._index, var_4_0)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.OnSelectBuff, arg_4_0._mo.id, var_4_0)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1
	arg_5_0._buffState = nil

	arg_5_0:refreshSelectUI()
	arg_5_0:refreshBuff()
end

function var_0_0.refreshBuff(arg_6_0)
	arg_6_0:refreshBuffState()
	UISpriteSetMgr.instance:setRouge4Sprite(arg_6_0._imagebufficon, arg_6_0._mo.icon)
	UISpriteSetMgr.instance:setRouge3Sprite(arg_6_0._imagebuffbg, "rouge_dlc1_buffbg" .. arg_6_0._mo.buffType)
end

function var_0_0.refreshSelectUI(arg_7_0)
	local var_7_0 = arg_7_0._view:getFirstSelect() == arg_7_0._mo

	gohelper.setActive(arg_7_0._goselect, var_7_0)
end

function var_0_0.refreshBuffState(arg_8_0)
	local var_8_0 = RougeDLCModel101.instance:getLimiterBuffState(arg_8_0._mo.id)
	local var_8_1 = arg_8_0._buffState == RougeDLCEnum101.BuffState.Locked
	local var_8_2 = var_8_0 ~= RougeDLCEnum101.BuffState.Locked

	arg_8_0._buffState = var_8_0

	arg_8_0._lockedAnimator:Stop()

	if var_8_1 and var_8_2 then
		arg_8_0._lockedAnimator:Play("unlock", arg_8_0.refreshUI, arg_8_0)

		return
	end

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	gohelper.setActive(arg_9_0._golocked, arg_9_0._buffState == RougeDLCEnum101.BuffState.Locked)
	gohelper.setActive(arg_9_0._goequiped, arg_9_0._buffState == RougeDLCEnum101.BuffState.Equiped)
	gohelper.setActive(arg_9_0._gocd, arg_9_0._buffState == RougeDLCEnum101.BuffState.CD)
	gohelper.setActive(arg_9_0._gounnecessary, arg_9_0._mo.blank == 1)

	if arg_9_0._buffState == RougeDLCEnum101.BuffState.CD then
		arg_9_0._txtcd.text = RougeDLCModel101.instance:getLimiterBuffCD(arg_9_0._mo.id)
	end
end

function var_0_0._onUpdateBuffState(arg_10_0, arg_10_1)
	arg_10_0:refreshBuffState()
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	arg_11_0._isSelect = arg_11_1

	gohelper.setActive(arg_11_0._goselect, arg_11_1)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
