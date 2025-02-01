module("modules.logic.versionactivity1_4.act131.model.Activity131LevelInfoMo", package.seeall)

slot0 = pureTable("Activity131LevelInfoMo")

function slot0.ctor(slot0)
	slot0.episodeId = 0
	slot0.state = 0
	slot0.progress = 0
	slot0.act131Elements = {}
end

function slot0.init(slot0, slot1)
	slot0.episodeId = slot1.episodeId
	slot0.state = slot1.state
	slot0.progress = slot1.progress
	slot0.act131Elements = {}

	for slot5, slot6 in ipairs(slot1.act131Elements) do
		slot7 = Activity131ElementMo.New()

		slot7:init(slot6)
		table.insert(slot0.act131Elements, slot7)
	end

	table.sort(slot0.act131Elements, uv0.sortById)
end

function slot0.updateInfo(slot0, slot1)
	if slot0.state ~= slot1.state then
		slot0.state = slot1.state

		Activity131Controller.instance:dispatchEvent(Activity131Event.FirstFinish, slot1.episodeId)
	end

	slot0.progress = slot1.progress
	slot0.act131Elements = {}

	for slot5, slot6 in ipairs(slot1.act131Elements) do
		slot7 = Activity131ElementMo.New()

		slot7:init(slot6)
		table.insert(slot0.act131Elements, slot7)
	end

	table.sort(slot0.act131Elements, uv0.sortById)
end

function slot0.sortById(slot0, slot1)
	return slot0.elementId < slot1.elementId
end

return slot0
