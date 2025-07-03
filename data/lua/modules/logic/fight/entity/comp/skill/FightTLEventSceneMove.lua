module("modules.logic.fight.entity.comp.skill.FightTLEventSceneMove", package.seeall)

local var_0_0 = class("FightTLEventSceneMove", FightTimelineTrackItem)

var_0_0.MoveType = {
	Revert = 2,
	Move = 1
}

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.moveType = tonumber(arg_1_3[1])
	arg_1_0.easeType = tonumber(arg_1_3[3])

	if arg_1_0.moveType == var_0_0.MoveType.Move then
		arg_1_0:handleMove(arg_1_1, arg_1_2, arg_1_3)
	else
		arg_1_0:handleRevert(arg_1_1, arg_1_2, arg_1_3)
	end
end

function var_0_0.handleMove(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.targetPos = FightStrUtil.instance:getSplitToNumberCache(arg_2_3[2], ",")

	local var_2_0 = FightHelper.getEntity(arg_2_1.fromId)
	local var_2_1 = var_2_0 and var_2_0:getMO()

	if not var_2_1 then
		logError("not found entity mo : " .. tostring(arg_2_1.fromId))

		return
	end

	local var_2_2, var_2_3, var_2_4 = FightHelper.getEntityStandPos(var_2_1)
	local var_2_5 = arg_2_0.targetPos[1]
	local var_2_6 = arg_2_0.targetPos[2]
	local var_2_7 = arg_2_0.targetPos[3]

	var_2_5 = var_2_1.side == FightEnum.EntitySide.MySide and var_2_5 or -var_2_5

	local var_2_8 = var_2_5 - var_2_2
	local var_2_9 = var_2_6 - var_2_3
	local var_2_10 = var_2_7 - var_2_4
	local var_2_11 = arg_2_0:getSceneTr()

	if var_2_11 then
		arg_2_0:clearTween()

		local var_2_12, var_2_13, var_2_14 = transformhelper.getLocalPos(var_2_11)

		FightModel.instance:setCurSceneOriginPos(var_2_12, var_2_13, var_2_14)

		arg_2_0.tweenId = ZProj.TweenHelper.DOMove(var_2_11, var_2_12 + var_2_8, var_2_13 + var_2_9, var_2_14 + var_2_10, arg_2_2, nil, nil, nil, arg_2_0.easeType)
	end
end

function var_0_0.handleRevert(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0, var_3_1, var_3_2 = FightModel.instance:getCurSceneOriginPos()
	local var_3_3 = arg_3_0:getSceneTr()

	if var_3_3 then
		arg_3_0:clearTween()

		arg_3_0.tweenId = ZProj.TweenHelper.DOMove(var_3_3, var_3_0, var_3_1, var_3_2, arg_3_2, arg_3_0.onRevertCallback, arg_3_0, nil, arg_3_0.easeType)
	end
end

function var_0_0.getSceneTr(arg_4_0)
	local var_4_0 = GameSceneMgr.instance:getCurScene()
	local var_4_1 = var_4_0 and var_4_0:getSceneContainerGO()

	return var_4_1 and var_4_1.transform
end

function var_0_0.onRevertCallback(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = FightModel.instance:getCurSceneOriginPos()

	FightModel.instance:setCurSceneOriginPos(nil, nil, nil)

	local var_5_3 = arg_5_0:getSceneTr()

	if var_5_3 then
		transformhelper.setLocalPos(var_5_3, var_5_0, var_5_1, var_5_2)
	end
end

function var_0_0.onTrackEnd(arg_6_0)
	return
end

function var_0_0.clearTween(arg_7_0)
	if arg_7_0.tweenId then
		ZProj.TweenHelper.KillById(arg_7_0.tweenId)

		arg_7_0.tweenId = nil
	end
end

function var_0_0.clearData(arg_8_0)
	arg_8_0.moveType = nil
	arg_8_0.targetPos = nil
	arg_8_0.easeType = nil
end

function var_0_0.onDestructor(arg_9_0)
	arg_9_0:clearTween()
	arg_9_0:clearData()
end

return var_0_0
