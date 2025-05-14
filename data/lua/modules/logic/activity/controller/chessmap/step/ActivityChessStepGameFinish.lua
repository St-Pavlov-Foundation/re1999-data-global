module("modules.logic.activity.controller.chessmap.step.ActivityChessStepGameFinish", package.seeall)

local var_0_0 = class("ActivityChessStepGameFinish", ActivityChessStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0:processSelectObj()
	arg_1_0:processWinStatus()
end

function var_0_0.processSelectObj(arg_2_0)
	ActivityChessGameController.instance:setSelectObj(nil)
end

function var_0_0.processWinStatus(arg_3_0)
	if arg_3_0.originData.win == true then
		logNormal("game clear!")
		ActivityChessGameController.instance:gameClear()
	else
		logNormal("game over!")

		if arg_3_0.originData.failReason == ActivityChessEnum.FailReason.FailInteract then
			local var_3_0 = arg_3_0.originData.failCharacter
			local var_3_1 = ActivityChessGameController.instance.interacts

			if var_3_0 ~= 0 and var_3_1 then
				local var_3_2 = var_3_1:get(var_3_0).config
				local var_3_3 = Activity109ChessModel.instance:getEpisodeId()
				local var_3_4 = "OnChessFailPause" .. var_3_3 .. "_" .. (var_3_2 and var_3_2.id or "")
				local var_3_5 = GuideEvent[var_3_4]
				local var_3_6 = GuideEvent.OnChessFailContinue
				local var_3_7 = var_0_0._gameOver
				local var_3_8 = arg_3_0

				GuideController.instance:GuideFlowPauseAndContinue(var_3_4, var_3_5, var_3_6, var_3_7, var_3_8)

				return
			end
		end

		arg_3_0:_gameOver()
	end
end

function var_0_0._gameOver(arg_4_0)
	ActivityChessGameController.instance:gameOver()
end

return var_0_0
