module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepNewCards", package.seeall)

local var_0_0 = class("XugoujiGameStepNewCards", XugoujiGameStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0._stepData.cards

	Activity188Model.instance:clearCardsInfo()
	Activity188Model.instance:updateCardInfo(var_1_0)
	Activity188Model.instance:setPairCount(0, true)
	Activity188Model.instance:setPairCount(0, false)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GotNewCardDisplay)
	XugoujiGameStepController.instance:insertStepListClient({
		{
			stepType = XugoujiEnum.GameStepType.UpdateInitialCard
		}
	}, true)
	TaskDispatcher.runDelay(arg_1_0.doNewCardDisplay, arg_1_0, 0.5)
end

function var_0_0.doNewCardDisplay(arg_2_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.NewCards)
	TaskDispatcher.runDelay(arg_2_0.finish, arg_2_0, 0.5)
end

function var_0_0.dispose(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.finish, arg_3_0)
	XugoujiGameStepBase.dispose(arg_3_0)
end

return var_0_0
