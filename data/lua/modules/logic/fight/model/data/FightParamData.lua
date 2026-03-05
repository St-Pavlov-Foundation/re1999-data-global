-- chunkname: @modules/logic/fight/model/data/FightParamData.lua

module("modules.logic.fight.model.data.FightParamData", package.seeall)

local FightParamData = FightDataClass("FightParamData")

FightParamData.ParamKey = {
	ProgressId = 2,
	DoomsdayClock_Range1 = 4,
	ACT191_CUR_HP_RATE = 12,
	DoomsdayClock_Range4 = 7,
	ACT191_HUNTING = 10,
	DoomsdayClock_Range3 = 6,
	ACT191_MIN_HP_RATE = 9,
	ACT191_COIN = 11,
	DoomsdayClock_Offset = 8,
	ROUGE2_COIN = 14,
	ProgressSkill = 1,
	ROUGE2_REVIVAL_COIN = 15,
	DoomsdayClock_Value = 3,
	SceneId = 16,
	DoomsdayClock_Range2 = 5
}

function FightParamData:onConstructor(proto)
	for i, v in ipairs(proto) do
		self[v.key] = v.value
	end
end

function FightParamData:getKey(key)
	return self[key]
end

function FightParamData:isInit(key)
	return self.initDict[key]
end

function FightParamData:setInit(key)
	return
end

return FightParamData
