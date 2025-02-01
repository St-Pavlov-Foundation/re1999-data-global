module("modules.logic.gm.model.GMGuideStatusModel", package.seeall)

slot0 = class("GMGuideStatusModel", ListScrollModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0.showOpBtn = true
	slot0.idReverse = false
	slot0.search = ""
end

function slot0.reInit(slot0)
	slot0._hasInit = nil
end

function slot0.onClickShowOpBtn(slot0)
	slot0.showOpBtn = not slot0.showOpBtn

	slot0:updateModel()
end

function slot0.onClickReverse(slot0)
	slot0.idReverse = not slot0.idReverse

	slot0:reInit()
	slot0:updateModel()
end

function slot0.setSearch(slot0, slot1)
	slot0.search = slot1

	slot0:reInit()
	slot0:updateModel()
end

function slot0.getSearch(slot0)
	return slot0.search
end

function slot0.updateModel(slot0)
	if not slot0._hasInit then
		slot0._hasInit = true
		slot1 = {}

		for slot5, slot6 in ipairs(lua_guide.configList) do
			slot7 = true

			if slot0.search then
				slot7 = string.find(tostring(slot6.id), slot0.search) or string.find(slot6.desc, slot0.search)
			end

			if slot6.isOnline == 1 and slot7 then
				table.insert(slot1, slot6)
			end
		end

		table.sort(slot1, function (slot0, slot1)
			return slot0.id < slot1.id
		end)

		if slot0.idReverse then
			tabletool.revert(slot1)
		end

		slot0:setList(slot1)
	else
		slot0:onModelUpdate()
	end
end

slot0.instance = slot0.New()

return slot0
