module("modules.logic.story.model.StoryLogListModel", package.seeall)

slot0 = class("StoryLogListModel", MixScrollModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._infos = nil
end

function slot0.setLogList(slot0, slot1)
	slot0._infos = slot1
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = StoryLogMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	slot0:setList(slot2)
end

function slot0.getInfoList(slot0, slot1)
	if not slot0._infos or #slot0._infos <= 0 then
		return {}
	end

	slot4 = 0
	slot5 = 0

	for slot9, slot10 in ipairs(slot0._infos) do
		slot11 = 0

		if type(slot10) == "number" then
			slot11 = GameUtil.getTextHeightByLine(gohelper.findChildText(slot1, "Viewport/logcontent/storylogitem/go_normal/txt_content"), GameUtil.filterRichText(StoryStepModel.instance:getStepListById(slot10).conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]), 42.35294, 13.96) + 80 - 42.35294 + 31.41

			if type(slot5) == "number" and slot5 > 0 then
				if StoryStepModel.instance:getStepListById(slot5).conversation.type == slot12.type and slot14.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == slot12.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] then
					slot4 = 1
					slot2[slot9 - 1].lineLength = math.max(slot2[slot9 - 1].lineLength - 20, 0)
				else
					slot4 = 0
				end
			else
				slot4 = 0
			end
		elseif type(slot10) == "table" then
			slot11 = 55 * #StoryModel.instance:getStoryBranchOpts(slot10.stepId) + 25
			slot4 = 0
		end

		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot4, slot11, nil))

		slot5 = slot10
	end

	return slot2
end

function slot0.clearData(slot0)
	slot0._infos = nil
end

function slot0.setPlayingLogAudio(slot0, slot1)
	slot0._playingId = slot1
end

function slot0.setPlayingLogAudioFinished(slot0, slot1)
	if slot0._playingId == slot1 then
		slot0._playingId = 0
	end
end

function slot0.getPlayingLogAudioId(slot0)
	return slot0._playingId
end

slot0.instance = slot0.New()

return slot0
