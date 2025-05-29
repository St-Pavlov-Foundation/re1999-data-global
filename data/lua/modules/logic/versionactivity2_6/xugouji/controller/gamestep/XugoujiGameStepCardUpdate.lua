module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepCardUpdate", package.seeall)

local var_0_0 = VersionActivity2_6Enum.ActivityId.Xugouji
local var_0_1 = class("XugoujiGameStepCardUpdate", XugoujiGameStepBase)

function var_0_1.start(arg_1_0)
	local var_1_0 = arg_1_0._stepData.uid
	local var_1_1 = arg_1_0._stepData.status
	local var_1_2 = Activity188Model.instance:getCardInfo(var_1_0)
	local var_1_3 = var_1_2.id
	local var_1_4 = Activity188Config.instance:getCardCfg(var_0_0, var_1_3)

	if var_1_4.type ~= 2 and var_1_2.statue ~= XugoujiEnum.CardStatus.Disappear and var_1_1 == XugoujiEnum.CardStatus.Disappear then
		Activity188Model.instance:addOpenedCard(var_1_0)
	elseif var_1_4.type == 2 and var_1_1 == XugoujiEnum.CardStatus.Front then
		Activity188Model.instance:addOpenedCard(var_1_0)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPair)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.GotActiveCard, {
			var_1_0,
			-1
		})
	end

	Activity188Model.instance:updateCardStatus(var_1_0, var_1_1)

	if var_1_4.type == 2 then
		if var_1_1 == XugoujiEnum.CardStatus.Front then
			if var_1_0 == Activity188Model.instance:getLastCardInfoUId() then
				arg_1_0:finish()
			else
				Activity188Model.instance:setLastCardInfoUId(var_1_0)
				XugoujiController.instance:registerCallback(XugoujiEvent.CloseCardInfoView, arg_1_0.onCloseCardInfoView, arg_1_0)
				XugoujiController.instance:openCardInfoView(nil)
			end
		else
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardPairStatusUpdated, arg_1_0._stepData.uid)
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, arg_1_0._stepData.uid)
			TaskDispatcher.runDelay(arg_1_0.finish, arg_1_0, 0.25)
		end
	elseif Activity188Model.instance:isMyTurn() then
		if Activity188Model.instance:getGameViewState() == XugoujiEnum.GameViewState.PlayerOperaDisplay then
			if var_1_1 ~= XugoujiEnum.CardStatus.Disappear and var_1_1 ~= XugoujiEnum.CardStatus.Back then
				XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, arg_1_0._stepData.uid)
			end
		else
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, arg_1_0._stepData.uid)
		end

		arg_1_0:finish()
	elseif Activity188Model.instance:getGameViewState() == XugoujiEnum.GameViewState.EnemyOperaDisplay then
		if var_1_1 ~= XugoujiEnum.CardStatus.Disappear and var_1_1 ~= XugoujiEnum.CardStatus.Back then
			XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, arg_1_0._stepData.uid)
		end

		arg_1_0:finish()
	else
		XugoujiController.instance:dispatchEvent(XugoujiEvent.CardStatusUpdated, arg_1_0._stepData.uid)
		TaskDispatcher.runDelay(arg_1_0.finish, arg_1_0, 0.5)
	end
end

function var_0_1.onCloseCardInfoView(arg_2_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, arg_2_0.onCloseCardInfoView, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.finish, arg_2_0, 0.3)
end

function var_0_1.finish(arg_3_0)
	var_0_1.super.finish(arg_3_0)
end

function var_0_1.dispose(arg_4_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.CloseCardInfoView, arg_4_0.onCloseCardInfoView, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.finish, arg_4_0)
	XugoujiGameStepBase.dispose(arg_4_0)
end

return var_0_1
