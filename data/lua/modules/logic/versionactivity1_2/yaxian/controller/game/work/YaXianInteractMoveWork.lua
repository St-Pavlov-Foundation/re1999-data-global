module("modules.logic.versionactivity1_2.yaxian.controller.game.work.YaXianInteractMoveWork", package.seeall)

local var_0_0 = class("YaXianInteractMoveWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.targetX = arg_1_1.targetX
	arg_1_0.targetY = arg_1_1.targetY
	arg_1_0.targetZ = arg_1_1.targetZ
	arg_1_0.duration = arg_1_1.duration
	arg_1_0.isPlayer = arg_1_1.isPlayer
	arg_1_0.interactMo = arg_1_1.interactMo
end

function var_0_0.onStart(arg_2_0)
	if arg_2_0.isPlayer then
		if arg_2_0:isPassedWall() then
			AudioMgr.instance:trigger(AudioEnum.YaXian.ThroughWall)
		else
			AudioMgr.instance:trigger(AudioEnum.YaXian.YaXianMove)
		end
	end

	arg_2_0.tweenId = ZProj.TweenHelper.DOLocalMove(arg_2_0.transform, arg_2_0.targetX, arg_2_0.targetY, arg_2_0.targetZ, arg_2_0.duration or YaXianGameEnum.MoveDuration, arg_2_0.onMoveCompleted, arg_2_0, nil, EaseType.Linear)
end

function var_0_0.isPassedWall(arg_3_0)
	if not arg_3_0.isPlayer then
		return false
	end

	if not arg_3_0.interactMo then
		logError("not found interactMo ... ")

		return false
	end

	local var_3_0 = YaXianGameModel.instance:getCanWalkPos2Direction()[YaXianGameHelper.getPosHashKey(arg_3_0.interactMo.posX, arg_3_0.interactMo.posY)]

	if var_3_0 then
		local var_3_1 = YaXianGameModel.instance:getCanWalkTargetPosDict()

		return var_3_1 and var_3_1[var_3_0] and var_3_1[var_3_0].passedWall
	end

	return false
end

function var_0_0.onMoveCompleted(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	if arg_5_0.tweenId then
		ZProj.TweenHelper.KillById(arg_5_0.tweenId)

		arg_5_0.tweenId = nil
	end
end

return var_0_0
