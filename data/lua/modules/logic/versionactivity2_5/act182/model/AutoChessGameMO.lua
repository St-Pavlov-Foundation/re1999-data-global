module("modules.logic.versionactivity2_5.act182.model.AutoChessGameMO", package.seeall)

slot0 = pureTable("AutoChessGameMO")

function slot0.init(slot0, slot1)
	slot0.module = slot1.module
	slot0.start = slot1.start
	slot0.currRound = slot1.currRound
	slot0.episodeId = slot1.episodeId

	slot0:updateMasterIdBox(slot1.masterIdBox)

	slot0.selectMasterId = slot1.selectMasterId
	slot0.refreshed = slot1.refreshed
end

function slot0.updateMasterIdBox(slot0, slot1)
	slot0.masterIdBox = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.masterIdBox[#slot0.masterIdBox + 1] = slot6
	end
end

return slot0
