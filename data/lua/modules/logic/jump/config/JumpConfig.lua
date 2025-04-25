module("modules.logic.jump.config.JumpConfig", package.seeall)

slot0 = class("JumpConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._jumpConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"jump"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "jump" then
		slot0._jumpConfig = slot2
	end
end

function slot0.getJumpConfig(slot0, slot1)
	if not tonumber(slot1) or slot1 == 0 then
		logError("jumpId为空")

		return nil
	end

	if not slot0._jumpConfig.configDict[slot1] then
		logError("没有找到跳转配置, jumpId: " .. tostring(slot1))
	end

	return slot2
end

function slot0.getJumpName(slot0, slot1, slot2)
	if slot0:getJumpConfig(slot1) then
		if string.nilorempty(slot3.param) then
			logError("跳转参数为空")

			return ""
		end

		slot5 = slot2 or "#3f485f"

		if tonumber(string.split(slot4, "#")[1]) == JumpEnum.JumpView.DungeonViewWithEpisode then
			return slot0:getEpisodeNameAndIndex(tonumber(slot6[2]))
		elseif slot7 == JumpEnum.JumpView.DungeonViewWithChapter then
			slot9 = DungeonConfig.instance:getChapterCO(tonumber(slot6[2]))
			slot10 = slot9.chapterIndex

			if slot9 then
				return string.format("<color=%s><size=32>%s</size></color>", slot5, slot3.name), ""
			end
		elseif slot7 == JumpEnum.JumpView.Show then
			return slot3.name or ""
		else
			return string.format("<color=%s><size=32>%s</size></color>", slot5, slot3.name) or ""
		end

		logError("跳转参数错误: " .. slot4)

		return ""
	end

	return ""
end

function slot0.getEpisodeNameAndIndex(slot0, slot1)
	if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot1).chapterId) and slot3.type == DungeonEnum.ChapterType.Hard then
		slot3 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot2.preEpisode).chapterId)
	end

	if slot2 and slot3 then
		slot4 = slot3.chapterIndex
		slot5, slot6 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot3.id, slot2.id)

		if slot6 == DungeonEnum.EpisodeType.Sp then
			slot4 = "SP"
		end

		return string.format("<color=#3f485f><size=32>%s</size></color>", slot2.name), string.format("%s-%s", slot4, slot5)
	end
end

function slot0.getJumpEpisodeId(slot0, slot1)
	if tonumber(string.split(slot0:getJumpConfig(slot1).param, "#")[1]) == JumpEnum.JumpView.DungeonViewWithEpisode then
		return tonumber(slot4[2])
	end
end

function slot0.getJumpView(slot0, slot1)
	if not slot1 then
		return nil
	end

	return tonumber(string.split(slot0:getJumpConfig(slot1).param, "#")[1])
end

function slot0.isJumpHardDungeon(slot0, slot1)
	slot2 = slot1 and DungeonConfig.instance:getEpisodeCO(slot1)
	slot3 = slot2 and DungeonConfig.instance:getChapterCO(slot2.chapterId)

	return slot3 and slot3.type == DungeonEnum.ChapterType.Hard
end

function slot0.isOpenJumpId(slot0, slot1)
	if VersionValidator.instance:isInReviewing() ~= true then
		return true
	end

	if tonumber(string.split(slot0:getJumpConfig(slot1).param, "#")[1]) == JumpEnum.JumpView.DungeonViewWithEpisode then
		if tonumber(slot4[2]) and DungeonConfig.instance:getEpisodeCO(slot6) then
			return ResSplitConfig.instance:isSaveChapter(slot7.chapterId)
		end
	elseif slot5 == JumpEnum.JumpView.NoticeView then
		return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Notice)
	end

	return true
end

slot0.instance = slot0.New()

return slot0
