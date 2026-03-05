-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondAttributeJudgment.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondAttributeJudgment", package.seeall)

local ArcadeSkillCondAttributeJudgment = class("ArcadeSkillCondAttributeJudgment", ArcadeSkillCondBase)
local JudgmentOperator = {}

function ArcadeSkillCondAttributeJudgment:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._attrId = tonumber(params[2])
	self._opName = tonumber(params[3])
	self._value = tonumber(params[4])
end

function ArcadeSkillCondAttributeJudgment:onIsCondSuccess()
	logNormal("ArcadeSkillCondAttributeJudgment:isCondSuccess() == > 特定属性的数值大于等于/小于等于X时，则触发")

	local opFunc = JudgmentOperator[self._opName]

	if opFunc then
		if opFunc(self:_getAttrValue(self._context.target), self._value) then
			return true
		end
	else
		logError(string.format("技能id：[%s]配置运算符错误。运算符：2 小于等于；1 大于等于", self._context and self._context.skillId))
	end

	return false
end

function ArcadeSkillCondAttributeJudgment:_getAttrValue(unitMO)
	if ArcadeGameEnum.BaseAttr.hp == self._attrId then
		return unitMO:getHp()
	end

	return unitMO:getAttributeValue(self._attrId)
end

function JudgmentOperator.lt(a, b)
	return a < b
end

function JudgmentOperator.gt(a, b)
	return b < a
end

function JudgmentOperator.et(a, b)
	return a == b
end

function JudgmentOperator.ltet(a, b)
	return a <= b
end

function JudgmentOperator.gtet(a, b)
	return b <= a
end

JudgmentOperator[1] = JudgmentOperator.gtet
JudgmentOperator[2] = JudgmentOperator.ltet

return ArcadeSkillCondAttributeJudgment
