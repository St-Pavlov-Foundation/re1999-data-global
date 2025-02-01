module("modules.logic.story.model.StoryStepMo", package.seeall)

slot0 = pureTable("StoryStepMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.name = ""
	slot0.conversation = {}
	slot0.heroList = {}
	slot0.bg = {}
	slot0.audioList = {}
	slot0.effList = {}
	slot0.picList = {}
	slot0.videoList = {}
	slot0.navigateList = {}
	slot0.optList = {}
	slot0.mainRole = {}
	slot0.mourningBorder = {}
end

function slot0.init(slot0, slot1)
	slot0.id = slot1[1]
	slot0.name = slot1[2]
	slot0.conversation = slot0:_buildConversation(slot1[3])
	slot0.heroList = slot0:_buildHero(slot1[4])
	slot0.bg = slot0:_buildBackground(slot1[5])
	slot0.audioList = slot0:_buildAudio(slot1[6])
	slot0.effList = slot0:_buildEffect(slot1[7])
	slot0.picList = slot0:_buildPictures(slot1[8])
	slot0.videoList = slot0:_buildVideo(slot1[9])
	slot0.navigateList = slot0:_buildNavigate(slot1[10])
	slot0.optList = slot0:_buildOption(slot1[11])
	slot0.mainRole = slot0:_buildMainRole(slot1[12])
	slot0.mourningBorder = slot0:_buildMourningBorder(slot1[13])
end

function slot0._buildConversation(slot0, slot1)
	slot2 = StoryStepConversationMo.New()

	slot2:init(slot1)

	return slot2
end

function slot0._buildHero(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = StoryStepHeroMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0._buildBackground(slot0, slot1)
	slot2 = StoryStepBGMo.New()

	slot2:init(slot1)

	return slot2
end

function slot0._buildAudio(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = StoryStepAudioMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0._buildEffect(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = StoryStepEffectMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0._buildPictures(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = StoryStepPictureMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0._buildVideo(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = StoryStepVideoMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0._buildNavigate(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = StoryStepNavigateMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0._buildOption(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = StoryStepOptionMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0._buildMainRole(slot0, slot1)
	slot2 = StoryStepMainHeroMo.New()

	slot2:init(slot1)

	return slot2
end

function slot0._buildMourningBorder(slot0, slot1)
	slot2 = StoryStepMourningBorderMo.New()

	slot2:init(slot1)

	return slot2
end

return slot0
