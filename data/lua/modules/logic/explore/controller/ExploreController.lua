module("modules.logic.explore.controller.ExploreController", package.seeall)

local var_0_0 = class("ExploreController", BaseController)

function var_0_0.onInit(arg_1_0)
	ResDispose.open()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0._onUpdateTaskList, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, arg_3_0._onDeleteTaskList, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_3_0._onSetTaskList, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, arg_3_0._onFinishTask, arg_3_0)
	arg_3_0:registerCallback(ExploreEvent.OpenGuideDialogueView, arg_3_0._openGuideDialogue, arg_3_0)
end

function var_0_0._onUpdateTaskList(arg_4_0, arg_4_1)
	local var_4_0 = false

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.taskInfo) do
		if iter_4_1.type == TaskEnum.TaskType.Explore then
			var_4_0 = true

			break
		end
	end

	if var_4_0 then
		ExploreSimpleModel.instance:checkTaskRed()
		var_0_0.instance:dispatchEvent(ExploreEvent.TaskUpdate)
	end
end

function var_0_0._onSetTaskList(arg_5_0)
	ExploreSimpleModel.instance:checkTaskRed()
	var_0_0.instance:dispatchEvent(ExploreEvent.TaskUpdate)
end

function var_0_0._onDeleteTaskList(arg_6_0, arg_6_1)
	local var_6_0 = false

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.taskIds) do
		local var_6_1 = TaskModel.instance:getTaskById(iter_6_1)

		if var_6_1 and var_6_1.type == TaskEnum.TaskType.Explore then
			var_6_0 = true

			break
		end
	end

	if var_6_0 then
		ExploreSimpleModel.instance:checkTaskRed()
		var_0_0.instance:dispatchEvent(ExploreEvent.TaskUpdate)
	end
end

function var_0_0._onFinishTask(arg_7_0, arg_7_1)
	local var_7_0 = TaskModel.instance:getTaskById(arg_7_1)

	if var_7_0 and var_7_0.type == TaskEnum.TaskType.Explore then
		ExploreSimpleModel.instance:checkTaskRed()
		var_0_0.instance:dispatchEvent(ExploreEvent.TaskUpdate)
	end
end

function var_0_0.registerMapComp(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._comps then
		arg_8_0._comps = {}
	end

	arg_8_0._comps[arg_8_1] = arg_8_2
end

function var_0_0.unRegisterMapComp(arg_9_0, arg_9_1)
	if not arg_9_0._comps then
		return
	end

	arg_9_0._comps[arg_9_1] = nil
end

function var_0_0.getMapComp(arg_10_0, arg_10_1)
	if not arg_10_0._comps then
		return
	end

	return arg_10_0._comps[arg_10_1]
end

function var_0_0.getMap(arg_11_0)
	return arg_11_0:getMapComp(ExploreEnum.MapCompType.Map)
end

function var_0_0.getMapLight(arg_12_0)
	return arg_12_0:getMapComp(ExploreEnum.MapCompType.Light)
end

function var_0_0.getMapWhirl(arg_13_0)
	return arg_13_0:getMapComp(ExploreEnum.MapCompType.Whirl)
end

function var_0_0.getMapPipe(arg_14_0)
	return arg_14_0:getMapComp(ExploreEnum.MapCompType.Pipe)
end

function var_0_0.enterExploreScene(arg_15_0, arg_15_1)
	if arg_15_1 then
		ExploreRpc.instance:sendChangeMapRequest(arg_15_1)
	else
		ExploreModel.instance.isFirstEnterMap = ExploreEnum.EnterMode.Battle

		ExploreRpc.instance:sendGetExploreInfoRequest()
	end
end

function var_0_0.enterExploreMap(arg_16_0, arg_16_1)
	arg_16_0:dispatchEvent(ExploreEvent.EnterExplore, arg_16_1)

	ExploreModel.instance.mapId = arg_16_1

	ExploreConfig.instance:loadExploreConfig(ExploreModel.instance.mapId)

	local var_16_0 = ExploreConfig.instance:getSceneId(arg_16_1)

	GameSceneMgr.instance:startScene(SceneType.Explore, var_16_0, SceneConfig.instance:getSceneLevelCOs(var_16_0)[1].id, true, true)
end

function var_0_0.enterExploreFight(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	DungeonFightController.instance:enterFight(DungeonEnum.ExploreChapterId, ExploreModel.instance:getNowMapEpisodeId(), arg_17_3)
end

function var_0_0.addItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1[1]
	local var_18_1 = var_18_0.materilType
	local var_18_2 = var_18_0.materilId
	local var_18_3 = var_18_0.quantity

	if var_18_1 == MaterialEnum.MaterialType.Explore then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.ExploreGetItemView, {
			id = var_18_2
		})
	else
		local var_18_4 = {}
		local var_18_5

		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			local var_18_6 = MaterialDataMO.New()

			if iter_18_1.materilType == MaterialEnum.MaterialType.PowerPotion then
				local var_18_7 = ItemPowerModel.instance:getLatestPowerChange()

				for iter_18_2, iter_18_3 in pairs(var_18_7) do
					if tonumber(iter_18_3.itemid) == tonumber(iter_18_1.materilId) then
						var_18_5 = iter_18_3.uid
					end
				end
			end

			var_18_6:initValue(iter_18_1.materilType, iter_18_1.materilId, iter_18_1.quantity, var_18_5)
			table.insert(var_18_4, var_18_6)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_18_4)
	end
