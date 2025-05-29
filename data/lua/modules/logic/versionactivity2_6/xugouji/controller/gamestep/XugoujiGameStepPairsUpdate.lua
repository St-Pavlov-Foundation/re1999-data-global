module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepPairsUpdate", package.seeall)

local var_0_0 = class("XugoujiGameStepPairsUpdate", XugoujiGameStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0._stepData.isSelf
	local var_1_1 = arg_1_0._stepData.pairCount

	if var_1_1 == 0 then
		arg_1_0:finish()

		return
	end

	Activity188Model.instance:setPairCount(var_1_1, var_1_0)
	TaskDispatcher.runDelay(arg_1_0.doGotPairsView, arg_1_0, 0.5)
end

function var_0_0.doGotPairsView(arg_2_0)
	local var_2_0, var_2_1 = Activity188Model.instance:getLastCardPair()

	if var_2_0 then
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPair)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.GotActiveCard, {
			var_2_0,
			var_2_1
		})
	end

	XugoujiController.instance:registerCallback(XugoujiEvent.CloseCardInfoView, arg_2_0.onCloseCardInfoView, arg_2_0)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	XugoujiController.instance:openCardInfoView()
end

function var_0_0.onCloseCardInfoView(arg_3_0)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)

	local var_3_0, var_3_1 = Activity188Model.instance:getLastCardPair()

	if var_3_0 then
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, var_3_0)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, var_3_1)
	end

	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, arg_3_0.onCloseCardInfoView, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0.finish, arg_3_0, 0.3)
end

function var_0_0.dispose(arg_4_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, arg_4_0.onCloseCardInfoView, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.doGotPairsView, arg_4_0)
	XugoujiGameStepBase.dispose(arg_4_0)
end

return var_0_0
