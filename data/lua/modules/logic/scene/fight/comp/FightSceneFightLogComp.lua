module("modules.logic.scene.fight.comp.FightSceneFightLogComp", package.seeall)

local var_0_0 = class("FightSceneFightLogComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	arg_1_0._cacheProto = {}

	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_1_0._onRestartStageBefore, arg_1_0)
	FightController.instance:registerCallback(FightEvent.CacheFightProto, arg_1_0._onCacheFightProto, arg_1_0)
	FightController.instance:registerCallback(FightEvent.GMCopyRoundLog, arg_1_0._onGMCopyRoundLog, arg_1_0)
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0._onRestartStageBefore(arg_3_0)
	arg_3_0._cacheProto = {}
end

function var_0_0._onGMCopyRoundLog(arg_4_0)
	if SLFramework.FrameworkSettings.IsEditor and arg_4_0._lastRoundProto then
		ZProj.UGUIHelper.CopyText(tostring(arg_4_0._lastRoundProto.proto))
	end
end

function var_0_0._onCacheFightProto(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._cacheProto then
		local var_5_0 = {
			protoType = arg_5_1,
			proto = arg_5_2,
			round = FightModel.instance:getCurRoundId()
		}

		table.insert(arg_5_0._cacheProto, var_5_0)

		if arg_5_1 == FightEnum.CacheProtoType.Round then
			arg_5_0._lastRoundProto = var_5_0
		end
	end
end

function var_0_0.getProtoList(arg_6_0)
	return arg_6_0._cacheProto
end

function var_0_0.getLastRoundProto(arg_7_0)
	return arg_7_0._lastRoundProto
end

function var_0_0.onSceneClose(arg_8_0, arg_8_1, arg_8_2)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_8_0._onRestartStageBefore, arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.CacheFightProto, arg_8_0._onCacheFightProto, arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.GMCopyRoundLog, arg_8_0._onGMCopyRoundLog, arg_8_0)
end

return var_0_0
