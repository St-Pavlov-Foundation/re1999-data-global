module("modules.logic.season.view.SeasonEquipHeroViewContainer", package.seeall)

slot0 = class("SeasonEquipHeroViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot2 = SeasonEquipTagSelect.New()

	slot2:init(Activity104EquipController.instance, "#go_normal/right/#drop_filter")

	return {
		SeasonEquipHeroView.New(),
		SeasonEquipHeroSpineView.New(),
		slot2,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, slot0:createEquipItemsParam()),
		TabViewGroup.New(1, "#go_btn")
	}
end

slot0.ColumnCount = 5

function slot0.createEquipItemsParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_normal/right/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = SeasonEquipItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = uv0.ColumnCount
	slot1.cellWidth = 170
	slot1.cellHeight = 235
	slot1.cellSpaceH = 9.2
	slot1.cellSpaceV = 2.18
	slot1.frameUpdateMs = 100
	slot1.minUpdateCountInFrame = uv0.ColumnCount

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

slot0.Close_Anim_Time = 0.17

function slot0.playCloseTransition(slot0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("close", 0, 0)
	TaskDispatcher.runDelay(slot0.delayOnPlayCloseAnim, slot0, uv0.Close_Anim_Time)
end

function slot0.delayOnPlayCloseAnim(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	slot0:onPlayCloseTransitionFinish()
end

return slot0
