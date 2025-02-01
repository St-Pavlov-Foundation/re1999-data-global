module("modules.logic.dungeon.view.map.DungeonMapTaskItem", package.seeall)

slot0 = class("DungeonMapTaskItem", DungeonMapTaskInfoItem)

function slot0.setParam(slot0, slot1)
	if slot0._anim and (not slot0.viewGO.activeInHierarchy or slot0._elementId ~= slot1[2]) then
		slot0._anim:Play("taskitem_in", 0, 0)
	end

	slot0._index = slot1[1]
	slot0._elementId = slot1[2]

	if not lua_chapter_map_element.configDict[slot0._elementId] then
		logError("元件表找不到元件id:" .. slot0._elementId)
	end

	slot0._txtinfo.text = slot2.title

	if slot0:_showIcon(slot2) then
		DungeonMapTaskInfoItem.setIcon(slot0._icon, slot0._elementId, "zhuxianditu_renwuicon_")
		gohelper.setActive(slot0._icon, true)
	else
		gohelper.setActive(slot0._icon, false)
	end

	slot0:refreshStatus()
end

function slot0._showIcon(slot0, slot1)
	if slot1.type == DungeonEnum.ElementType.Investigate then
		return false
	end

	return true
end

function slot0.refreshStatus(slot0)
	if DungeonMapModel.instance:elementIsFinished(slot0._elementId) then
		slot2 = GameUtil.parseColor("#272525b2")
		slot0._txtinfo.color = slot2
		slot0._txtprogress.color = slot2
		slot0._icon.color = GameUtil.parseColor("#b2562b")
		slot0._txtprogress.text = "1/1"
	else
		slot2 = GameUtil.parseColor("#272525")
		slot0._txtinfo.color = slot2
		slot0._txtprogress.color = slot2
		slot0._icon.color = GameUtil.parseColor("#81807f")
		slot0._txtprogress.text = "0/1"
	end
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "progress")
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
end

return slot0
