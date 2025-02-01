module("modules.logic.gm.view.GM_CharacterView", package.seeall)

slot0 = class("GM_CharacterView", BaseView)
slot1 = "#FFFF00"
slot0.s_AutoCheckFaceOnOpen = false
slot0.s_AutoCheckMouthOnOpen = false
slot0.s_AutoCheckContentOnOpen = false
slot0.s_AutoCheckMotionOnOpen = false

function slot2(slot0, slot1)
	slot2 = Checker_HeroVoiceFace.New(slot0)

	slot2:exec(slot1)
	slot2:log()
end

function slot3(slot0, slot1)
	slot2 = Checker_HeroVoiceMouth.New(slot0)

	slot2:exec(slot1)
	slot2:log()
end

function slot4(slot0, slot1)
	slot2 = Checker_HeroVoiceContent.New(slot0)

	slot2:exec(slot1)
	slot2:log()
end

function slot5(slot0, slot1)
	slot2 = Checker_HeroVoiceMotion.New(slot0)

	slot2:exec(slot1)
	slot2:log()
end

function slot0.register()
	uv0.CharacterView_register(CharacterView)
end

function slot0.CharacterView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshInfo")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_onSpineLoaded")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_CharacterViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_CharacterViewContainer.removeEvents(slot0)
	end

	function slot0._onSpineLoaded(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_onSpineLoaded", ...)

		if uv0.s_AutoCheckFaceOnOpen then
			uv1(slot0._heroMO.heroId, slot0._uiSpine)
		end

		if uv0.s_AutoCheckMouthOnOpen then
			uv2(slot2, slot3)
		end

		if uv0.s_AutoCheckContentOnOpen then
			uv3(slot2, slot3)
		end

		if uv0.s_AutoCheckMotionOnOpen then
			uv4(slot2, slot3)
		end
	end

	function slot0._refreshInfo(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshInfo", ...)

		if uv0.s_ShowAllTabId then
			slot1 = slot0._heroMO
			slot0._txtnamecn.text = gohelper.getRichColorText(slot1.heroId, uv1) .. slot1.config.name
		end
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		slot0:_refreshInfo()
	end

	function slot0._gm_onClickCheckFace(slot0)
		uv0(slot0._heroMO.heroId, slot0._uiSpine)
	end

	function slot0._gm_onClickCheckMouth(slot0)
		uv0(slot0._heroMO.heroId, slot0._uiSpine)
	end
end

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._item1Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item1/Toggle")
	slot0._item2Btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item2/Button")
	slot0._item3Btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item3/Button")
	slot0._item4Btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item4/Button")
	slot0._item5Btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item5/Button")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._item1Toggle:AddOnValueChanged(slot0._onItem1ToggleValueChanged, slot0)
	slot0._item2Btn:AddClickListener(slot0._onItem2Click, slot0)
	slot0._item3Btn:AddClickListener(slot0._onItem3Click, slot0)
	slot0._item4Btn:AddClickListener(slot0._onItem4Click, slot0)
	slot0._item5Btn:AddClickListener(slot0._onItem5Click, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._item1Toggle:RemoveOnValueChanged()
	slot0._item2Btn:RemoveClickListener()
	slot0._item3Btn:RemoveClickListener()
	slot0._item4Btn:RemoveClickListener()
	slot0._item5Btn:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0:_refreshItem1()
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

	GMController.instance:dispatchEvent(GMEvent.CharacterView_ShowAllTabIdUpdate, slot1)
end

function slot0._onItem2Click(slot0)
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckFace)
end

function slot0._onItem3Click(slot0)
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckMouth)
end

function slot0._onItem4Click(slot0)
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckContent)
end

function slot0._onItem5Click(slot0)
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckMotion)
end

return slot0
