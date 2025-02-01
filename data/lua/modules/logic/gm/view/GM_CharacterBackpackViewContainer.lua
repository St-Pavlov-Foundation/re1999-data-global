module("modules.logic.gm.view.GM_CharacterBackpackViewContainer", package.seeall)

slot0 = class("GM_CharacterBackpackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GM_CharacterBackpackView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.addEvents(slot0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_EnableCheckFaceOnSelect, slot0._gm_enableCheckFaceOnSelect, slot0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_EnableCheckMouthOnSelect, slot0._gm_enableCheckMouthOnSelect, slot0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_EnableCheckContentOnSelect, slot0._gm_enableCheckContentOnSelect, slot0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_EnableCheckMotionOnSelect, slot0._gm_enableCheckMotionOnSelect, slot0)
end

function slot0.removeEvents(slot0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_EnableCheckFaceOnSelect, slot0._gm_enableCheckFaceOnSelect, slot0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_EnableCheckMouthOnSelect, slot0._gm_enableCheckMouthOnSelect, slot0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_EnableCheckContentOnSelect, slot0._gm_enableCheckContentOnSelect, slot0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_EnableCheckMotionOnSelect, slot0._gm_enableCheckMotionOnSelect, slot0)
end

return slot0
