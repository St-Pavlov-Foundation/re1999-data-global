-- chunkname: @modules/logic/towercompose/model/TowerComposeBossSettleMo.lua

module("modules.logic.towercompose.model.TowerComposeBossSettleMo", package.seeall)

local TowerComposeBossSettleMo = pureTable("TowerComposeBossSettleMo")

function TowerComposeBossSettleMo:ctor()
	self.planes = {}
	self.curScore = 0
	self.newFlag = false
end

function TowerComposeBossSettleMo:update(info)
	self:_buildPlaneList(info.planes)

	self.curScore = info.currScore
	self.newFlag = info.newFlag
end

function TowerComposeBossSettleMo:_buildPlaneList(planes)
	self.planes = {}
	self.planes.atkStats = {}

	for _, plane in ipairs(planes) do
		table.insert(self.planes.atkStats, plane.attackStatistics)
	end
end

function TowerComposeBossSettleMo:getAtkStat(index)
	if self.planes and self.planes.atkStats then
		return self.planes.atkStats[index]
	end
end

return TowerComposeBossSettleMo
