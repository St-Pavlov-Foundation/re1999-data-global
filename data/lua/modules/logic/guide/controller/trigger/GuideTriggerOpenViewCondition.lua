module("modules.logic.guide.controller.trigger.GuideTriggerOpenViewCondition", package.seeall)

local var_0_0 = class("GuideTriggerOpenViewCondition", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = string.split(arg_2_2, "_")
	local var_2_1 = var_2_0[1]
	local var_2_2 = var_2_0[2]
	local var_2_3 = var_2_0[3]

	if arg_2_1 ~= var_2_1 then
		return false
	end

	return var_0_0[var_2_2](var_2_3)
end

function var_0_0._onOpenView(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:checkStartGuide(arg_3_1)
end

function var_0_0.checkInEliminateEpisode(arg_4_0)
	return EliminateTeamSelectionModel.instance:getSelectedEpisodeId() == tonumber(arg_4_0)
end

function var_0_0.checkInWindows(arg_5_0)
	return BootNativeUtil.isWindows()
end

function var_0_0.checkTowerMopUpOpen()
	local var_6_0 = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local var_6_1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)

	return var_6_0 >= tonumber(var_6_1)
end

function var_0_0.checkTowerBossOpen()
	local var_7_0 = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local var_7_1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

	return var_7_0 >= tonumber(var_7_1)
end

function var_0_0.checkTowerLimitOpen()
	local var_8_0 = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local var_8_1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)
	local var_8_2 = var_8_0 >= tonumber(var_8_1)

	var_8_2 = var_8_2 and TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() ~= nil

	local var_8_3 = GuideModel.instance:isGuideFinish(TowerEnum.BossGuideId)

	return var_8_2 and var_8_3
end

function var_0_0.checkTowerPermanentElite()
	return TowerPermanentModel.instance:checkNewLayerIsElite()
end

return var_0_0
