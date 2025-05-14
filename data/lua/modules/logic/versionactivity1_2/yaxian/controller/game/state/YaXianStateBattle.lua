module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateBattle", package.seeall)

local var_0_0 = class("YaXianStateBattle", YaXianStateBase)

function var_0_0.start(arg_1_0)
	arg_1_0.stateType = YaXianGameEnum.GameStateType.Battle

	logNormal("YaXianStateBattle start")

	if YaXianGameModel.instance:gameIsLoadDone() then
		arg_1_0:startBattle()
	else
		YaXianGameController.instance:registerCallback(YaXianEvent.OnGameLoadDone, arg_1_0.onGameLoadDone, arg_1_0)
	end
end

function var_0_0.onGameLoadDone(arg_2_0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, arg_2_0.onGameLoadDone, arg_2_0)
	arg_2_0:startBattle()
end

function var_0_0.startBattle(arg_3_0)
	arg_3_0.playerInteractItem = YaXianGameController.instance:getPlayerInteractItem()
	arg_3_0.enemyInteractItem = YaXianGameController.instance:getInteractItem(arg_3_0.originData.interactId)

	AudioMgr.instance:trigger(AudioEnum.YaXian.Fight)
	arg_3_0.playerInteractItem:showEffect(YaXianGameEnum.EffectType.Fight)
	arg_3_0.enemyInteractItem:showEffect(YaXianGameEnum.EffectType.Fight, arg_3_0.openTipView, arg_3_0)
end

function var_0_0.openTipView(arg_4_0)
	ViewMgr.instance:openView(ViewName.YaXianGameTipView, {
		interactId = arg_4_0.originData.interactId
	})
end

function var_0_0.dispose(arg_5_0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, arg_5_0.onGameLoadDone, arg_5_0)
	arg_5_0.playerInteractItem:cancelEffectTask()
	arg_5_0.enemyInteractItem:cancelEffectTask()
	var_0_0.super.dispose(arg_5_0)
end

return var_0_0
