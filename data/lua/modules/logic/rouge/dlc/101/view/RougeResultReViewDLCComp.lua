module("modules.logic.rouge.dlc.101.view.RougeResultReViewDLCComp", package.seeall)

slot0 = class("RougeResultReViewDLCComp", RougeBaseDLCViewComp)

function slot0.getSeason(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.reviewInfo

	return slot1 and slot1.season
end

function slot0.getVersions(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.reviewInfo

	return slot1 and slot1:getVersions()
end

return slot0
