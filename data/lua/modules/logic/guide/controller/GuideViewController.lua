module("modules.logic.guide.controller.GuideViewController", package.seeall)

slot0 = class("GuideViewController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	GuideController.instance:registerCallback(GuideEvent.FadeView, slot0._onReceiveFadeView, slot0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
end

function slot0._onFinishGuide(slot0, slot1)
	if slot0._isShow == false and slot1 == 501 then
		slot0._isShow = nil

		slot0:_fadeView(true)
	end
end

function slot0._onReceiveFadeView(slot0, slot1)
	slot2 = slot1 == "1"
	slot0._isShow = slot2

	slot0:_fadeView(slot2)
end

function slot0._fadeView(slot0, slot1)
	for slot6, slot7 in ipairs({
		ViewName.DungeonMapView,
		ViewName.MainView
	}) do
		if ViewMgr.instance:getContainer(slot7) and slot8:isOpen() and slot8.viewGO then
			if slot1 then
				slot8:_setVisible(true)
				gohelper.setActive(slot8.viewGO, false)
				gohelper.setActive(slot8.viewGO, true)

				break
			end

			slot8:_setVisible(false)

			break
		end
	end
end

slot0.instance = slot0.New()

return slot0
