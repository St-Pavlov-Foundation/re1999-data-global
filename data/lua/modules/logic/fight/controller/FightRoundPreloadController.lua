module("modules.logic.fight.controller.FightRoundPreloadController", package.seeall)

local var_0_0 = class("FightRoundPreloadController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._roundPreloadSequence = FlowSequence.New()

	arg_1_0._roundPreloadSequence:addWork(FightRoundPreloadTimelineWork.New())
	arg_1_0._roundPreloadSequence:addWork(FightPreloadTimelineRefWork.New())
	arg_1_0._roundPreloadSequence:addWork(FightRoundPreloadEffectWork.New())

	arg_1_0._monsterPreloadSequence = FlowSequence.New()

	arg_1_0._monsterPreloadSequence:addWork(FightRoundPreloadMonsterWork.New())

	arg_1_0._context = {
		callback = arg_1_0._onPreloadOneFinish,
		callbackObj = arg_1_0
	}
end

function var_0_0.addConstEvents(arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnStageChange, arg_2_0._onStageChange, arg_2_0)
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:dispose()
end

function var_0_0._onStageChange(arg_4_0, arg_4_1)
	if arg_4_1 == FightEnum.Stage.Card or arg_4_1 == FightEnum.Stage.AutoCard then
		arg_4_0:preload()
	elseif arg_4_1 == FightEnum.Stage.Play then
		if arg_4_0._monsterPreloadSequence and arg_4_0._monsterPreloadSequence.status == WorkStatus.Running then
			arg_4_0._monsterPreloadSequence:stop()
		end

		arg_4_0._monsterPreloadSequence:start(arg_4_0._context)
	end
end

function var_0_0.preload(arg_5_0)
	arg_5_0._assetItemDict = arg_5_0._assetItemDict or arg_5_0:getUserDataTb_()

	if arg_5_0._roundPreloadSequence and arg_5_0._roundPreloadSequence.status == WorkStatus.Running then
		arg_5_0._roundPreloadSequence:stop()
	end

	arg_5_0._roundPreloadSequence:registerDoneListener(arg_5_0._onPreloadDone, arg_5_0)
	arg_5_0._roundPreloadSequence:start(arg_5_0._context)
end

function var_0_0.dispose(arg_6_0)
	arg_6_0._battleId = nil

	arg_6_0._roundPreloadSequence:stop()
	arg_6_0._monsterPreloadSequence:stop()

	if arg_6_0._assetItemDict then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._assetItemDict) do
			iter_6_1:Release()

			arg_6_0._assetItemDict[iter_6_0] = nil
		end

		arg_6_0._assetItemDict = nil
	end

	arg_6_0._context.timelineDict = nil
	arg_6_0._context.timelineUrlDict = nil
	arg_6_0._context.timelineSkinDict = nil

	arg_6_0._roundPreloadSequence:unregisterDoneListener(arg_6_0._onPreloadDone, arg_6_0)
	arg_6_0:__onDispose()
end

function var_0_0._onPreloadDone(arg_7_0)
	return
end

function var_0_0._onPreloadOneFinish(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.ResPath

	if not arg_8_0._assetItemDict[var_8_0] then
		arg_8_0._assetItemDict[var_8_0] = arg_8_1

		arg_8_1:Retain()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
