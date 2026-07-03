-- chunkname: @modules/logic/abyss/model/AbyssInfoMo.lua

module("modules.logic.abyss.model.AbyssInfoMo", package.seeall)

local AbyssInfoMo = pureTable("AbyssInfoMo")

function AbyssInfoMo:ctor()
	self.stageInfoDic = {}
	self.stageInfoList = {}
	self.allHeroDic = {}
end

function AbyssInfoMo:init(actId)
	return
end

function AbyssInfoMo:updateInfo(actId, stageInfoList)
	self.actId = actId

	tabletool.clear(self.stageInfoList)
	tabletool.clear(self.stageInfoDic)
	tabletool.clear(self.allHeroDic)

	if stageInfoList and next(stageInfoList) then
		local count = #stageInfoList

		for index, stageInfo in ipairs(stageInfoList) do
			self:updateSingleInfo(stageInfo, index == count)
		end
	end
end

function AbyssInfoMo:updateSingleInfo(stageInfo, sort)
	if stageInfo then
		local stageMo

		if self.stageInfoDic[stageInfo.stageId] then
			stageMo = self.stageInfoDic[stageInfo]

			if stageMo:isChallenged() then
				for _, heroId in ipairs(stageMo.heroList) do
					self.allHeroDic[heroId] = nil
				end
			end
		else
			stageMo = AbyssStageMo.New()
			self.stageInfoDic[stageInfo.stageId] = stageMo

			table.insert(self.stageInfoList, stageMo)
		end

		stageMo:updateInfo(stageInfo, self.actId)

		for _, heroNo in ipairs(stageInfo.heros) do
			self.allHeroDic[heroNo.heroId] = heroNo.heroId
		end

		if sort then
			table.sort(self.stageInfoList, AbyssInfoMo.sortStageList)
		end
	end
end

function AbyssInfoMo:getStageInfo(stageId)
	if not self.stageInfoDic then
		return nil
	end

	return self.stageInfoDic[stageId]
end

function AbyssInfoMo:isHeroLocked(heroId)
	if not self.allHeroDic then
		return false
	end

	return self.allHeroDic[heroId] ~= nil
end

function AbyssInfoMo:resetStage(stageId)
	local stageInfoMo = self.stageInfoDic[stageId]

	if not stageInfoMo then
		return
	end

	if stageInfoMo:isChallenged() then
		for _, heroId in ipairs(stageInfoMo.heroList) do
			self.allHeroDic[heroId] = nil
		end

		stageInfoMo:resetInfo()
	end
end

function AbyssInfoMo.sortStageList(a, b)
	return a.stageId < b.stageId
end

return AbyssInfoMo
