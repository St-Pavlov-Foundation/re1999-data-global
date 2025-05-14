module("modules.logic.gm.view.GM_CharacterBackpackView", package.seeall)

local var_0_0 = class("GM_CharacterBackpackView", BaseView)
local var_0_1 = "#FFFF00"

function var_0_0.register()
	var_0_0.CharacterBackpackView_register(CharacterBackpackView)
	var_0_0.CharacterBackpackCardListItem_register(CharacterBackpackCardListItem)
end

function var_0_0.CharacterBackpackView_register(arg_2_0)
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "removeEvents")

	function arg_2_0._editableInitView(arg_3_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_3_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_3_0)
	end

	function arg_2_0.addEvents(arg_4_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_4_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_4_0)
		GM_CharacterBackpackViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_CharacterBackpackViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._gm_showAllTabIdUpdate(arg_6_0)
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroUpdatePush)
	end

	function arg_2_0._gm_enableCheckFaceOnSelect(arg_7_0)
		GM_CharacterView.s_AutoCheckFaceOnOpen = var_0_0.s_enableCheckSelectedFace
	end

	function arg_2_0._gm_enableCheckMouthOnSelect(arg_8_0)
		GM_CharacterView.s_AutoCheckMouthOnOpen = var_0_0.s_enableCheckSelectedMouth
	end

	function arg_2_0._gm_enableCheckContentOnSelect(arg_9_0)
		GM_CharacterView.s_AutoCheckContentOnOpen = var_0_0.s_enableCheckSelectedContent
	end

	function arg_2_0._gm_enableCheckMotionOnSelect(arg_10_0)
		GM_CharacterView.s_AutoCheckMotionOnOpen = var_0_0.s_enableCheckSelectedMotion
	end
end

function var_0_0.CharacterBackpackCardListItem_register(arg_11_0)
	GMMinusModel.instance:saveOriginalFunc(arg_11_0, "onUpdateMO")
	GMMinusModel.instance:saveOriginalFunc(arg_11_0, "_onItemClick")

	function arg_11_0.onUpdateMO(arg_12_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_12_0, "onUpdateMO", ...)

		if var_0_0.s_ShowAllTabId then
			local var_12_0 = arg_12_0._mo

			arg_12_0._heroItem._nameCnTxt.text = gohelper.getRichColorText(var_12_0.config.id, var_0_1)
		end
	end

	function arg_11_0._onItemClick(arg_13_0, ...)
		if var_0_0.s_enableCheckSelectedFace then
			GM_CharacterView.s_AutoCheckFaceOnOpen = true
		end

		if var_0_0.s_enableCheckSelectedMouth then
			GM_CharacterView.s_AutoCheckMouthOnOpen = true
		end

		if var_0_0.s_enableCheckSelectedContent then
			GM_CharacterView.s_AutoCheckContentOnOpen = true
		end

		if var_0_0.s_enableCheckSelectedMotion then
			GM_CharacterView.s_AutoCheckMotionOnOpen = true
		end

		GMMinusModel.instance:callOriginalSelfFunc(arg_13_0, "_onItemClick", ...)
	end
end

function var_0_0.onInitView(arg_14_0)
	arg_14_0._btnClose = gohelper.findChildButtonWithAudio(arg_14_0.viewGO, "btnClose")
	arg_14_0._item1Toggle = gohelper.findChildToggle(arg_14_0.viewGO, "viewport/content/item1/Toggle")
	arg_14_0._item2Toggle = gohelper.findChildToggle(arg_14_0.viewGO, "viewport/content/item2/Toggle")
	arg_14_0._item3Toggle = gohelper.findChildToggle(arg_14_0.viewGO, "viewport/content/item3/Toggle")
	arg_14_0._item4Toggle = gohelper.findChildToggle(arg_14_0.viewGO, "viewport/content/item4/Toggle")
	arg_14_0._item5Toggle = gohelper.findChildToggle(arg_14_0.viewGO, "viewport/content/item5/Toggle")
