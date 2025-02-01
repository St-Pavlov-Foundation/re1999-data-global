module("modules.logic.turnback.view.TurnbackPopupBeginnerView", package.seeall)

slot0 = class("TurnbackPopupBeginnerView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._gosubview = gohelper.findChild(slot0.viewGO, "#go_subview")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	NavigateMgr.instance:addEscape(ViewName.TurnbackPopupBeginnerView, slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	NavigateMgr.instance:removeEscape(ViewName.TurnbackPopupBeginnerView, slot0._btncloseOnClick, slot0)
end

slot1 = {
	TurnbackPopupRewardView
}

function slot0._btncloseOnClick(slot0)
	slot0.viewIndex = slot0.viewIndex + 1

	if uv0[slot0.viewIndex] then
		slot0:openSubPopupView(slot0.viewIndex)
	else
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
end

function slot0.openSubPopupView(slot0, slot1)
	if slot0.viewObjDict[slot0.viewContainer:getSetting().otherRes[slot0.viewIndex]] then
		gohelper.setActive(slot0.viewObjDict[slot2], true)
	end

	slot0:openExclusiveView(nil, slot1, uv0[slot1], slot0.viewObjDict[slot2] or slot2, slot0._gosubview, {
		callbackObject = slot0,
		closeCallback = slot0._btncloseOnClick
	})
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.viewObjDict = slot0:getUserDataTb_()

	slot0:com_loadListAsset(slot0.viewContainer:getSetting().otherRes, slot0._assetLoaded, slot0.onLoadFinish)
end

function slot0._assetLoaded(slot0, slot1)
	slot3 = gohelper.clone(slot1:GetResource(), slot0.viewGO)

	gohelper.setActive(slot3, false)

	slot0.viewObjDict[slot1.ResPath] = slot3
end

function slot0.onLoadFinish(slot0)
	slot0.viewIndex = 1

	slot0:openSubPopupView(slot0.viewIndex)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
