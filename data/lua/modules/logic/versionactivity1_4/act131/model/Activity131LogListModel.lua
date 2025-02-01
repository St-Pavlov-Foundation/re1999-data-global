module("modules.logic.versionactivity1_4.act131.model.Activity131LogListModel", package.seeall)

slot0 = class("Activity131LogListModel", MixScrollModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._infos = nil
end

function slot0.setLogList(slot0, slot1)
	slot0._infos = {}
	slot2 = {}

	if slot1 then
		slot0._infos = slot1

		for slot6, slot7 in ipairs(slot1) do
			slot8 = Activity131LogMo.New()

			slot8:init(slot7.speaker, slot7.content, tonumber(string.split(slot7.param, "#")[2]))
			table.insert(slot2, slot8)
		end
	end

	slot0:setList(slot2)
end

function slot0.getInfoList(slot0, slot1)
	if not slot0._infos or #slot0._infos <= 0 then
		return {}
	end

	slot4 = 0
	slot5 = nil

	for slot9, slot10 in ipairs(slot0._infos) do
		slot11 = 0
		slot11 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(gohelper.findChildText(slot1, "Viewport/logcontent/storylogitem/go_normal/txt_content"), GameUtil.filterRichText(slot10.content)) + 13.96

		if slot5 and slot10.speaker == slot5.speaker then
			slot4 = 1
		else
			if slot9 > 1 then
				slot2[slot9 - 1].lineLength = slot2[slot9 - 1].lineLength + 40
			end

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
