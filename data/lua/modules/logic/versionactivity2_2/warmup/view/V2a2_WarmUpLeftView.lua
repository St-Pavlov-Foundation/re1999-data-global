module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView", package.seeall)

slot0 = class("V2a2_WarmUpLeftView", BaseView)

function slot0.onInitView(slot0)
	slot0._middleGo = gohelper.findChild(slot0.viewGO, "Middle")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day1", "V2a2_WarmUpLeftView_Day1")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day2", "V2a2_WarmUpLeftView_Day2")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day3", "V2a2_WarmUpLeftView_Day3")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day4", "V2a2_WarmUpLeftView_Day4")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day5", "V2a2_WarmUpLeftView_Day5")

function slot0._editableInitView(slot0)
	slot0._dayItemList = {}

	for slot4 = 1, 5 do
		slot7 = _G["V2a2_WarmUpLeftView_Day" .. slot4].New({
			parent = slot0,
			baseViewContainer = slot0.viewContainer
		})

		slot7:setIndex(slot4)
		slot7:_internal_setEpisode(slot4)
		slot7:init(gohelper.findChild(slot0._middleGo, "day" .. slot4))

		slot0._dayItemList[slot4] = slot7
	end
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_dayItemList")
end

function slot0.onDataUpdateFirst(slot0)
	slot0._lastEpisodeId = nil

	if isDebugBuild then
		assert(slot0.viewContainer:getEpisodeCount() <= 5, "invalid config json_activity125 actId: " .. slot0.viewContainer:actId())
	end

	slot0:_getItem():onDataUpdateFirst()
end

function slot0.onDataUpdate(slot0)
	slot0:setActiveByEpisode(slot0:_episodeId())
	slot0:_getItem():onDataUpdate()
end

function slot0.onSwitchEpisode(slot0)
	slot0:setActiveByEpisode(slot0:_episodeId())
	slot0:_getItem():onSwitchEpisode()
end

function slot0.setActiveByEpisode(slot0, slot1)
	if slot0._lastEpisodeId then
		slot0:_getItem(slot0._lastEpisodeId):setActive(false)
	end

	slot0._lastEpisodeId = slot1

	slot0:_getItem(slot1):setActive(true)
end

function slot0._episodeId(slot0)
	return slot0.viewContainer:getCurSelectedEpisode()
end

function slot0.episode2Index(slot0, slot1)
	return slot0.viewContainer:episode2Index(slot1 or slot0:_episodeId())
end

function slot0._getItem(slot0, slot1)
	return slot0._dayItemList[slot0:episode2Index(slot1)]
end

return slot0
