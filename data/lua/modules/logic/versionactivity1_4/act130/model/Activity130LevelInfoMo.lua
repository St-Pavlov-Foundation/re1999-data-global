module("modules.logic.versionactivity1_4.act130.model.Activity130LevelInfoMo", package.seeall)

slot0 = pureTable("Activity130LevelInfoMo")

function slot0.ctor(slot0)
	slot0.episodeId = 0
	slot0.state = 0
	slot0.progress = 0
	slot0.act130Elements = {}
	slot0.tipsElementId = 0
	slot0.challengeNum = 0
end

function slot0.init(slot0, slot1)
	slot0.episodeId = slot1.episodeId
	slot0.state = slot1.state
	slot0.progress = slot1.progress
	slot0.act130Elements = {}

	for slot5, slot6 in ipairs(slot1.act130Elements) do
		slot7 = Activity130ElementMo.New()

		slot7:init(slot6)
		table.insert(slot0.act130Elements, slot7)
	end

	slot0.tipsElementId = slot1.tipsElementId
	slot0.challengeNum = slot1.startGameTimes
end

function slot0.updateInfo(slot0, slot1)
	slot0.state = slot1.state
	slot0.progress = slot1.progress
	slot0.act130Elements = {}

	for slot5, slot6 in ipairs(slot1.act130Elements) do
		slot7 = Activity130ElementMo.New()

		slot7:init(slot6)
		table.insert(slot0.act130Elements, slot7)
	end

	slot0.tipsElementId = slot1.tipsElementId
	slot0.challengeNum = slot1.startGameTimes
end

function slot0.getFinishElementCount(slot0)
	if not 0 then
		return slot1
	end

	for slot5, slot6 in ipairs(slot0.act130Elements) do
		if slot6.isFinish then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

function slot0.updateChallengeNum(slot0, slot1)
	slot0.challengeNum = slot1
end

return slot0
