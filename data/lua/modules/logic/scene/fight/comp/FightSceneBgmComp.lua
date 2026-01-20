-- chunkname: @modules/logic/scene/fight/comp/FightSceneBgmComp.lua

module("modules.logic.scene.fight.comp.FightSceneBgmComp", package.seeall)

local FightSceneBgmComp = class("FightSceneBgmComp", BaseSceneComp)

function FightSceneBgmComp:onInit()
	return
end

function FightSceneBgmComp:onSceneStart(sceneId, levelId)
	self._stopBgAudioId = nil

	local fightParam = FightModel.instance:getFightParam()

	self._bgAudioId = self:_getCurBgAudioId()

	if self._bgAudioId then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)
		self:_playBgm()
		self:_detectDefaultSwitch(fightParam.episodeId)
	end

	self:_playAmbientSound()
	FightController.instance:registerCallback(FightEvent.OnFightReconnect, self._switchMonsterGroup, self)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceStart, self._onStartSequenceStart, self)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceStart, self._switchMonsterGroup, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	FightController.instance:registerCallback(FightEvent.OnHpChange, self._onHpChange, self)
	FightController.instance:registerCallback(FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork, self)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, self._onEntityDeadBefore, self)
	FightController.instance:registerCallback(FightEvent.EntityDeadFinish, self._onEntityDeadFinish, self)
	FightController.instance:registerCallback(FightEvent.OnRestartFightDisposeDone, self._onRestartFightDisposeDone, self)
	FightController.instance:registerCallback(FightEvent.AddMagicCircile, self._onAddMagicCircile, self)
	FightController.instance:registerCallback(FightEvent.SwitchFightendBgm, self._onSwitchFightendBgm, self)
	FightController.instance:registerCallback(FightEvent.PlayDialog, self._onPlayDialog, self)
	FightController.instance:registerCallback(FightEvent.AfterPlayDialog, self._onAfterPlayDialog, self)
	FightController.instance:registerCallback(FightEvent.ReplayBgmAfterAVG, self.onReplayBgmAfterAVG, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self, LuaEventSystem.Low)
end

function FightSceneBgmComp:onReplayBgmAfterAVG()
	self:_playBgm()

	self._ambientSound = nil

	self:_playAmbientSound()
	FightAudioMgr.instance:setSwitch(self._cur_switch or FightEnum.AudioSwitch.Fightnormal)
end

function FightSceneBgmComp:_onLevelLoaded(levelId)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	local id = self:_getCurBgAudioId()

	if id ~= self._bgAudioId then
		self._bgAudioId = id

		self:_playBgm()
	end

	self:_playAmbientSound()
end

function FightSceneBgmComp:_playBgm()
	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Fight, self._bgAudioId, AudioEnum.Bgm.Stop_FightingMusic)
end

function FightSceneBgmComp:_onStartSequenceStart()
	local canSwitch = true
	local config = self:_getConfig(nil, 0, 11, 0)

	if config then
		canSwitch = false
	end

	if canSwitch then
		self:_switchMonsterGroup()
	end
end

function FightSceneBgmComp:_switchMonsterGroup()
	FightAudioMgr.instance:setSwitch(self._cur_switch or FightEnum.AudioSwitch.Fightnormal)
end

function FightSceneBgmComp:_onSkillPlayFinish(entity, skillId, stepData, timelineName)
	if self:_needDealFinishTimeline(entity, timelineName) then
		return
	end
end

