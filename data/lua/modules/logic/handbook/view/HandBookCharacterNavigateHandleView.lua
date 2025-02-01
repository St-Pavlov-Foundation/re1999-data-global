module("modules.logic.handbook.view.HandBookCharacterNavigateHandleView", package.seeall)

slot0 = class("HandBookCharacterNavigateHandleView", BaseView)

function slot0.onInitView(slot0)
	slot0._goParentView = gohelper.findChild(slot0.viewGO, "#go_characterswitch")
	slot0._goSubView = gohelper.findChild(slot0.viewGO, "#go_center")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.Status = {
	InParentView = 1,
	InSubView = 2
}

function slot0._editableInitView(slot0)
	slot0.status = uv0.Status.InParentView
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
	slot0:addEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, slot0.openSubView, slot0)
end

function slot0.onCloseBtnClick(slot0)
	if slot0.status == uv0.Status.InParentView then
		slot0:closeParentView()

		return
	end

	HandbookController.instance:dispatchEvent(HandbookController.EventName.PlayCharacterSwitchCloseAnim)
	slot0:closeSubView()
end

function slot0.openSubView(slot0)
	slot0.status = uv0.Status.InSubView

	slot0:refreshUI()
end

function slot0.closeSubView(slot0)
	slot0.status = uv0.Status.InParentView

	TaskDispatcher.runDelay(slot0.playCharacterSwitchOpenAnim, slot0, 0.267)
end

function slot0.playCharacterSwitchOpenAnim(slot0)
	slot0:refreshUI()
	HandbookController.instance:dispatchEvent(HandbookController.EventName.PlayCharacterSwitchOpenAnim)
end

function slot0.closeParentView(slot0)
	slot0:closeThis()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goParentView, slot0.status == uv0.Status.InParentView)
	gohelper.setActive(slot0._goSubView, slot0.status == uv0.Status.InSubView)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.playCharacterSwitchOpenAnim, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:removeEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, slot0.openSubView, slot0)
end

return slot0
