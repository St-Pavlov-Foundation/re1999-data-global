module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapTaskItem", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapTaskItem", DungeonMapTaskItem)

function slot0.setParam(slot0, slot1)
	if slot0._anim and (not slot0.viewGO.activeInHierarchy or slot0._elementId ~= slot1[2]) then
		slot0._anim:Play("taskitem_in", 0, 0)
	end

	slot0._index = slot1[1]
	slot0._elementId = slot1[2]

	if not lua_chapter_map_element.configDict[slot0._elementId] then
		logError("元件表找不到元件id:" .. slot0._elementId)
	end

	if VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(slot0._elementId) then
		slot0._txtinfo.text = slot3.title
	else
		slot0._txtinfo.text = slot2.title
	end

	DungeonMapTaskInfoItem.setIcon(slot0._icon, slot0._elementId, "zhuxianditu_renwuicon_")
	slot0:refreshStatus()
end

return slot0
