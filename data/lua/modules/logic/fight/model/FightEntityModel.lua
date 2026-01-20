-- chunkname: @modules/logic/fight/model/FightEntityModel.lua

module("modules.logic.fight.model.FightEntityModel", package.seeall)

local FightEntityModel = class("FightEntityModel", BaseModel)

function FightEntityModel:onInit()
	self._mySideModel = BaseModel.New()
	self._mySideSubModel = BaseModel.New()
	self._mySideDeadModel = BaseModel.New()
	self._mySideSpModel = BaseModel.New()
	self._enemySideModel = FightEnemySideModel.New()
	self._enemySideSubModel = BaseModel.New()
	self._enemySideDeadModel = BaseModel.New()
	self._enemySideSpModel = BaseModel.New()
end

function FightEntityModel:clear()
	FightEntityModel.super.clear(self)
	self._mySideModel:clear()
	self._mySideSubModel:clear()
	self._mySideDeadModel:clear()
	self._mySideSpModel:clear()
	self._enemySideModel:clear()
	self._enemySideSubModel:clear()
	self._enemySideDeadModel:clear()
	self._enemySideSpModel:clear()
end

function FightEntityModel:clearExistEntitys()
	FightEntityModel.super.clear(self)
	self._mySideModel:clear()
	self._mySideSubModel:clear()
	self._mySideSpModel:clear()
	self._enemySideModel:clear()
	self._enemySideSubModel:clear()
	self._enemySideSpModel:clear()
end

function FightEntityModel:clientTestSetEntity(side, entityMOList, subEntityMOList)
	if side == FightEnum.EntitySide.MySide then
		self._mySideModel:setList(entityMOList)
		self._mySideSubModel:setList(subEntityMOList)
	else
		self._enemySideModel:setList(entityMOList)
		self._enemySideSubModel:setList(subEntityMOList)
	end

	self:addList(entityMOList)
	self:addList(subEntityMOList)
end

function FightEntityModel:setMySide(fightTeam)
	self:_setEntityMOList(self._mySideModel, fightTeam.entitys, FightEnum.EntitySide.MySide)
	self:_setEntityMOList(self._mySideSubModel, fightTeam.subEntitys, FightEnum.EntitySide.MySide)
	self:_setEntityMOList(self._mySideSpModel, fightTeam.spEntitys, FightEnum.EntitySide.MySide)
end

function FightEntityModel:setEnemySide(fightTeam)
	self:_setEntityMOList(self._enemySideModel, fightTeam.entitys, FightEnum.EntitySide.EnemySide)
	self:_setEntityMOList(self._enemySideSubModel, fightTeam.subEntitys, FightEnum.EntitySide.EnemySide)
	self:_setEntityMOList(self._enemySideSpModel, fightTeam.spEntitys, FightEnum.EntitySide.EnemySide)
end

function FightEntityModel:_setEntityMOList(entityModel, fightEntityInfos, side)
	local oldList = entityModel:getList()

	for i, info in ipairs(fightEntityInfos) do
		local entityMO = oldList[i]

		if not entityMO then
			entityMO = FightEntityMO.New()

			table.insert(oldList, entityMO)
		end

		entityMO:init(info, side)
	end

	for i = #fightEntityInfos + 1, #oldList do
		oldList[i] = nil
	end

	entityModel:setList(oldList)
	self:addList(entityModel:getList())

	for _, info in ipairs(fightEntityInfos) do
		if info.currentHp <= 0 then
			self:onDead(info.uid)
		end
	end
end

function FightEntityModel:onDead(entityId)
	self:_checkDeadModel(entityId, self._mySideModel, self._mySideDeadModel)
	self:_checkDeadModel(entityId, self._mySideSpModel, self._mySideDeadModel)
	self:_checkDeadModel(entityId, self._enemySideModel, self._enemySideDeadModel)
	self:_checkDeadModel(entityId, self._enemySideSpModel, self._enemySideDeadModel)
end

function FightEntityModel:_checkDeadModel(entityId, model, deadModel)
	local entityMO = model:getById(entityId)

	if entityMO then
		model:remove(entityMO)

		if not deadModel:getById(entityId) then
			deadModel:addAtLast(entityMO)
		end

		self:remove(entityMO)
	end
end

function FightEntityModel:replaceEntityMO(entityMO)
	local entityId = entityMO.id
	local sideModel = self:removeEntityById(entityId)

	sideModel = sideModel or self:getModel(entityMO.side)

	if not sideModel then
		return
	end

	sideModel:addAtLast(entityMO)
	self:addAtLast(entityMO)
	FightController.instance:dispatchEvent(FightEvent.ReplaceEntityMO, entityMO)
