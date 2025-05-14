module("modules.logic.explore.map.heroanimflow.ExploreHeroCatchUnitFlow", package.seeall)

local var_0_0 = class("ExploreHeroCatchUnitFlow")

function var_0_0.catchUnit(arg_1_0, arg_1_1)
	if ExploreHeroResetFlow.instance:isReseting() then
		return
	end

	arg_1_0._catchUnit = arg_1_1

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.CatchUnit)

	local var_1_0 = arg_1_0:getHero()
	local var_1_1 = ExploreHelper.xyToDir(arg_1_1.mo.nodePos.x - var_1_0.nodePos.x, arg_1_1.mo.nodePos.y - var_1_0.nodePos.y)
	local var_1_2 = (var_1_0:getPos() - arg_1_1:getPos()):SetNormalize():Mul(0.3):Add(arg_1_1:getPos())

	var_1_0:setTrOffset(var_1_1, var_1_2, 0.39, arg_1_0.onRoleMoveToUnitEnd, arg_1_0)
	var_1_0:setMoveSpeed(0.3)
end

function var_0_0.onRoleMoveToUnitEnd(arg_2_0)
	local var_2_0 = arg_2_0:getHero()

	var_2_0:setMoveSpeed(0)

	if arg_2_0._catchUnit then
		var_2_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPick)
	else
		var_2_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPut)
	end

	TaskDispatcher.runDelay(arg_2_0._delayCatchUnit, arg_2_0, 0.4)
end

function var_0_0._delayCatchUnit(arg_3_0)
	if arg_3_0._catchUnit then
		local var_3_0 = arg_3_0:getHero():getHangTrans(ExploreAnimEnum.RoleHangPointType.Hand_Right)

		if var_3_0 then
			arg_3_0._catchUnit:setParent(var_3_0, ExploreEnum.ExplorePipePotHangType.Carry)
		end

		AudioMgr.instance:trigger(AudioEnum.Explore.Pick_Pot)
	else
		arg_3_0._uncatchUnit:setParent(ExploreController.instance:getMap():getUnitRoot().transform, ExploreEnum.ExplorePipePotHangType.UnCarry)
		AudioMgr.instance:trigger(AudioEnum.Explore.Put_Pot)
	end

	TaskDispatcher.runDelay(arg_3_0._onCatchEnd, arg_3_0, 0.4)
end

function var_0_0._onCatchEnd(arg_4_0)
	local var_4_0 = arg_4_0:getHero()

	var_4_0:setMoveSpeed(0)

	if arg_4_0._catchUnit then
		var_4_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Carry)

		local var_4_1 = ExploreHelper.tileToPos(ExploreHelper.posToTile(var_4_0:getPos() + var_4_0._displayTr.localPosition))

		var_4_1.y = var_4_0:getPos().y

		var_4_0:setTrOffset(nil, var_4_1, 0.21, arg_4_0.onRoleMoveToCenterEnd, arg_4_0)
		var_4_0:setMoveSpeed(0.3)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	else
		var_4_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
		var_4_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.MoveBack)

		local var_4_2 = var_4_0:getPos():Clone()
		local var_4_3 = ExploreHelper.dirToXY(var_4_0.dir)
		local var_4_4 = var_4_2:Clone()

		var_4_4.x = var_4_4.x - var_4_3.x * 1
		var_4_4.z = var_4_4.z - var_4_3.y * 1
		var_4_2.x = var_4_2.x - var_4_3.x * 0.3
		var_4_2.z = var_4_2.z - var_4_3.y * 0.3
		var_4_0._displayTr.localPosition = var_4_2 - var_4_4

		var_4_0:setPos(var_4_4, nil, true)
		var_4_0:setTrOffset(var_4_0.dir, var_4_4, 0.6, arg_4_0.onRoleMoveBackEnd, arg_4_0)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	end
end

function var_0_0.onRoleMoveToCenterEnd(arg_5_0)
	local var_5_0 = arg_5_0:getHero()
	local var_5_1 = var_5_0:getPos() + var_5_0._displayTr.localPosition

	var_5_0:setPos(var_5_1)

	var_5_0._displayTr.localPosition = Vector3.zero

	var_5_0:setMoveSpeed(0)

	arg_5_0._catchUnit = nil

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.CatchUnit)
end

function var_0_0.onRoleMoveBackEnd(arg_6_0)
	local var_6_0 = arg_6_0:getHero()

	if arg_6_0._catchUnit and arg_6_0._fromUnit then
		var_6_0:setMoveSpeed(0)
	else
		var_6_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	end

	if arg_6_0._endCallBack and arg_6_0._fromUnit then
		arg_6_0._endCallBack(arg_6_0._fromUnit)
	end

	arg_6_0._catchUnit = nil
	arg_6_0._uncatchUnit = nil
	arg_6_0._fromUnit = nil
	arg_6_0._endCallBack = nil

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.CatchUnit)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryEnd)
end

