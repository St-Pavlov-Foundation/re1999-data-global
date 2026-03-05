-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/ArcadeSkillFactory.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.ArcadeSkillFactory", package.seeall)

local ArcadeSkillFactory = class("ArcadeSkillFactory")

function ArcadeSkillFactory:createSkillById(skillId)
	local skillCfg = ArcadeConfig.instance:getPassiveSkillCfg(skillId, true)

	if not skillCfg then
		return
	end

	local skillObj = ArcadeSkillNormal.New(skillId)
	local sEffList = ArcadeGameEnum.TriggerCfgKeys.Effect
	local condList = ArcadeGameEnum.TriggerCfgKeys.Condition
	local pointList = ArcadeGameEnum.TriggerCfgKeys.TriggerPoint
	local limitList = ArcadeGameEnum.TriggerCfgKeys.Limit
	local effectIdList = ArcadeGameEnum.TriggerCfgKeys.EffectId
	local atkEffectIdList = ArcadeGameEnum.TriggerCfgKeys.AtkEffectId

	self._createSkillCfg = skillCfg

	for idx, effKey in ipairs(sEffList) do
		self._createIndex = idx

		local effectStr = skillCfg[effKey]
		local condStr = skillCfg[condList[idx]]
		local triggerPoint = skillCfg[pointList[idx]]
		local limit = skillCfg[limitList[idx]]
		local effectId = skillCfg[effectIdList[idx]]
		local atkEffectId = skillCfg[atkEffectIdList[idx]]

		if ArcadeGameEnum.PrintLog and not string.nilorempty(effectStr) then
			logNormal(string.format("ArcadeSkillFactory:createSkillTriggerById => skillId:%s -> %s,effet:%s,point:%s,cond:%s", skillCfg.id, idx, effectStr, triggerPoint, condStr))
		end

		local triggerBase = self:createSkillTriggerById(effectStr, triggerPoint, condStr)

		if triggerBase then
			skillObj:addTriggerBase(triggerBase)
			triggerBase:setSkillBase(skillObj)

			local hitBase = triggerBase:getHitBase()

			hitBase.limit = limit
			hitBase.effectId = effectId
			hitBase.atkEffectId = atkEffectId
		end
	end

	self._createSkillCfg = nil
	self._createIndex = nil

	return skillObj
end

function ArcadeSkillFactory:createSkillTriggerById(effectStr, triggerPoint, condStr, triggerType)
	if not string.nilorempty(effectStr) then
		local condBase = self:createSkillCond(condStr)
		local hitBase = self:createSkillHit(effectStr)
		local clz = self:_getClzById(triggerType, ArcadeSkillFactory.TriggerBaseClzMap, ArcadeSkillTriggerNormal)

		return clz.New(condBase, hitBase, triggerPoint)
	end

	return nil
end

function ArcadeSkillFactory:createSkillTargetById(id)
	local taregtCfg = ArcadeConfig.instance:getSkillTargetCfg(id, true)
	local clz = self:_getClzById(taregtCfg and taregtCfg.clztype, ArcadeSkillFactory.TargetBaseClzMap, ArcadeSkillTargetNormal)
	local instClz = clz.New()

	instClz:setTargetConfig(taregtCfg)

	return instClz
end

function ArcadeSkillFactory:createSkillCond(condStr)
	return self:_newSkillClz(condStr, ArcadeSkillFactory.CondBaseClzMap, ArcadeSkillCondNormal, true, self._createIndex and ArcadeGameEnum.TriggerCfgKeys.Condition[self._createIndex])
end

function ArcadeSkillFactory:createSkillHit(effStr)
	return self:_newSkillClz(effStr, ArcadeSkillFactory.HitBaseClzMap, ArcadeSkillHitNormal, true, self._createIndex and ArcadeGameEnum.TriggerCfgKeys.Effect[self._createIndex])
end

function ArcadeSkillFactory:_getClzById(id, clzMap, defineClz)
	local clz = clzMap[id] or defineClz

	return clz
end

