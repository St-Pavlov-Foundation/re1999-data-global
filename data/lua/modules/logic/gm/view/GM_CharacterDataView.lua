module("modules.logic.gm.view.GM_CharacterDataView", package.seeall)

local var_0_0 = class("GM_CharacterDataView")

function var_0_0.register()
	var_0_0.CharacterDataVoiceView_register(CharacterDataVoiceView)
	var_0_0.CharacterVoiceItem_register(CharacterVoiceItem)
end

function var_0_0.CharacterDataVoiceView_register(arg_2_0)
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
		GM_CharacterDataVoiceViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_CharacterDataVoiceViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._gm_showAllTabIdUpdate(arg_6_0)
		arg_6_0:_refreshVoice()
	end
end

function var_0_0.CharacterVoiceItem_register(arg_7_0)
	GMMinusModel.instance:saveOriginalFunc(arg_7_0, "_refreshItem")

	function arg_7_0._refreshItem(arg_8_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_8_0, "_refreshItem", ...)

		if not GM_CharacterDataVoiceView.s_ShowAllTabId then
			return
		end

		local var_8_0 = arg_8_0._mo
		local var_8_1 = var_8_0.id

		arg_8_0._txtvoicename.text = tostring(var_8_1) .. " " .. var_8_0.name
		arg_8_0._txtlockvoicename.text = tostring(var_8_1) .. " " .. CharacterDataConfig.instance:getConditionStringName(var_8_0)
	end
end

return var_0_0
