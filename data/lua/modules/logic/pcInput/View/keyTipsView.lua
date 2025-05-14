module("modules.logic.pcInput.View.keyTipsView", package.seeall)

local var_0_0 = class("keyTipsView", LuaCompBase)
local var_0_1 = "ui/viewres/pc/pcbuttonitem.prefab"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._keyName = arg_1_1.keyname
	arg_1_0._activityid = arg_1_1.activityId
	arg_1_0._keyid = arg_1_1.keyid
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1

	arg_2_0:load()
end

function var_0_0.load(arg_3_0)
	arg_3_0._loader = PrefabInstantiate.Create(arg_3_0._go)

	arg_3_0._loader:startLoad(var_0_1, var_0_0._onCallback, arg_3_0)
end

function var_0_0._onCallback(arg_4_0)
	arg_4_0._instGO = arg_4_0._loader:getInstGO()

	local var_4_0 = PlayerPrefsHelper.getNumber("keyTips", 0)

	gohelper.setActive(arg_4_0._instGO, not GuideController.instance:isAnyGuideRunningNoBlock() and var_4_0 == 1)

	arg_4_0._text1 = gohelper.findChildText(arg_4_0._instGO, "btn_1/#txt_btn")
	arg_4_0._text2 = gohelper.findChildText(arg_4_0._instGO, "btn_2/#txt_btn")
	arg_4_0._btn1 = gohelper.findChild(arg_4_0._instGO, "btn_1")
	arg_4_0._btn2 = gohelper.findChild(arg_4_0._instGO, "btn_2")

	local var_4_1 = arg_4_0._keyName or PCInputModel.instance:getKey(arg_4_0._activityid, arg_4_0._keyid)

	if arg_4_0:selectType(var_4_1) == 1 then
		arg_4_0._btn1:SetActive(true)
		arg_4_0._btn2:SetActive(false)

		arg_4_0._text1.text = PCInputController.instance:KeyNameToDescName(var_4_1)
	else
		arg_4_0._btn1:SetActive(false)
		arg_4_0._btn2:SetActive(true)

		arg_4_0._text2.text = PCInputController.instance:KeyNameToDescName(var_4_1)
	end
end

function var_0_0.Show(arg_5_0, arg_5_1)
	if arg_5_0._instGO then
		arg_5_0._instGO:SetActive(arg_5_1 and not GuideController.instance:isAnyGuideRunningNoBlock() and PlayerPrefsHelper.getNumber("keyTips", 0) == 1)
	end

	if arg_5_0._go then
		gohelper.setActive(arg_5_0._go, arg_5_1)
	end
end

function var_0_0.selectType(arg_6_0, arg_6_1)
	if string.len(arg_6_1) > 1 then
		return 2
	else
		return 1
	end
end

function var_0_0.Refresh(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._activityid = arg_7_1
	arg_7_0._keyid = arg_7_2
	arg_7_0._keyName = nil

	if arg_7_0._instGO then
		arg_7_0:_onCallback()
	end
end

function var_0_0.RefreshByKeyName(arg_8_0, arg_8_1)
	arg_8_0._keyName = arg_8_1
	arg_8_0._activityid = nil
	arg_8_0._keyid = nil

	if arg_8_0._instGO then
		arg_8_0:_onCallback()
	end
end

function var_0_0.addEventListeners(arg_9_0)
	arg_9_0:addEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, arg_9_0._onCallback, arg_9_0)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_9_0.onOpenViewCallBack, arg_9_0)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_9_0.onCloseViewCallBack, arg_9_0)
end

function var_0_0.removeEventListeners(arg_10_0)
	arg_10_0:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, arg_10_0._onCallback, arg_10_0)
	arg_10_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_10_0.onOpenViewCallBack, arg_10_0)
	arg_10_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_10_0.onCloseViewCallBack, arg_10_0)
end

function var_0_0.onOpenViewCallBack(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.GuideView then
		arg_11_0:Show(false)
	end
end

function var_0_0.onCloseViewCallBack(arg_12_0, arg_12_1)
	if arg_12_1 == ViewName.GuideView then
		arg_12_0:Show(true)
	end
end

function var_0_0.onStart(arg_13_0)
	return
end

function var_0_0.onDestroy(arg_14_0)
	return
end

return var_0_0
