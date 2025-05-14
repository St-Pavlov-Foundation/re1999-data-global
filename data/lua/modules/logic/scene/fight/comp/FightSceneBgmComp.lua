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
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0, LuaEventSystem.Low)
end

function var_0_0._onLevelLoaded(arg_3_0, arg_3_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	local var_3_0 = arg_3_0:_getCurBgAudioId()

	if var_3_0 ~= arg_3_0._bgAudioId then
		arg_3_0._bgAudioId = var_3_0

		arg_3_0:_playBgm()
	end

	arg_3_0:_playAmbientSound()
end

function var_0_0._playBgm(arg_4_0)
	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Fight, arg_4_0._bgAudioId, AudioEnum.Bgm.Stop_FightingMusic)
end

function var_0_0._onStartSequenceStart(arg_5_0)
	local var_5_0 = true

	if arg_5_0:_getConfig(nil, 0, 11, 0) then
		var_5_0 = false
	end

	if var_5_0 then
		arg_5_0:_switchMonsterGroup()
	end
end

function var_0_0._switchMonsterGroup(arg_6_0)
	FightAudioMgr.instance:setSwitch(arg_6_0._cur_switch or FightEnum.AudioSwitch.Fightnormal)
end

function var_0_0._onSkillPlayFinish(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0:_needDealFinishTimeline(arg_7_1, arg_7_4) then
		return
	end
end

function var_0_0._needDealFinishTimeline(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = FightModel.instance:getFightParam()

	if not arg_8_1 or not arg_8_1:getMO() then
		return
	end

	local var_8_1 = arg_8_0:_getConfig(var_8_0.episodeId, arg_8_1:getMO().modelId, 9, arg_8_2)

	if not var_8_1 then
		return
	end

	if arg_8_0._cur_switch == var_8_1.switch then
		return
	end

	arg_8_0._cur_switch = var_8_1.switch

	arg_8_0:_switchMonsterGroup()

	return true
end

function var_0_0._onSkillPlayStart(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_0:_needDealPlayTimeline(arg_9_1, arg_9_4) then
		return
	end

	local var_9_0 = arg_9_0:needDealBgm(arg_9_3.fromId, 1, arg_9_3.actId)

	if not var_9_0 then
		return
	end

	if arg_9_0._cur_switch == var_9_0.switch then
		return
	end

	arg_9_0._cur_switch = var_9_0.switch

	arg_9_0:_switchMonsterGroup()
end

function var_0_0._needDealPlayTimeline(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = FightModel.instance:getFightParam()

	if not arg_10_1 or not arg_10_1:getMO() then
		return
	end

	local var_10_1 = arg_10_0:_getConfig(var_10_0.episodeId, arg_10_1:getMO().modelId, 8, arg_10_2)

	if not var_10_1 then
		return
	end

	if arg_10_0._cur_switch == var_10_1.switch then
		return
	end

	arg_10_0._cur_switch = var_10_1.switch

	arg_10_0:_switchMonsterGroup()

	return true
end

function var_0_0._onBuffUpdate(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_2 ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local var_11_0 = arg_11_0:needDealBgm(arg_11_1, 2, arg_11_3)

	if not var_11_0 then
		return
	end

	if arg_11_0._cur_switch == var_11_0.switch then
		return
	end

	arg_11_0._cur_switch = var_11_0.switch

	arg_11_0:_switchMonsterGroup()
end

function var_0_0._onHpChange(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:needDealBgm(arg_12_1.id, 3)

	if not var_12_0 then
		return
	end

	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		table.insert(var_12_1, iter_12_1)
	end

	table.sort(var_12_1, var_0_0.hpSortFunc)

	local var_12_2 = arg_12_1:getMO()
	local var_12_3 = var_12_2.currentHp / (var_12_2.attrMO and var_12_2.attrMO.hp > 0 and var_12_2.attrMO.hp or 1) * 100
	local var_12_4 = arg_12_0._cur_switch

	for iter_12_2, iter_12_3 in ipairs(var_12_1) do
		if var_12_3 <= tonumber(iter_12_3.param) then
			arg_12_0._cur_switch = iter_12_3.switch
		end
	end

	if var_12_4 == arg_12_0._cur_switch then
		return
	end

	arg_12_0:_switchMonsterGroup()
end

function var_0_0.hpSortFunc(arg_13_0, arg_13_1)
	return tonumber(arg_13_0.param) > tonumber(arg_13_1.param)
end

function var_0_0._detectDefaultSwitch(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:_getConfig(arg_14_1, 0, 4, "0")

	if not var_14_0 then
		return
	end

	if arg_14_0._cur_switch == var_14_0.switch then
		return
	end

	arg_14_0._cur_switch = var_14_0.switch
end

function var_0_0.needPlayVictory(arg_15_0)
	local var_15_0 = FightModel.instance:getFightParam()

	if not arg_15_0:_getConfig(var_15_0.episodeId, 0, 6, "0") then
		return
	end

	return true
end

function var_0_0._onSwitchFightendBgm(arg_16_0)
	if not arg_16_0:_getConfig(nil, 0, 12, 0) then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Fightend)
	end
end

function var_0_0._onSpineLoaded(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:needDealBgm(arg_17_1.unitSpawn.id, 5, 0)

	if not var_17_0 then
		return
	end

	if arg_17_0._cur_switch == var_17_0.switch then
		return
	end

	arg_17_0._cur_switch = var_17_0.switch

	arg_17_0:_switchMonsterGroup()
end

function var_0_0._onEntityDeadBefore(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:needDealBgm(arg_18_1, 7, 0)

	if not var_18_0 then
		return
	end

	if arg_18_0._cur_switch == var_18_0.switch then
		return
	end

	arg_18_0._cur_switch = var_18_0.switch

	arg_18_0:_switchMonsterGroup()
end

function var_0_0._onEntityDeadFinish(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:_getConfig(nil, arg_19_1, 15, 0)

	if not var_19_0 then
		return
	end

	if arg_19_0._cur_switch == var_19_0.switch then
		return
	end

	arg_19_0._cur_switch = var_19_0.switch

	arg_19_0:_switchMonsterGroup()
end

function var_0_0._onAddMagicCircile(arg_20_0, arg_20_1)
	local var_20_0 = FightModel.instance:getFightParam()
	local var_20_1 = arg_20_0:_getConfig(var_20_0.episodeId, 0, 10, tostring(arg_20_1))

	if not var_20_1 then
		return
	end

	if arg_20_0._cur_switch == var_20_1.switch then
		return
	end

	arg_20_0._cur_switch = var_20_1.switch

	arg_20_0:_switchMonsterGroup()

	return true
end

function var_0_0._onFightReconnectLastWork(arg_21_0)
	local var_21_0 = FightHelper.getAllEntitys()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		local var_21_1 = iter_21_1:getMO()

		if var_21_1 then
			local var_21_2 = var_21_1:getBuffList()

			for iter_21_2, iter_21_3 in ipairs(var_21_2) do
				arg_21_0:_onBuffUpdate(iter_21_1.id, FightEnum.EffectType.BUFFADD, iter_21_3.buffId)
			end
		end

		arg_21_0:_onHpChange(iter_21_1)
	end
end

function var_0_0.needDealBgm(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = FightHelper.getEntity(arg_22_1)

	if not var_22_0 or not var_22_0:getMO() then
		return
	end

	local var_22_1 = FightModel.instance:getFightParam()
	local var_22_2 = arg_22_0:_getConfig(var_22_1.episodeId, var_22_0:getMO().modelId, arg_22_2, tostring(arg_22_3))

	if not var_22_2 then
		return
	end

	return var_22_2
end

function var_0_0._getConfig(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = FightModel.instance:getFightParam()
	local var_23_1 = var_23_0.battleId
	local var_23_2 = lua_fight_music.configDict[arg_23_1 or var_23_0.episodeId] or lua_fight_music.configDict[0]

	if var_23_2 then
		var_23_2 = var_23_2[var_23_1] or var_23_2[0]

		if var_23_2 and var_23_2[arg_23_2] and var_23_2[arg_23_2][arg_23_3] then
			if arg_23_3 == 3 then
				return var_23_2[arg_23_2][arg_23_3]
			end

			return var_23_2[arg_23_2][arg_23_3][tostring(arg_23_4)]
		end
	end
end

function var_0_0._getCurBgAudioId(arg_24_0)
	local var_24_0 = FightModel.instance:getFightParam()
	local var_24_1 = var_24_0 and var_24_0.battleId and lua_battle.configDict[var_24_0.battleId]

	if var_24_1 and var_24_1.bgmevent and var_24_1.bgmevent > 0 then
		return var_24_1.bgmevent
	end

	local var_24_2 = FightModel.instance:getCurWaveId()
	local var_24_3 = var_24_0:getSceneLevel(var_24_2)
	local var_24_4 = lua_scene_level.configDict[var_24_3]

	if var_24_4.bgm and var_24_4.bgm > 0 then
		return var_24_4.bgm
	end
end

function var_0_0._playAmbientSound(arg_25_0)
	local var_25_0 = FightModel.instance:getCurWaveId()
	local var_25_1 = FightModel.instance:getFightParam():getSceneLevel(var_25_0)
	local var_25_2 = lua_scene_level.configDict[var_25_1]

	if var_25_2.ambientSound and var_25_2.ambientSound > 0 and var_25_2.ambientSound ~= arg_25_0._ambientSound then
		arg_25_0._ambientSound = var_25_2.ambientSound

		AudioMgr.instance:trigger(arg_25_0._ambientSound)
	end
end

function var_0_0.stopBgm(arg_26_0)
	if arg_26_0._bgAudioId then
		arg_26_0._stopBgAudioId = arg_26_0._bgAudioId
		arg_26_0._bgAudioId = nil

		AudioBgmManager.instance:stopAndRemove(AudioBgmEnum.Layer.Fight)
	end

	arg_26_0._ambientSound = nil

	AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
end

function var_0_0.resumeBgm(arg_27_0)
	arg_27_0._cur_switch = nil

	if arg_27_0._stopBgAudioId then
		arg_27_0._bgAudioId = arg_27_0._stopBgAudioId
		arg_27_0._stopBgAudioId = nil

		arg_27_0:_playBgm()
		arg_27_0:_playAmbientSound()
	end
end

function var_0_0._onRestartFightDisposeDone(arg_28_0)
	arg_28_0._cur_switch = nil

	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)

	local var_28_0 = FightModel.instance:getFightParam()

	if arg_28_0._bgAudioId then
		arg_28_0:_detectDefaultSwitch(var_28_0.episodeId)
	end
end

function var_0_0._onPlayDialog(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:_getConfig(nil, 0, 13, arg_29_1)

	if not var_29_0 then
		return
	end

	if arg_29_0._cur_switch == var_29_0.switch then
		return
	end

	arg_29_0._cur_switch = var_29_0.switch

	arg_29_0:_switchMonsterGroup()

	return true
end

function var_0_0._onAfterPlayDialog(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:_getConfig(nil, 0, 14, arg_30_1)

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

function var_0_0.onSceneClose(arg_31_0)
	arg_31_0:stopBgm()

	arg_31_0._stopBgAudioId = nil
	arg_31_0._cur_switch = nil

	FightController.instance:unregisterCallback(FightEvent.OnFightReconnect, arg_31_0._switchMonsterGroup, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceStart, arg_31_0._onStartSequenceStart, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, arg_31_0._switchMonsterGroup, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_31_0._onSkillPlayStart, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_31_0._onSkillPlayFinish, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_31_0._onBuffUpdate, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.OnHpChange, arg_31_0._onHpChange, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.OnFightReconnectLastWork, arg_31_0._onFightReconnectLastWork, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_31_0._onSpineLoaded, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_31_0._onEntityDeadBefore, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.EntityDeadFinish, arg_31_0._onEntityDeadFinish, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartFightDisposeDone, arg_31_0._onRestartFightDisposeDone, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.AddMagicCircile, arg_31_0._onAddMagicCircile, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.SwitchFightendBgm, arg_31_0._onSwitchFightendBgm, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.PlayDialog, arg_31_0._onPlayDialog, arg_31_0)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayDialog, arg_31_0._onAfterPlayDialog, arg_31_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_31_0._onLevelLoaded, arg_31_0, LuaEventSystem.Low)
end

return var_0_0
