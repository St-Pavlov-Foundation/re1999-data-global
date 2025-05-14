module("modules.logic.fight.view.work.FightSuccShowExtraBonusWork", package.seeall)

local var_0_0 = class("FightSuccShowExtraBonusWork", BaseWork)
local var_0_1 = 0.05
local var_0_2 = 0.05
local var_0_3 = 0.45
local var_0_4 = 175
local var_0_5 = 0.5

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	arg_1_0:initParam(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
end

function var_0_0.initParam(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)
	arg_2_0._bonusGOList = arg_2_1
	arg_2_0._bonusGOCount = arg_2_0._bonusGOList and #arg_2_0._bonusGOList or 0
	arg_2_0._containerGODict = arg_2_2
	arg_2_0._showEffectCb = arg_2_3
	arg_2_0._showEffectCbObj = arg_2_4
	arg_2_0._moveBonusGOList = arg_2_5
	arg_2_0._delayTime = arg_2_7
	arg_2_0._itemDelay = arg_2_8
	arg_2_0._bonusItemContainer = arg_2_6
end

function var_0_0.onStart(arg_3_0)
	if arg_3_0._bonusGOCount <= 0 then
		arg_3_0:onDone(true)

		return
	end

	arg_3_0:_moveBonus()
end

function var_0_0._moveBonus(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._moveBonusGOList) do
		local var_4_0 = iter_4_1.transform

		var_4_0.parent = var_4_0.parent.parent

		local var_4_1 = recthelper.getAnchorX(var_4_0) + arg_4_0._bonusGOCount * var_0_4

		ZProj.TweenHelper.DOAnchorPosX(var_4_0, var_4_1, var_0_3, nil, nil, nil, EaseType.InOutCubic)
	end

	TaskDispatcher.runDelay(arg_4_0._startShowBonus, arg_4_0, var_0_1)

	if arg_4_0._showEffectCb then
		TaskDispatcher.runDelay(arg_4_0._showEffectCb, arg_4_0._showEffectCbObj, var_0_2)
	end
end

function var_0_0._startShowBonus(arg_5_0)
	local var_5_0 = (arg_5_0._bonusGOCount - 1) * arg_5_0._delayTime + arg_5_0._itemDelay + var_0_5

	arg_5_0._bonusTweenId = ZProj.TweenHelper.DOTweenFloat(0, var_5_0, var_5_0, arg_5_0._bonusTweenFrame, arg_5_0._bonusTweenFinish, arg_5_0, nil, EaseType.Linear)
end

function var_0_0._bonusTweenFrame(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._bonusGOList) do
		if arg_6_1 >= (iter_6_0 - 1) * arg_6_0._delayTime then
			gohelper.setActive(iter_6_1, true)
		end
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_0._containerGODict) do
		if iter_6_2 <= arg_6_1 then
			gohelper.setActive(iter_6_3, true)
		end
	end
end

function var_0_0._bonusTweenFinish(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._bonusGOList) do
		gohelper.setActive(iter_7_1, true)
		table.insert(var_7_0, iter_7_1)
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._containerGODict) do
		gohelper.setActive(iter_7_3, true)
	end

	for iter_7_4, iter_7_5 in ipairs(arg_7_0._moveBonusGOList) do
		table.insert(var_7_0, iter_7_5)
	end

	arg_7_0._moveBonusGOList = var_7_0

	arg_7_0:_moveBonusDone()
	arg_7_0:onDone(true)
end

function var_0_0._moveBonusDone(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._moveBonusGOList) do
		iter_8_1.transform.parent = arg_8_0._bonusItemContainer.transform
	end
end

function var_0_0.clearWork(arg_9_0)
	if arg_9_0._bonusTweenId then
		ZProj.TweenHelper.KillById(arg_9_0._bonusTweenId)
	end

	TaskDispatcher.cancelTask(arg_9_0._startShowBonus, arg_9_0)

	if arg_9_0._showEffectCb then
		TaskDispatcher.cancelTask(arg_9_0._showEffectCb, arg_9_0._showEffectCbObj)
	end

	arg_9_0:initParam()
end

return var_0_0
