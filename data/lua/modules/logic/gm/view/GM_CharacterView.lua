module("modules.logic.gm.view.GM_CharacterView", package.seeall)

local var_0_0 = class("GM_CharacterView", BaseView)
local var_0_1 = "#FFFF00"

var_0_0.s_AutoCheckFaceOnOpen = false
var_0_0.s_AutoCheckMouthOnOpen = false
var_0_0.s_AutoCheckContentOnOpen = false
var_0_0.s_AutoCheckMotionOnOpen = false

local function var_0_2(arg_1_0, arg_1_1)
	local var_1_0 = Checker_HeroVoiceFace.New(arg_1_0)

	var_1_0:exec(arg_1_1)
	var_1_0:log()
end

local function var_0_3(arg_2_0, arg_2_1)
	local var_2_0 = Checker_HeroVoiceMouth.New(arg_2_0)

	var_2_0:exec(arg_2_1)
	var_2_0:log()
end

local function var_0_4(arg_3_0, arg_3_1)
	local var_3_0 = Checker_HeroVoiceContent.New(arg_3_0)

	var_3_0:exec(arg_3_1)
	var_3_0:log()
end

local function var_0_5(arg_4_0, arg_4_1)
	local var_4_0 = Checker_HeroVoiceMotion.New(arg_4_0)

	var_4_0:exec(arg_4_1)
	var_4_0:log()
end

function var_0_0.register()
	var_0_0.CharacterView_register(CharacterView)
end

function var_0_0.CharacterView_register(arg_6_0)
	GMMinusModel.instance:saveOriginalFunc(arg_6_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_6_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_6_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_6_0, "_refreshInfo")
	GMMinusModel.instance:saveOriginalFunc(arg_6_0, "_onSpineLoaded")

	function arg_6_0._editableInitView(arg_7_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_7_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_7_0)
	end

	function arg_6_0.addEvents(arg_8_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_8_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_8_0)
		GM_CharacterViewContainer.addEvents(arg_8_0)
	end

	function arg_6_0.removeEvents(arg_9_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_9_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_9_0)
		GM_CharacterViewContainer.removeEvents(arg_9_0)
	end

	function arg_6_0._onSpineLoaded(arg_10_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_10_0, "_onSpineLoaded", ...)

		local var_10_0 = arg_10_0._heroMO.heroId
		local var_10_1 = arg_10_0._uiSpine

		if var_0_0.s_AutoCheckFaceOnOpen then
			var_0_2(var_10_0, var_10_1)
		end

		if var_0_0.s_AutoCheckMouthOnOpen then
			var_0_3(var_10_0, var_10_1)
		end

		if var_0_0.s_AutoCheckContentOnOpen then
			var_0_4(var_10_0, var_10_1)
		end

		if var_0_0.s_AutoCheckMotionOnOpen then
			var_0_5(var_10_0, var_10_1)
		end
	end

	function arg_6_0._refreshInfo(arg_11_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_11_0, "_refreshInfo", ...)

		if var_0_0.s_ShowAllTabId then
			local var_11_0 = arg_11_0._heroMO
			local var_11_1 = var_11_0.heroId
			local var_11_2 = var_11_0.config

			arg_11_0._txtnamecn.text = gohelper.getRichColorText(var_11_1, var_0_1) .. var_11_2.name
		end
	end

	function arg_6_0._gm_showAllTabIdUpdate(arg_12_0)
		arg_12_0:_refreshInfo()
	end

	function arg_6_0._gm_onClickCheckFace(arg_13_0)
		local var_13_0 = arg_13_0._heroMO.heroId
		local var_13_1 = arg_13_0._uiSpine

		var_0_2(var_13_0, var_13_1)
	end

	function arg_6_0._gm_onClickCheckMouth(arg_14_0)
		local var_14_0 = arg_14_0._heroMO.heroId
		local var_14_1 = arg_14_0._uiSpine

		var_0_3(var_14_0, var_14_1)
	end
end

function var_0_0.onInitView(arg_15_0)
	arg_15_0._btnClose = gohelper.findChildButtonWithAudio(arg_15_0.viewGO, "btnClose")
	arg_15_0._item1Toggle = gohelper.findChildToggle(arg_15_0.viewGO, "viewport/content/item1/Toggle")
	arg_15_0._item2Btn = gohelper.findChildButtonWithAudio(arg_15_0.viewGO, "viewport/content/item2/Button")
	arg_15_0._item3Btn = gohelper.findChildButtonWithAudio(arg_15_0.viewGO, "viewport/content/item3/Button")
	arg_15_0._item4Btn = gohelper.findChildButtonWithAudio(arg_15_0.viewGO, "viewport/content/item4/Button")
	arg_15_0._item5Btn = gohelper.findChildButtonWithAudio(arg_15_0.viewGO, "viewport/content/item5/Button")
end

function var_0_0.addEvents(arg_16_0)
	arg_16_0._btnClose:AddClickListener(arg_16_0.closeThis, arg_16_0)
	arg_16_0._item1Toggle:AddOnValueChanged(arg_16_0._onItem1ToggleValueChanged, arg_16_0)
	arg_16_0._item2Btn:AddClickListener(arg_16_0._onItem2Click, arg_16_0)
	arg_16_0._item3Btn:AddClickListener(arg_16_0._onItem3Click, arg_16_0)
	arg_16_0._item4Btn:AddClickListener(arg_16_0._onItem4Click, arg_16_0)
	arg_16_0._item5Btn:AddClickListener(arg_16_0._onItem5Click, arg_16_0)
end

function var_0_0.removeEvents(arg_17_0)
	arg_17_0._btnClose:RemoveClickListener()
	arg_17_0._item1Toggle:RemoveOnValueChanged()
	arg_17_0._item2Btn:RemoveClickListener()
	arg_17_0._item3Btn:RemoveClickListener()
	arg_17_0._item4Btn:RemoveClickListener()
	arg_17_0._item5Btn:RemoveClickListener()
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0:_refreshItem1()
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_20_0)
	local var_20_0 = var_0_0.s_ShowAllTabId

	arg_20_0._item1Toggle.isOn = var_20_0
end

function var_0_0._onItem1ToggleValueChanged(arg_21_0)
	local var_21_0 = arg_21_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_21_0

	GMController.instance:dispatchEvent(GMEvent.CharacterView_ShowAllTabIdUpdate, var_21_0)
end

function var_0_0._onItem2Click(arg_22_0)
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckFace)
end

function var_0_0._onItem3Click(arg_23_0)
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckMouth)
end

function var_0_0._onItem4Click(arg_24_0)
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckContent)
end

function var_0_0._onItem5Click(arg_25_0)
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckMotion)
end

return var_0_0
