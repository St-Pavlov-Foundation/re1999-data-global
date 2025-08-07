module("modules.logic.fightuiswitch.view.FightUISwitchSceneView", package.seeall)

local var_0_0 = class("FightUISwitchSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_bg")
	arg_1_0._gounFullScene = gohelper.findChild(arg_1_0.viewGO, "root/#go_unFullScene")
	arg_1_0._goFullScene = gohelper.findChild(arg_1_0.viewGO, "root/#go_FullScene")
	arg_1_0._scrolleffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_effect")
	arg_1_0._goeffectItem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_effect/Viewport/Content/#go_effectItem")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_effect/Viewport/Content/#go_effectItem/#go_normal")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#scroll_effect/Viewport/Content/#go_effectItem/#go_normal/#btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_effect/Viewport/Content/#go_effectItem/#go_select")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnroot:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnroot:RemoveClickListener()
end

function var_0_0._btnequipOnClick(arg_4_0)
	return
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnclickOnClick(arg_6_0)
	return
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._goroot = gohelper.findChild(arg_7_0.viewGO, "root")
	arg_7_0._btnroot = SLFramework.UGUI.UIClickListener.Get(arg_7_0._goroot.gameObject)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._mo = arg_10_0.viewParam.mo
	arg_10_0._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._goroot, FightUISwitchEffectComp)

	arg_10_0._effectComp:refreshEffect(arg_10_0._goFullScene, arg_10_0._mo, arg_10_0.viewName)
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._effectComp:onClose()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._effectComp:onDestroy()
end

return var_0_0
