module("modules.logic.gm.view.GM_SummonHeroDetailView", package.seeall)

local var_0_0 = class("GM_SummonHeroDetailView", BaseView)
local var_0_1 = string.format
local var_0_2 = "#FFFF00"

function var_0_0.register()
	var_0_0.SummonHeroDetailView_register(SummonHeroDetailView)
end

function var_0_0.SummonHeroDetailView_register(arg_2_0)
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_refreshHero")

	function arg_2_0._editableInitView(arg_3_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_3_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_3_0)
	end

	function arg_2_0.addEvents(arg_4_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_4_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_4_0)
		GM_SummonHeroDetailViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_SummonHeroDetailViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._refreshHero(arg_6_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_6_0, "_refreshHero", ...)

		if not var_0_0.s_ShowAllTabId then
			return
		end

		local var_6_0 = arg_6_0._heroId
		local var_6_1 = arg_6_0._skinId
		local var_6_2 = HeroConfig.instance:getHeroCO(var_6_0)

		if SkinConfig.instance:getSkinCo(var_6_1) then
			arg_6_0._txtnameen.text = var_6_2.nameEng .. var_0_1(" (skinId: %s)", gohelper.getRichColorText(var_6_1, var_0_2))
		end

		arg_6_0._txtname.text = var_6_2.name .. gohelper.getRichColorText(var_6_0, var_0_2)
	end

	function arg_2_0._gm_showAllTabIdUpdate(arg_7_0)
		arg_7_0:_refreshUI()
	end
end

function var_0_0.onInitView(arg_8_0)
	arg_8_0._btnClose = gohelper.findChildButtonWithAudio(arg_8_0.viewGO, "btnClose")
	arg_8_0._item1Toggle = gohelper.findChildToggle(arg_8_0.viewGO, "viewport/content/item1/Toggle")
end

function var_0_0.addEvents(arg_9_0)
	arg_9_0._btnClose:AddClickListener(arg_9_0.closeThis, arg_9_0)
	arg_9_0._item1Toggle:AddOnValueChanged(arg_9_0._onItem1ToggleValueChanged, arg_9_0)
end

function var_0_0.removeEvents(arg_10_0)
	arg_10_0._btnClose:RemoveClickListener()
	arg_10_0._item1Toggle:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:_refreshItem1()
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_13_0)
	local var_13_0 = var_0_0.s_ShowAllTabId

	arg_13_0._item1Toggle.isOn = var_13_0
end

function var_0_0._onItem1ToggleValueChanged(arg_14_0)
	local var_14_0 = arg_14_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_14_0

	GMController.instance:dispatchEvent(GMEvent.SummonHeroDetailView_ShowAllTabIdUpdate, var_14_0)
end

return var_0_0
