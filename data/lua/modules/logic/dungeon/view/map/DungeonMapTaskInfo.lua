module("modules.logic.dungeon.view.map.DungeonMapTaskInfo", package.seeall)

slot0 = class("DungeonMapTaskInfo", BaseView)

function slot0.onInitView(slot0)
	slot0._gotasklist = gohelper.findChild(slot0.viewGO, "#go_tasklist")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_taskitem")
	slot0._gounlocktip = gohelper.findChild(slot0.viewGO, "#go_unlocktip")
	slot0._txtunlocktitle = gohelper.findChildText(slot0.viewGO, "#go_unlocktip/#txt_unlocktitle")
	slot0._txtunlockprogress = gohelper.findChildText(slot0.viewGO, "#go_unlocktip/#txt_unlockprogress")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._itemList = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0._onChangeFocusEpisodeItem(slot0, slot1)
	if slot1 == slot0._episodeItem then
		return
	end

	slot0._episodeItem = slot1
	slot0._episodeId = slot0._episodeItem:getEpisodeId()

	slot0:_showTaskList(slot0._episodeId)
end

function slot0._showTaskList(slot0, slot1, slot2)
	slot6 = false
	slot7 = DungeonConfig.instance:getUnlockChapterConfig(DungeonConfig.instance:getEpisodeCO(slot1).chapterId) and slot5.chapterIndex ~= "4TH" and slot5 and DungeonModel.instance:chapterIsLock(slot5.id) and DungeonModel.instance:chapterIsPass(slot4)

	gohelper.setActive(slot0._gotasklist, not slot7)
	gohelper.setActive(slot0._gounlocktip, slot7)

	if slot7 then
		slot0._txtunlocktitle.text = formatLuaLang("dungeonmapview_unlocktitle", slot5.name)
		slot8, slot9 = DungeonMapModel.instance:getTotalRewardPointProgress(slot4)
		slot0._txtunlockprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeonmapview_unlockprogress"), {
			slot8,
			slot9
		})

		return
	end

	if slot2 then
		return
	end

	slot0:_doShowTaskList(slot1)
end

function slot0._doShowTaskList(slot0, slot1)
	slot5 = DungeonMapEpisodeItem.getMap(DungeonConfig.instance:getEpisodeCO(slot1))

	for slot9 = #string.splitToNumber(DungeonConfig.instance:getElementList(slot1), "#"), 1, -1 do
		if lua_chapter_map_element.configDict[slot3[slot9]] and slot10.mapId ~= slot5.Id then
			table.remove(slot3, slot9)
		end
	end

	if slot5 and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) and DungeonConfig.instance:getMapElements(slot5.id) then
		for slot10, slot11 in ipairs(slot6) do
			if not tabletool.indexOf(slot3, slot11.id) then
				table.insert(slot3, slot11.id)
			end
		end
	end

	for slot11, slot12 in ipairs(slot3) do
		slot14 = lua_chapter_map_element.configDict[slot12]

		if DungeonModel.instance:hasPassLevelAndStory(slot1) and not DungeonMapModel.instance:elementIsFinished(slot12) and slot14 and slot14.type ~= DungeonEnum.ElementType.UnLockExplore and slot14.type ~= DungeonEnum.ElementType.Investigate and not ToughBattleConfig.instance:isActEleCo(slot14) then
			slot7 = 0 + 1
			slot15 = slot0:_getItem(slot7)

			slot15:setParam({
				slot7,
				slot12
			})
			gohelper.setActive(slot15.viewGO, true)
		end
	end

	for slot11 = slot7 + 1, #slot0._itemList do
		slot0._itemList[slot11]:playTaskOutAnim()
	end
end

function slot0._getItem(slot0, slot1)
	if not slot0._itemList[slot1] then
		slot0._itemList[slot1] = MonoHelper.addLuaComOnceToGo(gohelper.cloneInPlace(slot0._gotaskitem), DungeonMapTaskInfoItem)
	end

	return slot2
end

function slot0.onOpen(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, slot0._onChangeFocusEpisodeItem, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0._OnRemoveElement, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0._beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0._endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.GuideShowElementAnimFinish, slot0._guideShowElementAnimFinish, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
end

function slot0._onUpdateDungeonInfo(slot0)
	slot0:_showTaskList(slot0._episodeId, true)
end

function slot0._guideShowElementAnimFinish(slot0)
	slot0:_updateTaskList()
end

function slot0._beginShowRewardView(slot0)
	slot0._showRewardView = true
end

function slot0._endShowRewardView(slot0)
	slot0._showRewardView = false

	TaskDispatcher.runDelay(slot0._updateTaskList, slot0, DungeonEnum.RefreshTimeAfterShowReward)
end

function slot0._updateTaskList(slot0)
	slot0:_showTaskList(slot0._episodeId)
end

function slot0._OnRemoveElement(slot0, slot1)
	if slot0._showRewardView then
		return
	end

	slot0:_updateTaskList()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._updateTaskList, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, slot0._onChangeFocusEpisodeItem, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0._OnRemoveElement, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0._beginShowRewardView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0._endShowRewardView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.GuideShowElementAnimFinish, slot0._guideShowElementAnimFinish, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