end

function var_0_0.addEvents(arg_15_0)
	arg_15_0._btnClose:AddClickListener(arg_15_0.closeThis, arg_15_0)
	arg_15_0._item1Toggle:AddOnValueChanged(arg_15_0._onItem1ToggleValueChanged, arg_15_0)
	arg_15_0._item2Toggle:AddOnValueChanged(arg_15_0._onItem2ToggleValueChanged, arg_15_0)
	arg_15_0._item3Toggle:AddOnValueChanged(arg_15_0._onItem3ToggleValueChanged, arg_15_0)
	arg_15_0._item4Toggle:AddOnValueChanged(arg_15_0._onItem4ToggleValueChanged, arg_15_0)
	arg_15_0._item5Toggle:AddOnValueChanged(arg_15_0._onItem5ToggleValueChanged, arg_15_0)
end

function var_0_0.removeEvents(arg_16_0)
	arg_16_0._btnClose:RemoveClickListener()
	arg_16_0._item1Toggle:RemoveOnValueChanged()
	arg_16_0._item2Toggle:RemoveOnValueChanged()
	arg_16_0._item3Toggle:RemoveOnValueChanged()
	arg_16_0._item4Toggle:RemoveOnValueChanged()
	arg_16_0._item5Toggle:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:_refreshItem1()
	arg_17_0:_refreshItem2()
	arg_17_0:_refreshItem3()
	arg_17_0:_refreshItem4()
	arg_17_0:_refreshItem5()
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_19_0)
	local var_19_0 = var_0_0.s_ShowAllTabId

	arg_19_0._item1Toggle.isOn = var_19_0
end

function var_0_0._onItem1ToggleValueChanged(arg_20_0)
	local var_20_0 = arg_20_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_20_0

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_ShowAllTabIdUpdate, var_20_0)
end

var_0_0.s_enableCheckSelectedFace = false

function var_0_0._refreshItem2(arg_21_0)
	local var_21_0 = var_0_0.s_enableCheckSelectedFace

	arg_21_0._item2Toggle.isOn = var_21_0
end

function var_0_0._onItem2ToggleValueChanged(arg_22_0)
	local var_22_0 = arg_22_0._item2Toggle.isOn

	var_0_0.s_enableCheckSelectedFace = var_22_0

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckFaceOnSelect, var_22_0)
end

var_0_0.s_enableCheckSelectedMouth = false

function var_0_0._refreshItem3(arg_23_0)
	local var_23_0 = var_0_0.s_enableCheckSelectedMouth

	arg_23_0._item3Toggle.isOn = var_23_0
end

function var_0_0._onItem3ToggleValueChanged(arg_24_0)
	local var_24_0 = arg_24_0._item3Toggle.isOn

	var_0_0.s_enableCheckSelectedMouth = var_24_0

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckMouthOnSelect, var_24_0)
end

var_0_0.s_enableCheckSelectedContent = false

function var_0_0._refreshItem4(arg_25_0)
	local var_25_0 = var_0_0.s_enableCheckSelectedContent

	arg_25_0._item4Toggle.isOn = var_25_0
end

function var_0_0._onItem4ToggleValueChanged(arg_26_0)
	local var_26_0 = arg_26_0._item4Toggle.isOn

	var_0_0.s_enableCheckSelectedContent = var_26_0

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckContentOnSelect, var_26_0)
end

var_0_0.s_enableCheckSelectedMotion = false

function var_0_0._refreshItem5(arg_27_0)
	local var_27_0 = var_0_0.s_enableCheckSelectedMotion

	arg_27_0._item5Toggle.isOn = var_27_0
end

function var_0_0._onItem5ToggleValueChanged(arg_28_0)
	local var_28_0 = arg_28_0._item5Toggle.isOn

	var_0_0.s_enableCheckSelectedMotion = var_28_0

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckMotionOnSelect, var_28_0)
end

return var_0_0
