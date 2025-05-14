module("modules.logic.settings.view.SettingsRoleVoiceViewLangBtn", package.seeall)

local var_0_0 = class("SettingsRoleVoiceViewLangBtn", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnCN = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "click")
	arg_1_0._goCNUnSelected = gohelper.findChild(arg_1_0.viewGO, "unselected")
	arg_1_0._info1 = gohelper.findChildText(arg_1_0.viewGO, "unselected/info1")
	arg_1_0._goCNSelected = gohelper.findChild(arg_1_0.viewGO, "selected")
	arg_1_0._info2 = gohelper.findChildText(arg_1_0.viewGO, "selected/info2")
	arg_1_0._goCNSelectPoint = gohelper.findChild(arg_1_0.viewGO, "selected/point")

	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnCN:AddClickListener(arg_2_0._btnCNOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnCN:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	var_0_0.super._editableInitView(arg_4_0)
end

function var_0_0.refreshSelected(arg_5_0, arg_5_1)
	arg_5_0:setSelected(arg_5_1 == arg_5_0:_langId())
end

function var_0_0._curSelectLang(arg_6_0)
	return arg_6_0:parent()._curSelectLang or 0
end

function var_0_0._useCurLang(arg_7_0)
	arg_7_0:parent():setcurSelectLang(arg_7_0:_langId())
end

function var_0_0.refreshLangOptionDownloadState(arg_8_0)
	arg_8_0:parent():_refreshLangOptionDownloadState(arg_8_0:_langId(), arg_8_0._goCNUnSelected)
end

function var_0_0._lang(arg_9_0)
	return arg_9_0._mo.lang
end

function var_0_0._langId(arg_10_0)
	return arg_10_0._mo.langId
end

function var_0_0._isValid(arg_11_0)
	return arg_11_0._mo.available
end

function var_0_0.setData(arg_12_0, arg_12_1)
	arg_12_0._mo = arg_12_1

	local var_12_0 = luaLang(arg_12_0:_lang())

	arg_12_0._info1.text = var_12_0
	arg_12_0._info2.text = var_12_0

	arg_12_0:refreshLangOptionDownloadState()
end

function var_0_0._btnCNOnClick(arg_13_0)
	if arg_13_0:isSelected() then
		return
	end

	if not arg_13_0:_isValid() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	arg_13_0:_useCurLang()
	arg_13_0:parent():afterSelectedNewLang()
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	arg_14_0:_setSelectedActive(arg_14_1)

	arg_14_0._staticData.isSelected = arg_14_1
end

function var_0_0._setSelectedActive(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._goCNUnSelected, not arg_15_1)
	gohelper.setActive(arg_15_0._goCNSelected, arg_15_1)
end

function var_0_0._setActive_goCNSelectPoint(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._goCNSelectPoint, arg_16_1)
end

function var_0_0.refreshLangOptionSelectState(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:_setActive_goCNSelectPoint(arg_17_1 == arg_17_0:_langId() and arg_17_2)
end

function var_0_0.refreshLangMode(arg_18_0, arg_18_1)
	arg_18_0:_setSelectedActive(arg_18_1 == arg_18_0:_langId())
end

function var_0_0.onDestroyView(arg_19_0)
	var_0_0.super.onDestroyView(arg_19_0)
end

return var_0_0
