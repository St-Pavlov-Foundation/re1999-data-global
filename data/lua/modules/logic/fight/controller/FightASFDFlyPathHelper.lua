module("modules.logic.fight.controller.FightASFDFlyPathHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getMissileMover(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	return (var_0_0.flyPathHandle[arg_1_1.flyPath] or var_0_0.defaultFlyMover)(arg_1_1.flyPath, arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
end

function var_0_0.defaultFlyMover(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	local var_2_0 = MonoHelper.addLuaComOnceToGo(arg_2_3.containerGO, UnitMoverBezier3)

	MonoHelper.addLuaComOnceToGo(arg_2_3.containerGO, UnitMoverHandler)
	var_2_0:registerCallback(UnitMoveEvent.Arrive, arg_2_6, arg_2_7)
	FightASFDHelper.changeRandomArea()

	local var_2_1 = arg_2_1:getMO()
	local var_2_2 = FightASFDHelper.getStartPos(var_2_1 and var_2_1.side or FightEnum.EntitySide.MySide, arg_2_2.sceneEmitterId)
	local var_2_3 = FightASFDHelper.getEndPos(arg_2_4)
	local var_2_4 = var_2_2
	local var_2_5 = FightASFDHelper.getRandomPos(var_2_2, var_2_3, arg_2_2)
	local var_2_6 = var_2_5
	local var_2_7 = var_2_3

	arg_2_3:setWorldPos(var_2_2.x, var_2_2.y, var_2_2.z)

	local var_2_8 = FightASFDConfig.instance:getFlyPathCo(arg_2_0)

	var_2_0:setEaseType(var_2_8.lineType)

	local var_2_9 = arg_2_5.emitterAttackNum
	local var_2_10 = FightASFDConfig.instance:getFlyDuration(var_2_8.flyDuration, var_2_9) / FightModel.instance:getSpeed()

	var_2_0:simpleMove(var_2_4, var_2_5, var_2_6, var_2_7, var_2_10)

	return var_2_0
end

function var_0_0.straightLineFlyMover(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	local var_3_0 = MonoHelper.addLuaComOnceToGo(arg_3_3.containerGO, UnitMoverEase)

	MonoHelper.addLuaComOnceToGo(arg_3_3.containerGO, UnitMoverHandler)
	var_3_0:registerCallback(UnitMoveEvent.Arrive, arg_3_6, arg_3_7)

	local var_3_1 = arg_3_1:getMO()
	local var_3_2 = FightASFDHelper.getStartPos(var_3_1 and var_3_1.side or FightEnum.EntitySide.MySide, arg_3_2.sceneEmitterId)
	local var_3_3 = FightASFDHelper.getEndPos(arg_3_4, ModuleEnum.SpineHangPoint.mountbody)

	arg_3_3:setWorldPos(var_3_2.x, var_3_2.y, var_3_2.z)

	local var_3_4 = FightASFDHelper.getZRotation(var_3_2.x, var_3_2.y, var_3_3.x, var_3_3.y)

	transformhelper.setLocalRotation(arg_3_3.containerGO.transform, 0, 0, var_3_4)

	local var_3_5 = FightASFDConfig.instance:getFlyPathCo(arg_3_0)

	var_3_0:setEaseType(var_3_5.lineType)

	local var_3_6 = arg_3_5.emitterAttackNum
	local var_3_7 = FightASFDConfig.instance:getFlyDuration(var_3_5.flyDuration, var_3_6) / FightModel.instance:getSpeed()

	var_3_0:simpleMove(var_3_2.x, var_3_2.y, var_3_2.z, var_3_3.x, var_3_3.y, var_3_3.z, var_3_7)

	return var_3_0
end

var_0_0.flyPathHandle = {
	[FightEnum.ASFDFlyPath.Default] = var_0_0.defaultFlyMover,
	[FightEnum.ASFDFlyPath.StraightLine] = var_0_0.straightLineFlyMover
}

return var_0_0
