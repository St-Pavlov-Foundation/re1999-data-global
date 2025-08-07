module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyDetectsWork", package.seeall)

local var_0_0 = class("StealthEnemyDetectsWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = AssassinStealthGameModel.instance:getHeroUidList()

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		if AssassinStealthGameHelper.isHeroCanBeScan(iter_1_1) then
			local var_1_2 = AssassinStealthGameModel.instance:getHeroMo(iter_1_1, true):getPos()

			if not var_1_0[var_1_2] and AssassinStealthGameHelper.isGridEnemyWillScan(var_1_2) then
				var_1_0[var_1_2] = true
			end
		end
	end

	if next(var_1_0) then
		for iter_1_2, iter_1_3 in pairs(var_1_0) do
			AssassinStealthGameEntityMgr.instance:playGridScanEff(iter_1_2)
		end

		local var_1_3 = AssassinConfig.instance:getAssassinEffectDuration(AssassinEnum.EffectId.ScanEffectId)

		TaskDispatcher.cancelTask(arg_1_0._playScanEffFinished, arg_1_0)
		TaskDispatcher.runDelay(arg_1_0._playScanEffFinished, arg_1_0, var_1_3)
	else
		arg_1_0:_playScanEffFinished()
	end
end

local var_0_1 = 3

function var_0_0._playScanEffFinished(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = AssassinStealthGameModel.instance:getEnemyOperationData()
	local var_2_2 = var_2_1 and var_2_1.hero

	if var_2_2 then
		AssassinStealthGameController.instance:updateHeroes(var_2_2)

		for iter_2_0, iter_2_1 in ipairs(var_2_2) do
			var_2_0[#var_2_0 + 1] = iter_2_1.uid
		end
	end

	if #var_2_0 > 0 then
		AssassinStealthGameController.instance:registerCallback(AssassinEvent.PlayExposeTipFinished, arg_2_0._showExposedTipFinished, arg_2_0)
		AssassinStealthGameController.instance:heroBeExposed(var_2_0, arg_2_0._showExposedTipFinished, arg_2_0)
		TaskDispatcher.cancelTask(arg_2_0._showExposedTipFinished, arg_2_0)
		TaskDispatcher.runDelay(arg_2_0._showExposedTipFinished, arg_2_0, var_0_1)
	else
		arg_2_0:_showExposedTipFinished()
	end
end

function var_0_0._showExposedTipFinished(arg_3_0)
	AssassinStealthGameController.instance:unregisterCallback(AssassinEvent.PlayExposeTipFinished, arg_3_0._showExposedTipFinished, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._showExposedTipFinished, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	AssassinStealthGameController.instance:unregisterCallback(AssassinEvent.PlayExposeTipFinished, arg_4_0._showExposedTipFinished, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._showExposedTipFinished, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._playScanEffFinished, arg_4_0)
end

return var_0_0
