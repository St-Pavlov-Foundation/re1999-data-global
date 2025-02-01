module("modules.logic.dungeon.view.map.DungeonMapTaskInfoItem", package.seeall)

slot0 = class("DungeonMapTaskInfoItem", LuaCompBase)

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

	uv0.setIcon(slot0._icon, slot0._elementId, "zhuxianditu_renwuicon_")
	slot0:refreshStatus()
end

function slot0.setIcon(slot0, slot1, slot2)
	UISpriteSetMgr.instance:setUiFBSprite(slot0, slot2 .. (DungeonEnum.ElementTypeUIResIdMap[lua_chapter_map_element.configDict[slot1].type] or slot3.type) .. (DungeonMapModel.instance:elementIsFinished(slot1) and 1 or 0))
end

function slot0.refreshStatus(slot0)
	if DungeonMapModel.instance:elementIsFinished(slot0._elementId) then
		slot2 = GameUtil.parseColor("#c66030")
		slot0._txtinfo.color = slot2
		slot0._icon.color = slot2
	else
		slot0._txtinfo.color = GameUtil.parseColor("#ded9d4")
		slot0._icon.color = GameUtil.parseColor("#a1a3a6")
	end
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "info")
	slot0._icon = gohelper.findChildImage(slot1, "icon")
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.playTaskOutAnim(slot0)
	if slot0.viewGO.activeInHierarchy then
		slot0._anim:Play("taskitem_out")
		TaskDispatcher.cancelTask(slot0._hideGo, slot0)
		TaskDispatcher.runDelay(slot0._hideGo, slot0, 0.24)
	end
end

function slot0._hideGo(slot0)
	gohelper.setActive(slot0.viewGO, false)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._setEpisodeListVisible, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._setEpisodeListVisible(slot0, slot1)
	if slot1 then
		slot0._anim:Play("taskitem_in", 0, 0)
	else
		slot0._anim:Play("taskitem_out", 0, 0)
	end
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._hideGo, slot0)
end

function slot0._playEnterAnim(slot0, slot1)
	if slot1 == ViewName.DungeonMapTaskView then
		slot0._anim:Play("taskitem_in", 0, 0)
	end
end

function slot0._playOutAnim(slot0, slot1)
	if slot1 == ViewName.DungeonMapTaskView then
		slot0._anim:Play("taskitem_out", 0, 0)
	end
end

return slot0
