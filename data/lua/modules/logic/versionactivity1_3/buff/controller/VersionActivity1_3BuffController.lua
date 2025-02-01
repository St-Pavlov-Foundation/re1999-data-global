module("modules.logic.versionactivity1_3.buff.controller.VersionActivity1_3BuffController", package.seeall)

slot0 = class("VersionActivity1_3BuffController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openBuffView(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3BuffView)
end

function slot0.openFairyLandView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3FairyLandView, slot1)
end

slot0.instance = slot0.New()

return slot0
