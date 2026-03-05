-- chunkname: @modules/logic/rouge2/start/controller/Rouge2_SystemController.lua

module("modules.logic.rouge2.start.controller.Rouge2_SystemController", package.seeall)

local Rouge2_SystemController = class("Rouge2_SystemController", BaseController)

function Rouge2_SystemController:isRecommendHero(heroId)
	local curSystemId = Rouge2_Model.instance:getCurTeamSystemId()

	if not heroId or not curSystemId or curSystemId == Rouge2_Enum.UnselectTeamSystemId then
		return
	end

	return self:checkHeroContainBattleTag(heroId, tostring(curSystemId))
end

function Rouge2_SystemController:getHeroListByBattleTag(tagId)
	local resultList = {}
	local checkHeroIdMap = {}
	local heroList = HeroConfig.instance:getHeroListByBattleTag(tagId)

	if heroList then
		for _, heroCo in ipairs(heroList) do
			if self:checkHeroContainBattleTag(heroCo.id, tagId) then
				table.insert(resultList, heroCo)
			end

			checkHeroIdMap[heroCo.id] = true
		end
	end

	local allHeroList = HeroModel.instance:getAllHero()

	if allHeroList then
		for heroId in pairs(allHeroList) do
			if not checkHeroIdMap[heroId] then
				if self:checkHeroContainBattleTag(heroId, tagId) then
					local heroCo = HeroConfig.instance:getHeroCO(heroId)

					table.insert(resultList, heroCo)
				end

				checkHeroIdMap[heroId] = true
			end
		end
	end

	return resultList
end

function Rouge2_SystemController:checkHeroContainBattleTag(heroId, tagId)
	local battleTagList = self:getHeroBattleTagList(heroId)
	local isContain = self:isContainBattleTag(battleTagList, tagId)

	return isContain
end

function Rouge2_SystemController:getHeroBattleTagList(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return HeroConfig.instance:getHeroBattleTagList(heroId)
	end

	local battleTagStr = heroMo:getHeroBattleTag()

	return battleTagStr and string.split(battleTagStr, "#")
end

function Rouge2_SystemController:isContainBattleTag(battleTagList, targetTag)
	if battleTagList and targetTag then
		return tabletool.indexOf(battleTagList, targetTag) ~= nil
	end
end

function Rouge2_SystemController:hasAnyRecommendHero(battleTag)
	if string.nilorempty(battleTag) then
		return
	end

	local allHeroList = HeroModel.instance:getAllHero()

	if allHeroList then
		for heroId in pairs(allHeroList) do
			if self:checkHeroContainBattleTag(heroId, battleTag) then
				return true
			end
		end
	end
end

Rouge2_SystemController.instance = Rouge2_SystemController.New()

return Rouge2_SystemController
