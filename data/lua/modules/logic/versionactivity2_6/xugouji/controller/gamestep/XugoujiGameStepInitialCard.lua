module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepInitialCard", package.seeall)

local var_0_0 = VersionActivity2_6Enum.ActivityId.Xugouji
local var_0_1 = class("XugoujiGameStepInitialCard", XugoujiGameStepBase)

function var_0_1.start(arg_1_0)
	local var_1_0 = Activity188Model.instance:getCardsInfoList()
	local var_1_1 = Activity188Model.instance:getCurGameId()
	local var_1_2 = Activity188Config.instance:getGameCfg(var_0_0, var_1_1).readNum

	var_1_2 = var_1_2 > #var_1_0 and #var_1_0 or var_1_2
	arg_1_0._randomCardIdxs = {}

	for iter_1_0 = 1, var_1_2 do
		local var_1_3 = math.random(1, #var_1_0)

		while tabletool.indexOf(arg_1_0._randomCardIdxs, var_1_3) do
			var_1_3 = math.random(1, #var_1_0)
		end

		table.insert(arg_1_0._randomCardIdxs, var_1_3)
	end

	for iter_1_1 = 1, #arg_1_0._randomCardIdxs do
		local var_1_4 = var_1_0[arg_1_0._randomCardIdxs[iter_1_1]].uid

		Activity188Model.instance:updateCardStatus(var_1_4, XugoujiEnum.CardStatus.Front)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, var_1_4)
	end

	if not Activity188Model.instance:isGameGuideMode() then
		TaskDispatcher.runDelay(arg_1_0._onCardInitailDone, arg_1_0, 2)
	end

	XugoujiController.instance:registerCallback(XugoujiEvent.FinishInitialCardShow, arg_1_0._onCardInitailDone, arg_1_0)
end

function var_0_1._onCardInitailDone(arg_2_0)
	local var_2_0 = Activity188Model.instance:getCardsInfoList()

	for iter_2_0 = 1, #arg_2_0._randomCardIdxs do
		local var_2_1 = var_2_0[arg_2_0._randomCardIdxs[iter_2_0]].uid

		Activity188Model.instance:updateCardStatus(var_2_1, XugoujiEnum.CardStatus.Back)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, var_2_1)
	end

	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	TaskDispatcher.runDelay(arg_2_0.finish, arg_2_0, 1)
end

function var_0_1.dispose(arg_3_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.FinishInitialCardShow, arg_3_0._onCardInitailDone, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._onCardInitailDone, arg_3_0)
	XugoujiGameStepBase.dispose(arg_3_0)
end

return var_0_1
