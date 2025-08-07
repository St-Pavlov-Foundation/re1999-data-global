module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapSceneElements", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapSceneElements", VersionActivityFixedDungeonMapSceneElements)

function var_0_0.loadSceneFinish(arg_1_0, arg_1_1)
	arg_1_0._mapCfg = arg_1_1.mapConfig
	arg_1_0._sceneGo = arg_1_1.mapSceneGo
	arg_1_0._elementRoot = gohelper.findChild(arg_1_0._sceneGo, "elementRoot")

	if gohelper.isNil(arg_1_0._elementRoot) then
		arg_1_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(arg_1_0._sceneGo, arg_1_0._elementRoot)
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnTweenEpisodeListVisible, arg_2_0._onTweenEpisodeListVisible, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnEpisodeListVisibleDone, arg_2_0._onEpisodeListVisibleDone, arg_2_0)
end

function var_0_0.isMouseDownElement(arg_3_0)
	return arg_3_0.mouseDownElement ~= nil
end

function var_0_0._updateArrow(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._arrowList[arg_4_1:getElementId()]

	if not var_4_0 then
		return
	end

	if not arg_4_1:isConfigShowArrow() then
		gohelper.setActive(var_4_0.go, false)

		return
	end

	local var_4_1 = arg_4_1._transform
	local var_4_2 = CameraMgr.instance:getMainCamera():WorldToViewportPoint(var_4_1.position)

	if var_4_2.z < 0 then
		var_4_2.x = 1 - var_4_2.x
		var_4_2.y = 1 - var_4_2.y
	end

	local var_4_3 = var_4_2.x
	local var_4_4 = var_4_2.y
	local var_4_5 = var_4_3 >= 0 and var_4_3 <= 1 and var_4_4 >= 0 and var_4_4 <= 1

	gohelper.setActive(var_4_0.go, not var_4_5)

	if var_4_5 then
		return
	end

	local var_4_6 = math.max(0.02, math.min(var_4_3, 0.98))
	local var_4_7 = math.max(0.035, math.min(var_4_4, 0.965))
	local var_4_8 = recthelper.getWidth(arg_4_0._goarrow.transform)
	local var_4_9 = recthelper.getHeight(arg_4_0._goarrow.transform)

	recthelper.setAnchor(var_4_0.go.transform, var_4_8 * (var_4_6 - 0.5), var_4_9 * (var_4_7 - 0.5))

	local var_4_10 = var_4_0.initRotation

	if var_4_3 >= 0 and var_4_3 <= 1 then
		if var_4_4 < 0 then
			transformhelper.setLocalRotation(var_4_0.rotationTrans, var_4_10[1], var_4_10[2], 180)

			return
		elseif var_4_4 > 1 then
			transformhelper.setLocalRotation(var_4_0.rotationTrans, var_4_10[1], var_4_10[2], 0)

			return
		end
	end

	if var_4_4 >= 0 and var_4_4 <= 1 then
		if var_4_3 < 0 then
			transformhelper.setLocalRotation(var_4_0.rotationTrans, var_4_10[1], var_4_10[2], 270)

			return
		elseif var_4_3 > 1 then
			transformhelper.setLocalRotation(var_4_0.rotationTrans, var_4_10[1], var_4_10[2], 90)

			return
		end
	end

	local var_4_11 = 90 - Mathf.Atan2(var_4_4, var_4_3) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(var_4_0.rotationTrans, var_4_10[1], var_4_10[2], var_4_11)
end

function var_0_0._showElementAnim(arg_5_0, arg_5_1, arg_5_2)
	var_0_0.super._showElementAnim(arg_5_0, arg_5_1, arg_5_2)

	if not arg_5_1 or #arg_5_1 <= 0 then
		arg_5_0:_dispatchNewElementsFocusDoneEvent()

		return
	end

	if arg_5_0._showSequence then
		arg_5_0._showSequence:addWork(FunctionWork.New(arg_5_0._dispatchNewElementsFocusDoneEvent, arg_5_0))
	end
end

function var_0_0._dispatchNewElementsFocusDoneEvent(arg_6_0)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnNewElementsFocusDone)
end

function var_0_0._onTweenEpisodeListVisible(arg_7_0)
	gohelper.setActive(arg_7_0._goarrow, false)
end

function var_0_0._onEpisodeListVisibleDone(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goarrow, arg_8_1)
end

return var_0_0
