module("modules.logic.gm.model.GMLangTxtModel", package.seeall)

slot0 = class("GMLangTxtModel", ListScrollModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._allText = {}
	slot0._txtIndex = 1
	slot0.search = ""
end

function slot0.reInit(slot0)
	slot0._hasInit = nil
end

function slot0.setSearch(slot0, slot1)
	slot0.search = slot1

	slot0:reInit()
	slot0:updateModel()
end

function slot0.getSearch(slot0)
	return slot0.search
end

function slot0.clearAll(slot0, slot1)
	slot0._allText = {}
	slot0._txtIndex = 1

	slot0:setList({})
end

function slot0.addLangTxt(slot0, slot1)
	if slot0._allText[slot1] then
		return
	end

	slot0._allText[slot1] = {
		id = slot0._txtIndex,
		txt = slot1
	}
	slot0._txtIndex = slot0._txtIndex + 1

	slot0:addAtLast(slot0._allText[slot1])
end

function slot0.updateModel(slot0)
	if not slot0._hasInit then
		slot0._hasInit = true
		slot1 = {}

		for slot5, slot6 in pairs(slot0._allText) do
			slot7 = true

			if slot0.search then
				slot7 = string.find(slot5, slot0.search)
			end

			if slot7 then
				table.insert(slot1, slot6)
			end
		end

		table.sort(slot1, function (slot0, slot1)
			return slot0.id < slot1.id
		end)
		slot0:setList(slot1)
	else
		slot0:onModelUpdate()
	end
end

slot0.instance = slot0.New()

return slot0
