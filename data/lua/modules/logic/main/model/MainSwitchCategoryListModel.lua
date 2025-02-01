module("modules.logic.main.model.MainSwitchCategoryListModel", package.seeall)

slot0 = class("MainSwitchCategoryListModel", ListScrollModel)

function slot0.setCategoryId(slot0, slot1)
	slot0.categoryId = slot1

	slot0:onModelUpdate()
end

function slot0.getCategoryId(slot0)
	return slot0.categoryId
end

function slot0.initCategoryList(slot0)
	slot0.categoryId = MainEnum.SwitchType.Character

	slot0:setList({
		{
			id = MainEnum.SwitchType.Character
		},
		{
			id = MainEnum.SwitchType.Scene
		}
	})
end

slot0.instance = slot0.New()

return slot0
