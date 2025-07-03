module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceView", package.seeall)

local var_0_0 = class("V2a7_SelfSelectSix_PickChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopickchoice = gohelper.findChild(arg_1_0.viewGO, "pickchoice")
	arg_1_0._gooverview = gohelper.findChild(arg_1_0.viewGO, "overview")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0._gopickchoice, "Tips2/#txt_num")
	arg_1_0._btnoverview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "overview/#btn_close")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0._gopickchoice, "#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0._gopickchoice, "#btn_cancel")
	arg_1_0._scrollrule = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_rule")
	arg_1_0._trsscrollrule = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule").transform
	arg_1_0._trscontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/Content").transform
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	arg_1_0._txtlocked = gohelper.findChildText(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title/go_locked/#txt_locked")
	arg_1_0._txtunlock = gohelper.findChildText(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title/go_unlock/#txt_unlock")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero")
	arg_1_0._goexskill = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero/heroitem/role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero/heroitem/role/#go_exskill/#image_exskill")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero/heroitem/select/#go_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnoverview:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0:addEventCb(V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, arg_2_0.refreshUI, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnoverview:RemoveClickListener()
	arg_3_0:removeEventCb(V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, arg_3_0.refreshUI, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	V2a7_SelfSelectSix_PickChoiceController.instance:tryChoice(arg_4_0.viewParam)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._isPreview = arg_6_0.viewParam and arg_6_0.viewParam.isPreview

	gohelper.setActive(arg_6_0._gopickchoice, not arg_6_0._isPreview)
	gohelper.setActive(arg_6_0._gooverview, arg_6_0._isPreview)
	arg_6_0:refreshSelectCount()

	local var_6_0 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getLastUnlockIndex() - 1
	local var_6_1 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getArrCount()
	local var_6_2 = 266
	local var_6_3 = 30
	local var_6_4 = var_6_2 * var_6_1 + var_6_3
	local var_6_5 = var_6_0 > 0 and var_6_0 * var_6_2 or 0
	local var_6_6 = var_6_4 - recthelper.getHeight(arg_6_0._trsscrollrule)

	if var_6_6 < var_6_5 then
		var_6_5 = var_6_6
	end

	ZProj.TweenHelper.DOAnchorPosY(arg_6_0._trscontent, var_6_5, 0.3)
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:refreshSelectCount()
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.CharacterGetView then
		arg_8_0:closeThis()
	end
end

function var_0_0.refreshSelectCount(arg_9_0)
	local var_9_0 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()
	local var_9_1 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()

	arg_9_0._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		var_9_0,
		var_9_1
	})

	ZProj.UGUIHelper.SetGrayscale(arg_9_0._btnconfirm.gameObject, var_9_0 ~= var_9_1)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
