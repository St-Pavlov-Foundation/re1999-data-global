-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitAttackTargetChange.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitAttackTargetChange", package.seeall)

local ArcadeSkillHitAttackTargetChange = class("ArcadeSkillHitAttackTargetChange", ArcadeSkillHitBase)

function ArcadeSkillHitAttackTargetChange:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._skillTargetId = tonumber(params[2])
	self._skillTargetBase = ArcadeSkillFactory.instance:createSkillTargetById(self._skillTargetId)
end

function ArcadeSkillHitAttackTargetChange:onHit()
	if self._skillTargetBase and self._context.hiterList then
		local hiterList = self._context.hiterList
		local gridX, gridY = self._context.target:getGridPos()
		local direction = self._context.target:getDirection()

		self._skillTargetBase:findByContext(self._context)
		self:addHiterList(self._skillTargetBase:getTargetList())

		if hiterList then
			for i = #hiterList, 1, -1 do
				local unitMO = hiterList[i]

				if self._skillTargetBase:isHasTarget(unitMO) then
					table.remove(hiterList, i)
				end
			end
		end

		tabletool.addValues(self._context.hiterList, self._skillTargetBase:getTargetList())
	end
end

function ArcadeSkillHitAttackTargetChange:onHitPrintLog()
	logNormal(string.format("%s 攻击目标选择器修正 targetId:%s", self:getLogPrefixStr(), self._skillTargetId))
end

return ArcadeSkillHitAttackTargetChange
