module("modules.logic.sp01.odyssey.controller.OdysseyController", package.seeall)

local var_0_0 = class("OdysseyController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_3_0.onDailyRefresh, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0.onUpdateTaskList, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_3_0.onSetTaskList, arg_3_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, arg_3_0.setAddOuterItemData, arg_3_0)
end

function var_0_0.onDailyRefresh(arg_4_0)
	if not ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Dungeon2) then
		return
	end

	OdysseyRpc.instance:sendOdysseyGetInfoRequest(function()
		var_0_0.instance:dispatchEvent(OdysseyEvent.DailyRefresh)
	end, arg_4_0)
end

function var_0_0.onUpdateTaskList(arg_6_0, arg_6_1)
	if OdysseyTaskModel.instance:updateTaskInfo(arg_6_1.taskInfo) then
		OdysseyTaskModel.instance:refreshList()
	end

	arg_6_0:checkTaskReddotShow()
	arg_6_0:dispatchEvent(OdysseyEvent.OdysseyTaskUpdated)
end

function var_0_0.onSetTaskList(arg_7_0)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.OdysseyLevelReward,
		RedDotEnum.DotNode.OdysseyTask
	})
	OdysseyTaskModel.instance:setTaskInfoList()
	OdysseyTaskModel.instance:refreshList()
	arg_7_0:checkTaskReddotShow()
	arg_7_0:dispatchEvent(OdysseyEvent.OdysseyTaskUpdated)
end

function var_0_0.checkTaskReddotShow(arg_8_0)
	local var_8_0 = OdysseyTaskModel.instance:checkHasLevelReawrdTaskCanGet() and 1 or 0
	local var_8_1 = OdysseyTaskModel.instance:checkHasNormalTaskCanGet() and 1 or 0
	local var_8_2 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.OdysseyLevelReward,
			value = var_8_0
		},
		{
			uid = 0,
			id = RedDotEnum.DotNode.OdysseyTask,
			value = var_8_1
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_8_2, true)
end

function var_0_0.showItemTipView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.OdysseyItemTipView, arg_9_1)
end

function var_0_0.openTalentTreeView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.OdysseyTalentTreeView, arg_10_1)
end

function var_0_0.openLibraryView(arg_11_0, arg_11_1)
	AssassinController.instance:openAssassinLibraryView(VersionActivity2_9Enum.ActivityId.Dungeon2, arg_11_1 or AssassinEnum.LibraryType.Hero)
end

function var_0_0.openTaskView(arg_12_0)
	OdysseyTaskModel.instance:setCurSelectTaskTypeAndGroupId(OdysseyEnum.TaskType.NormalTask, OdysseyEnum.TaskGroupType.Story)
	OdysseyTaskModel.instance:refreshList()
	ViewMgr.instance:openView(ViewName.OdysseyTaskView)
end

function var_0_0.openHeroGroupView(arg_13_0, arg_13_1)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	HeroGroupModel.instance:setParam(nil, nil, nil, nil, DungeonEnum.EpisodeType.Odyssey)

	if arg_13_1 == nil then
		arg_13_1 = {}
	end

	arg_13_1.heroGroupType = OdysseyEnum.HeroGroupType.Prepare

	ViewMgr.instance:openView(ViewName.OdysseyHeroGroupView, arg_13_1)
end

function var_0_0.openEquipView(arg_14_0, arg_14_1)
	ViewMgr.instance:openView(ViewName.OdysseyEquipView, arg_14_1)
end

function var_0_0.openFightSuccView(arg_15_0)
	local var_15_0 = OdysseyModel.instance:getFightResultInfo()

	if var_15_0 and var_15_0:checkFightTypeIsMyth() then
		ViewMgr.instance:openView(ViewName.OdysseyMythSuccessView)
	else
		ViewMgr.instance:openView(ViewName.OdysseySuccessView)
	end
end

function var_0_0.openBagView(arg_16_0, arg_16_1)
	ViewMgr.instance:openView(ViewName.OdysseyBagView, arg_16_1)
end

function var_0_0.openSuitTipsView(arg_17_0, arg_17_1)
	ViewMgr.instance:openView(ViewName.OdysseySuitTipView, arg_17_1)
end

function var_0_0.setAddOuterItemData(arg_18_0, arg_18_1)
	OdysseyDungeonModel.instance:setCurFightEpisodeId(nil)
	OdysseyItemModel.instance:setAddOuterItem(arg_18_1.firstBonus or {})
end

var_0_0.instance = var_0_0.New()

return var_0_0
