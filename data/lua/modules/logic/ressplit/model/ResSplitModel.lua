module("modules.logic.ressplit.model.ResSplitModel", package.seeall)

slot0 = class("ResSplitModel", BaseModel)

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0._excludeDic = {}
	slot0._excludeStoryIdsDic = {}
	slot0.audioDic = slot3
	slot0._includeCharacterIdDic = slot1
	slot0._includeChapterIdDic = slot2
	slot0._includeStoryIdDic = slot4
	slot0._includeGuideIdDic = slot5
	slot0._includeSkinDic = {}
	slot0._includeSkillDic = {}
	slot0._includeTimelineDic = {}
	slot0.includeSeasonDic = slot8
	slot0._innerBGMWenDic = {}

	for slot12, slot13 in pairs(slot6) do
		uv0.instance:setExclude(ResSplitEnum.Video, slot12, false)
	end

	for slot12, slot13 in pairs(slot7) do
		uv0.instance:setExclude(ResSplitEnum.Path, slot12, false)
	end
end

function slot0.isExcludeCharacter(slot0, slot1)
	return slot0._includeCharacterIdDic[slot1] ~= true
end

function slot0.addIncludeChapter(slot0, slot1)
	slot0._includeChapterIdDic[slot1] = true
end

function slot0.isExcludeChapter(slot0, slot1)
	return slot0._includeChapterIdDic[slot1] ~= true
end

function slot0.isExcludeSkin(slot0, slot1)
	return slot0._includeSkinDic[slot1] ~= true
end

function slot0.isExcludeStoryId(slot0, slot1)
	return slot0._includeStoryIdDic[slot1] ~= true
end

function slot0.addIncludeStory(slot0, slot1)
	slot0._includeStoryIdDic[slot1] = true
end

function slot0.addIncludeSkin(slot0, slot1)
	slot0._includeSkinDic[slot1] = true
end

function slot0.addIncludeSkill(slot0, slot1)
	slot0._includeSkillDic[slot1] = true
end

function slot0.addInnerBGMWenDic(slot0, slot1)
	slot0._innerBGMWenDic[slot1] = true
end

function slot0.getInnerBGMWenDic(slot0)
	return slot0._innerBGMWenDic
end

function slot0.addIncludeTimeline(slot0, slot1)
	slot0._includeTimelineDic[slot1] = true
end

function slot0.getIncludeSkill(slot0)
	return slot0._includeSkillDic
end

function slot0.getIncludeGuide(slot0)
	return slot0._includeGuideIdDic
end

function slot0.getIncludeTimelineDic(slot0)
	return slot0._includeTimelineDic
end

function slot0.setExclude(slot0, slot1, slot2, slot3)
	if slot0._excludeDic[slot1] == nil then
		slot0._excludeDic[slot1] = {}
	end

	if slot0._excludeDic[slot1][slot2] ~= false then
		slot4[slot2] = slot3
	end
end

function slot0.getExcludeDic(slot0, slot1)
	return slot0._excludeDic[slot1]
end

slot0.instance = slot0.New()

return slot0
