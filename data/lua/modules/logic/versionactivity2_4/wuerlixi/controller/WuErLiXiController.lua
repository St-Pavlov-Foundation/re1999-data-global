module("modules.logic.versionactivity2_4.wuerlixi.controller.WuErLiXiController", package.seeall)

slot0 = class("WuErLiXiController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.enterLevelView(slot0)
	Activity180Rpc.instance:sendGet180InfosRequest(VersionActivity2_4Enum.ActivityId.WuErLiXi, slot0._onRecInfo, slot0)
end

function slot0._onRecInfo(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		ViewMgr.instance:openView(ViewName.WuErLiXiLevelView)
	end
end

function slot0.enterGameView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WuErLiXiGameView, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
