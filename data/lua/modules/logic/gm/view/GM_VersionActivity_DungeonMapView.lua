module("modules.logic.gm.view.GM_VersionActivity_DungeonMapView", package.seeall)

local var_0_0 = class("GM_VersionActivity_DungeonMapView", BaseView)
local var_0_1 = "#FFFF00"

local function var_0_2()
	ViewMgr.instance:openView(ViewName.GM_VersionActivity_DungeonMapView)
end

function var_0_0.VersionActivityX_XDungeonMapView_register(arg_2_0)
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "removeEvents")

	function arg_2_0._editableInitView(arg_3_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_3_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_3_0)
	end

	function arg_2_0.addEvents(arg_4_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_4_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_4_0, var_0_2)
		GM_VersionActivity_DungeonMapViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_VersionActivity_DungeonMapViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._gm_showAllTabIdUpdate()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function var_0_0.VersionActivityX_XMapEpisodeItem_register(arg_7_0)
	GMMinusModel.instance:saveOriginalFunc(arg_7_0, "refreshUI")

	function arg_7_0.refreshUI(arg_8_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_8_0, "refreshUI", ...)

		if not var_0_0.s_ShowAllTabId then
			return
		end

		arg_8_0._txtsectionname.text = tostring(arg_8_0._config.id) .. "\n" .. arg_8_0._config.name
	end
end

function var_0_0.VersionActivityX_XDungeonMapLevelView_register(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1 = arg_9_1 or 1
	arg_9_2 = arg_9_2 or 0

	local function var_9_0(arg_10_0, arg_10_1)
		if arg_10_0 > arg_9_1 then
			return true
		end

		if arg_9_1 == arg_10_0 then
			return arg_10_1 >= arg_9_2
		end

		return false
	end

	local function var_9_1(arg_11_0, arg_11_1)
		if arg_11_0 < arg_9_1 then
			return true
		end

		if arg_9_1 == arg_11_0 then
			return arg_11_1 <= arg_9_2
		end

		return false
	end

	GMMinusModel.instance:saveOriginalFunc(arg_9_0, "refreshStartBtn")

	function arg_9_0.refreshStartBtn(arg_12_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_12_0, "refreshStartBtn", ...)

		if not var_0_0.s_ShowAllTabId then
			return
		end

		local var_12_0 = arg_12_0.showEpisodeCo
		local var_12_1 = gohelper.getRichColorText(var_12_0.id, var_0_1)

		if DungeonModel.instance:hasPassLevel(var_12_0.id) and var_12_0.afterStory > 0 and not StoryModel.instance:isStoryFinished(var_12_0.afterStory) then
			var_12_1 = var_12_1 .. luaLang("p_dungeonlevelview_continuestory")
		else
			var_12_1 = var_12_1 .. luaLang("p_dungeonlevelview_startfight")
		end

		arg_12_0._txtnorstarttext.text = var_12_1

		if var_9_0(1, 2) then
			arg_12_0._txtnorstarttext2.text = var_12_1
		end
	end
end

function var_0_0.onInitView(arg_13_0)
	arg_13_0._btnClose = gohelper.findChildButtonWithAudio(arg_13_0.viewGO, "btnClose")
	arg_13_0._item1Toggle = gohelper.findChildToggle(arg_13_0.viewGO, "viewport/content/item1/Toggle")
end

function var_0_0.addEvents(arg_14_0)
	arg_14_0._btnClose:AddClickListener(arg_14_0.closeThis, arg_14_0)
	arg_14_0._item1Toggle:AddOnValueChanged(arg_14_0._onItem1ToggleValueChanged, arg_14_0)
end

function var_0_0.removeEvents(arg_15_0)
	arg_15_0._btnClose:RemoveClickListener()
	arg_15_0._item1Toggle:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:_refreshItem1()
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_18_0)
	local var_18_0 = var_0_0.s_ShowAllTabId

	arg_18_0._item1Toggle.isOn = var_18_0
end

function var_0_0._onItem1ToggleValueChanged(arg_19_0)
	local var_19_0 = arg_19_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_19_0

	GMController.instance:dispatchEvent(GMEvent.VersionActivity_DungeonMapView_ShowAllTabIdUpdate, var_19_0)
end

return var_0_0
