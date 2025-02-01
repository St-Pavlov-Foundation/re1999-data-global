module("modules.logic.share.view.ShareTipView", package.seeall)

slot0 = class("ShareTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btn_close")
	slot0._gorawImage = gohelper.findChild(slot0.viewGO, "bg/#go_rawImage")
	slot0._btnshare = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#go_rawImage/#btn_share")
	slot0._simagelogo = gohelper.findChildSingleImage(slot0.viewGO, "#simage_logo")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnshare:AddClickListener(slot0._btnshareOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnshare:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnshareOnClick(slot0)
	if not slot0._viewOpen then
		return
	end

	slot0._openShareEditor = true

	slot0:closeThis()
	ShareController.instance:openShareEditorView(slot0._texture)
end

function slot0._editableInitView(slot0)
	slot0._bgGO = gohelper.findChild(slot0.viewGO, "bg")
	slot0._bgTr = slot0._bgGO.transform
	slot0._touchGO = gohelper.findChild(slot0.viewGO, "touch")
	slot0._touch = TouchEventMgrHepler.getTouchEventMgr(slot0._touchGO)

	slot0._touch:SetIgnoreUI(true)
	slot0._touch:SetOnlyTouch(true)
	slot0._touch:SetOnTouchDownCb(slot0._onTouch, slot0)

	slot0._viewOpen = false
end

function slot0._onTouch(slot0, slot1)
	if recthelper.getWidth(slot0._bgTr) < math.abs(recthelper.screenPosToAnchorPos(slot1, slot0._bgTr).x) or recthelper.getHeight(slot0._bgTr) < math.abs(slot2.y) then
		slot0:closeThis()
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0._viewOpen = true

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0._texture = slot0.viewParam
	gohelper.onceAddComponent(slot0._gorawImage, gohelper.Type_RawImage).texture = slot0._texture

	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 3)
end

function slot0.onClose(slot0)
	slot0._viewOpen = false

	if not slot0._openShareEditor then
		UnityEngine.Object.Destroy(slot0._texture)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)

	if slot0._touch then
		TouchEventMgrHepler.remove(slot0._touch)

		slot0._touch = nil
	end
end

return slot0
