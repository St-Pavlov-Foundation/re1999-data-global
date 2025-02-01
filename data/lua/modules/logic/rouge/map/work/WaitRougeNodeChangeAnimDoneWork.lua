module("modules.logic.rouge.map.work.WaitRougeNodeChangeAnimDoneWork", package.seeall)

slot0 = class("WaitRougeNodeChangeAnimDoneWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if not RougeMapModel.instance:getFinalMapInfo() then
		return slot0:onDone(true)
	end

	RougeMapModel.instance:updateMapInfo(slot1)
	RougeMapModel.instance:setFinalMapInfo(nil)

	return slot0:onDone(true)
end

return slot0
