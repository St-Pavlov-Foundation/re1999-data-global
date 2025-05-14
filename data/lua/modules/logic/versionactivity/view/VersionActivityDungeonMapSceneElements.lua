module("modules.logic.versionactivity.view.VersionActivityDungeonMapSceneElements", package.seeall)

local var_0_0 = class("VersionActivityDungeonMapSceneElements", DungeonMapSceneElements)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.finishElementList = {}
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0.activityDungeonMo = arg_2_0.viewContainer.versionActivityDungeonBaseMo

	var_0_0.super.onOpen(arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_2_0.onModeChange, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, arg_2_0._initElements, arg_2_0)
end

function var_0_0.onModeChange(arg_3_0)
	local var_3_0 = arg_3_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story

	for iter_3_0, iter_3_1 in pairs(arg_3_0._elementList) do
		if var_3_0 then
			iter_3_1:show()
		else
			iter_3_1:hide()
		end
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0.finishElementList) do
		if var_3_0 then
			iter_3_3:show()
		else
			iter_3_3:hide()
		end
	end
end

function var_0_0._removeElement(arg_4_0, arg_4_1)
	local var_4_0 = DungeonConfig.instance:getChapterMapElement(arg_4_1)

	if not arg_4_0:canShow(var_4_0) then
		var_0_0.super._removeElement(arg_4_0, arg_4_1)

		return
	end

	local var_4_1 = arg_4_0._elementList[arg_4_1]
	local var_4_2 = var_4_1._go

	var_4_1:setFinishAndDotDestroy()

	arg_4_0._elementList[arg_4_1] = nil

	local var_4_3 = arg_4_0._arrowList[arg_4_1]

	if var_4_3 then
		var_4_3.arrowClick:RemoveClickListener()

		arg_4_0._arrowList[arg_4_1] = nil

		gohelper.destroy(var_4_3.go)
	end

	arg_4_0:addFinishElement(DungeonConfig.instance:getChapterMapElement(arg_4_1), var_4_2)
end

function var_0_0._showElements(arg_5_0, arg_5_1)
	if arg_5_0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(arg_5_0.activityDungeonMo.episodeId) then
		return
	end

	var_0_0.super._showElements(arg_5_0, arg_5_1)

	local var_5_0 = DungeonMapModel.instance:getElements(arg_5_1)
	local var_5_1 = DungeonConfig.instance:getMapElements(arg_5_1)

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			if arg_5_0:canShow(iter_5_1) and not arg_5_0:inNotFinishElementList(iter_5_1.id, var_5_0) then
				arg_5_0:addFinishElement(iter_5_1)
			end
		end
	end
end

function var_0_0.inNotFinishElementList(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		if iter_6_1.id == arg_6_1 then
			return true
		end
	end

	return false
end

function var_0_0.addFinishElement(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.finishElementList[arg_7_1.id] then
		return
	end

	local var_7_0 = arg_7_2

	if not var_7_0 then
		var_7_0 = UnityEngine.GameObject.New(tostring(arg_7_1.id))

		gohelper.addChild(arg_7_0._elementRoot, var_7_0)
	end

	local var_7_1 = MonoHelper.addLuaComOnceToGo(var_7_0, DungeonMapFinishElement, {
		arg_7_1,
		arg_7_0._mapScene,
		arg_7_0,
		arg_7_2
	})

	arg_7_0.finishElementList[arg_7_1.id] = var_7_1
end

function var_0_0.canShow(arg_8_0, arg_8_1)
	return arg_8_1.type == DungeonEnum.ElementType.PuzzleGame or arg_8_1.type == DungeonEnum.ElementType.None
end

function var_0_0._disposeScene(arg_9_0)
	var_0_0.super._disposeScene(arg_9_0)
	arg_9_0:disposeFinishElements()
end

function var_0_0._disposeOldMap(arg_10_0)
	var_0_0.super._disposeOldMap(arg_10_0)
	arg_10_0:disposeFinishElements()
end

function var_0_0.disposeFinishElements(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.finishElementList) do
		iter_11_1:onDestroy()
	end

	arg_11_0.finishElementList = {}
end

return var_0_0
