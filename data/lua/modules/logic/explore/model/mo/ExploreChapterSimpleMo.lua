module("modules.logic.explore.model.mo.ExploreChapterSimpleMo", package.seeall)

slot0 = pureTable("ExploreChapterSimpleMo")

function slot0.ctor(slot0)
	slot0.archiveIds = {}
	slot0.bonusScene = {}
	slot0.isFinish = false
end

function slot0.init(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.archiveIds) do
		slot0.archiveIds[slot6] = true
	end

	for slot5, slot6 in ipairs(slot1.bonusScene) do
		slot0.bonusScene[slot6.bonusSceneId] = slot6.options
	end

	slot0.isFinish = slot1.isFinish
end

function slot0.onGetArchive(slot0, slot1)
	slot0.archiveIds[slot1] = true
end

function slot0.onGetBonus(slot0, slot1, slot2)
	slot0.bonusScene[slot1] = slot2
end

function slot0.haveBonusScene(slot0)
	return next(slot0.bonusScene) and true or false
end

return slot0
