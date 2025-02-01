module("modules.logic.test.view.TestUIView", package.seeall)

slot0 = class("TestUIView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
end

function slot0.addEvents(slot0)
	slot0:addClickCb(gohelper.getClick(gohelper.findChild(slot0.viewGO, "#btn_decompose")), slot0._onClick, slot0)
	slot0:addClickCb(gohelper.getClick(gohelper.findChild(slot0.viewGO, "#btn_1")), slot0._on1Click, slot0)
	slot0:addClickCb(gohelper.getClick(gohelper.findChild(slot0.viewGO, "#btn_2")), slot0._on2Click, slot0)
	slot0:addClickCb(gohelper.getClick(gohelper.findChild(slot0.viewGO, "#btn_3")), slot0._on3Click, slot0)
	slot0:addClickCb(gohelper.getClick(gohelper.findChild(slot0.viewGO, "#btn_close_exclusive")), slot0._onCloseExclusive, slot0)
end

function slot0._onClick(slot0)
	if slot0.sub_view then
		slot0.sub_view:setViewVisible(true)
	else
		slot0.sub_view = slot0:openSubView(TestUISubView, "ui/viewres/test/testuisubview.prefab")
	end
end

function slot0._on1Click(slot0)
	slot0:openSubView(TestHeroBagView)
end

function slot0._on2Click(slot0)
	slot0:openExclusiveView(nil, 2, TestUIExclusive, "ui/viewres/test/testuiexclusiveview.prefab", nil, 2)
end

function slot0._on3Click(slot0)
	slot0:openExclusiveView(nil, 3, TestUIExclusive, "ui/viewres/test/testuiexclusiveview.prefab", nil, 3)
end

function slot0._onCloseExclusive(slot0)
	slot0:hideExclusiveGroup(1)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

return slot0
