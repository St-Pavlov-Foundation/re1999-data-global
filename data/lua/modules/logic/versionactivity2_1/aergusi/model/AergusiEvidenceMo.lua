module("modules.logic.versionactivity2_1.aergusi.model.AergusiEvidenceMo", package.seeall)

slot0 = class("AergusiEvidenceMo")

function slot0.ctor(slot0)
	slot0.clueInfos = {}
	slot0.hp = 0
	slot0.tipCount = 0
	slot0.success = false
end

function slot0.init(slot0, slot1)
	slot0.clueInfos = slot0:_buildClues(slot1.cluesInfo)
	slot0.hp = slot1.hp
	slot0.tipCount = slot1.tipCount
	slot0.success = slot1.success
end

function slot0.update(slot0, slot1)
	slot0:init(slot1)
end

function slot0._buildClues(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = AergusiClueMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

return slot0
