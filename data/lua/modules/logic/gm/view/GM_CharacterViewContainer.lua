module("modules.logic.gm.view.GM_CharacterViewContainer", package.seeall)

slot0 = class("GM_CharacterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GM_CharacterView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.addEvents(slot0)
	GMController.instance:registerCallback(GMEvent.CharacterView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
	GMController.instance:registerCallback(GMEvent.CharacterView_OnClickCheckFace, slot0._gm_onClickCheckFace, slot0)
	GMController.instance:registerCallback(GMEvent.CharacterView_OnClickCheckMouth, slot0._gm_onClickCheckMouth, slot0)
end

function slot0.removeEvents(slot0)
	GMController.instance:unregisterCallback(GMEvent.CharacterView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
	GMController.instance:unregisterCallback(GMEvent.CharacterView_OnClickCheckFace, slot0._gm_onClickCheckFace, slot0)
	GMController.instance:unregisterCallback(GMEvent.CharacterView_OnClickCheckMouth, slot0._gm_onClickCheckMouth, slot0)
end

return slot0
