module("modules.logic.versionactivity2_7.coopergarland.view.Entity.CooperGarlandComponentEntity", package.seeall)

local var_0_0 = class("CooperGarlandComponentEntity", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.mapId = arg_1_1.mapId
	arg_1_0.componentId = arg_1_1.componentId
	arg_1_0.componentType = arg_1_1.componentType

	local var_1_0 = CooperGarlandConfig.instance:getMapComponentExtraParams(arg_1_0.mapId, arg_1_0.componentId)

	arg_1_0.extraParam = string.splitToNumber(var_1_0, "#")
	arg_1_0.spikeMoveSpeed = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.SpikeMoveSpeed, true)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_1.transform
	arg_2_0.animator = arg_2_0.go:GetComponent(typeof(UnityEngine.Animator))

	if arg_2_0.animator then
		arg_2_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_2_0.go)
	end

	arg_2_0:onInit()
end

function var_0_0.onInit(arg_3_0)
	local var_3_0 = arg_3_0.componentType == CooperGarlandEnum.ComponentType.Wall
	local var_3_1, var_3_2 = CooperGarlandConfig.instance:getMapComponentPos(arg_3_0.mapId, arg_3_0.componentId)
	local var_3_3 = CooperGarlandGameEntityMgr.instance:getCompPosZ(var_3_0)

	transformhelper.setLocalPos(arg_3_0.trans, var_3_1, var_3_2, var_3_3)

	arg_3_0.originalPos = {
		x = var_3_1,
		y = var_3_2,
		z = var_3_3
	}

	local var_3_4 = CooperGarlandConfig.instance:getMapComponentRotation(arg_3_0.mapId, arg_3_0.componentId)

	transformhelper.setEulerAngles(arg_3_0.trans, 0, 0, var_3_4)

	local var_3_5 = CooperGarlandConfig.instance:getMapComponentScale(arg_3_0.mapId, arg_3_0.componentId)

	transformhelper.setLocalScale(arg_3_0.trans, var_3_5, var_3_5, 1)

	local var_3_6, var_3_7 = CooperGarlandConfig.instance:getMapComponentSize(arg_3_0.mapId, arg_3_0.componentId)

	recthelper.setSize(arg_3_0.trans, var_3_6, var_3_7)

	arg_3_0._collider = gohelper.onceAddComponent(arg_3_0.go, typeof(UnityEngine.BoxCollider))

	local var_3_8, var_3_9 = CooperGarlandConfig.instance:getMapComponentColliderSize(arg_3_0.mapId, arg_3_0.componentId)
	local var_3_10 = CooperGarlandGameEntityMgr.instance:getCompColliderSizeZ()

	arg_3_0._collider.size = Vector3(var_3_8, var_3_9, var_3_10)

	local var_3_11 = arg_3_0.componentType == CooperGarlandEnum.ComponentType.Door
	local var_3_12, var_3_13 = CooperGarlandConfig.instance:getMapComponentColliderOffset(arg_3_0.mapId, arg_3_0.componentId)
	local var_3_14 = CooperGarlandGameEntityMgr.instance:getCompColliderOffsetZ(var_3_0)

	arg_3_0._collider.center = Vector3(var_3_12, var_3_13, var_3_14)
	arg_3_0._collider.isTrigger = not var_3_0 and not var_3_11

	if arg_3_0.componentType == CooperGarlandEnum.ComponentType.Hole or arg_3_0.componentType == CooperGarlandEnum.ComponentType.Spike then
		arg_3_0._goRemoveModeVx = gohelper.findChild(arg_3_0.go, "image_vx")

		local var_3_15 = gohelper.findChild(arg_3_0.go, "#go_click")

		arg_3_0._click = ZProj.BoxColliderClickListener.Get(var_3_15)

		arg_3_0._click:SetIgnoreUI(true)
	end

	arg_3_0:reset()
end

