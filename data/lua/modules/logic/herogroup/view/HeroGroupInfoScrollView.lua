module("modules.logic.herogroup.view.HeroGroupInfoScrollView", package.seeall)

local var_0_0 = class("HeroGroupInfoScrollView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_container/#scroll_info")
	arg_1_0._container = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain")
	arg_1_0._arrow = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_arrow")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scrollinfo:AddOnValueChanged(arg_2_0.onValueChange, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scrollinfo:RemoveOnValueChanged()
	arg_3_0:removeEventCb(arg_3_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0._refreshUI(arg_4_0)
	ZProj.UGUIHelper.RebuildLayout(arg_4_0._scrollinfo.transform)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._scrollHeight = recthelper.getHeight(arg_5_0._scrollinfo.transform)

	TaskDispatcher.runRepeat(arg_5_0._checkContainHeight, arg_5_0, 0)
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._checkContainHeight, arg_6_0)
end

function var_0_0._checkContainHeight(arg_7_0)
	local var_7_0 = recthelper.getHeight(arg_7_0._container.transform)

	if var_7_0 == arg_7_0._containerHeight then
		return
	end

	arg_7_0._containerHeight = var_7_0
	arg_7_0._showArrow = arg_7_0._scrollHeight < arg_7_0._containerHeight

	gohelper.setActive(arg_7_0._arrow, arg_7_0._showArrow)
end

function var_0_0.onValueChange(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._showArrow then
		return
	end

	gohelper.setActive(arg_8_0._arrow, arg_8_2 > 0)
end

return var_0_0
