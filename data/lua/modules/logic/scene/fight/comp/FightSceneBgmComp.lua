module("modules.logic.scene.fight.comp.FightSceneBgmComp", package.seeall)

local var_0_0 = class("FightSceneBgmComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._stopBgAudioId = nil

	local var_2_0 = FightModel.instance:getFightParam()

	arg_2_0._bgAudioId = arg_2_0:_getCurBgAudioId()

	if arg_2_0._bgAudioId then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)
		arg_2_0:_playBgm()
		arg_2_0:_detectDefaultSwitch(var_2_0.episodeId)
	end

	arg_2_0:_playAmbientSound()
	FightController.instance:registerCallback(FightEvent.OnFightReconnect, arg_2_0._switchMonsterGroup, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceStart, arg_2_0._onStartSequenceStart, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceStart, arg_2_0._switchMonsterGroup, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_2_0._onSkillPlayStart, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnHpChange, arg_2_0._onHpChange, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnFightReconnectLastWork, arg_2_0._onFightReconnectLastWork, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_2_0._onSpineLoaded, arg_2_0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, arg_2_0._onEntityDeadBefore, arg_2_0)
	FightController.instance:registerCallback(FightEvent.EntityDeadFinish, arg_2_0._onEntityDeadFinish, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRestartFightDisposeDone, arg_2_0._onRestartFightDisposeDone, arg_2_0)
	FightController.instance:registerCallback(FightEvent.AddMagicCircile, arg_2_0._onAddMagicCircile, arg_2_0)
	FightController.instance:registerCallback(FightEvent.SwitchFightendBgm, arg_2_0._onSwitchFightendBgm, arg_2_0)
	FightController.instance:registerCallback(FightEvent.PlayDialog, arg_2_0._onPlayDialog, arg_2_0)
	FightController.instance:registerCallback(FightEvent.AfterPlayDialog, arg_2_0._onAfterPlayDialog, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ReplayBgmAfterAVG, arg_2_0.onReplayBgmAfterAVG, arg_2_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.onReplayBgmAfterAVG(arg_3_0)
	arg_3_0:_playBgm()

	arg_3_0._ambientSound = nil

	arg_3_0:_playAmbientSound()
	FightAudioMgr.instance:setSwitch(arg_3_0._cur_switch or FightEnum.AudioSwitch.Fightnormal)
end

function var_0_0._onLevelLoaded(arg_4_0, arg_4_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	local var_4_0 = arg_4_0:_getCurBgAudioId()

	if var_4_0 ~= arg_4_0._bgAudioId then
		arg_4_0._bgAudioId = var_4_0

		arg_4_0:_playBgm()
	end

	arg_4_0:_playAmbientSound()
end

function var_0_0._playBgm(arg_5_0)
	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Fight, arg_5_0._bgAudioId, AudioEnum.Bgm.Stop_FightingMusic)
end

function var_0_0._onStartSequenceStart(arg_6_0)
	local var_6_0 = true

	if arg_6_0:_getConfig(nil, 0, 11, 0) then
		var_6_0 = false
	end

	if var_6_0 then
		arg_6_0:_switchMonsterGroup()
	end
end

function var_0_0._switchMonsterGroup(arg_7_0)
	FightAudioMgr.instance:setSwitch(arg_7_0._cur_switch or FightEnum.AudioSwitch.Fightnormal)
end

function var_0_0._onSkillPlayFinish(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_0:_needDealFinishTimeline(arg_8_1, arg_8_4) then
		return
	end
end

function var_0_0._needDealFinishTimeline(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = FightModel.instance:getFightParam()

	if not arg_9_1 or not arg_9_1:getMO() then
		return
	end

	local var_9_1 = arg_9_0:_getConfig(var_9_0.episodeId, arg_9_1:getMO().modelId, 9, arg_9_2)

	if not var_9_1 then
		return
	end

	if arg_9_0._cur_switch == var_9_1.switch then
		return
	end

	arg_9_0._cur_switch = var_9_1.switch

	arg_9_0:_switchMonsterGroup()

	return true
end

function var_0_0._onSkillPlayStart(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0:_needDealPlayTimeline(arg_10_1, arg_10_4) then
		return
	end

	local var_10_0 = arg_10_0:needDealBgm(arg_10_3.fromId, 1, arg_10_3.actId)

	if not var_10_0 then
		return
	end

	if arg_10_0._cur_switch == var_10_0.switch then
		return
	end

	arg_10_0._cur_switch = var_10_0.switch

	arg_10_0:_switchMonsterGroup()
end

function var_0_0._needDealPlayTimeline(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = FightModel.instance:getFightParam()

	if not arg_11_1 or not arg_11_1:getMO() then
		return
	end

	local var_11_1 = arg_11_0:_getConfig(var_11_0.episodeId, arg_11_1:getMO().modelId, 8, arg_11_2)

	if not var_11_1 then
		return
	end

	if arg_11_0._cur_switch == var_11_1.switch then
		return
	end

	arg_11_0._cur_switch = var_11_1.switch

	arg_11_0:_switchMonsterGroup()

	return true
end

function var_0_0._onBuffUpdate(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_2 ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local var_12_0 = arg_12_0:needDealBgm(arg_12_1, 2, arg_12_3)

	if not var_12_0 then
		return
	end

	if arg_12_0._cur_switch == var_12_0.switch then
		return
	end

	arg_12_0._cur_switch = var_12_0.switch

	arg_12_0:_switchMonsterGroup()
end

function var_0_0._onHpChange(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:needDealBgm(arg_13_1.id, 3)

	if not var_13_0 then
		return
	end

	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		table.insert(var_13_1, iter_13_1)
	end

	table.sort(var_13_1, var_0_0.hpSortFunc)

	local var_13_2 = arg_13_1:getMO()
	local var_13_3 = var_13_2.currentHp / (var_13_2.attrMO and var_13_2.attrMO.hp > 0 and var_13_2.attrMO.hp or 1) * 100
	local var_13_4 = arg_13_0._cur_switch

	for iter_13_2, iter_13_3 in ipairs(var_13_1) do
		if var_13_3 <= tonumber(iter_13_3.param) then
			arg_13_0._cur_switch = iter_13_3.switch
		end
	end

	if var_13_4 == arg_13_0._cur_switch then
		return
	end

	arg_13_0:_switchMonsterGroup()
end

function var_0_0.hpSortFunc(arg_14_0, arg_14_1)
	return tonumber(arg_14_0.param) > tonumber(arg_14_1.param)
end

function var_0_0._detectDefaultSwitch(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:_getConfig(arg_15_1, 0, 4, "0")

	if not var_15_0 then
		return
	end

	if arg_15_0._cur_switch == var_15_0.switch then
		return
	end

	arg_15_0._cur_switch = var_15_0.switch
end

function var_0_0.needPlayVictory(arg_16_0)
	local var_16_0 = FightModel.instance:getFightParam()

	if not arg_16_0:_getConfig(var_16_0.episodeId, 0, 6, "0") then
		return
	end

	return true
end

function var_0_0._onSwitchFightendBgm(arg_17_0)
	if not arg_17_0:_getConfig(nil, 0, 12, 0) then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Fightend)
	end
end

function var_0_0._onSpineLoaded(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:needDealBgm(arg_18_1.unitSpawn.id, 5, 0)

	if not var_18_0 then
		return
	end

	if arg_18_0._cur_switch == var_18_0.switch then
		return
	end

	arg_18_0._cur_switch = var_18_0.switch

	arg_18_0:_switchMonsterGroup()
end

function var_0_0._onEntityDeadBefore(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:needDealBgm(arg_19_1, 7, 0)

	if not var_19_0 then
		return
	end

	if arg_19_0._cur_switch == var_19_0.switch then
		return
	end

	arg_19_0._cur_switch = var_19_0.switch

	arg_19_0:_switchMonsterGroup()
end

function var_0_0._onEntityDeadFinish(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:_getConfig(nil, arg_20_1, 15, 0)

	if not var_20_0 then
		return
	end

	if arg_20_0._cur_switch == var_20_0.switch then
		return
	end

	arg_20_0._cur_switch = var_20_0.switch

	arg_20_0:_switchMonsterGroup()
end

function var_0_0._onAddMagicCircile(arg_21_0, arg_21_1)
	local var_21_0 = FightModel.instance:getFightParam()
	local var_21_1 = arg_21_0:_getConfig(var_21_0.episodeId, 0, 10, tostring(arg_21_1))

	if not var_21_1 then
		return
	end

	if arg_21_0._cur_switch == var_21_1.switch then
		return
	end

	arg_21_0._cur_switch = var_21_1.switch

	arg_21_0:_switchMonsterGroup()

	return true
end

function var_0_0._onFightReconnectLastWork(arg_22_0)
	local var_22_0 = FightHelper.getAllEntitys()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_1 = iter_22_1:getMO()

		if var_22_1 then
			local var_22_2 = var_22_1:getBuffList()

			for iter_22_2, iter_22_3 in ipairs(var_22_2) do
				arg_22_0:_onBuffUpdate(iter_22_1.id, FightEnum.EffectType.BUFFADD, iter_22_3.buffId)
			end
		end

		arg_22_0:_onHpChange(iter_22_1)
	end
end

function var_0_0.needDealBgm(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = FightHelper.getEntity(arg_23_1)

	if not var_23_0 or not var_23_0:getMO() then
		return
	end

	local var_23_1 = FightModel.instance:getFightParam()
	local var_23_2 = arg_23_0:_getConfig(var_23_1.episodeId, var_23_0:getMO().modelId, arg_23_2, tostring(arg_23_3))

	if not var_23_2 then
		return
	end

	return var_23_2
end

function var_0_0._getConfig(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = FightModel.instance:getFightParam()
	local var_24_1 = var_24_0.battleId
	local var_24_2 = lua_fight_music.configDict[arg_24_1 or var_24_0.episodeId] or lua_fight_music.configDict[0]

	if var_24_2 then
		var_24_2 = var_24_2[var_24_1] or var_24_2[0]

		if var_24_2 and var_24_2[arg_24_2] and var_24_2[arg_24_2][arg_24_3] then
			if arg_24_3 == 3 then
				return var_24_2[arg_24_2][arg_24_3]
			end

			return var_24_2[arg_24_2][arg_24_3][tostring(arg_24_4)]
		end
	end
end

function var_0_0._getCurBgAudioId(arg_25_0)
	local var_25_0 = FightModel.instance:getFightParam()
	local var_25_1 = var_25_0 and var_25_0.battleId and lua_battle.configDict[var_25_0.battleId]

	if var_25_1 and var_25_1.bgmevent and var_25_1.bgmevent > 0 then
		return var_25_1.bgmevent
	end

	local var_25_2 = FightModel.instance:getCurWaveId()
	local var_25_3 = var_25_0:getSceneLevel(var_25_2)
	local var_25_4 = lua_scene_level.configDict[var_25_3]

	if var_25_4.bgm and var_25_4.bgm > 0 then
		return var_25_4.bgm
	end
end

function var_0_0._playAmbientSound(arg_26_0)
	local var_26_0 = FightModel.instance:getCurWaveId()
	local var_26_1 = FightModel.instance:getFightParam():getSceneLevel(var_26_0)
	local var_26_2 = lua_scene_level.configDict[var_26_1]

	if var_26_2.ambientSound and var_26_2.ambientSound > 0 and var_26_2.ambientSound ~= arg_26_0._ambientSound then
		arg_26_0._ambientSound = var_26_2.ambientSound

		AudioMgr.instance:trigger(arg_26_0._ambientSound)
	end
end

function var_0_0.stopBgm(arg_27_0)
	if arg_27_0._bgAudioId then
		arg_27_0._stopBgAudioId = arg_27_0._bgAudioId
		arg_27_0._bgAudioId = nil

		AudioBgmManager.instance:stopAndRemove(AudioBgmEnum.Layer.Fight)
	end

	arg_27_0._ambientSound = nil

	AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
end

function var_0_0.resumeBgm(arg_28_0)
	arg_28_0._cur_switch = nil

	if arg_28_0._stopBgAudioId then
		arg_28_0._bgAudioId = arg_28_0._stopBgAudioId
		arg_28_0._stopBgAudioId = nil

		arg_28_0:_playBgm()
		arg_28_0:_playAmbientSound()
	end
end

function var_0_0._onRestartFightDisposeDone(arg_29_0)
	arg_29_0._cur_switch = nil

	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)

	local var_29_0 = FightModel.instance:getFightParam()

	if arg_29_0._bgAudioId then
		arg_29_0:_detectDefaultSwitch(var_29_0.episodeId)
	end
end

function var_0_0._onPlayDialog(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:_getConfig(nil, 0, 13, arg_30_1)

	if not var_30_0 then
		return
	end

	if arg_30_0._cur_switch == var_30_0.switch then
		return
	end

	arg_30_0._cur_switch = var_30_0.switch

	arg_30_0:_switchMonsterGroup()

	return true
end

function var_0_0._onAfterPlayDialog(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:_getConfig(nil, 0, 14, arg_31_1)

	if not var_31_0 then
		return
	end

	if arg_31_0._cur_switch == var_31_0.switch then
		return
	end

	arg_31_0._cur_switch = var_31_0.switch

	arg_31_0:_switchMonsterGroup()

	return true
end

function var_0_0.onSceneClose(arg_32_0)
	arg_32_0:stopBgm()

	arg_32_0._stopBgAudioId = nil
	arg_32_0._cur_switch = nil

	FightController.instance:unregisterCallback(FightEvent.OnFightReconnect, arg_32_0._switchMonsterGroup, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceStart, arg_32_0._onStartSequenceStart, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, arg_32_0._switchMonsterGroup, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_32_0._onSkillPlayStart, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_32_0._onSkillPlayFinish, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_32_0._onBuffUpdate, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.OnHpChange, arg_32_0._onHpChange, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.OnFightReconnectLastWork, arg_32_0._onFightReconnectLastWork, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_32_0._onSpineLoaded, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_32_0._onEntityDeadBefore, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.EntityDeadFinish, arg_32_0._onEntityDeadFinish, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartFightDisposeDone, arg_32_0._onRestartFightDisposeDone, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.AddMagicCircile, arg_32_0._onAddMagicCircile, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.SwitchFightendBgm, arg_32_0._onSwitchFightendBgm, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.PlayDialog, arg_32_0._onPlayDialog, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayDialog, arg_32_0._onAfterPlayDialog, arg_32_0)
	FightController.instance:unregisterCallback(FightEvent.ReplayBgmAfterAVG, arg_32_0.onReplayBgmAfterAVG, arg_32_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_32_0._onLevelLoaded, arg_32_0, LuaEventSystem.Low)
end

return var_0_0
