module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepChangeTurn", package.seeall)

local var_0_0 = class("XugoujiGameStepChangeTurn", XugoujiGameStepBase)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0._stepData.isSelf

	Activity188Model.instance:setTurn(var_1_0)
	Activity188Model.instance:setCurCardUid(nil)

	if not Activity188Model.instance:isGameGuideMode() then
		local var_1_1 = Activity188Model.instance:getCardsInfoList()
		local var_1_2 = false

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			local var_1_3 = iter_1_1.uid

			if Activity188Model.instance:getCardItemStatue(var_1_3) == XugoujiEnum.CardStatus.Front then
				var_1_2 = true

				break
			end
		end

		if var_1_2 then
			local var_1_4 = tonumber(Activity188Config.instance:getConstCfg(var_0_1, var_0_3).value2)

			TaskDispatcher.runDelay(arg_1_0._doChangeTurnAction, arg_1_0, var_1_4 or 2)
		else
			local var_1_5 = tonumber(Activity188Config.instance:getConstCfg(var_0_1, var_0_2).value2)

			TaskDispatcher.runDelay(arg_1_0._doChangeTurnCardsView, arg_1_0, var_1_5 or 2)
		end
	else
		XugoujiController.instance:registerCallback(XugoujiEvent.GuideChangeTurn, arg_1_0._onGuideChangeTurn, arg_1_0)
	end
end

function var_0_0._onGuideChangeTurn(arg_2_0)
	arg_2_0:_doChangeTurnAction()
end

function var_0_0._doChangeTurnAction(arg_3_0)
	arg_3_0:_filpBackUnActiveCards()

	local var_3_0 = tonumber(Activity188Config.instance:getConstCfg(var_0_1, var_0_2).value2)

	TaskDispatcher.runDelay(arg_3_0._doChangeTurnCardsView, arg_3_0, var_3_0 or 2)
end

function var_0_0._filpBackUnActiveCards(arg_4_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.FilpBackUnActiveCard)
end

function var_0_0._doChangeTurnCardsView(arg_5_0)
	local var_5_0 = Activity188Model.instance:isMyTurn()

	if var_5_0 then
		Activity188Model.instance:setGameViewState(XugoujiEnum.GameViewState.PlayerOperating)
	else
		Activity188Model.instance:setGameViewState(XugoujiEnum.GameViewState.EnemyOperating)
	end

	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.changeTurn)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.TurnChanged, var_5_0 and 1 or 0)

	local var_5_1 = tonumber(Activity188Config.instance:getConstCfg(var_0_1, var_0_2).value2)

	TaskDispatcher.runDelay(arg_5_0.finish, arg_5_0, 1)
end

function var_0_0.finish(arg_6_0)
	var_0_0.super.finish(arg_6_0)
end

function var_0_0.dispose(arg_7_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.GuideChangeTurn, arg_7_0._onGuideChangeTurn, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._doChangeTurnAction, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.finish, arg_7_0)
	XugoujiGameStepBase.dispose(arg_7_0)
end

return var_0_0
