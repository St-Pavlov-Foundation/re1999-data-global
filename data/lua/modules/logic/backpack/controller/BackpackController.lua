module("modules.logic.backpack.controller.BackpackController", package.seeall)

slot0 = class("BackpackController", BaseController)
slot0.BackpackViewTabContainerId = 2

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	slot0:registerCallback(BackpackEvent.SelectCategoryById, slot0._onSelectCategoryById, slot0)
end

function slot0._onSelectCategoryById(slot0, slot1)
	slot0._selectCategoryType = tonumber(slot1)
end

function slot0.enterItemBackpack(slot0, slot1)
	slot2 = {
		cateList = slot0:getCategoryCoList(),
		itemList = BackpackModel.instance:getBackpackList()
	}

	if slot0._selectCategoryType then
		slot1 = slot1 or slot0._selectCategoryType
	end

	slot0._selectCategoryType = nil
	slot1 = slot1 or ItemEnum.CategoryType.Material

	BackpackModel.instance:setCurCategoryId(slot1)
	BackpackModel.instance:setBackpackItemList(slot2.itemList)
	BackpackModel.instance:setBackpackCategoryList(slot2.cateList)
	BackpackCategoryListModel.instance:setCategoryList(slot2.cateList)
	BackpackPropListModel.instance:setCategoryPropItemList(BackpackModel.instance:getCategoryItemlist(BackpackModel.instance:getCurCategoryId()))

	if slot1 == ItemEnum.CategoryType.Equip then
		({
			data = slot2,
			isJump = true,
			defaultTabIds = {}
		}).defaultTabIds[uv0.BackpackViewTabContainerId] = 2
	elseif slot1 == ItemEnum.CategoryType.Antique then
		-- Nothing
	end

	ViewMgr.instance:openView(ViewName.BackpackView, slot5)
end

function slot0.getCategoryCoList(slot0)
	table.remove(tabletool.copy(BackpackConfig.instance:getCategoryCO()), 1)

	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Equip) then
		table.insert(slot1, {
			id = ItemEnum.CategoryType.Equip,
			name = luaLang("equip"),
			subname = "PSYCHUBE"
		})
	end

	if AntiqueModel.instance:isAntiqueUnlock() then
		table.insert(slot1, {
			id = ItemEnum.CategoryType.Antique,
			name = luaLang("antique"),
			subname = "Collections"
		})
	end

	return slot1
end

function slot0.reInit(slot0)
end

slot0.instance = slot0.New()

return slot0
