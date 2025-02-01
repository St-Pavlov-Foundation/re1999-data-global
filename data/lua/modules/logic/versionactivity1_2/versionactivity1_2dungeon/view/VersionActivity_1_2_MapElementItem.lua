module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_MapElementItem", package.seeall)

slot0 = class("VersionActivity_1_2_MapElementItem", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._icon1 = gohelper.findChild(slot0.viewGO, "ani/icon1/anim")
	slot0._icon2 = gohelper.findChild(slot0.viewGO, "ani/icon2/anim")
	slot0._icon3 = gohelper.findChild(slot0.viewGO, "ani/icon3/anim")

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
	slot0._episodeConfig = VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(slot0._elementId) or DungeonConfig.instance:getEpisodeCO(tonumber(slot0._elementConfig.param))
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._icon2, true)

	gohelper.findChild(slot0._icon2, "num"):GetComponent(typeof(TMPro.TextMeshPro)).text = ""
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
