module("modules.spine.SpineVoiceTextHelper", package.seeall)

slot0 = class("SpineVoiceTextHelper")

function slot0.getSeparateContent(slot0, slot1, slot2)
	slot3 = {}

	table.insert(slot3, uv0.getSeparateMarks(slot0.content))
	table.insert(slot3, uv0.getSeparateMarks(slot0.twcontent))
	table.insert(slot3, uv0.getSeparateMarks(slot0.encontent))
	table.insert(slot3, uv0.getSeparateMarks(slot0.kocontent))
	table.insert(slot3, uv0.getSeparateMarks(slot0.jpcontent))
	table.insert(slot3, uv0.getSeparateMarks(slot0.decontent))
	table.insert(slot3, uv0.getSeparateMarks(slot0.frcontent))
	table.insert(slot3, uv0.getSeparateMarks(slot0.thaicontent))

	slot4 = ""

	if slot1 == LanguageEnum.LanguageStoryType.CN then
		slot4 = slot0.content
	elseif slot1 == LanguageEnum.LanguageStoryType.TW then
		slot4 = slot0.twcontent
	elseif slot1 == LanguageEnum.LanguageStoryType.EN then
		slot4 = slot0.encontent
	elseif slot1 == LanguageEnum.LanguageStoryType.KR then
		slot4 = slot0.kocontent
	elseif slot1 == LanguageEnum.LanguageStoryType.JP then
		slot4 = slot0.jpcontent
	elseif slot1 == LanguageEnum.LanguageStoryType.DE then
		slot4 = slot0.decontent
	elseif slot1 == LanguageEnum.LanguageStoryType.FR then
		slot4 = slot0.frcontent
	elseif slot1 == LanguageEnum.LanguageStoryType.THAI then
		slot4 = slot0.thaicontent
	end

	for slot9, slot10 in ipairs(slot3[slot1]) do
		slot4 = string.gsub(slot4, "(#%d+%.?%d?%d?)", "<sep>" .. slot9 .. "</sep>", 1)
	end

	slot6 = 0

	if (slot0.audio == nil or slot0.audio == 0) and #slot3[slot2] == 0 then
		slot7 = slot3[slot1]
	end

	for slot11 in string.gmatch(slot4, "<sep>%d+</sep>") do
		slot4 = string.gsub(slot4, "<sep>" .. slot6 .. "</sep>", slot7[slot6 + 1] or "#0")
	end

	return StoryModel.instance:getStoryTxtByVoiceType(slot4, slot0.audio)
end

function slot0.getSeparateMarks(slot0)
	slot1 = {}

	for slot6 in string.gmatch(slot0, "(#%d+%.?%d?)") do
		table.insert(slot1, slot6)
	end

	return slot1
end

return slot0
