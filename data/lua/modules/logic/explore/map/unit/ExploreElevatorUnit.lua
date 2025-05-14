module("modules.logic.explore.map.unit.ExploreElevatorUnit", package.seeall)

local var_0_0 = class("ExploreElevatorUnit", ExploreBaseDisplayUnit)

function var_0_0.onInit(arg_1_0)
	arg_1_0._stayUnitDic = {}
end

function var_0_0.setupMO(arg_2_0)
	arg_2_0._useHeight1 = arg_2_0.mo:getInteractInfoMO().statusInfo.height == arg_2_0.mo.height2

	arg_2_0:_elevatorKeep()
end

function var_0_0.onRoleEnter(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_2 then
		return
	end

	if ExploreHeroCatchUnitFlow.instance:isInFlow() then
		ExploreController.instance:registerCallback(ExploreEvent.HeroCarryEnd, arg_3_0._carryEnd, arg_3_0)

		return
	end

	if arg_3_0._stayUnitDic[arg_3_3] == nil then
		arg_3_0._useHeight1 = arg_3_0.position.y == arg_3_0.mo.height1

		arg_3_0:_elevatorMoving()
	end

	arg_3_0._stayUnitDic[arg_3_3] = arg_3_3.position.y - arg_3_0.position.y

	arg_3_3:clearTarget()
end

function var_0_0._carryEnd(arg_4_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroCarryEnd, arg_4_0._carryEnd, arg_4_0)
	arg_4_0:onRoleEnter(nil, true, ExploreController.instance:getMap():getHero())
end

function var_0_0.onRoleLeave(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._stayUnitDic[arg_5_3] = nil
end

function var_0_0.movingElevator(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.position.y ~= arg_6_1 then
		arg_6_0.mo:updateNodeHeight(9999999)

		local var_6_0 = arg_6_1
		local var_6_1 = arg_6_0.position.y

		if arg_6_0._tweenId then
			ZProj.TweenHelper.KillById(arg_6_0._tweenId)
		end

		arg_6_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_6_1, var_6_0, arg_6_2, arg_6_0._setY, nil, arg_6_0, nil, EaseType.Linear)
		arg_6_0._tarY = var_6_0

		arg_6_0:setStatusActive(true)
		TaskDispatcher.runDelay(arg_6_0.setNodeHeightByTarY, arg_6_0, arg_6_2)
	end
end

function var_0_0._elevatorKeep(arg_7_0)
	arg_7_0:setStatusActive(false)
	arg_7_0:setSpikeActive(arg_7_0._useHeight1 == false)

	if string.nilorempty(arg_7_0.mo.keepTime) == false then
		TaskDispatcher.runDelay(arg_7_0._elevatorMoving, arg_7_0, arg_7_0.mo.keepTime)
	end
end

function var_0_0._elevatorMoving(arg_8_0)
	arg_8_0.mo:updateNodeHeight(9999999)

	if string.nilorempty(arg_8_0.mo.intervalTime) == false then
		local var_8_0 = arg_8_0._useHeight1 and arg_8_0.mo.height2 or arg_8_0.mo.height1
		local var_8_1 = arg_8_0._useHeight1 and arg_8_0.mo.height1 or arg_8_0.mo.height2

		if arg_8_0._tweenId then
			ZProj.TweenHelper.KillById(arg_8_0._tweenId)
		end

		arg_8_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_8_1, var_8_0, arg_8_0.mo.intervalTime, arg_8_0._setY, nil, arg_8_0, nil, EaseType.Linear)

		TaskDispatcher.runDelay(arg_8_0._elevatorKeep, arg_8_0, arg_8_0.mo.intervalTime)
		arg_8_0:setStatusActive(true)
	else
		arg_8_0:_elevatorKeep()
	end
end

function var_0_0.setStatusActive(arg_9_0, arg_9_1)
	arg_9_0.mo:getInteractInfoMO():setBitByIndex(ExploreEnum.InteractIndex.ActiveState, arg_9_1 and 1 or 0)
end

function var_0_0.setNodeHeightByTarY(arg_10_0)
	ZProj.TweenHelper.KillByObj(arg_10_0.trans)
	arg_10_0.mo:updateNodeHeight(arg_10_0._tarY)
	arg_10_0:_setY(arg_10_0._tarY)
	arg_10_0:setStatusActive(false)
end

function var_0_0.setSpikeActive(arg_11_0, arg_11_1)
	ZProj.TweenHelper.KillByObj(arg_11_0.trans)

	arg_11_0._useHeight1 = arg_11_1

	local var_11_0 = ExploreHelper.getKey(arg_11_0.nodePos)
	local var_11_1

	if arg_11_1 then
		var_11_1 = arg_11_0.mo.height1
	else
		var_11_1 = arg_11_0.mo.height2
	end

	arg_11_0.mo:updateNodeHeight(var_11_1)
	arg_11_0:_setY(var_11_1)
end

function var_0_0._setY(arg_12_0, arg_12_1)
	arg_12_0.position.y = arg_12_1

	transformhelper.setPos(arg_12_0.trans, arg_12_0.position.x, arg_12_0.position.y, arg_12_0.position.z)
	arg_12_0:_updateUnitRoleY()
end

function var_0_0._updateUnitRoleY(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._stayUnitDic) do
		iter_13_0:updateSceneY(arg_13_0.position.y + iter_13_1)
	end
end

function var_0_0.onDestroy(arg_14_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroCarryEnd, arg_14_0._carryEnd, arg_14_0)
	ZProj.TweenHelper.KillByObj(arg_14_0.trans)

	if arg_14_0._tweenId then
		ZProj.TweenHelper.KillById(arg_14_0._tweenId)
	end

	TaskDispatcher.cancelTask(arg_14_0._elevatorMoving, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._elevatorKeep, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.setNodeHeightByTarY, arg_14_0)
	var_0_0.super.onDestroy(arg_14_0)
end

return var_0_0
