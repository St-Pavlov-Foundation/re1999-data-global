module("modules.logic.dungeon.view.chapter.DungeonChapterUnlockItem", package.seeall)

slot0 = class("DungeonChapterUnlockItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._gotemplate = gohelper.findChild(slot0.viewGO, "#go_item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, slot1)
	slot0._config = slot1
end

function slot0._editableInitView(slot0)
	slot0:_showUnlockContent()
	slot0:_showBeUnlockEpisode()
	gohelper.setActive(slot0.viewGO, false)
	TaskDispatcher.runDelay(slot0._delayShow, slot0, 0.7)
end

function slot0._delayShow(slot0)
	gohelper.setActive(slot0.viewGO, true)
end

function slot0._showUnlockContent(slot0)
	for slot5, slot6 in ipairs(uv0.getUnlockContentList(slot0._config.id)) do
		slot7 = gohelper.clone(slot0._gotemplate, slot0._gocontainer)

		gohelper.setActive(slot7, true)
		UISpriteSetMgr.instance:setUiFBSprite(gohelper.findChildImage(slot7, "#image_icon"), "jiesuo", true)

		gohelper.findChildTextMesh(slot7, "#txt_condition").text = slot6
	end
end

function slot0.getUnlockContentList(slot0, slot1)
	if DungeonModel.instance:isReactivityEpisode(slot0) then
		return {}
	end

	if OpenConfig.instance:getOpenShowInEpisode(slot0) then
		for slot7, slot8 in ipairs(slot3) do
			slot9 = lua_open.configDict[slot8]
			slot10 = nil

			if slot1 and slot9 and slot9.bindActivityId ~= 0 then
				if ActivityHelper.getActivityStatus(slot9.bindActivityId) == ActivityEnum.ActivityStatus.Normal then
					slot10 = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.ActivityOpen, slot8)
				end
			else
				slot10 = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.Open, slot8)
			end

			if slot10 then
				table.insert(slot2, slot10)
			end
		end
	end

	if DungeonConfig.instance:getUnlockEpisodeList(slot0) then
		for slot8, slot9 in ipairs(slot4) do
			if DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.Episode, slot9) then
				table.insert(slot2, slot10)
			end
		end
	end

	if OpenConfig.instance:getOpenGroupShowInEpisode(slot0) then
		for slot9, slot10 in ipairs(slot5) do
			if DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.OpenGroup, slot10) then
				table.insert(slot2, slot11)
			end
		end
	end

	return slot2
end

function slot0._showBeUnlockEpisode(slot0)
	if slot0._config.unlockEpisode <= 0 or DungeonModel.instance:hasPassLevelAndStory(slot0._config.id) then
		return
	end

	slot1 = gohelper.clone(slot0._gotemplate, slot0._gocontainer)

	gohelper.setActive(slot1, true)
	UISpriteSetMgr.instance:setUiFBSprite(gohelper.findChildImage(slot1, "#image_icon"), "suo1", true)

	slot4 = DungeonConfig.instance:getEpisodeCO(slot0._config.unlockEpisode)
	gohelper.findChildTextMesh(slot1, "#txt_condition").text = formatLuaLang("dungeon_unlock_episode", string.format("%s %s", DungeonController.getEpisodeName(slot4), slot4.name))
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._delayShow, slot0)
end

return slot0
