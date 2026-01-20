-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventChangeScene.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventChangeScene", package.seeall)

local FightTLEventChangeScene = class("FightTLEventChangeScene", FightTimelineTrackItem)

function FightTLEventChangeScene:onTrackStart(fightStepData, duration, paramsArr)
	if not string.nilorempty(paramsArr[1]) then
		local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)

		fightScene.level:loadLevelNoEffect(tonumber(paramsArr[1]))
	end
end

function FightTLEventChangeScene:onTrackEnd()
	return
end

return FightTLEventChangeScene
