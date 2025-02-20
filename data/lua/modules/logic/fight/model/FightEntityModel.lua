module("modules.logic.fight.model.FightEntityModel", package.seeall)

slot0 = class("FightEntityModel", BaseModel)

function slot0.onInit(slot0)
	slot0._mySideModel = BaseModel.New()
	slot0._mySideSubModel = BaseModel.New()
	slot0._mySideDeadModel = BaseModel.New()
	slot0._mySideSpModel = BaseModel.New()
	slot0._enemySideModel = FightEnemySideModel.New()
	slot0._enemySideSubModel = BaseModel.New()
	slot0._enemySideDeadModel = BaseModel.New()
	slot0._enemySideSpModel = BaseModel.New()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0._mySideModel:clear()
	slot0._mySideSubModel:clear()
	slot0._mySideDeadModel:clear()
	slot0._mySideSpModel:clear()
	slot0._enemySideModel:clear()
	slot0._enemySideSubModel:clear()
	slot0._enemySideDeadModel:clear()
	slot0._enemySideSpModel:clear()
end

function slot0.clearExistEntitys(slot0)
	uv0.super.clear(slot0)
	slot0._mySideModel:clear()
	slot0._mySideSubModel:clear()
	slot0._mySideSpModel:clear()
	slot0._enemySideModel:clear()
	slot0._enemySideSubModel:clear()
	slot0._enemySideSpModel:clear()
end

function slot0.clientTestSetEntity(slot0, slot1, slot2, slot3)
	if slot1 == FightEnum.EntitySide.MySide then
		slot0._mySideModel:setList(slot2)
		slot0._mySideSubModel:setList(slot3)
	else
		slot0._enemySideModel:setList(slot2)
		slot0._enemySideSubModel:setList(slot3)
	end

	slot0:addList(slot2)
	slot0:addList(slot3)
end

function slot0.setMySide(slot0, slot1)
	slot0:_setEntityMOList(slot0._mySideModel, slot1.entitys, FightEnum.EntitySide.MySide)
	slot0:_setEntityMOList(slot0._mySideSubModel, slot1.subEntitys, FightEnum.EntitySide.MySide)
	slot0:_setEntityMOList(slot0._mySideSpModel, slot1.spEntitys, FightEnum.EntitySide.MySide)
end

function slot0.setEnemySide(slot0, slot1)
	slot0:_setEntityMOList(slot0._enemySideModel, slot1.entitys, FightEnum.EntitySide.EnemySide)
	slot0:_setEntityMOList(slot0._enemySideSubModel, slot1.subEntitys, FightEnum.EntitySide.EnemySide)
	slot0:_setEntityMOList(slot0._enemySideSpModel, slot1.spEntitys, FightEnum.EntitySide.EnemySide)
end

function slot0._setEntityMOList(slot0, slot1, slot2, slot3)
	slot4 = slot1:getList()

	for slot8, slot9 in ipairs(slot2) do
		if not slot4[slot8] then
			table.insert(slot4, FightEntityMO.New())
		end

		slot10:init(slot9, slot3)
	end

	for slot8 = #slot2 + 1, #slot4 do
		slot4[slot8] = nil
	end

	slot1:setList(slot4)

	slot8 = slot1.getList

	slot0:addList(slot8(slot1))

	for slot8, slot9 in ipairs(slot2) do
		if slot9.currentHp <= 0 then
			slot0:onDead(slot9.uid)
		end
	end
end

function slot0.onDead(slot0, slot1)
	slot0:_checkDeadModel(slot1, slot0._mySideModel, slot0._mySideDeadModel)
	slot0:_checkDeadModel(slot1, slot0._mySideSpModel, slot0._mySideDeadModel)
	slot0:_checkDeadModel(slot1, slot0._enemySideModel, slot0._enemySideDeadModel)
	slot0:_checkDeadModel(slot1, slot0._enemySideSpModel, slot0._enemySideDeadModel)
end

function slot0._checkDeadModel(slot0, slot1, slot2, slot3)
	if slot2:getById(slot1) then
		slot2:remove(slot4)

		if not slot3:getById(slot1) then
			slot3:addAtLast(slot4)
		end

		slot0:remove(slot4)
	end
end