function var_0_0.uncatchUnit(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getHero()

	if ExploreHeroResetFlow.instance:isReseting() then
		local var_7_1 = ExploreController.instance:getMap()

		arg_7_1:setParent(var_7_1:getUnitRoot().transform, ExploreEnum.ExplorePipePotHangType.UnCarry)
		var_7_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)

		return
	end

	transformhelper.setLocalPos(arg_7_1.trans, 0, 0, 0)

	arg_7_0._uncatchUnit = arg_7_1

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.CatchUnit)

	local var_7_2 = ExploreHelper.dirToXY(var_7_0.dir)
	local var_7_3 = var_7_0:getPos():Clone()

	var_7_3.x = var_7_3.x - var_7_2.x * 0.3
	var_7_3.z = var_7_3.z - var_7_2.y * 0.3

	var_7_0:setTrOffset(var_7_0.dir, var_7_3, 0.39, arg_7_0.onRoleMoveToUnitEnd, arg_7_0)
	var_7_0:setMoveSpeed(0.3)
end

function var_0_0.getHero(arg_8_0)
	return ExploreController.instance:getMap():getHero()
end

function var_0_0.isInFlow(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return arg_9_0._catchUnit or arg_9_0._uncatchUnit
	end

	return arg_9_1 == arg_9_0._catchUnit or arg_9_1 == arg_9_0._uncatchUnit
end

function var_0_0.catchUnitFrom(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if ExploreHeroResetFlow.instance:isReseting() then
		arg_10_3(arg_10_2)

		return
	end

	arg_10_0._catchUnit = arg_10_1
	arg_10_0._fromUnit = arg_10_2
	arg_10_0._endCallBack = arg_10_3

	arg_10_0:moveToFromUnit(arg_10_2)
end

function var_0_0.uncatchUnitFrom(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if ExploreHeroResetFlow.instance:isReseting() then
		arg_11_3(arg_11_2)

		return
	end

	arg_11_0._uncatchUnit = arg_11_1
	arg_11_0._fromUnit = arg_11_2
	arg_11_0._endCallBack = arg_11_3

	transformhelper.setLocalPos(arg_11_0._uncatchUnit.trans, 0, 0, 0)
	arg_11_0:moveToFromUnit(arg_11_2)
end

function var_0_0.moveToFromUnit(arg_12_0, arg_12_1)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.CatchUnit)

	local var_12_0 = arg_12_0:getHero()
	local var_12_1 = ExploreHelper.xyToDir(arg_12_1.mo.nodePos.x - var_12_0.nodePos.x, arg_12_1.mo.nodePos.y - var_12_0.nodePos.y)
	local var_12_2 = (var_12_0:getPos() - arg_12_1:getPos()):SetNormalize():Mul(0.3):Add(arg_12_1:getPos())

	var_12_0:setTrOffset(var_12_1, var_12_2, 0.39, arg_12_0.onRoleMoveToFromUnitEnd, arg_12_0)
	var_12_0:setMoveSpeed(0.3)
end

function var_0_0.onRoleMoveToFromUnitEnd(arg_13_0)
	local var_13_0 = arg_13_0:getHero()

	var_13_0:setMoveSpeed(0)

	local var_13_1 = 0.4

	if arg_13_0._catchUnit then
		var_13_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPick)
	else
		var_13_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPut)

		var_13_1 = 0.2
	end

	TaskDispatcher.runDelay(arg_13_0._delayCatchUnitFromUnit, arg_13_0, var_13_1)
end

function var_0_0._delayCatchUnitFromUnit(arg_14_0)
	local var_14_0 = 0.4

	if arg_14_0._catchUnit then
		local var_14_1 = arg_14_0:getHero():getHangTrans(ExploreAnimEnum.RoleHangPointType.Hand_Right)

		if var_14_1 then
			arg_14_0._catchUnit:setParent(var_14_1, ExploreEnum.ExplorePipePotHangType.Carry)
		end

		AudioMgr.instance:trigger(AudioEnum.Explore.Take_On_Pot)
	else
		arg_14_0._uncatchUnit:setParent(arg_14_0._fromUnit.trans, ExploreEnum.ExplorePipePotHangType.Put)

		var_14_0 = 0.6

		AudioMgr.instance:trigger(AudioEnum.Explore.Take_Off_Pot)
	end

	TaskDispatcher.runDelay(arg_14_0._onCatchFromUnitEnd, arg_14_0, var_14_0)
end

function var_0_0._onCatchFromUnitEnd(arg_15_0)
	local var_15_0 = arg_15_0._fromUnit
	local var_15_1 = arg_15_0:getHero()
	local var_15_2 = ExploreHelper.xyToDir(var_15_0.nodePos.x - var_15_1.nodePos.x, var_15_0.mo.nodePos.y - var_15_1.nodePos.y)
	local var_15_3 = ExploreHelper.tileToPos(var_15_1.nodePos)

	var_15_1:setTrOffset(var_15_2, var_15_3, 0.39, arg_15_0.onRoleMoveBackEnd, arg_15_0)

	if arg_15_0._catchUnit then
		var_15_1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Carry)
		var_15_1:setMoveSpeed(0.3)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	else
		var_15_1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
		var_15_1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.MoveBack)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	end
end

function var_0_0.clear(arg_16_0)
	arg_16_0._catchUnit = nil
	arg_16_0._uncatchUnit = nil
	arg_16_0._fromUnit = nil
	arg_16_0._endCallBack = nil

	TaskDispatcher.cancelTask(arg_16_0._delayCatchUnitFromUnit, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._delayCatchUnit, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._onCatchEnd, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._onCatchFromUnitEnd, arg_16_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