function FightSceneBgmComp:_needDealFinishTimeline(entity, timelineName)
	local fightParam = FightModel.instance:getFightParam()

	if not entity or not entity:getMO() then
		return
	end

	local config = self:_getConfig(fightParam.episodeId, entity:getMO().modelId, 9, timelineName)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightSceneBgmComp:_onSkillPlayStart(entity, skillId, stepData, timelineName)
	if self:_needDealPlayTimeline(entity, timelineName) then
		return
	end

	local config = self:needDealBgm(stepData.fromId, 1, stepData.actId)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightSceneBgmComp:_needDealPlayTimeline(entity, timelineName)
	local fightParam = FightModel.instance:getFightParam()

	if not entity or not entity:getMO() then
		return
	end

	local config = self:_getConfig(fightParam.episodeId, entity:getMO().modelId, 8, timelineName)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightSceneBgmComp:_onBuffUpdate(targetId, effectType, buffId, uid)
	if effectType ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local config = self:needDealBgm(targetId, 2, buffId)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightSceneBgmComp:_onHpChange(target_entity)
	local configs = self:needDealBgm(target_entity.id, 3)

	if not configs then
		return
	end

	local temp_list = {}

	for k, v in pairs(configs) do
		table.insert(temp_list, v)
	end

	table.sort(temp_list, FightSceneBgmComp.hpSortFunc)

	local entity_mo = target_entity:getMO()
	local currentHp = entity_mo.currentHp
	local maxHp = entity_mo.attrMO and entity_mo.attrMO.hp > 0 and entity_mo.attrMO.hp or 1
	local percent = currentHp / maxHp * 100
	local last_switch = self._cur_switch

	for i, v in ipairs(temp_list) do
		if percent <= tonumber(v.param) then
			self._cur_switch = v.switch
		end
	end

	if last_switch == self._cur_switch then
		return
	end

	self:_switchMonsterGroup()
end

function FightSceneBgmComp.hpSortFunc(item1, item2)
	return tonumber(item1.param) > tonumber(item2.param)
end

function FightSceneBgmComp:_detectDefaultSwitch(episodeId)
	local config = self:_getConfig(episodeId, 0, 4, "0")

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch
end

function FightSceneBgmComp:needPlayVictory()
	local fightParam = FightModel.instance:getFightParam()
	local config = self:_getConfig(fightParam.episodeId, 0, 6, "0")

	if not config then
		return
	end

	return true
end

function FightSceneBgmComp:_onSwitchFightendBgm()
	if not self:_getConfig(nil, 0, 12, 0) then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Fightend)
	end
end

function FightSceneBgmComp:_onSpineLoaded(spine)
	local config = self:needDealBgm(spine.unitSpawn.id, 5, 0)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightSceneBgmComp:_onEntityDeadBefore(entityId)
	local config = self:needDealBgm(entityId, 7, 0)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightSceneBgmComp:_onEntityDeadFinish(modelId)
	local config = self:_getConfig(nil, modelId, 15, 0)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightSceneBgmComp:_onAddMagicCircile(magicCircleId)
	local fightParam = FightModel.instance:getFightParam()
	local config = self:_getConfig(fightParam.episodeId, 0, 10, tostring(magicCircleId))

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightSceneBgmComp:_onFightReconnectLastWork()
	local all_entity = FightHelper.getAllEntitys()

	for i, v in ipairs(all_entity) do
		local tar_entity_mo = v:getMO()

		if tar_entity_mo then
			local buff_list = tar_entity_mo:getBuffList()

			for index, buff in ipairs(buff_list) do
				self:_onBuffUpdate(v.id, FightEnum.EffectType.BUFFADD, buff.buffId)
			end
		end

		self:_onHpChange(v)
	end
end

function FightSceneBgmComp:needDealBgm(entity_id, deal_type, param)
	local entity = FightHelper.getEntity(entity_id)

	if not entity or not entity:getMO() then
		return
	end

	local fightParam = FightModel.instance:getFightParam()
	local config = self:_getConfig(fightParam.episodeId, entity:getMO().modelId, deal_type, tostring(param))

	if not config then
		return
	end

	return config
end

function FightSceneBgmComp:_getConfig(id, monster, invokeType, param)
	local fightParam = FightModel.instance:getFightParam()
	local battleId = fightParam.battleId
	local configDict = lua_fight_music.configDict[id or fightParam.episodeId]

	configDict = configDict or lua_fight_music.configDict[0]

	if configDict then
		configDict = configDict[battleId] or configDict[0]

		if configDict and configDict[monster] and configDict[monster][invokeType] then
			if invokeType == 3 then
				return configDict[monster][invokeType]
			end

			return configDict[monster][invokeType][tostring(param)]
		end
	end