function slot0.replaceEntityMO(slot0, slot1)
	if not (slot0:removeEntityById(slot1.id) or slot0:getModel(slot1.side)) then
		return
	end

	slot3:addAtLast(slot1)
	slot0:addAtLast(slot1)
	FightController.instance:dispatchEvent(FightEvent.ReplaceEntityMO, slot1)
end

function slot0.addEntityMO(slot0, slot1)
	slot0:removeEntityById(slot1.id)

	if slot0:getModel(slot1.side) then
		slot2:addAtLast(slot1)
		slot0:addAtLast(slot1)
	end
end

function slot0.removeEntityById(slot0, slot1)
	if slot0._mySideModel:getById(slot1) then
		slot0._mySideModel:remove(slot2)
		slot0:remove(slot2)

		return slot0._mySideModel
	end

	if slot0._mySideSubModel:getById(slot1) then
		slot0._mySideSubModel:remove(slot2)
		slot0:remove(slot2)

		return slot0._mySideSubModel
	end

	if slot0._mySideSpModel:getById(slot1) then
		slot0._mySideSpModel:remove(slot2)
		slot0:remove(slot2)

		return slot0._mySideSpModel
	end

	if slot0._enemySideModel:getById(slot1) then
		slot0._enemySideModel:remove(slot2)
		slot0:remove(slot2)

		return slot0._enemySideModel
	end

	if slot0._enemySideSubModel:getById(slot1) then
		slot0._enemySideSubModel:remove(slot2)
		slot0:remove(slot2)

		return slot0._enemySideSubModel
	end

	if slot0._enemySideSpModel:getById(slot1) then
		slot0._enemySideSpModel:remove(slot2)
		slot0:remove(slot2)

		return slot0._enemySideSpModel
	end
end

function slot0.getModel(slot0, slot1)
	return slot1 == FightEnum.EntitySide.MySide and slot0._mySideModel or slot0._enemySideModel
end

function slot0.getSubModel(slot0, slot1)
	return slot1 == FightEnum.EntitySide.MySide and slot0._mySideSubModel or slot0._enemySideSubModel
end

function slot0.getSpModel(slot0, slot1)
	return slot1 == FightEnum.EntitySide.MySide and slot0._mySideSpModel or slot0._enemySideSpModel
end

function slot0.getDeadModel(slot0, slot1)
	return slot1 == FightEnum.EntitySide.MySide and slot0._mySideDeadModel or slot0._enemySideDeadModel
end

function slot0.getMySideModel(slot0)
	return slot0._mySideModel
end

function slot0.getEnemySideModel(slot0)
	return slot0._enemySideModel
end

function slot0.getMySideList(slot0)
	return slot0._mySideModel:getList()
end

function slot0.getEnemySideList(slot0)
	return slot0._enemySideModel:getList()
end

function slot0.getMySideDeadListLength(slot0)
	return #slot0._mySideDeadModel:getList()
end

function slot0.getByPosId(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(slot0:getModel(slot1):getList()) do
		if slot9.position == slot2 then
			return slot9
		end
	end

	for slot10, slot11 in ipairs(slot0:getSubModel(slot1):getList()) do
		if slot11.position == slot2 then
			return slot11
		end
	end
end

function slot0.isSub(slot0, slot1)
	if slot0._mySideSubModel:getById(slot1) then
		return true
	end

	return slot0._enemySideSubModel:getById(slot1) and true or false
end

function slot0.getDeadById(slot0, slot1)
	if slot0._mySideDeadModel:getById(slot1) then
		return slot2
	end

	return slot0._enemySideDeadModel:getById(slot1)
end

function slot0.addDeadUid(slot0, slot1)
	slot0._deadUids = slot0._deadUids or {}
	slot0._deadUids[slot1] = true
end

function slot0.isDeadUid(slot0, slot1)
	return slot0._deadUids and slot0._deadUids[slot1]
end

function slot0.clearDeadUids(slot0)
	slot0._deadUids = {}
end

function slot0.sortSubEntityList(slot0, slot1)
	return slot1.position < slot0.position
end

slot0.instance = slot0.New()

slot0.instance:onInit()
setmetatable(slot0.instance, {
	__index = function (slot0, slot1)
		logError("FightEntityModel 已废弃。新的entity数据管理为 FightEntityDataMgr ,访问数据请用 FightDataHelper.entityMgr ,如果疑问或需要支持联系左皓文")

		return uv0[slot1]
	end
})

return slot0
