module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_radiotaskitem", package.seeall)

local var_0_0 = class("V2a4_WarmUp_radiotaskitem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	var_0_0.super.ctor(arg_4_0, arg_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._txtDateUnSelected = gohelper.findChildText(arg_5_0.viewGO, "txt_DateUnSelected")
	arg_5_0._goDateSelected = gohelper.findChild(arg_5_0.viewGO, "image_Selected")
	arg_5_0._txtDateSelected = gohelper.findChildText(arg_5_0.viewGO, "image_Selected/txt_DateSelected")
	arg_5_0._finishEffectGo = gohelper.findChild(arg_5_0.viewGO, "image_Selected/Wave_effect2")
	arg_5_0._imagewave = gohelper.findChildImage(arg_5_0.viewGO, "image_Selected/image_wave")
	arg_5_0._goDateLocked = gohelper.findChild(arg_5_0.viewGO, "image_Locked")
	arg_5_0._click = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "btn_click")
	arg_5_0._txtDateUnSelectedGo = arg_5_0._txtDateUnSelected.gameObject
end

function var_0_0._editableAddEvents(arg_6_0)
	arg_6_0._click:AddClickListener(arg_6_0._onClick, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	arg_7_0._click:RemoveClickListener()
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goDateSelected, arg_8_1)
	gohelper.setActive(arg_8_0._txtDateUnSelectedGo, not arg_8_1)
end

function var_0_0.onDestroyView(arg_9_0)
	var_0_0.super.onDestroyView(arg_9_0)
end

function var_0_0._getEpisodeConfig(arg_10_0, arg_10_1)
	return arg_10_0:_assetGetViewContainer():getEpisodeConfig(arg_10_1)
end

function var_0_0._getRLOC(arg_11_0, arg_11_1)
	return arg_11_0:_assetGetViewContainer():getRLOC(arg_11_1)
end

function var_0_0._isEpisodeDayOpen(arg_12_0, arg_12_1)
	return arg_12_0:_assetGetViewContainer():isEpisodeDayOpen(arg_12_1)
end

function var_0_0._isEpisodeUnLock(arg_13_0, arg_13_1)
	return arg_13_0:_assetGetViewContainer():isEpisodeUnLock(arg_13_1)
end

function var_0_0._isEpisodeReallyOpen(arg_14_0, arg_14_1)
	return arg_14_0:_assetGetViewContainer():isEpisodeReallyOpen(arg_14_1)
end

function var_0_0.setData(arg_15_0, arg_15_1)
	arg_15_0._mo = arg_15_1

	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_0:_getEpisodeConfig(var_15_0).openDay
	local var_15_2 = not arg_15_0:_isEpisodeReallyOpen(var_15_0)
	local var_15_3 = arg_15_0:_getRLOC(var_15_0)
	local var_15_4 = not var_15_2 and not var_15_3
	local var_15_5 = formatLuaLang("warmup_radiotaskitem_day", var_15_1)

	arg_15_0._txtDateUnSelected.text = var_15_5
	arg_15_0._txtDateSelected.text = var_15_5

	gohelper.setActive(arg_15_0._goDateLocked, var_15_2)
	gohelper.setActive(arg_15_0._goreddot, var_15_4)
end

function var_0_0._onClick(arg_16_0)
	local var_16_0 = arg_16_0:_assetGetParent()

	if not arg_16_0:_checkIfOpenAndToast() then
		return
	end

	var_16_0:onClickTab(arg_16_0._mo)
end

function var_0_0._checkIfOpenAndToast(arg_17_0)
	local var_17_0 = arg_17_0._mo
	local var_17_1, var_17_2 = arg_17_0:_isEpisodeDayOpen(var_17_0)

	if not var_17_1 then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeNotOpen, var_17_2)

		return false
	end

	if not arg_17_0:_isEpisodeUnLock(var_17_0) then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeLock)

		return false
	end

	return true
end

return var_0_0
