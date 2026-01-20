-- chunkname: @modules/logic/fight/entity/FightEntityBuffObject.lua

module("modules.logic.fight.entity.FightEntityBuffObject", package.seeall)

local FightEntityBuffObject = class("FightEntityBuffObject", FightBaseClass)

function FightEntityBuffObject:onConstructor(buffData)
	self.buffData = buffData
	self.uid = buffData.uid
	self.entityId = buffData.entityId
	self.buffId = buffData.buffId
	self.buffDic = {}
end

function FightEntityBuffObject:onAddBuff()
	local buffId = self.buffId
	local uid = self.uid

	self:showAddEffect()

	if lua_fight_gao_si_niao_buffeffect_electric_level.configDict[buffId] then
		self.buffDic[uid] = self:newClass(FightGaoSiNiaoBuffEffectWithElectricLevel, self.buffData)
	end

	local dicActivity128Const = lua_activity128_const.configDict

	if buffId == dicActivity128Const[7].value1 then
		self.buffDic[uid] = self:newClass(FightZongMaoWillEnterEyeWitnessRound, self.buffData)
	elseif buffId == dicActivity128Const[8].value1 then
		self.buffDic[uid] = self:newClass(FightZongMaoEyeWitnessRound, self.buffData)
	elseif buffId == dicActivity128Const[9].value1 then
		self.buffDic[uid] = self:newClass(FightZongMaoEyeWitnessEnd, self.buffData)
	end

	FightMsgMgr.sendMsg(FightMsgId.OnAddBuff, self.buffData)
end

function FightEntityBuffObject:showAddEffect()
	return
end

function FightEntityBuffObject:onRemoveBuff(uid)
	if uid ~= self.uid then
		return
	end

	self:showRemoveEffect()

	local buffObj = self.buffDic[uid]

	if buffObj then
		buffObj:disposeSelf()
	end

	FightMsgMgr.sendMsg(FightMsgId.OnRemoveBuff, self.buffData)
end

function FightEntityBuffObject:showRemoveEffect()
	return
end

function FightEntityBuffObject:onUpdateBuff(uid)
	if uid ~= self.uid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.OnUpdateBuff, self.buffData)
end

function FightEntityBuffObject:onDestructor()
	return
end

return FightEntityBuffObject
