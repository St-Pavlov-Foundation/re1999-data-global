module("modules.logic.test.view.TestUISubView", package.seeall)

slot0 = class("TestUISubView", BaseViewExtended)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
	slot0:addClickCb(gohelper.getClick(gohelper.findChild(slot0.viewGO, "#simage_bg")), slot0._onClick, slot0)
	slot0:addClickCb(gohelper.getClick(gohelper.findChild(slot0.viewGO, "#btn_decompose")), slot0._onOpenSubView, slot0)
end

function slot0._onOpenSubView(slot0)
	if slot0.sub_view then
		slot0.sub_view:setViewVisible(true)
	else
		slot0.sub_view = slot0:openSubView(uv0, "ui/viewres/test/testuisubview.prefab")
	end
end

function slot0._onClick(slot0)
	slot0:setViewVisible(false)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

return slot0
