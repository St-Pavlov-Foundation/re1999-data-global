module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_MapElement105Item", package.seeall)

slot0 = class("VersionActivity_1_2_MapElement105Item", BaseViewExtended)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._onClick(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, slot0._elementId)
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._elementId = slot1
	slot0._elementConfig = lua_chapter_map_element.configDict[slot1]
	slot0._episodeConfig = DungeonConfig.instance:getEpisodeCO(tonumber(slot0._elementConfig.param))
	slot0.leftChallenge = 10
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
