module("modules.logic.herogroup.view.HeroGroupFightWeekWalkView", package.seeall)

local var_0_0 = class("HeroGroupFightWeekWalkView", BaseView)

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
	if arg_7_0._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk then
		return
	end

	local var_7_0 = WeekWalkModel.instance:getCurMapInfo()

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:getLayer()

	if var_7_1 < WeekWalkEnum.FirstDeepLayer then
		return
	end

	local var_7_2 = HeroGroupModel.instance.battleId
	local var_7_3 = var_7_0:getBattleInfo(var_7_2)

	if not var_7_3 then
		return
	end

	local var_7_4 = HeroGroupModel.instance.curGroupSelectIndex
	local var_7_5 = var_7_1 == WeekWalkEnum.FirstDeepLayer and var_7_3.heroGroupSelect ~= var_7_4
	local var_7_6 = var_7_1 ~= WeekWalkEnum.FirstDeepLayer and var_7_3.heroGroupSelect ~= 0 and var_7_3.heroGroupSelect ~= var_7_4

	if var_7_5 or var_7_6 then
		WeekwalkRpc.instance:sendChangeWeekwalkHeroGroupSelectRequest(var_7_0.id, var_7_2, var_7_4)
	end

	if var_7_1 ~= WeekWalkEnum.FirstDeepLayer and var_7_3.heroGroupSelect == 0 then
		local var_7_7 = WeekWalkModel.instance:getBattleInfoByLayerAndIndex(var_7_1 - 1, var_7_3.index)

		if var_7_7 and var_7_7.heroGroupSelect ~= 0 then
			local var_7_8 = var_7_7.heroGroupSelect - 1

			if var_7_8 >= 0 and var_7_8 <= 3 then
				arg_7_0._changeIndex = var_7_8

				if var_7_7.heroGroupSelect == var_7_4 then
					arg_7_0:_updateWeekWalkGroupSelectIndex()

					return
				end

				UIBlockMgrExtend.setNeedCircleMv(false)
				UIBlockMgr.instance:startBlock("HeroGroupFightWeekWalkViewChangeGroup")
				TaskDispatcher.cancelTask(arg_7_0._changeGroupIndex, arg_7_0)

				local var_7_9 = arg_7_0:_anyHeroInCd() and 2.2 or 0.8

				TaskDispatcher.runDelay(arg_7_0._changeGroupIndex, arg_7_0, var_7_9)
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
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalkViewChangeGroup")

	local var_9_0 = arg_9_0.viewContainer:getHeroGroupFightView()

	var_9_0:setGroupChangeToast(ToastEnum.WeekWalkChangeGroup)
	arg_9_0._dropherogroup:SetValue(arg_9_0._changeIndex)
	var_9_0:setGroupChangeToast(nil)
end

function var_0_0._updateWeekWalkGroupSelectIndex(arg_10_0)
	if arg_10_0._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk then
		return
	end

	local var_10_0 = WeekWalkModel.instance:getCurMapInfo()

	if not var_10_0 then
		return
	end

	if var_10_0:getLayer() < WeekWalkEnum.FirstDeepLayer then
		return
	end

	local var_10_1 = HeroGroupModel.instance.battleId
	local var_10_2 = var_10_0:getBattleInfo(var_10_1)

	if not var_10_2 then
		return
	end

	local var_10_3 = HeroGroupModel.instance.curGroupSelectIndex

	if var_10_2.heroGroupSelect ~= var_10_3 then
		WeekwalkRpc.instance:sendChangeWeekwalkHeroGroupSelectRequest(var_10_0.id, var_10_1, var_10_3)
	end
end

function var_0_0.onClose(arg_11_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalkViewChangeGroup")
	TaskDispatcher.cancelTask(arg_11_0._changeGroupIndex, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._setWeekWalkGroupSelectIndex, arg_11_0)
end

return var_0_0
