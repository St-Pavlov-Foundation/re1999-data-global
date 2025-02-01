module("modules.logic.versionactivity1_3.astrology.controller.VersionActivity1_3AstrologyController", package.seeall)

slot0 = class("VersionActivity1_3AstrologyController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openVersionActivity1_3AstrologyView(slot0)
	if Activity126Model.instance:receiveHoroscope() and slot2 > 0 then
		({
			defaultTabIds = {
				[2.0] = 1
			}
		}).defaultTabIds[3] = 2
	else
		slot1.defaultTabIds[3] = 1
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_3AstrologyView, slot1)
end

function slot0.openVersionActivity1_3AstrologySuccessView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3AstrologySuccessView, slot1, slot2)
end

function slot0.openVersionActivity1_3AstrologyPropView(slot0, slot1)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.VersionActivity1_3AstrologyPropView, slot1)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
