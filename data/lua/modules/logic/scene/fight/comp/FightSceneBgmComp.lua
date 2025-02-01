module("modules.logic.scene.fight.comp.FightSceneBgmComp", package.seeall)

slot0 = class("FightSceneBgmComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._stopBgAudioId = nil
	slot0._bgAudioId = slot0:_getCurBgAudioId()

	if slot0._bgAudioId then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)
		slot0:_playBgm()
		slot0:_detectDefaultSwitch(FightModel.instance:getFightParam().episodeId)
	end

	slot0:_playAmbientSound()
	FightController.instance:registerCallback(FightEvent.OnFightReconnect, slot0._switchMonsterGroup, slot0)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceStart, slot0._onStartSequenceStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceStart, slot0._switchMonsterGroup, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	FightController.instance:registerCallback(FightEvent.OnHpChange, slot0._onHpChange, slot0)
	FightController.instance:registerCallback(FightEvent.OnFightReconnectLastWork, slot0._onFightReconnectLastWork, slot0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, slot0._onEntityDeadBefore, slot0)
	FightController.instance:registerCallback(FightEvent.EntityDeadFinish, slot0._onEntityDeadFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartFightDisposeDone, slot0._onRestartFightDisposeDone, slot0)
	FightController.instance:registerCallback(FightEvent.AddMagicCircile, slot0._onAddMagicCircile, slot0)
	FightController.instance:registerCallback(FightEvent.SwitchFightendBgm, slot0._onSwitchFightendBgm, slot0)
	FightController.instance:registerCallback(FightEvent.PlayDialog, slot0._onPlayDialog, slot0)
	FightController.instance:registerCallback(FightEvent.AfterPlayDialog, slot0._onAfterPlayDialog, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0, LuaEventSystem.Low)
end

function slot0._onLevelLoaded(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	if slot0:_getCurBgAudioId() ~= slot0._bgAudioId then
		slot0._bgAudioId = slot2

		slot0:_playBgm()
	end

	slot0:_playAmbientSound()
end

function slot0._playBgm(slot0)
	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Fight, slot0._bgAudioId, AudioEnum.Bgm.Stop_FightingMusic)
end

function slot0._onStartSequenceStart(slot0)
	slot1 = true

	if slot0:_getConfig(nil, 0, 11, 0) then
		slot1 = false
	end

	if slot1 then
		slot0:_switchMonsterGroup()
	end
end

function slot0._switchMonsterGroup(slot0)
	FightAudioMgr.instance:setSwitch(slot0._cur_switch or FightEnum.AudioSwitch.Fightnormal)
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3, slot4)
	if slot0:_needDealFinishTimeline(slot1, slot4) then
		return
	end
end

function slot0._needDealFinishTimeline(slot0, slot1, slot2)
	slot3 = FightModel.instance:getFightParam()

	if not slot1 or not slot1:getMO() then
		return
	end

	if not slot0:_getConfig(slot3.episodeId, slot1:getMO().modelId, 9, slot2) then
		return
	end

	if slot0._cur_switch == slot4.switch then
		return
	end

	slot0._cur_switch = slot4.switch

	slot0:_switchMonsterGroup()

	return true
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3, slot4)
	if slot0:_needDealPlayTimeline(slot1, slot4) then
		return
	end

	if not slot0:needDealBgm(slot3.fromId, 1, slot3.actId) then
		return
	end

	if slot0._cur_switch == slot5.switch then
		return
	end

	slot0._cur_switch = slot5.switch

	slot0:_switchMonsterGroup()
end

