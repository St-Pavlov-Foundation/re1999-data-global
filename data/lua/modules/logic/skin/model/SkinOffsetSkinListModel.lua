module("modules.logic.skin.model.SkinOffsetSkinListModel", package.seeall)

slot0 = class("SkinOffsetSkinListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0.selectSkinIndex = 0
	slot0.selectSkin = 0
end

function slot0.setScrollView(slot0, slot1)
	slot0.scrollView = slot1
end

function slot0.initOriginSkinList(slot0)
	slot0._originSkinCoList = {}

	for slot4, slot5 in ipairs(lua_skin.configList) do
		if slot5.characterId > 0 then
			table.insert(slot0._originSkinCoList, slot5)
		end
	end
end

function slot0.initSkinList(slot0)
	slot0._skinList = {}

	for slot4, slot5 in ipairs(slot0._originSkinCoList) do
		if slot5.characterId > 0 then
			if slot0.filterFunc then
				if slot0.filterFunc(slot5) then
					table.insert(slot0._skinList, {
						skinId = slot5.id,
						skinName = slot5.name
					})
				end
			else
				table.insert(slot0._skinList, {
					skinId = slot5.id,
					skinName = slot5.name
				})
			end
		end
	end

	slot0:refreshList()
	slot0.scrollView:setSkinScrollRectVertical(1 - slot0.selectSkinIndex / #slot0._originSkinCoList)
end

function slot0.slideNext(slot0)
	slot0.selectSkinIndex = slot0.selectSkinIndex + 1

	if slot0.selectSkinIndex > #slot0._skinList then
		slot0.selectSkinIndex = 1
	end

	slot0:refreshSelectByIndex(slot0.selectSkinIndex)
end

function slot0.slidePre(slot0)
	slot0.selectSkinIndex = slot0.selectSkinIndex - 1

	if slot0.selectSkinIndex < 1 then
		slot0.selectSkinIndex = #slot0._skinList
	end

	slot0:refreshSelectByIndex(slot0.selectSkinIndex)
end

function slot0.refreshSelectByIndex(slot0, slot1)
	slot0:setSelectSkin(slot0._skinList[slot1].skinId)
end

function slot0.setSelectSkin(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._skinList) do
		if slot6.skinId == slot1 then
			slot0.selectSkinIndex = slot5
			slot0.selectSkin = slot1

			slot0.scrollView.viewContainer.skinOffsetAdjustView:refreshSkin({
				skinId = slot1,
				skinName = slot6.skinName
			})
			SkinOffsetController.instance:dispatchEvent(SkinOffsetController.Event.OnSelectSkinChange)

			return
		end
	end

	logError(string.format("not found skinId : %s index", slot1))
end

function slot0.isSelect(slot0, slot1)
	return slot0.selectSkin == slot1
end

function slot0.filterById(slot0, slot1)
	slot0._skinList = {}

	for slot5, slot6 in ipairs(slot0._originSkinCoList) do
		if slot6.characterId > 0 and string.match(tostring(slot6.id), slot1) then
			if slot0.filterFunc then
				if slot0.filterFunc(slot6) then
					table.insert(slot0._skinList, {
						skinId = slot6.id,
						skinName = slot6.name
					})
				end
			else
				table.insert(slot0._skinList, {
					skinId = slot6.id,
					skinName = slot6.name
				})
			end
		end
	end

	slot0:refreshList()
end

function slot0.filterByName(slot0, slot1)
	slot0._skinList = {}

	for slot5, slot6 in ipairs(slot0._originSkinCoList) do
		if slot6.characterId > 0 and string.match(slot6.name, slot1) then
			if slot0.filterFunc then
				if slot0.filterFunc(slot6) then
					table.insert(slot0._skinList, {
						skinId = slot6.id,
						skinName = slot6.name
					})
				end
			else
				table.insert(slot0._skinList, {
					skinId = slot6.id,
					skinName = slot6.name
				})
			end
		end
	end

	slot0:refreshList()
end

function slot0.setInitFilterFunc(slot0, slot1)
	slot0.filterFunc = slot1
end

function slot0.getFirst(slot0)
	return slot0._skinList[1]
end

function slot0.refreshList(slot0)
	slot0:setList(slot0._skinList)
end

slot0.instance = slot0.New()

return slot0