function var_0_0.addEventListeners(arg_4_0)
	if arg_4_0._click then
		arg_4_0._click:AddClickListener(arg_4_0._onClick, arg_4_0)
	end

	arg_4_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, arg_4_0._onBallKeyChange, arg_4_0)
	arg_4_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, arg_4_0._onRemoveModeChange, arg_4_0)
	arg_4_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnGameStopChange, arg_4_0._onGameStopChange, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	if arg_5_0._click then
		arg_5_0._click:RemoveClickListener()
	end

	arg_5_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, arg_5_0._onBallKeyChange, arg_5_0)
	arg_5_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, arg_5_0._onRemoveModeChange, arg_5_0)
	arg_5_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnGameStopChange, arg_5_0._onGameStopChange, arg_5_0)
end

function var_0_0._onClick(arg_6_0)
	if arg_6_0._isDead then
		return
	end

	local var_6_0 = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.CooperGarlandForceRemove)

	if var_6_0 and arg_6_0.componentId ~= tonumber(var_6_0) then
		return
	end

	CooperGarlandController.instance:removeComponent(arg_6_0.mapId, arg_6_0.componentId)
end

function var_0_0.onTriggerEnter(arg_7_0, arg_7_1)
	if arg_7_0._isDead then
		return
	end

	CooperGarlandController.instance:triggerEnterComponent(arg_7_0.mapId, arg_7_0.componentId)
end

function var_0_0.onTriggerExit(arg_8_0, arg_8_1)
	if arg_8_0._isDead then
		return
	end

	CooperGarlandController.instance:triggerExitComponent(arg_8_0.mapId, arg_8_0.componentId)
end

function var_0_0._onBallKeyChange(arg_9_0)
	if arg_9_0._isDead then
		return
	end

	arg_9_0:refreshDoorCollider()
end

function var_0_0._onRemoveModeChange(arg_10_0)
	if arg_10_0._isDead then
		return
	end

	arg_10_0:refreshRemoveMode()
end

function var_0_0._onGameStopChange(arg_11_0)
	if arg_11_0.componentType ~= CooperGarlandEnum.ComponentType.Spike or #arg_11_0.extraParam <= 0 then
		return
	end

	if CooperGarlandGameModel.instance:getIsStopGame() then
		arg_11_0:killTween()
	elseif not arg_11_0.moveTweenId then
		local var_11_0 = arg_11_0.extraParam[1]
		local var_11_1, var_11_2, var_11_3 = transformhelper.getLocalPos(arg_11_0.trans)
		local var_11_4 = arg_11_0._moveParam and arg_11_0._moveParam.from
		local var_11_5 = arg_11_0._moveParam and arg_11_0._moveParam.to

		arg_11_0:beginMove(var_11_0 == CooperGarlandEnum.Const.SpikeMoveDirX and var_11_1 or var_11_2, var_11_4, var_11_5)
	end
end

function var_0_0.refresh(arg_12_0)
	arg_12_0:refreshDoorCollider()
	arg_12_0:refreshRemoveMode()
end

function var_0_0.refreshDoorCollider(arg_13_0)
	if not (arg_13_0.componentType == CooperGarlandEnum.ComponentType.Door) then
		return
	end

	if arg_13_0._collider then
		local var_13_0 = CooperGarlandGameModel.instance:getBallHasKey()

		arg_13_0._collider.isTrigger = var_13_0
	end
end

function var_0_0.refreshRemoveMode(arg_14_0)
	local var_14_0 = CooperGarlandGameModel.instance:getIsRemoveMode()

	gohelper.setActive(arg_14_0._goRemoveModeVx, var_14_0)
end

