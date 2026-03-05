-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventChangeSceneByEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventChangeSceneByEffect", package.seeall)

local FightTLEventChangeSceneByEffect = class("FightTLEventChangeSceneByEffect", FightTimelineTrackItem)

function FightTLEventChangeSceneByEffect:onTrackStart(fightStepData, duration, paramsArr)
	local actEffect = FightHelper.getActEffectData(FightEnum.EffectType.CHANGESCENE, fightStepData)

	if not actEffect then
		return
	end

	local levelId = actEffect.effectNum

	if levelId < 1 then
		return
	end

	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)

	local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)

	fightScene.level:loadLevelNoEffect(levelId)
end

function FightTLEventChangeSceneByEffect:_onLevelLoaded()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)

	local entityDic = FightGameMgr.entityMgr:getAllEntity()

	if entityDic then
		for _, entity in pairs(entityDic) do
			entity:resetStandPos()
		end
	end
end

function FightTLEventChangeSceneByEffect:onTrackEnd()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)
end

function FightTLEventChangeSceneByEffect:onDestructor()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)
end

return FightTLEventChangeSceneByEffect
