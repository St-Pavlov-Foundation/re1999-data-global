-- chunkname: @modules/logic/fight/system/work/FightWorkAddUseCardContainer.lua

module("modules.logic.fight.system.work.FightWorkAddUseCardContainer", package.seeall)

local FightWorkAddUseCardContainer = class("FightWorkAddUseCardContainer", FightStepEffectFlow)

FightWorkAddUseCardContainer.IndexList = {}

function FightWorkAddUseCardContainer:onStart()
	local dataList = self:getAdjacentSameEffectList(nil, false)

	self:customPlayEffectData(dataList)

	local indexList = FightWorkAddUseCardContainer.IndexList

	tabletool.clear(indexList)

	local waitTime = 0.5

	for _, data in ipairs(dataList) do
		local actEffectData = data.actEffectData
		local index = actEffectData.effectNum
		local curUsedCards = FightPlayCardModel.instance:getUsedCards()

		if index - 1 > #curUsedCards then
			index = #curUsedCards + 1
		end

		table.insert(indexList, index)
		FightPlayCardModel.instance:addUseCard(index, actEffectData.cardInfo, actEffectData.effectNum1)

		if FightHeroALFComp.ALFSkillDict[actEffectData.effectNum1] then
			waitTime = 1.8
		end
	end

	FightController.instance:dispatchEvent(FightEvent.AddUseCard, indexList)
	FightController.instance:dispatchEvent(FightEvent.AfterAddUseCardContainer, self.fightStepData)
	self:com_registTimer(self._delayAfterPerformance, waitTime / FightModel.instance:getUISpeed())
end

function FightWorkAddUseCardContainer:customPlayEffectData(dataList)
	for _, data in ipairs(dataList) do
		FightDataHelper.playEffectData(data.actEffectData)
	end
end

function FightWorkAddUseCardContainer:clearWork()
	return
end

return FightWorkAddUseCardContainer