end

function var_0_0.updateUnit(arg_19_0, arg_19_1)
	local var_19_0 = ExploreMapModel.instance:getUnitMO(arg_19_1.id)
	local var_19_1 = {
		arg_19_1.id,
		arg_19_1.type,
		[ExploreUnitMoFieldEnum.nodePos] = {
			arg_19_1.posx,
			arg_19_1.posy
		},
		[ExploreUnitMoFieldEnum.unitDir] = arg_19_1.dir
	}

	if var_19_0 == nil then
		var_19_0 = ExploreMapModel.instance:createUnitMO(var_19_1)
	else
		var_19_0:init(var_19_1)
	end

	var_0_0.instance:addUnit(var_19_0)
end

function var_0_0.addUnit(arg_20_0, arg_20_1)
	arg_20_0:getMap():enterUnit(arg_20_1)
end

function var_0_0.removeUnit(arg_21_0, arg_21_1)
	arg_21_0:getMap():removeUnit(arg_21_1)
end

function var_0_0.exit(arg_22_0)
	if not arg_22_0:getMap() then
		return
	end

	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Explore, false)

	DungeonModel.instance.curSendEpisodeId = ExploreConfig.instance:getEpisodeId(ExploreModel.instance:getMapId())

	MainController.instance:enterMainScene()
end

function var_0_0._openGuideDialogue(arg_23_0, arg_23_1)
	local var_23_0 = string.splitToNumber(arg_23_1, "_")
	local var_23_1 = var_23_0[1]
	local var_23_2 = var_23_0[2]
	local var_23_3 = GuideConfig.instance:getStepCO(var_23_1, var_23_2)
	local var_23_4 = GuideConfig.instance:getStepCO(var_23_1, var_23_2 + 1)
	local var_23_5 = {
		guideKey = arg_23_1,
		tipsTalker = var_23_3.tipsTalker,
		tipsContent = var_23_3.tipsContent
	}

	if var_23_4 and not string.nilorempty(var_23_4.tipsContent) and not string.nilorempty(var_23_4.tipsTalker) then
		var_23_5.noClose = true
	end

	var_23_5.closeCallBack = var_0_0._onCloseGuideDialogueViewByGuide

	ViewMgr.instance:openView(ViewName.ExploreGuideDialogueView, var_23_5)
end

function var_0_0._onCloseGuideDialogueViewByGuide(arg_24_0)
	var_0_0.instance:dispatchEvent(ExploreEvent.CloseGuideDialogueView, arg_24_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
