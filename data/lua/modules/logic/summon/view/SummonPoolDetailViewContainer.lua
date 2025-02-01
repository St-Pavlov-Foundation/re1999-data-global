module("modules.logic.summon.view.SummonPoolDetailViewContainer", package.seeall)

slot0 = class("SummonPoolDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "category/#scroll_category"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = SummonPoolDetailCategoryItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 380
	slot2.cellHeight = 116
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 4

	table.insert(slot1, LuaListScrollView.New(SummonPoolDetailCategoryListModel.instance, slot2))
	table.insert(slot1, SummonPoolDetailView.New())
	table.insert(slot1, TabViewGroup.New(1, "info"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			MultiView.New({
				SummonPoolDetailDescView.New(),
				SummonPoolDetailDescProbUpView.New()
			}),
			SummonPoolDetailProbabilityView.New()
		}
	end
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
