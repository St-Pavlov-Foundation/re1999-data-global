module("modules.logic.fight.model.FightViewTechniqueModel", package.seeall)

slot0 = class("FightViewTechniqueModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._all = nil
end

function slot0.reInit(slot0)
	slot0._all = nil
end

function slot0.initFromSimpleProperty(slot0)
	if slot0._all then
		return
	end

	slot0._all = BaseModel.New()

	if not FightStrUtil.instance:getSplitString2Cache(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.FightTechnique) or "", true, "|", "#") then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		for slot12, slot13 in ipairs(slot8) do
			if lua_fight_technique.configDict[slot13] then
				slot0._all:addAtLast({
					id = slot13
				})

				if slot7 == 2 then
					table.insert(slot3, slot15)
				end
			end
		end
	end

	slot0:addList(slot3)
end

function slot0.addUnread(slot0, slot1)
	if slot0._all:getById(slot1) then
		return
	end

	slot2 = {
		id = slot1
	}

	slot0._all:addAtLast(slot2)
	slot0:addAtLast(slot2)

	return slot2
end

function slot0.markRead(slot0, slot1)
	if not slot0._all:getById(slot1) or not slot0:getById(slot1) then
		return
	end

	slot2 = slot0:getById(slot1)

	slot0:remove(slot2)

	return slot2
end

function slot0.getPropertyStr(slot0)
	slot1 = {}
	slot2 = {}

	for slot7, slot8 in ipairs(slot0._all:getList()) do
		if slot0:getById(slot8.id) then
			table.insert(slot2, slot8.id)
		else
			table.insert(slot1, slot8.id)
		end
	end

	return string.format("%s|%s", table.concat(slot1, "#"), table.concat(slot2, "#"))
end

function slot0.getAll(slot0)
	if slot0._all then
		return slot0._all:getList()
	end
end

function slot0.isUnlock(slot0, slot1)
	if slot0._all then
		slot4 = slot0._all
		slot6 = slot4

		for slot5, slot6 in ipairs(slot4.getList(slot6)) do
			if slot6.id == slot1 then
				return true
			end
		end
	end

	return nil
end

function slot0.readTechnique(slot0, slot1)
	if slot1 and slot0:markRead(slot1) then
		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.FightTechnique, slot0:getPropertyStr())
	end
end

slot0.instance = slot0.New()

return slot0
