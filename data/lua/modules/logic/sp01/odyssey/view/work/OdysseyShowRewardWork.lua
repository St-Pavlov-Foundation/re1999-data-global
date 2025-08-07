module("modules.logic.sp01.odyssey.view.work.OdysseyShowRewardWork", package.seeall)

local var_0_0 = class("OdysseyShowRewardWork", BaseWork)
local var_0_1 = 0.5
local var_0_2 = 0.34

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.showGO = arg_1_1
	arg_1_0.showTime = arg_1_2
	arg_1_0.rewardItemType = arg_1_3
	arg_1_0.canShowAddItemList = arg_1_4
	arg_1_0.anim = arg_1_0.showGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.isSetDone = false
end

function var_0_0.onStart(arg_2_0)
	gohelper.setActive(arg_2_0.showGO, true)
	arg_2_0.anim:Play("open", 0, 0)
	arg_2_0.anim:Update(0)
	TaskDispatcher.runDelay(arg_2_0.onSetDone, arg_2_0, arg_2_0.showTime)

	if arg_2_0.rewardItemType and arg_2_0.rewardItemType == OdysseyEnum.RewardItemType.Talent then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowDungeonTalentGetEffect)
	end

	if arg_2_0.canShowAddItemList then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowDungeonBagGetEffect)
	end

	arg_2_0.rewardItemType = nil
	arg_2_0.canShowAddItemList = false
end

function var_0_0.onSetDone(arg_3_0)
	if arg_3_0.isSetDone then
		return
	end

	arg_3_0.isSetDone = true

	arg_3_0.anim:Play("close", 0, 0)
	arg_3_0.anim:Update(0)
	TaskDispatcher.cancelTask(arg_3_0._delayFinish, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._delayFinish, arg_3_0, var_0_2)
end

function var_0_0._delayFinish(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	gohelper.setActive(arg_5_0.showGO, false)
	TaskDispatcher.cancelTask(arg_5_0._delayFinish, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.onSetDone, arg_5_0)

	if arg_5_0.animTweenId then
		ZProj.TweenHelper.KillById(arg_5_0.animTweenId)
	end

	arg_5_0.rewardItemType = nil
	arg_5_0.canShowAddItemList = false
	arg_5_0.isSetDone = false
end

return var_0_0
