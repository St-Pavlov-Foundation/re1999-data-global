module("modules.logic.gm.view.GM_CharacterBackpackView", package.seeall)

slot0 = class("GM_CharacterBackpackView", BaseView)
slot1 = "#FFFF00"

function slot0.register()
	uv0.CharacterBackpackView_register(CharacterBackpackView)
	uv0.CharacterBackpackCardListItem_register(CharacterBackpackCardListItem)
end

function slot0.CharacterBackpackView_register(slot0)
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
		GM_CharacterBackpackViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_CharacterBackpackViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroUpdatePush)
	end

	function slot0._gm_enableCheckFaceOnSelect(slot0)
		GM_CharacterView.s_AutoCheckFaceOnOpen = uv0.s_enableCheckSelectedFace
	end

	function slot0._gm_enableCheckMouthOnSelect(slot0)
		GM_CharacterView.s_AutoCheckMouthOnOpen = uv0.s_enableCheckSelectedMouth
	end

	function slot0._gm_enableCheckContentOnSelect(slot0)
		GM_CharacterView.s_AutoCheckContentOnOpen = uv0.s_enableCheckSelectedContent
	end

	function slot0._gm_enableCheckMotionOnSelect(slot0)
		GM_CharacterView.s_AutoCheckMotionOnOpen = uv0.s_enableCheckSelectedMotion
	end
end

function slot0.CharacterBackpackCardListItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "onUpdateMO")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_onItemClick")

	function slot0.onUpdateMO(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "onUpdateMO", ...)

		if uv0.s_ShowAllTabId then
			slot0._heroItem._nameCnTxt.text = gohelper.getRichColorText(slot0._mo.config.id, uv1)
		end
	end

	function slot0._onItemClick(slot0, ...)
		if uv0.s_enableCheckSelectedFace then
			GM_CharacterView.s_AutoCheckFaceOnOpen = true
		end

		if uv0.s_enableCheckSelectedMouth then
			GM_CharacterView.s_AutoCheckMouthOnOpen = true
		end

		if uv0.s_enableCheckSelectedContent then
			GM_CharacterView.s_AutoCheckContentOnOpen = true
		end

		if uv0.s_enableCheckSelectedMotion then
			GM_CharacterView.s_AutoCheckMotionOnOpen = true
		end

		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_onItemClick", ...)
	end
end

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._item1Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item1/Toggle")
	slot0._item2Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item2/Toggle")
	slot0._item3Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item3/Toggle")
	slot0._item4Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item4/Toggle")
	slot0._item5Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item5/Toggle")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._item1Toggle:AddOnValueChanged(slot0._onItem1ToggleValueChanged, slot0)
	slot0._item2Toggle:AddOnValueChanged(slot0._onItem2ToggleValueChanged, slot0)
	slot0._item3Toggle:AddOnValueChanged(slot0._onItem3ToggleValueChanged, slot0)
	slot0._item4Toggle:AddOnValueChanged(slot0._onItem4ToggleValueChanged, slot0)
	slot0._item5Toggle:AddOnValueChanged(slot0._onItem5ToggleValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._item1Toggle:RemoveOnValueChanged()
	slot0._item2Toggle:RemoveOnValueChanged()
	slot0._item3Toggle:RemoveOnValueChanged()
	slot0._item4Toggle:RemoveOnValueChanged()
	slot0._item5Toggle:RemoveOnValueChanged()
end

function slot0.onOpen(slot0)
	slot0:_refreshItem1()
	slot0:_refreshItem2()
	slot0:_refreshItem3()
	slot0:_refreshItem4()
	slot0:_refreshItem5()
end

function slot0.onDestroyView(slot0)
end

slot0.s_ShowAllTabId = false

function slot0._refreshItem1(slot0)
	slot0._item1Toggle.isOn = uv0.s_ShowAllTabId
end

function slot0._onItem1ToggleValueChanged(slot0)
	slot1 = slot0._item1Toggle.isOn
	uv0.s_ShowAllTabId = slot1

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_ShowAllTabIdUpdate, slot1)
end

slot0.s_enableCheckSelectedFace = false

function slot0._refreshItem2(slot0)
	slot0._item2Toggle.isOn = uv0.s_enableCheckSelectedFace
end

function slot0._onItem2ToggleValueChanged(slot0)
	slot1 = slot0._item2Toggle.isOn
	uv0.s_enableCheckSelectedFace = slot1

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckFaceOnSelect, slot1)
end

slot0.s_enableCheckSelectedMouth = false

function slot0._refreshItem3(slot0)
	slot0._item3Toggle.isOn = uv0.s_enableCheckSelectedMouth
end

function slot0._onItem3ToggleValueChanged(slot0)
	slot1 = slot0._item3Toggle.isOn
	uv0.s_enableCheckSelectedMouth = slot1

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckMouthOnSelect, slot1)
end

slot0.s_enableCheckSelectedContent = false

function slot0._refreshItem4(slot0)
	slot0._item4Toggle.isOn = uv0.s_enableCheckSelectedContent
end

function slot0._onItem4ToggleValueChanged(slot0)
	slot1 = slot0._item4Toggle.isOn
	uv0.s_enableCheckSelectedContent = slot1

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckContentOnSelect, slot1)
end

slot0.s_enableCheckSelectedMotion = false

function slot0._refreshItem5(slot0)
	slot0._item5Toggle.isOn = uv0.s_enableCheckSelectedMotion
end

function slot0._onItem5ToggleValueChanged(slot0)
	slot1 = slot0._item5Toggle.isOn
	uv0.s_enableCheckSelectedMotion = slot1

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckMotionOnSelect, slot1)
end

return slot0
