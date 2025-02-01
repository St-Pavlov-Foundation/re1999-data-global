module("modules.logic.explore.controller.ExploreController", package.seeall)

slot0 = class("ExploreController", BaseController)

function slot0.onInit(slot0)
	ResDispose.open()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, slot0._onDeleteTaskList, slot0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0._onSetTaskList, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:registerCallback(ExploreEvent.OpenGuideDialogueView, slot0._openGuideDialogue, slot0)
end

function slot0._onUpdateTaskList(slot0, slot1)
	slot2 = false

	for slot6, slot7 in ipairs(slot1.taskInfo) do
		if slot7.type == TaskEnum.TaskType.Explore then
			slot2 = true

			break
		end
	end

	if slot2 then
		ExploreSimpleModel.instance:checkTaskRed()
		uv0.instance:dispatchEvent(ExploreEvent.TaskUpdate)
	end
end

function slot0._onSetTaskList(slot0)
	ExploreSimpleModel.instance:checkTaskRed()
	uv0.instance:dispatchEvent(ExploreEvent.TaskUpdate)
end

function slot0._onDeleteTaskList(slot0, slot1)
	slot2 = false

	for slot6, slot7 in ipairs(slot1.taskIds) do
		if TaskModel.instance:getTaskById(slot7) and slot8.type == TaskEnum.TaskType.Explore then
			slot2 = true

			break
		end
	end

	if slot2 then
		ExploreSimpleModel.instance:checkTaskRed()
		uv0.instance:dispatchEvent(ExploreEvent.TaskUpdate)
	end
end

function slot0._onFinishTask(slot0, slot1)
	if TaskModel.instance:getTaskById(slot1) and slot2.type == TaskEnum.TaskType.Explore then
		ExploreSimpleModel.instance:checkTaskRed()
		uv0.instance:dispatchEvent(ExploreEvent.TaskUpdate)
	end
end

function slot0.registerMapComp(slot0, slot1, slot2)
	if not slot0._comps then
		slot0._comps = {}
	end

	slot0._comps[slot1] = slot2
end

function slot0.unRegisterMapComp(slot0, slot1)
	if not slot0._comps then
		return
	end

	slot0._comps[slot1] = nil
end

function slot0.getMapComp(slot0, slot1)
	if not slot0._comps then
		return
	end

	return slot0._comps[slot1]
end

function slot0.getMap(slot0)
	return slot0:getMapComp(ExploreEnum.MapCompType.Map)
end

function slot0.getMapLight(slot0)
	return slot0:getMapComp(ExploreEnum.MapCompType.Light)
end

function slot0.getMapWhirl(slot0)
	return slot0:getMapComp(ExploreEnum.MapCompType.Whirl)
end

function slot0.getMapPipe(slot0)
	return slot0:getMapComp(ExploreEnum.MapCompType.Pipe)
end

function slot0.enterExploreScene(slot0, slot1)
	if slot1 then
		ExploreRpc.instance:sendChangeMapRequest(slot1)
	else
		ExploreModel.instance.isFirstEnterMap = ExploreEnum.EnterMode.Battle

		ExploreRpc.instance:sendGetExploreInfoRequest()
	end
end

function slot0.enterExploreMap(slot0, slot1)
	slot0:dispatchEvent(ExploreEvent.EnterExplore, slot1)

	ExploreModel.instance.mapId = slot1

	ExploreConfig.instance:loadExploreConfig(ExploreModel.instance.mapId)

	slot2 = ExploreConfig.instance:getSceneId(slot1)

	GameSceneMgr.instance:startScene(SceneType.Explore, slot2, SceneConfig.instance:getSceneLevelCOs(slot2)[1].id, true, true)
end

function slot0.enterExploreFight(slot0, slot1, slot2, slot3)
	DungeonFightController.instance:enterFight(DungeonEnum.ExploreChapterId, ExploreModel.instance:getNowMapEpisodeId(), slot3)
end

function slot0.addItem(slot0, slot1)
	slot2 = slot1[1]
	slot5 = slot2.quantity

	if slot2.materilType == MaterialEnum.MaterialType.Explore then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.ExploreGetItemView, {
			id = slot2.materilId
		})
	else
		slot6 = {}
		slot7 = nil

		for slot11, slot12 in ipairs(slot1) do
			slot13 = MaterialDataMO.New()

			if slot12.materilType == MaterialEnum.MaterialType.PowerPotion then
				for slot18, slot19 in pairs(ItemPowerModel.instance:getLatestPowerChange()) do
					if tonumber(slot19.itemid) == tonumber(slot12.materilId) then
						slot7 = slot19.uid
					end
				end
			end

			slot13:initValue(slot12.materilType, slot12.materilId, slot12.quantity, slot7)
			table.insert(slot6, slot13)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot6)
	end
end

function slot0.updateUnit(slot0, slot1)
	if ExploreMapModel.instance:getUnitMO(slot1.id) == nil then
		slot2 = ExploreMapModel.instance:createUnitMO({
			slot1.id,
			slot1.type,
			[ExploreUnitMoFieldEnum.nodePos] = {
				slot1.posx,
				slot1.posy
			},
			[ExploreUnitMoFieldEnum.unitDir] = slot1.dir
		})
	else
		slot2:init(slot3)
	end

	uv0.instance:addUnit(slot2)
end

function slot0.addUnit(slot0, slot1)
	slot0:getMap():enterUnit(slot1)
end

function slot0.removeUnit(slot0, slot1)
	slot0:getMap():removeUnit(slot1)
end

function slot0.exit(slot0)
	if not slot0:getMap() then
		return
	end

	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Explore, false)

	DungeonModel.instance.curSendEpisodeId = ExploreConfig.instance:getEpisodeId(ExploreModel.instance:getMapId())

	MainController.instance:enterMainScene()
end

function slot0._openGuideDialogue(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "_")
	slot3 = slot2[1]
	slot4 = slot2[2]
	slot5 = GuideConfig.instance:getStepCO(slot3, slot4)

	if GuideConfig.instance:getStepCO(slot3, slot4 + 1) and not string.nilorempty(slot6.tipsContent) and not string.nilorempty(slot6.tipsTalker) then
		-- Nothing
	end

	ViewMgr.instance:openView(ViewName.ExploreGuideDialogueView, {
		guideKey = slot1,
		tipsTalker = slot5.tipsTalker,
		tipsContent = slot5.tipsContent,
		noClose = true,
		closeCallBack = uv0._onCloseGuideDialogueViewByGuide
	})
end

function slot0._onCloseGuideDialogueViewByGuide(slot0)
	uv0.instance:dispatchEvent(ExploreEvent.CloseGuideDialogueView, slot0)
end

slot0.instance = slot0.New()

return slot0
