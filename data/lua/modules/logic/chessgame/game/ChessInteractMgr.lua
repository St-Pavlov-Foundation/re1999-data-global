module("modules.logic.chessgame.game.ChessInteractMgr", package.seeall)

slot0 = class("ChessInteractMgr")

function slot0.ctor(slot0)
	slot0._list = {}
	slot0._dict = {}
	slot0._showList = {}
end

function slot0.add(slot0, slot1)
	slot2 = slot1.id

	slot0:remove(slot2)

	slot0._dict[slot2] = slot1

	table.insert(slot0._list, slot1)

	if slot1:isShow() and slot1:checkHaveAvatarPath() then
		table.insert(slot0._showList, slot1)
	end
end

function slot0.remove(slot0, slot1)
	if slot0._dict[slot1] then
		slot0._dict[slot1] = nil

		for slot6, slot7 in ipairs(slot0._list) do
			if slot7 == slot2 then
				table.remove(slot0._list, slot6)
				table.remove(slot0._showList, slot6)
				slot7:dispose()

				return true
			end
		end
	end

	return false
end

function slot0.getList(slot0)
	return slot0._list
end

function slot0.get(slot0, slot1)
	if slot0._dict then
		return slot0._dict[slot1]
	end

	return nil
end

function slot0.hideCompById(slot0, slot1)
	if slot0._dict and slot0._dict[slot1] then
		slot0._dict[slot1]:hideSelf()
	end
end

function slot0.getMainPlayer(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0._list) do
		if slot6.objType == ChessGameEnum.InteractType.Role then
			return slot6
		end
	end

	return slot1
end

function slot0.removeAll(slot0)
	for slot4, slot5 in ipairs(slot0._list) do
		slot5:dispose()
	end

	slot0._list = {}
	slot0._dict = {}
	slot0._showList = {}
end

function slot0.checkCompleletedLoaded(slot0, slot1)
	slot0._checkDict = slot0._checkDict or {}

	table.insert(slot0._checkDict, slot1)

	if #slot0._checkDict == #slot0._showList then
		slot0:_onAllInteractLoadCompleleted()
	end
end

function slot0._onAllInteractLoadCompleleted(slot0)
	slot0._checkDict = nil

	if slot0:getMainPlayer() then
		slot1:getHandler():calCanWalkArea()
	end
end

function slot0.dispose(slot0)
	if slot0._list then
		for slot4, slot5 in ipairs(slot0._list) do
			slot5:dispose()
		end

		slot0._list = nil
		slot0._dict = nil
	end
end

return slot0