function slot0._needDealPlayTimeline(slot0, slot1, slot2)
	slot3 = FightModel.instance:getFightParam()

	if not slot1 or not slot1:getMO() then
		return
	end

	if not slot0:_getConfig(slot3.episodeId, slot1:getMO().modelId, 8, slot2) then
		return
	end

	if slot0._cur_switch == slot4.switch then
		return
	end

	slot0._cur_switch = slot4.switch

	slot0:_switchMonsterGroup()

	return true
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot2 ~= FightEnum.EffectType.BUFFADD then
		return
	end

	if not slot0:needDealBgm(slot1, 2, slot3) then
		return
	end

	if slot0._cur_switch == slot5.switch then
		return
	end

	slot0._cur_switch = slot5.switch

	slot0:_switchMonsterGroup()
end

function slot0._onHpChange(slot0, slot1)
	if not slot0:needDealBgm(slot1.id, 3) then
		return
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		table.insert(slot3, slot8)
	end

	table.sort(slot3, uv0.hpSortFunc)

	slot4 = slot1:getMO()
	slot8 = slot0._cur_switch

	for slot12, slot13 in ipairs(slot3) do
		if slot4.currentHp / (slot4.attrMO and slot4.attrMO.hp > 0 and slot4.attrMO.hp or 1) * 100 <= tonumber(slot13.param) then
			slot0._cur_switch = slot13.switch
		end
	end

	if slot8 == slot0._cur_switch then
		return
	end

	slot0:_switchMonsterGroup()
end

function slot0.hpSortFunc(slot0, slot1)
	return tonumber(slot1.param) < tonumber(slot0.param)
end

function slot0._detectDefaultSwitch(slot0, slot1)
	if not slot0:_getConfig(slot1, 0, 4, "0") then
		return
	end

	if slot0._cur_switch == slot2.switch then
		return
	end

	slot0._cur_switch = slot2.switch
end

function slot0.needPlayVictory(slot0)
	if not slot0:_getConfig(FightModel.instance:getFightParam().episodeId, 0, 6, "0") then
		return
	end

	return true
end

function slot0._onSwitchFightendBgm(slot0)
	if not slot0:_getConfig(nil, 0, 12, 0) then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Fightend)
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if not slot0:needDealBgm(slot1.unitSpawn.id, 5, 0) then
		return
	end

	if slot0._cur_switch == slot2.switch then
		return
	end

	slot0._cur_switch = slot2.switch

	slot0:_switchMonsterGroup()
end

function slot0._onEntityDeadBefore(slot0, slot1)
	if not slot0:needDealBgm(slot1, 7, 0) then
		return
	end

	if slot0._cur_switch == slot2.switch then
		return
	end

	slot0._cur_switch = slot2.switch

	slot0:_switchMonsterGroup()
end

function slot0._onEntityDeadFinish(slot0, slot1)
	if not slot0:_getConfig(nil, slot1, 15, 0) then
		return
	end

	if slot0._cur_switch == slot2.switch then
		return
	end

	slot0._cur_switch = slot2.switch

	slot0:_switchMonsterGroup()
end

function slot0._onAddMagicCircile(slot0, slot1)
	if not slot0:_getConfig(FightModel.instance:getFightParam().episodeId, 0, 10, tostring(slot1)) then
		return
	end

	if slot0._cur_switch == slot3.switch then
		return
	end

	slot0._cur_switch = slot3.switch

	slot0:_switchMonsterGroup()

	return true
end

function slot0._onFightReconnectLastWork(slot0)
	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		if slot6:getMO() then
			for slot12, slot13 in ipairs(slot7:getBuffList()) do
				slot0:_onBuffUpdate(slot6.id, FightEnum.EffectType.BUFFADD, slot13.buffId)
			end
		end

		slot0:_onHpChange(slot6)
	end
end

function slot0.needDealBgm(slot0, slot1, slot2, slot3)
	if not FightHelper.getEntity(slot1) or not slot4:getMO() then
		return
	end

	if not slot0:_getConfig(FightModel.instance:getFightParam().episodeId, slot4:getMO().modelId, slot2, tostring(slot3)) then
		return
	end

	return slot6
end