end

function FightEntityModel:addEntityMO(entityMO)
	self:removeEntityById(entityMO.id)

	local model = self:getModel(entityMO.side)

	if model then
		model:addAtLast(entityMO)
		self:addAtLast(entityMO)
	end
end

function FightEntityModel:removeEntityById(entityId)
	local entityMO = self._mySideModel:getById(entityId)

	if entityMO then
		self._mySideModel:remove(entityMO)
		self:remove(entityMO)

		return self._mySideModel
	end

	entityMO = self._mySideSubModel:getById(entityId)

	if entityMO then
		self._mySideSubModel:remove(entityMO)
		self:remove(entityMO)

		return self._mySideSubModel
	end

	entityMO = self._mySideSpModel:getById(entityId)

	if entityMO then
		self._mySideSpModel:remove(entityMO)
		self:remove(entityMO)

		return self._mySideSpModel
	end

	entityMO = self._enemySideModel:getById(entityId)

	if entityMO then
		self._enemySideModel:remove(entityMO)
		self:remove(entityMO)

		return self._enemySideModel
	end

	entityMO = self._enemySideSubModel:getById(entityId)

	if entityMO then
		self._enemySideSubModel:remove(entityMO)
		self:remove(entityMO)

		return self._enemySideSubModel
	end

	entityMO = self._enemySideSpModel:getById(entityId)

	if entityMO then
		self._enemySideSpModel:remove(entityMO)
		self:remove(entityMO)

		return self._enemySideSpModel
	end
end

function FightEntityModel:getModel(side)
	return side == FightEnum.EntitySide.MySide and self._mySideModel or self._enemySideModel
end

function FightEntityModel:getSubModel(side)
	return side == FightEnum.EntitySide.MySide and self._mySideSubModel or self._enemySideSubModel
end

function FightEntityModel:getSpModel(side)
	return side == FightEnum.EntitySide.MySide and self._mySideSpModel or self._enemySideSpModel
end

function FightEntityModel:getDeadModel(side)
	return side == FightEnum.EntitySide.MySide and self._mySideDeadModel or self._enemySideDeadModel
end

function FightEntityModel:getMySideModel()
	return self._mySideModel
end

function FightEntityModel:getEnemySideModel()
	return self._enemySideModel
end

function FightEntityModel:getMySideList()
	return self._mySideModel:getList()
end

function FightEntityModel:getEnemySideList()
	return self._enemySideModel:getList()
end

function FightEntityModel:getMySideDeadListLength()
	return #self._mySideDeadModel:getList()
end

function FightEntityModel:getByPosId(side, posId)
	local model = self:getModel(side)
	local list = model:getList()

	for _, entityMO in ipairs(list) do
		if entityMO.position == posId then
			return entityMO
		end
	end

	local subModel = self:getSubModel(side)
	local subList = subModel:getList()

	for _, entityMO in ipairs(subList) do
		if entityMO.position == posId then
			return entityMO
		end
	end
end

function FightEntityModel:isSub(uid)
	local mySub = self._mySideSubModel:getById(uid)

	if mySub then
		return true
	end

	local enemySub = self._enemySideSubModel:getById(uid)

	return enemySub and true or false
end

function FightEntityModel:getDeadById(uid)
	local myDead = self._mySideDeadModel:getById(uid)

	if myDead then
		return myDead
	end

	local enemyDead = self._enemySideDeadModel:getById(uid)

	return enemyDead
end

function FightEntityModel:addDeadUid(uid)
	self.deadUids = self.deadUids or {}
	self.deadUids[uid] = true
end

function FightEntityModel:isDeadUid(uid)
	return self.deadUids and self.deadUids[uid]
end

function FightEntityModel:clearDeadUids()
	self.deadUids = {}
end

function FightEntityModel.sortSubEntityList(item1, item2)
	return item1.position > item2.position
end

FightEntityModel.instance = FightEntityModel.New()

FightEntityModel.instance:onInit()
setmetatable(FightEntityModel.instance, {
	__index = function(tab, key)
		logError("FightEntityModel 已废弃。新的entity数据管理为 FightEntityDataMgr ,访问数据请用 FightDataHelper.entityMgr ,如果疑问或需要支持联系左皓文")

		return FightEntityModel[key]
	end
})

return FightEntityModel
