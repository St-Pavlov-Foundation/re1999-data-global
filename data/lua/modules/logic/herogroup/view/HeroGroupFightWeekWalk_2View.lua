module("modules.logic.herogroup.view.HeroGroupFightWeekWalk_2View", package.seeall)

local var_0_0 = class("HeroGroupFightWeekWalk_2View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._dropherogroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_2_0._onModifyGroupSelectIndex, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onModifyGroupSelectIndex(arg_4_0)
	arg_4_0:_updateWeekWalkGroupSelectIndex()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._episodeId = HeroGroupModel.instance.episodeId
	arg_5_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_5_0._episodeId)
	arg_5_0._chapterConfig = DungeonConfig.instance:getChapterCO(arg_5_0.episodeConfig.chapterId)
end

function var_0_0.onOpenFinish(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._setWeekWalkGroupSelectIndex, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._setWeekWalkGroupSelectIndex, arg_6_0, 0)
end

function var_0_0._setWeekWalkGroupSelectIndex(arg_7_0)
	if arg_7_0._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk_2 then
		return
	end

	local var_7_0 = WeekWalk_2Model.instance:getCurMapInfo()
	local var_7_1 = var_7_0:getLayer()
	local var_7_2 = HeroGroupModel.instance.battleId
	local var_7_3 = var_7_0:getBattleInfoByBattleId(var_7_2)
	local var_7_4 = HeroGroupModel.instance.curGroupSelectIndex
	local var_7_5 = var_7_1 == WeekWalk_2Enum.FirstDeepLayer and var_7_3.heroGroupSelect ~= var_7_4
	local var_7_6 = var_7_1 ~= WeekWalk_2Enum.FirstDeepLayer and var_7_3.heroGroupSelect ~= 0 and var_7_3.heroGroupSelect ~= var_7_4

	if var_7_5 or var_7_6 then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChangeHeroGroupSelectRequest(var_7_0.id, var_7_2, var_7_4)
	end

	if var_7_1 ~= WeekWalk_2Enum.FirstDeepLayer and var_7_3.heroGroupSelect == 0 then
		local var_7_7 = WeekWalk_2Model.instance:getBattleInfoByLayerAndIndex(var_7_1 - 1, var_7_3.index)

		if var_7_7 and var_7_7.heroGroupSelect ~= 0 then
			local var_7_8 = var_7_7.heroGroupSelect
			local var_7_9 = HeroGroupPresetHeroGroupChangeController.instance:getValidHeroGroupId(HeroGroupModel.instance:getPresetHeroGroupType(), var_7_8)

			if var_7_9 then
				arg_7_0._changeIndex = var_7_9

				if var_7_9 == var_7_4 then
					arg_7_0:_updateWeekWalkGroupSelectIndex()

					return
				end

				UIBlockMgrExtend.setNeedCircleMv(false)
				UIBlockMgr.instance:startBlock("HeroGroupFightWeekWalk_2ViewChangeGroup")
				TaskDispatcher.cancelTask(arg_7_0._changeGroupIndex, arg_7_0)

				local var_7_10 = arg_7_0:_anyHeroInCd() and 2.2 or 0.8

				TaskDispatcher.runDelay(arg_7_0._changeGroupIndex, arg_7_0, var_7_10)
			end
		end
	end
end

function var_0_0._anyHeroInCd(arg_8_0)
	for iter_8_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_8_0 = HeroSingleGroupModel.instance:getById(iter_8_0)
		local var_8_1 = var_8_0 and var_8_0:getHeroMO()
		local var_8_2 = var_8_1 and WeekWalkModel.instance:getCurMapHeroCd(var_8_1.config.id)

		if var_8_2 and var_8_2 > 0 then
			return true
		end
	end
end

function var_0_0._changeGroupIndex(arg_9_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalk_2ViewChangeGroup")

	local var_9_0 = arg_9_0.viewContainer:getHeroGroupFightView()

	var_9_0:setGroupChangeToast(ToastEnum.WeekWalkChangeGroup)
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.UseHeroGroup, {
		groupId = ModuleEnum.HeroGroupSnapshotType.Common,
		subId = arg_9_0._changeIndex
	})
	var_9_0:setGroupChangeToast(nil)
end

function var_0_0._updateWeekWalkGroupSelectIndex(arg_10_0)
	if arg_10_0._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk_2 then
		return
	end

	local var_10_0 = WeekWalk_2Model.instance:getCurMapInfo()
	local var_10_1 = var_10_0:getLayer()
	local var_10_2 = HeroGroupModel.instance.battleId
	local var_10_3 = var_10_0:getBattleInfoByBattleId(var_10_2)
	local var_10_4 = HeroGroupModel.instance.curGroupSelectIndex

	if var_10_3.heroGroupSelect ~= var_10_4 then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChangeHeroGroupSelectRequest(var_10_0.id, var_10_2, var_10_4)
	end
end

function var_0_0.onClose(arg_11_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalk_2ViewChangeGroup")
	TaskDispatcher.cancelTask(arg_11_0._changeGroupIndex, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._setWeekWalkGroupSelectIndex, arg_11_0)
end

return var_0_0
