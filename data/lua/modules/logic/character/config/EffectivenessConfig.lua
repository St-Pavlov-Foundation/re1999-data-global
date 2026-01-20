-- chunkname: @modules/logic/character/config/EffectivenessConfig.lua

module("modules.logic.character.config.EffectivenessConfig", package.seeall)

local EffectivenessConfig = class("EffectivenessConfig", BaseConfig)

function EffectivenessConfig:ctor()
	self.subValue = 0.7
end

function EffectivenessConfig:reqConfigNames()
	return {
		"hero_effectiveness",
		"equip_effectiveness",
		"talent_effectiveness",
		"talent_scheme"
	}
end

function EffectivenessConfig:onConfigLoaded(configName, configTable)
	return
end

EffectivenessConfig.HeroRareRareEnum = {
	SR = 4,
	Other = 3,
	SSR = 5
}
EffectivenessConfig.EquipRareRareEnum = {
	SR = 4,
	Other = 3,
	SSR = 5
}

function EffectivenessConfig:calculateHeroEffectiveness(heroMo, isSub)
	local co = lua_hero_effectiveness.configDict[heroMo.level]
	local heroCo = heroMo.config
	local value

	if heroCo.rare == EffectivenessConfig.HeroRareRareEnum.SSR then
		value = co.ssr
	elseif heroCo.rare == EffectivenessConfig.HeroRareRareEnum.SR then
		value = co.sr
	else
		value = co.r
	end

	if isSub then
		return value * self.subValue
	end

	return value
end

function EffectivenessConfig:calculateHeroAverageEffectiveness(heroMoList, subHeroList)
	local resultValue = 0

	for i = 1, #heroMoList do
		resultValue = resultValue + self:calculateHeroEffectiveness(heroMoList[i])
	end

	for i = 1, #subHeroList do
		resultValue = resultValue + self:calculateHeroEffectiveness(subHeroList[i], true)
	end

	return resultValue / (#heroMoList + #subHeroList)
end

function EffectivenessConfig:calculateEquipEffectiveness(equipMo, isSub)
	local co = lua_equip_effectiveness.configDict[equipMo.level]
	local equipCo = equipMo.config
	local value

	if equipCo.rare == EffectivenessConfig.EquipRareRareEnum.SSR then
		value = co.ssr
	elseif equipCo.rare == EffectivenessConfig.EquipRareRareEnum.SR then
		value = co.sr
	else
		value = co.r
	end

	if isSub then
		return value * self.subValue
	end

	return value
end

function EffectivenessConfig:calculateEquipAverageEffectiveness(equipMoList)
	local resultValue = 0

	for i, equipMo in ipairs(equipMoList) do
		if i == 4 then
			resultValue = resultValue + self:calculateEquipEffectiveness(equipMo, true)
		else
			resultValue = resultValue + self:calculateEquipEffectiveness(equipMo)
		end
	end

	return #equipMoList ~= 0 and resultValue / #equipMoList or 0
end

function EffectivenessConfig:calculateTalentEffectiveness(heroMo, isSub)
	local co = lua_talent_effectiveness.configDict[heroMo.talent]
	local heroCo = heroMo.config
	local value

	if heroCo.rare == EffectivenessConfig.HeroRareRareEnum.SSR then
		value = co.ssr
	elseif heroCo.rare == EffectivenessConfig.HeroRareRareEnum.SR then
		value = co.sr
	else
		value = co.r
	end

	if isSub then
		return value * self.subValue
	end

	return value
end

function EffectivenessConfig:calculateTalentAverageEffectiveness(heroMoList, subHeroList)
	local resultValue = 0

	for i = 1, #heroMoList do
		resultValue = resultValue + self:calculateTalentEffectiveness(heroMoList[i])
	end

	for i = 1, #subHeroList do
		resultValue = resultValue + self:calculateTalentEffectiveness(subHeroList[i], true)
	end

	return resultValue / (#heroMoList + #subHeroList)
end

EffectivenessConfig.instance = EffectivenessConfig.New()

return EffectivenessConfig
