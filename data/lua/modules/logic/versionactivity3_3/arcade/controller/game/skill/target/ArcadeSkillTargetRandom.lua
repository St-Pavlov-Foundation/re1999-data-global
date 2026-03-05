-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetRandom.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetRandom", package.seeall)

local ArcadeSkillTargetRandom = class("ArcadeSkillTargetRandom", ArcadeSkillTargetBase)

function ArcadeSkillTargetRandom:onCtor()
	self._tempMoList = {}
	self._randomNum = 1
end

function ArcadeSkillTargetRandom:onConfigParams()
	if self._effectParams and #self._effectParams >= 1 then
		local params = self._effectParams

		self._randomNum = math.max(1, tonumber(params[1]))
	end
end

function ArcadeSkillTargetRandom:onFindTarget()
	local targetNum = self._randomNum

	self:clearList(self._tempMoList)

	local unitMOList = ArcadeGameModel.instance:getMonsterList()

	if not unitMOList or #unitMOList < 1 then
		return
	end

	local gridX, gridY = 1, 1

	for _, unitMO in ipairs(unitMOList) do
		gridX, gridY = unitMO:getGridPos()

		if not ArcadeGameHelper.isOutSideRoom(gridX, gridY) and not unitMO:getIsDead() and unitMO:getHp() > 0 then
			self._tempMoList[#self._tempMoList + 1] = unitMO
		end
	end

	RoomHelper.randomArray(self._tempMoList)

	for i = 1, #self._tempMoList do
		if i <= targetNum then
			self:addTarget(self._tempMoList[i])
		else
			break
		end
	end
end

function ArcadeSkillTargetRandom:getRandomNum()
	return self._randomNum
end

return ArcadeSkillTargetRandom