end

function FightSceneBgmComp:_getCurBgAudioId()
	local fightParam = FightModel.instance:getFightParam()
	local battleCO = fightParam and fightParam.battleId and lua_battle.configDict[fightParam.battleId]

	if battleCO and battleCO.bgmevent and battleCO.bgmevent > 0 then
		return battleCO.bgmevent
	end

	local wave = FightModel.instance:getCurWaveId()
	local levelId = fightParam:getSceneLevel(wave)
	local sceneLevelCO = lua_scene_level.configDict[levelId]

	if sceneLevelCO.bgm and sceneLevelCO.bgm > 0 then
		return sceneLevelCO.bgm
	end
end

function FightSceneBgmComp:_playAmbientSound()
	local wave = FightModel.instance:getCurWaveId()
	local levelId = FightModel.instance:getFightParam():getSceneLevel(wave)
	local sceneLevelCO = lua_scene_level.configDict[levelId]

	if sceneLevelCO.ambientSound and sceneLevelCO.ambientSound > 0 and sceneLevelCO.ambientSound ~= self._ambientSound then
		self._ambientSound = sceneLevelCO.ambientSound

		AudioMgr.instance:trigger(self._ambientSound)
	end
end

function FightSceneBgmComp:stopBgm()
	if self._bgAudioId then
		self._stopBgAudioId = self._bgAudioId
		self._bgAudioId = nil

		AudioBgmManager.instance:stopAndRemove(AudioBgmEnum.Layer.Fight)
	end

	self._ambientSound = nil

	AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
end

function FightSceneBgmComp:resumeBgm()
	self._cur_switch = nil

	if self._stopBgAudioId then
		self._bgAudioId = self._stopBgAudioId
		self._stopBgAudioId = nil

		self:_playBgm()
		self:_playAmbientSound()
	end
end

function FightSceneBgmComp:_onRestartFightDisposeDone()
	self._cur_switch = nil

	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)

	local fightParam = FightModel.instance:getFightParam()

	if self._bgAudioId then
		self:_detectDefaultSwitch(fightParam.episodeId)
	end
end

function FightSceneBgmComp:_onPlayDialog(id)
	local config = self:_getConfig(nil, 0, 13, id)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightSceneBgmComp:_onAfterPlayDialog(id)
	local config = self:_getConfig(nil, 0, 14, id)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightSceneBgmComp:onSceneClose()
	self:stopBgm()

	self._stopBgAudioId = nil
	self._cur_switch = nil

	FightController.instance:unregisterCallback(FightEvent.OnFightReconnect, self._switchMonsterGroup, self)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceStart, self._onStartSequenceStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, self._switchMonsterGroup, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	FightController.instance:unregisterCallback(FightEvent.OnHpChange, self._onHpChange, self)
	FightController.instance:unregisterCallback(FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, self._onEntityDeadBefore, self)
	FightController.instance:unregisterCallback(FightEvent.EntityDeadFinish, self._onEntityDeadFinish, self)
	FightController.instance:unregisterCallback(FightEvent.OnRestartFightDisposeDone, self._onRestartFightDisposeDone, self)
	FightController.instance:unregisterCallback(FightEvent.AddMagicCircile, self._onAddMagicCircile, self)
	FightController.instance:unregisterCallback(FightEvent.SwitchFightendBgm, self._onSwitchFightendBgm, self)
	FightController.instance:unregisterCallback(FightEvent.PlayDialog, self._onPlayDialog, self)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayDialog, self._onAfterPlayDialog, self)
	FightController.instance:unregisterCallback(FightEvent.ReplayBgmAfterAVG, self.onReplayBgmAfterAVG, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self, LuaEventSystem.Low)
end

return FightSceneBgmComp
