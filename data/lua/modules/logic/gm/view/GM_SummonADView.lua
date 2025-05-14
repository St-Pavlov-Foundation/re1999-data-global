module("modules.logic.gm.view.GM_SummonADView", package.seeall)

local var_0_0 = class("GM_SummonADView")

function var_0_0.register()
	var_0_0.SummonMainView_register(SummonMainView)
	var_0_0.SummonMainCategoryItem_register(SummonMainCategoryItem)
end

function var_0_0.SummonMainView_register(arg_2_0)
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
		GM_SummonMainViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_SummonMainViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._gm_showAllTabIdUpdate()
		SummonController.instance:dispatchEvent(SummonEvent.onSummonInfoGot)
	end
end

function var_0_0.SummonMainCategoryItem_register(arg_7_0)
	GMMinusModel.instance:saveOriginalFunc(arg_7_0, "_initCurrentComponents")

	function arg_7_0._initCurrentComponents(arg_8_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_8_0, "_initCurrentComponents", ...)

		if not GM_SummonMainView.s_ShowAllTabId then
			return
		end

		local var_8_0 = arg_8_0._mo.originConf
		local var_8_1 = gohelper.getRichColorText("=====> id:" .. tostring(var_8_0.id), "#FFFF00")

		arg_8_0._txtnameselect.text = var_8_1
		arg_8_0._txtname.text = var_8_1
		arg_8_0._txtnameen.text = var_8_1
		arg_8_0._txtnameenselect.text = var_8_1
	end
end

return var_0_0