function slot0._getConfig(slot0, slot1, slot2, slot3, slot4)
	if (lua_fight_music.configDict[slot1 or slot5.episodeId] or lua_fight_music.configDict[0]) and (slot7[FightModel.instance:getFightParam().battleId] or slot7[0]) and slot7[slot2] and slot7[slot2][slot3] then
		if slot3 == 3 then
			return slot7[slot2][slot3]
		end

		return slot7[slot2][slot3][tostring(slot4)]
	end
end

function slot0._getCurBgAudioId(slot0)
	if FightModel.instance:getFightParam() and slot1.battleId and lua_battle.configDict[slot1.battleId] and slot2.bgmevent and slot2.bgmevent > 0 then
		return slot2.bgmevent
	end

	if lua_scene_level.configDict[slot1:getSceneLevel(FightModel.instance:getCurWaveId())].bgm and slot5.bgm > 0 then
		return slot5.bgm
	end
end

function slot0._playAmbientSound(slot0)
	if lua_scene_level.configDict[FightModel.instance:getFightParam():getSceneLevel(FightModel.instance:getCurWaveId())].ambientSound and slot3.ambientSound > 0 and slot3.ambientSound ~= slot0._ambientSound then
		slot0._ambientSound = slot3.ambientSound

		AudioMgr.instance:trigger(slot0._ambientSound)
	end
end

function slot0.stopBgm(slot0)
	if slot0._bgAudioId then
		slot0._stopBgAudioId = slot0._bgAudioId
		slot0._bgAudioId = nil

		AudioBgmManager.instance:stopAndRemove(AudioBgmEnum.Layer.Fight)
	end

	slot0._ambientSound = nil

	AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
end

function slot0.resumeBgm(slot0)
	slot0._cur_switch = nil

	if slot0._stopBgAudioId then
		slot0._bgAudioId = slot0._stopBgAudioId
		slot0._stopBgAudioId = nil

		slot0:_playBgm()
		slot0:_playAmbientSound()
	end
end

function slot0._onRestartFightDisposeDone(slot0)
	slot0._cur_switch = nil

	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)

	if slot0._bgAudioId then
		slot0:_detectDefaultSwitch(FightModel.instance:getFightParam().episodeId)
	end
end

function slot0._onPlayDialog(slot0, slot1)
	if not slot0:_getConfig(nil, 0, 13, slot1) then
		return
	end

	if slot0._cur_switch == slot2.switch then
		return
	end

	slot0._cur_switch = slot2.switch

	slot0:_switchMonsterGroup()

	return true
end

function slot0._onAfterPlayDialog(slot0, slot1)
	if not slot0:_getConfig(nil, 0, 14, slot1) then
		return
	end

	if slot0._cur_switch == slot2.switch then
		return
	end

	slot0._cur_switch = slot2.switch

	slot0:_switchMonsterGroup()

	return true
end

function slot0.onSceneClose(slot0)
	slot0:stopBgm()

	slot0._stopBgAudioId = nil
	slot0._cur_switch = nil

	FightController.instance:unregisterCallback(FightEvent.OnFightReconnect, slot0._switchMonsterGroup, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceStart, slot0._onStartSequenceStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, slot0._switchMonsterGroup, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnHpChange, slot0._onHpChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnFightReconnectLastWork, slot0._onFightReconnectLastWork, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, slot0._onEntityDeadBefore, slot0)
	FightController.instance:unregisterCallback(FightEvent.EntityDeadFinish, slot0._onEntityDeadFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartFightDisposeDone, slot0._onRestartFightDisposeDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.AddMagicCircile, slot0._onAddMagicCircile, slot0)
	FightController.instance:unregisterCallback(FightEvent.SwitchFightendBgm, slot0._onSwitchFightendBgm, slot0)
	FightController.instance:unregisterCallback(FightEvent.PlayDialog, slot0._onPlayDialog, slot0)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayDialog, slot0._onAfterPlayDialog, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0, LuaEventSystem.Low)
end

return slot0
