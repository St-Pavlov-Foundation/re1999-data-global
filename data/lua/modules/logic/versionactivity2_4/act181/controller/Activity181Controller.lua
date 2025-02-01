module("modules.logic.versionactivity2_4.act181.controller.Activity181Controller", package.seeall)

slot0 = class("Activity181Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getActivityInfo(slot0, slot1, slot2, slot3)
	Activity181Rpc.instance:SendGet181InfosRequest(slot1, slot2, slot3)
end

function slot0.getBonus(slot0, slot1, slot2, slot3, slot4)
	Activity181Rpc.instance:SendGet181BonusRequest(slot1, slot2, slot3, slot4)
end

function slot0.getSPBonus(slot0, slot1, slot2, slot3)
	Activity181Rpc.instance:SendGet181SpBonusRequest(slot1, slot2, slot3)
end

slot0.instance = slot0.New()

return slot0
