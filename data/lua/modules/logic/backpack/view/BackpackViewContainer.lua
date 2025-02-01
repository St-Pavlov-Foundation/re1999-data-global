module("modules.logic.backpack.view.BackpackViewContainer", package.seeall)

slot0 = class("BackpackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_category"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[2]
	slot1.cellClass = BackpackCategoryListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 370
	slot1.cellHeight = 110
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 4

	return {
		LuaListScrollView.New(BackpackCategoryListModel.instance, slot1),
		BackpackView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(BackpackController.BackpackViewTabContainerId, "#go_container"),
		CommonRainEffectView.New("rainEffect")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot2 = 0

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
		slot3 = ListScrollParam.New()
		slot3.scrollGOPath = "#scroll_prop"
		slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot3.prefabUrl = slot0._viewSetting.otherRes[1]
		slot3.cellClass = BackpackPropListItem
		slot3.scrollDir = ScrollEnum.ScrollDirV
		slot3.lineCount = 6
		slot3.cellWidth = 254
		slot3.cellHeight = 200
		slot3.cellSpaceH = slot2
		slot3.cellSpaceV = 25
		slot3.startSpace = 28
		slot3.endSpace = 0
		slot3.minUpdateCountInFrame = 100
		slot4 = ListScrollParam.New()
		slot4.scrollGOPath = "#scroll_equip"
		slot4.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot4.prefabUrl = slot0._viewSetting.otherRes[3]
		slot4.cellClass = CharacterEquipItem
		slot4.scrollDir = ScrollEnum.ScrollDirV
		slot4.lineCount = 6
		slot4.cellWidth = 220
		slot4.cellHeight = 210
		slot4.cellSpaceH = 33.8 + slot2
		slot4.cellSpaceV = 13
		slot4.startSpace = 16
		slot4.minUpdateCountInFrame = 100
		slot6 = nil

		for slot10 = 1, 24 do
		end

		slot7 = ListScrollParam.New()
		slot7.scrollGOPath = "#scroll_antique"
		slot7.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot7.prefabUrl = slot0._viewSetting.otherRes[1]
		slot7.cellClass = AntiqueBackpackItem
		slot7.scrollDir = ScrollEnum.ScrollDirV
		slot7.lineCount = 6
		slot7.cellWidth = 250
		slot7.cellHeight = 250
		slot7.cellSpaceH = 0
		slot7.cellSpaceV = 0
		slot7.startSpace = 20
		slot7.endSpace = 10
		slot7.minUpdateCountInFrame = 100
		slot0.notPlayAnimation = true

		return {
			MultiView.New({
				BackpackPropView.New(),
				LuaListScrollView.New(BackpackPropListModel.instance, slot3)
			}),
			MultiView.New({
				CharacterBackpackEquipView.New(),
				LuaListScrollViewWithAnimator.New(CharacterBackpackEquipListModel.instance, slot4, {
					[slot10] = (math.ceil(slot10 / 6) - 1) * 0.03
				})
			}),
			MultiView.New({
				AntiqueBackpackView.New(),
				LuaListScrollViewWithAnimator.New(AntiqueBackpackListModel.instance, slot7)
			})
		}
	end
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_Rolesclose)
end

function slot0.setCurrentSelectCategoryId(slot0, slot1)
	slot0.currentSelectCategoryId = slot1 or ItemEnum.CategoryType.All
end

function slot0.getCurrentSelectCategoryId(slot0)
	return slot0.currentSelectCategoryId
end

return slot0
