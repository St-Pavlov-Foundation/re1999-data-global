module("modules.logic.fightuiswitch.view.FightUISwitchEquipView", package.seeall)

local var_0_0 = class("FightUISwitchEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_bg")
	arg_1_0._goScene = gohelper.findChild(arg_1_0.viewGO, "root/#go_Scene")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom")
	arg_1_0._scrolleffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_bottom/#scroll_effect")
	arg_1_0._goeffectItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem/#go_normal")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem/#go_normal/#btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/#scroll_effect/Viewport/Content/#go_effectItem/#go_select")
	arg_1_0._goSceneName = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/#go_SceneName")
	arg_1_0._txtSceneName = gohelper.findChildText(arg_1_0.viewGO, "root/#go_bottom/#go_SceneName/#txt_SceneName")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "root/#go_bottom/#go_SceneName/#txt_SceneName/#txt_Time")
	arg_1_0._txtSceneDescr = gohelper.findChildText(arg_1_0.viewGO, "root/#go_bottom/#txt_SceneDescr")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/#btn_equip")
	arg_1_0._gouse = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/#go_use")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	return
end

function var_0_0._btnequipOnClick(arg_5_0)
	FightUISwitchModel.instance:useStyleId(arg_5_0._mo.classify, arg_5_0._mo.id)
	arg_5_0:_refreshBtn()
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._mo = arg_10_0.viewParam.mo
	arg_10_0._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._gobottom, FightUISwitchEffectComp)

	arg_10_0:refreshStyle()
end

function var_0_0.refreshStyle(arg_11_0)
	if not arg_11_0._mo then
		return
	end

	arg_11_0._effectComp:refreshEffect(arg_11_0._goScene, arg_11_0._mo, arg_11_0.viewName)

	local var_11_0 = arg_11_0._mo:getItemConfig()

	if var_11_0 then
		arg_11_0._txtSceneName.text = var_11_0.name
		arg_11_0._txtSceneDescr.text = var_11_0.desc
	end

	arg_11_0._txtTime.text = arg_11_0._mo:getObtainTime() or ""

	arg_11_0:_refreshBtn()
end

function var_0_0._refreshBtn(arg_12_0)
	local var_12_0 = arg_12_0._mo:isUse()
	local var_12_1 = arg_12_0._mo:isUnlock()

	gohelper.setActive(arg_12_0._btnequip.gameObject, var_12_1 and not var_12_0)
	gohelper.setActive(arg_12_0._gouse.gameObject, var_12_1 and var_12_0)
end

function var_0_0.onClose(arg_13_0)
	arg_13_0._effectComp:onClose()
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._effectComp:onDestroy()
end

return var_0_0
