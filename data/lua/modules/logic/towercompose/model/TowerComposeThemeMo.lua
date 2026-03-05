-- chunkname: @modules/logic/towercompose/model/TowerComposeThemeMo.lua

module("modules.logic.towercompose.model.TowerComposeThemeMo", package.seeall)

local TowerComposeThemeMo = class("TowerComposeThemeMo", TowerComposeThemeMo)

function TowerComposeThemeMo:ctor(themeId)
	self.themeId = themeId
	self.passLayerId = 0
	self.researchProgress = 0
	self.highScore = 0
	self.curScore = 0
	self.unlockModIdMap = {}
	self.unlockModIdList = {}
	self.planeInfoMap = {}
end

function TowerComposeThemeMo:updateInfo(info)
	self.themeId = info.themeId
	self.researchProgress = info.researchProgress

	self:updateUnlockModIds(info.unlockModIds)
	self:updateComposeBossInfo(info.boss)

	self.passLayerId = info.passMaxLayerId
end

function TowerComposeThemeMo:updateUnlockModIds(unlockModIds)
	for index, modId in ipairs(unlockModIds) do
		if not self.unlockModIdMap[modId] then
			self.unlockModIdMap[modId] = modId

			table.insert(self.unlockModIdList, modId)
		end
	end
end

function TowerComposeThemeMo:updateComposeBossInfo(bossInfo)
	for index, planeInfo in ipairs(bossInfo.planes) do
		self:updatePlaneInfoData(planeInfo)
	end

	self.highScore = bossInfo.highScore
	self.curScore = bossInfo.currScore
end

function TowerComposeThemeMo:updatePlaneInfoData(planeInfo)
	local planeInfoMo = self.planeInfoMap[planeInfo.planeId]

	if not planeInfoMo then
		planeInfoMo = TowerComposePlaneMo.New({
			themeId = self.themeId
		})
		self.planeInfoMap[planeInfo.planeId] = planeInfoMo
	end

	planeInfoMo:updateInfo(planeInfo)
end

function TowerComposeThemeMo:updateResearchProgress(progress)
	self.researchProgress = progress
end

function TowerComposeThemeMo:getPlaneMo(planeId)
	return self.planeInfoMap[planeId]
end

function TowerComposeThemeMo:getAllUnlockModIdList()
	return self.unlockModIdList
end

function TowerComposeThemeMo:isModUnlock(modId)
	return self.unlockModIdMap[modId]
end

return TowerComposeThemeMo
