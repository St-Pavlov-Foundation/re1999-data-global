module("modules.logic.fight.view.work.FightSuccShowBonusWork", package.seeall)

local var_0_0 = class("FightSuccShowBonusWork", BaseWork)
local var_0_1 = 0.2

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:initParam(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
end

function var_0_0.initParam(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0._bonusGOList = arg_2_1
	arg_2_0._bonusGOCount = arg_2_0._bonusGOList and #arg_2_0._bonusGOList or 0
	arg_2_0._containerGODict = arg_2_2
	arg_2_0._delayTime = arg_2_3
	arg_2_0._itemDelay = arg_2_4
end

function var_0_0.onStart(arg_3_0)
	if arg_3_0._bonusGOCount <= 0 then
		arg_3_0:onDone(true)

		return
	end

	local var_3_0 = (arg_3_0._bonusGOCount - 1) * arg_3_0._delayTime + arg_3_0._itemDelay + var_0_1

	arg_3_0._bonusTweenId = ZProj.TweenHelper.DOTweenFloat(0, var_3_0, var_3_0, arg_3_0._bonusTweenFrame, arg_3_0._bonusTweenFinish, arg_3_0, nil, EaseType.Linear)
end

function var_0_0._bonusTweenFrame(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._bonusGOList) do
		if arg_4_1 >= (iter_4_0 - 1) * arg_4_0._delayTime then
			gohelper.setActive(iter_4_1, true)
		end
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0._containerGODict) do
		if iter_4_2 <= arg_4_1 then
			gohelper.setActive(iter_4_3, true)
		end
	end
end

function var_0_0._bonusTweenFinish(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._bonusGOList) do
		gohelper.setActive(iter_5_1, true)
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0._containerGODict) do
		gohelper.setActive(iter_5_3, true)
	end

	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	if arg_6_0._bonusTweenId then
		ZProj.TweenHelper.KillById(arg_6_0._bonusTweenId)
	end

	arg_6_0:initParam()
end

return var_0_0
