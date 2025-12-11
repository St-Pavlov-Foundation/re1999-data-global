module("modules.logic.gm.view.GM_V3a1_GaoSiNiao_LevelView", package.seeall)

local var_0_0 = class("GM_V3a1_GaoSiNiao_LevelView", BaseView)
local var_0_1 = string.format
local var_0_2 = "#FFFF00"
local var_0_3 = "#FF0000"
local var_0_4 = "#00FF00"
local var_0_5 = "#0000FF"

function var_0_0.register()
	var_0_0.V3a1_GaoSiNiao_LevelView_register(V3a1_GaoSiNiao_LevelView)
	var_0_0.V3a1_GaoSiNiao_LevelViewStageItem_register(V3a1_GaoSiNiao_LevelViewStageItem)
end

function var_0_0.V3a1_GaoSiNiao_LevelView_register(arg_2_0)
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "removeEvents")

	function arg_2_0._editableInitView(arg_3_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_3_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_3_0)

		arg_3_0._gm_txt_Endless = gohelper.findChildText(arg_3_0._btnEndlessGo, "txt_Endless")
	end

	function arg_2_0.addEvents(arg_4_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_4_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_4_0)
		GM_V3a1_GaoSiNiao_LevelViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_V3a1_GaoSiNiao_LevelViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._gm_showAllTabIdUpdate(arg_6_0)
		arg_6_0._gm_txt_Endless.text = luaLang("p_v3a1_gaosiniao_level_txt_Endless")

		arg_6_0:_refresh()

		if not var_0_0.s_ShowAllTabId then
			return
		end

		local var_6_0 = arg_6_0:_spCO()

		if var_6_0 then
			local var_6_1 = var_6_0.episodeId

			arg_6_0._gm_txt_Endless.text = gohelper.getRichColorText(var_6_1, var_0_2)
		end
	end

	function arg_2_0._gm_enableEditModeOnSelect(arg_7_0, arg_7_1)
		GM_V3a1_GaoSiNiao_GameView.s_isEditMode = arg_7_1 and true or false
	end
end

function var_0_0.V3a1_GaoSiNiao_LevelViewStageItem_register(arg_8_0)
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "setData")

	function arg_8_0.setData(arg_9_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_9_0, "setData", ...)

		if not var_0_0.s_ShowAllTabId then
			return
		end

		arg_9_0._txtstagename.text = gohelper.getRichColorText(arg_9_0:episodeId(), var_0_2)
	end
end

function var_0_0.onInitView(arg_10_0)
	arg_10_0._btnClose = gohelper.findChildButtonWithAudio(arg_10_0.viewGO, "btnClose")
	arg_10_0._item1Toggle = gohelper.findChildToggle(arg_10_0.viewGO, "viewport/content/item1/Toggle")
	arg_10_0._item2Toggle = gohelper.findChildToggle(arg_10_0.viewGO, "viewport/content/item2/Toggle")
end

function var_0_0.addEvents(arg_11_0)
	arg_11_0._btnClose:AddClickListener(arg_11_0.closeThis, arg_11_0)
	arg_11_0._item1Toggle:AddOnValueChanged(arg_11_0._onItem1ToggleValueChanged, arg_11_0)
	arg_11_0._item2Toggle:AddOnValueChanged(arg_11_0._onItem2ToggleValueChanged, arg_11_0)
end

function var_0_0.removeEvents(arg_12_0)
	arg_12_0._btnClose:RemoveClickListener()
	arg_12_0._item1Toggle:RemoveOnValueChanged()
	arg_12_0._item2Toggle:RemoveOnValueChanged()
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:refresh()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:onUpdateParam()
end

function var_0_0.refresh(arg_15_0)
	arg_15_0:_refreshItem1()
	arg_15_0:_refreshItem2()
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_17_0)
	local var_17_0 = var_0_0.s_ShowAllTabId

	arg_17_0._item1Toggle.isOn = var_17_0
end

function var_0_0._onItem1ToggleValueChanged(arg_18_0)
	local var_18_0 = arg_18_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_18_0

	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_LevelView_ShowAllTabIdUpdate, var_18_0)
end

var_0_0.s_EnableEditModeOnSelect = false

function var_0_0._refreshItem2(arg_19_0)
	local var_19_0 = var_0_0.s_EnableEditModeOnSelect

	GM_V3a1_GaoSiNiao_GameView.s_isEditMode = var_19_0 and true or false
	arg_19_0._item2Toggle.isOn = var_19_0
end

function var_0_0._onItem2ToggleValueChanged(arg_20_0)
	local var_20_0 = arg_20_0._item2Toggle.isOn

	var_0_0.s_EnableEditModeOnSelect = var_20_0

	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_LevelView_EnableEditModeOnSelect, var_20_0)
end

return var_0_0
