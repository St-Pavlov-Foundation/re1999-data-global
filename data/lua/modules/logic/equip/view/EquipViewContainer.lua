module("modules.logic.equip.view.EquipViewContainer", package.seeall)

slot0 = class("EquipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_category"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = EquipCategoryItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 300
	slot1.cellHeight = 120
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_equip"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[4]
	slot2.cellClass = EquipChooseItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 3
	slot2.cellWidth = 228
	slot2.cellHeight = 218
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 2.22
	slot2.startSpace = 0
	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = "#scroll_refine_equip"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot3.prefabUrl = slot0._viewSetting.otherRes[4]
	slot3.cellClass = EquipRefineItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.lineCount = 3
	slot3.cellWidth = 228
	slot3.cellHeight = 218
	slot3.cellSpaceH = 1.92
	slot3.cellSpaceV = 3
	slot3.startSpace = 0
	slot4 = ListScrollParam.New()
	slot4.scrollGOPath = "#scroll_costequip"
	slot4.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot4.prefabUrl = slot0._viewSetting.otherRes[5]
	slot4.cellClass = EquipSelectedItem
	slot4.scrollDir = ScrollEnum.ScrollDirH
	slot4.lineCount = 1
	slot4.cellWidth = 127
	slot4.cellHeight = 150
	slot4.cellSpaceH = 8
	slot4.cellSpaceV = 0
	slot4.startSpace = 8
	slot4.endSpace = 8
	slot4.minUpdateCountInFrame = 5
	slot0.equipView = EquipView.New()
	slot0.tableView = EquipTabViewGroup.New(2, "right")

	return {
		LuaListScrollView.New(EquipCategoryListModel.instance, slot1),
		LuaListScrollView.New(EquipChooseListModel.instance, slot2),
		LuaListScrollView.New(EquipRefineListModel.instance, slot3),
		LuaListScrollView.New(EquipSelectedListModel.instance, slot4),
		slot0.equipView,
		TabViewGroup.New(1, "#go_btns"),
		slot0.tableView,
		TabViewGroup.New(3, "#go_righttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigationView
		}
	elseif slot1 == 2 then
		slot2 = ListScrollParam.New()
		slot2.scrollGOPath = "#go_effect/#go_cost/#scroll_cost"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromView
		slot2.prefabUrl = "#go_effect/#go_cost/#scroll_cost/Viewport/#go_cost_item"
		slot2.cellClass = EquipRefineSelectedItem
		slot2.scrollDir = ScrollEnum.ScrollDirH
		slot2.lineCount = 1
		slot2.cellWidth = 124
		slot2.cellHeight = 127
		slot2.cellSpaceH = 18
		slot2.cellSpaceV = 0
		slot2.startSpace = 0
		slot2.endSpace = 0
		slot0.equipInfoView = EquipInfoView.New()
		slot0.equipStrengthenView = EquipStrengthenView.New()
		slot0.equipRefineView = EquipRefineView.New()
		slot0.equipStoryView = EquipStoryView.New()

		return {
			slot0.equipInfoView,
			slot0.equipStrengthenView,
			MultiView.New({
				slot0.equipRefineView,
				LuaListScrollView.New(EquipRefineSelectedListModel.instance, slot2)
			}),
			slot0.equipStoryView
		}
	elseif slot1 == 3 then
		slot2 = CurrencyView.New({
			CurrencyEnum.CurrencyType.Gold
		})

		slot2:overrideCurrencyClickFunc(slot0.onClickCurrency, slot0)

		return {
			slot2
		}
	end
end

function slot0.onClickCurrency(slot0, slot1)
	for slot6 = #JumpController.instance:getCurrentOpenedView(), 1, -1 do
		if slot2[slot6].viewName == slot0.viewName then
			slot7.viewParam = slot7.viewParam or {}
			slot7.viewParam.defaultTabIds = {
				[2.0] = 2
			}
		elseif slot7.viewName == ViewName.BackpackView then
			slot7.viewParam = slot7.viewParam or {}
			slot7.viewParam.defaultTabIds = {
				[BackpackController.BackpackViewTabContainerId] = 2
			}
		end
	end

	if type(slot1) == "number" then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, slot1, false, nil, slot0._cantJump, {
			type = MaterialEnum.MaterialType.Currency,
			id = slot1,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = slot2
		})
	else
		MaterialTipController.instance:showMaterialInfo(slot1.type, slot1.id, false, nil, slot0._cantJump, {
			type = slot1.type,
			id = slot1.id,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = slot2
		})
	end
end

function slot0.playCloseTransition(slot0)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 0.05)
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_checkpoint_story_close)
end

function slot0.setIsOpenLeftBackpack(slot0, slot1)
	slot0.isOpenLeftBackpack = slot1
end

function slot0.getIsOpenLeftBackpack(slot0)
	return slot0.isOpenLeftBackpack or false
end

function slot0.isOpenLeftStrengthenScroll(slot0)
	return slot0.equipView._isShowStrengthenScroll
end

function slot0.playCurrencyViewAnimation(slot0, slot1)
	slot0.equipView:playCurrencyViewAnimation(slot1)
end

return slot0
