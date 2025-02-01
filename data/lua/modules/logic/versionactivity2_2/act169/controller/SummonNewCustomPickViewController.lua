module("modules.logic.versionactivity2_2.act169.controller.SummonNewCustomPickViewController", package.seeall)

slot0 = class("SummonNewCustomPickViewController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.getSummonInfo(slot0, slot1, slot2, slot3)
	SummonNewCustomPickViewRpc.instance:sendGet169InfoRequest(slot1, slot2, slot3)
end

function slot0.reInit(slot0)
	SummonNewCustomPickViewModel.instance:reInit()
end

slot0.instance = slot0.New()

return slot0
