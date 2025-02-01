module("modules.logic.gm.view.GM_CharacterDataView", package.seeall)

slot0 = class("GM_CharacterDataView")

function slot0.register()
	uv0.CharacterDataVoiceView_register(CharacterDataVoiceView)
	uv0.CharacterVoiceItem_register(CharacterVoiceItem)
end

function slot0.CharacterDataVoiceView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_CharacterDataVoiceViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_CharacterDataVoiceViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		slot0:_refreshVoice()
	end
end

function slot0.CharacterVoiceItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshItem")

	function slot0._refreshItem(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshItem", ...)

		if not GM_CharacterDataVoiceView.s_ShowAllTabId then
			return
		end

		slot1 = slot0._mo
		slot2 = slot1.id
		slot0._txtvoicename.text = tostring(slot2) .. " " .. slot1.name
		slot0._txtlockvoicename.text = tostring(slot2) .. " " .. CharacterDataConfig.instance:getConditionStringName(slot1)
	end
end

return slot0