function var_0_0.beginMove(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if CooperGarlandGameModel.instance:getIsStopGame() or arg_15_0.moveTweenId or arg_15_0.componentType ~= CooperGarlandEnum.ComponentType.Spike or #arg_15_0.extraParam <= 0 then
		return
	end

	local var_15_0 = arg_15_0.extraParam[1]
	local var_15_1 = var_15_0 == CooperGarlandEnum.Const.SpikeMoveDirX
	local var_15_2 = arg_15_3 or arg_15_0.extraParam[2]
	local var_15_3 = arg_15_2 or var_15_1 and arg_15_0.originalPos.x or arg_15_0.originalPos.y
	local var_15_4 = math.abs(var_15_2 - (arg_15_1 or var_15_3)) / arg_15_0.spikeMoveSpeed

	arg_15_0._moveParam = {
		dir = var_15_0,
		from = var_15_3,
		to = var_15_2
	}

	if var_15_1 then
		arg_15_0.moveTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_15_0.trans, var_15_2, var_15_4, arg_15_0._movePingPong, arg_15_0, arg_15_0._moveParam, EaseType.Linear)
	else
		arg_15_0.moveTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_15_0.trans, var_15_2, var_15_4, arg_15_0._movePingPong, arg_15_0, arg_15_0._moveParam, EaseType.Linear)
	end
end

function var_0_0._movePingPong(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.dir
	local var_16_1 = arg_16_1.from
	local var_16_2 = arg_16_1.to
	local var_16_3 = math.abs(var_16_1 - var_16_2) / arg_16_0.spikeMoveSpeed

	arg_16_0._moveParam = {
		dir = var_16_0,
		from = var_16_2,
		to = var_16_1
	}

	if var_16_0 == CooperGarlandEnum.Const.SpikeMoveDirX then
		arg_16_0.moveTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_16_0.trans, var_16_1, var_16_3, arg_16_0._movePingPong, arg_16_0, arg_16_0._moveParam, EaseType.Linear)
	else
		arg_16_0.moveTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_16_0.trans, var_16_1, var_16_3, arg_16_0._movePingPong, arg_16_0, arg_16_0._moveParam, EaseType.Linear)
	end
end

function var_0_0.setRemoved(arg_17_0)
	arg_17_0._isDead = true

	arg_17_0:killTween()

	if arg_17_0.animatorPlayer then
		arg_17_0.animator.speed = 1

		arg_17_0.animatorPlayer:Play("out", arg_17_0._playRemoveAnimFinish, arg_17_0)
	else
		arg_17_0:_playRemoveAnimFinish()
	end
end

function var_0_0._playRemoveAnimFinish(arg_18_0)
	gohelper.setActive(arg_18_0.go, false)
end

function var_0_0.getWorldPos(arg_19_0)
	return arg_19_0.trans and arg_19_0.trans.position
end

function var_0_0.reset(arg_20_0)
	if CooperGarlandGameModel.instance:isFinishedStoryComponent(arg_20_0.mapId, arg_20_0.componentId) then
		return
	end

	arg_20_0._isDead = false
	arg_20_0._moveParam = nil

	arg_20_0:refresh()
	arg_20_0:killTween()
	transformhelper.setLocalPos(arg_20_0.trans, arg_20_0.originalPos.x, arg_20_0.originalPos.y, arg_20_0.originalPos.z)
	arg_20_0:beginMove()
	gohelper.setActive(arg_20_0.go, true)

	if arg_20_0.animator then
		arg_20_0.animator.enabled = true
		arg_20_0.animator.speed = 0

		arg_20_0.animator:Play("out", 0, 0)
	end
end

function var_0_0.killTween(arg_21_0)
	if arg_21_0.moveTweenId then
		ZProj.TweenHelper.KillById(arg_21_0.moveTweenId)

		arg_21_0.moveTweenId = nil
	end
end

function var_0_0.getIsRemoved(arg_22_0)
	return arg_22_0._isDead
end

function var_0_0.destroy(arg_23_0)
	arg_23_0:killTween()
	arg_23_0:removeEventListeners()

	arg_23_0._moveParam = nil

	gohelper.destroy(arg_23_0.go)
end

function var_0_0.onDestroy(arg_24_0)
	return
end

return var_0_0
