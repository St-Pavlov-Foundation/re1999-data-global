module("modules.logic.dungeon.view.map.DungeonMapTaskInfo", package.seeall)

local var_0_0 = class("DungeonMapTaskInfo", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotasklist = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist/#go_taskitem")
	arg_1_0._gounlocktip = gohelper.findChild(arg_1_0.viewGO, "#go_unlocktip")
	arg_1_0._txtunlocktitle = gohelper.findChildText(arg_1_0.viewGO, "#go_unlocktip/#txt_unlocktitle")
	arg_1_0._txtunlockprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_unlocktip/#txt_unlockprogress")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._itemList = arg_4_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._onChangeFocusEpisodeItem(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0._episodeItem then
		return
	end

	arg_6_0._episodeItem = arg_6_1
	arg_6_0._episodeId = arg_6_0._episodeItem:getEpisodeId()

	arg_6_0:_showTaskList(arg_6_0._episodeId)
end

function var_0_0._showTaskList(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = DungeonConfig.instance:getEpisodeCO(arg_7_1).chapterId
	local var_7_1 = DungeonConfig.instance:getUnlockChapterConfig(var_7_0)
	local var_7_2 = false
	local var_7_3 = not not var_7_1 and var_7_1.chapterIndex ~= "4TH" and var_7_1 and DungeonModel.instance:chapterIsLock(var_7_1.id) and DungeonModel.instance:chapterIsPass(var_7_0)

	gohelper.setActive(arg_7_0._gotasklist, not var_7_3)
	gohelper.setActive(arg_7_0._gounlocktip, var_7_3)

	if var_7_3 then
		arg_7_0._txtunlocktitle.text = formatLuaLang("dungeonmapview_unlocktitle", var_7_1.name)

		local var_7_4, var_7_5 = DungeonMapModel.instance:getTotalRewardPointProgress(var_7_0)
		local var_7_6 = {
			var_7_4,
			var_7_5
		}

		arg_7_0._txtunlockprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeonmapview_unlockprogress"), var_7_6)

		return
	end

	if arg_7_2 then
		return
	end

	arg_7_0:_doShowTaskList(arg_7_1)
end

function var_0_0._doShowTaskList(arg_8_0, arg_8_1)
	local var_8_0 = DungeonConfig.instance:getElementList(arg_8_1)
	local var_8_1 = string.splitToNumber(var_8_0, "#")
	local var_8_2 = DungeonConfig.instance:getEpisodeCO(arg_8_1)
	local var_8_3 = DungeonMapEpisodeItem.getMap(var_8_2)

	for iter_8_0 = #var_8_1, 1, -1 do
		local var_8_4 = lua_chapter_map_element.configDict[var_8_1[iter_8_0]]

		if var_8_4 and var_8_4.mapId ~= var_8_3.Id then
			table.remove(var_8_1, iter_8_0)
		end
	end

	if var_8_3 and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		local var_8_5 = DungeonConfig.instance:getMapElements(var_8_3.id)

		if var_8_5 then
			for iter_8_1, iter_8_2 in ipairs(var_8_5) do
				if not tabletool.indexOf(var_8_1, iter_8_2.id) then
					table.insert(var_8_1, iter_8_2.id)
				end
			end
		end
	end

	local var_8_6 = DungeonModel.instance:hasPassLevelAndStory(arg_8_1)
	local var_8_7 = 0

	for iter_8_3, iter_8_4 in ipairs(var_8_1) do
		local var_8_8 = var_8_6 and not DungeonMapModel.instance:elementIsFinished(iter_8_4)
		local var_8_9 = lua_chapter_map_element.configDict[iter_8_4]

		if var_8_8 and var_8_9 and var_8_9.type ~= DungeonEnum.ElementType.UnLockExplore and var_8_9.type ~= DungeonEnum.ElementType.Investigate and not ToughBattleConfig.instance:isActEleCo(var_8_9) then
			var_8_7 = var_8_7 + 1

			local var_8_10 = arg_8_0:_getItem(var_8_7)

			var_8_10:setParam({
				var_8_7,
				iter_8_4
			})
			gohelper.setActive(var_8_10.viewGO, true)
		end
	end

	for iter_8_5 = var_8_7 + 1, #arg_8_0._itemList do
		arg_8_0._itemList[iter_8_5]:playTaskOutAnim()
	end
end

function var_0_0._getItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._itemList[arg_9_1]

	if not var_9_0 then
		local var_9_1 = gohelper.cloneInPlace(arg_9_0._gotaskitem)

		var_9_0 = MonoHelper.addLuaComOnceToGo(var_9_1, DungeonMapTaskInfoItem)
		arg_9_0._itemList[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, arg_10_0._onChangeFocusEpisodeItem, arg_10_0)
	arg_10_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_10_0._OnRemoveElement, arg_10_0)
	arg_10_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_10_0._beginShowRewardView, arg_10_0)
	arg_10_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_10_0._endShowRewardView, arg_10_0)
	arg_10_0:addEventCb(DungeonController.instance, DungeonEvent.GuideShowElementAnimFinish, arg_10_0._guideShowElementAnimFinish, arg_10_0)
	arg_10_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_10_0._onUpdateDungeonInfo, arg_10_0)
end

function var_0_0._onUpdateDungeonInfo(arg_11_0)
	arg_11_0:_showTaskList(arg_11_0._episodeId, true)
end

function var_0_0._guideShowElementAnimFinish(arg_12_0)
	arg_12_0:_updateTaskList()
end

function var_0_0._beginShowRewardView(arg_13_0)
	arg_13_0._showRewardView = true
end

function var_0_0._endShowRewardView(arg_14_0)
	arg_14_0._showRewardView = false

	TaskDispatcher.runDelay(arg_14_0._updateTaskList, arg_14_0, DungeonEnum.RefreshTimeAfterShowReward)
end

function var_0_0._updateTaskList(arg_15_0)
	arg_15_0:_showTaskList(arg_15_0._episodeId)
end

function var_0_0._OnRemoveElement(arg_16_0, arg_16_1)
	if arg_16_0._showRewardView then
		return
	end

	arg_16_0:_updateTaskList()
end

function var_0_0.onClose(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._updateTaskList, arg_17_0)
	arg_17_0:removeEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, arg_17_0._onChangeFocusEpisodeItem, arg_17_0)
	arg_17_0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_17_0._OnRemoveElement, arg_17_0)
	arg_17_0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_17_0._beginShowRewardView, arg_17_0)
	arg_17_0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_17_0._endShowRewardView, arg_17_0)
	arg_17_0:removeEventCb(DungeonController.instance, DungeonEvent.GuideShowElementAnimFinish, arg_17_0._guideShowElementAnimFinish, arg_17_0)
	arg_17_0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_17_0._onUpdateDungeonInfo, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
