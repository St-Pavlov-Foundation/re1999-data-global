module("modules.logic.antique.model.AntiqueBackpackListModel", package.seeall)

slot0 = class("AntiqueBackpackListModel", ListScrollModel)

function slot0.init(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._antiqueList = {}
end

function slot0.updateModel(slot0)
	slot0:setList(slot0._antiqueList)
end

function slot0.getCount(slot0)
	return slot0._antiqueList and #slot0._antiqueList or 0
end

function slot0.setAntiqueList(slot0, slot1)
	slot0._antiqueList = slot1

	table.sort(slot0._antiqueList, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
	slot0:setList(slot0._antiqueList)
end

function slot0._getAntiqueList(slot0)
	return slot0._antiqueList
end

function slot0.clearAntiqueList(slot0)
	slot0._antiqueList = nil

	slot0:clear()
end

slot0.instance = slot0.New()

return slot0
