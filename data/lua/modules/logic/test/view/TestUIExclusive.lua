module("modules.logic.test.view.TestUIExclusive", package.seeall)

slot0 = class("TestUIExclusive", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0.text = gohelper.findChildTextMesh(slot0.viewGO, "#txt_des")
end

function slot0.addEvents(slot0)
	slot0:addClickCb(gohelper.getClick(gohelper.findChild(slot0.viewGO, "#btn_close_exclusive")), slot0._onClick, slot0)
end

function slot0._onOpenSubView(slot0)
end

function slot0.onSetExclusiveViewVisible(slot0, slot1)
	if not slot1 then
		GameFacade.showToast(ToastEnum.ClassShow)
	end

	slot0:setViewVisibleInternal(slot1)
end

function slot0._onClick(slot0)
	slot0:getParentView():hideExclusiveView(slot0)
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0.str = slot1
end

function slot0.onOpen(slot0)
	slot0.text.text = slot0.str
end

function slot0.onClose(slot0)
end

return slot0