function ArcadeSkillFactory:_newSkillClz(str, clzMap, defineClz, isLogErro, key)
	if not string.nilorempty(str) then
		local clz
		local params = string.split(str, "#")

		if params then
			clz = clzMap[params[1]]
		end

		if clz then
			return clz.New(params)
		end

		if isLogErro == true then
			if self._createSkillCfg then
				logError(string.format("字段名配置错误，找不到对应的脚本。skillId:[%s] %s==> %s", self._createSkillCfg.id, key, str))
			else
				logError(string.format("字段名配置错误，找不到对应的脚本。==> %s", str))
			end
		end
	end

	return defineClz.New()
end

ArcadeSkillFactory.CondBaseClzMap = {
	ifAttackType = ArcadeSkillCondAttackType,
	inSpecifyRoom = ArcadeSkillCondSpecifyRoom,
	attributeJudgment = ArcadeSkillCondAttributeJudgment,
	scopeJudgment = ArcadeSkillCondScopeJudgment,
	beAttackBy = ArcadeSkillCondBeAttackBy,
	ifInjured = ArcadeSkillCondIfInjured,
	weaponNotFully = ArcadeSkillCondWeaponNotFully
}
ArcadeSkillFactory.TargetBaseClzMap = {
	character = ArcadeSkillTargetCharacter,
	lineColor = ArcadeSkillTargetLinkColor,
	color = ArcadeSkillTargetSameColor,
	rect = ArcadeSkillTargetRect,
	cross = ArcadeSkillTargetCross,
	line = ArcadeSkillTargetLine,
	random = ArcadeSkillTargetRandom,
	scope = ArcadeSkillTargetScope,
	attacker = ArcadeSkillTargetAttacker,
	owner = ArcadeSkillTargetOwner,
	shapeSize = AracdeSkillTargetShapeSize,
	floor = AracdeSkillTargetFloorGrid,
	outline = ArcadeSkillTargetOutline
}
ArcadeSkillFactory.TriggerBaseClzMap = {}
ArcadeSkillFactory.HitBaseClzMap = {
	attributeChange1 = ArcadeSkillHitAttrChange,
	attributeChange2 = ArcadeSkillHitAttrChange,
	dropSomething = ArcadeSkillHitDropSomething,
	attackTargetChange = ArcadeSkillHitAttackTargetChange,
	skillAttack = ArcadeSkillHitSkillAttack,
	passiveSkillAdd = ArcadeSkillHitPassiveSkillAdd,
	passiveSkillRemove = ArcadeSkillHitPassiveSkillRemove,
	durabilityFix = ArcadeSkillHitDurabilityFix,
	energyAdd = ArcadeSkillHitEnergyAdd,
	lostWeapon = ArcadeSkillHitLostWeapon,
	refreshProducts = ArcadeSkillHitRefreshProducts,
	summon = ArcadeSkillHitSummon,
	randomSummon = ArcadeSkillHitRandomSummon,
	addBuff = ArcadeSkillHitAddBuff,
	removeBuff = ArcadeSkillHitRemoveBuff,
	normalmove = ArcadeSkillHitNormalMove,
	flashmove = ArcadeSkillHitFlashMove,
	randomUseSkill = ArcadeSkillHitRandomUseSkill,
	ghost = ArcadeSkillHitGhost,
	collision = ArcadeSkillHitCollision,
	alertAttack = ArcadeSkillHitAlertAttack,
	killSelf = ArcadeSkillHitKillSelf,
	dieandsummon = ArcadeSkillHitDieandSummon,
	dirShield = ArcadeSkillHitDirShield,
	flop = ArcadeSkillHitFlop,
	massifAdd = ArcadeSkillHitMassifAdd,
	throwingBomb = ArcadeSkillHitThrowingBomb,
	unaffectedFloor = ArcadeSkillHitUnaffectedFloor,
	dropPortal = ArcadeSkillHitDropPortal,
	weaponUsedTimesFix = ArcadeSkillHitWeaponUsedTimesFix,
	removeCollection = ArcadeSkillHitRemoveCollection
}
ArcadeSkillFactory.instance = ArcadeSkillFactory.New()

return ArcadeSkillFactory
