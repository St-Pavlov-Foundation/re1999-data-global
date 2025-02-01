module("modules.logic.open.config.OpenConfig", package.seeall)

slot0 = class("OpenConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._openConfig = nil
	slot0._opengroupConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"open",
		"open_group",
		"open_lang"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "open" then
		slot0._openConfig = slot2

		slot0:_initOpenConfig()
	elseif slot1 == "open_group" then
		slot0._opengroupConfig = slot2

		slot0:_initOpenGroupConfig()
	elseif slot1 == "open_lang" then
		slot0._openglangConfig = slot2

		slot0:_initOpenLangConfig()
	end
end

function slot0._initOpenConfig(slot0)
	slot0._openShowInEpisodeList = {}

	for slot4, slot5 in ipairs(slot0._openConfig.configList) do
		if slot5.showInEpisode == 1 then
			slot6 = slot0._openShowInEpisodeList[slot5.episodeId] or {}
			slot0._openShowInEpisodeList[slot5.episodeId] = slot6

			table.insert(slot6, slot5.id)
		end
	end
end

function slot0._initOpenGroupConfig(slot0)
	slot0._openGroupShowInEpisodeList = {}

	for slot4, slot5 in ipairs(slot0._opengroupConfig.configList) do
		if slot5.showInEpisode == 1 then
			slot6 = slot0._openGroupShowInEpisodeList[slot5.need_episode] or {}
			slot0._openGroupShowInEpisodeList[slot5.need_episode] = slot6

			table.insert(slot6, slot5.id)
		end
	end
end

function slot0._initOpenLangConfig(slot0)
	slot0._openLangTxtsDic = {}
	slot0._openLangVoiceDic = {}
	slot0._openLangStoryVoiceDic = {}
	slot1 = slot0._openglangConfig.configList[1]
	slot3 = string.split(slot1.langVoice, "#")
	slot4 = string.split(slot1.langStoryVoice, "#")

	for slot8, slot9 in ipairs(string.split(slot1.langTxts, "#")) do
		slot0._openLangTxtsDic[slot9] = true
	end

	for slot8, slot9 in ipairs(slot3) do
		slot0._openLangVoiceDic[slot9] = true
	end

	for slot8, slot9 in ipairs(slot4) do
		slot0._openLangStoryVoiceDic[slot9] = true
	end
end

function slot0.isOpenLangTxt(slot0, slot1)
	return slot0._openLangTxtsDic[slot1]
end

function slot0.isOpenLangVoice(slot0, slot1)
	return slot0._openLangVoiceDic[slot1]
end

function slot0.isOpenLangStoryVoice(slot0, slot1)
	return slot0._openLangStoryVoiceDic[slot1]
end

function slot0.getOpenShowInEpisode(slot0, slot1)
	return slot0._openShowInEpisodeList[slot1]
end

function slot0.getOpenGroupShowInEpisode(slot0, slot1)
	return slot0._openGroupShowInEpisodeList[slot1]
end

function slot0.getOpensCO(slot0)
	return slot0._openConfig.configDict
end

function slot0.getOpenCo(slot0, slot1)
	return slot0._openConfig.configDict[slot1]
end

function slot0.getOpenGroupsCo(slot0)
	return slot0._opengroupConfig.configDict
end

function slot0.getOpenGroupCO(slot0, slot1)
	return slot0._opengroupConfig.configDict[slot1]
end

function slot0.isShowWaterMarkConfig(slot0)
	if not slot0.isShowWaterMark then
		slot0.isShowWaterMark = SLFramework.GameConfig.Instance.ShowWaterMark
	end

	return slot0.isShowWaterMark
end

slot0.instance = slot0.New()

return slot0
