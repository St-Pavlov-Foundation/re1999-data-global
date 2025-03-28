module("modules.logic.seasonver.act123.view2_0.Season123_2_0EquipViewContainer", package.seeall)

slot0 = class("Season123_2_0EquipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot2 = Season123_2_0EquipTagSelect.New()

	slot2:init(Season123EquipController.instance, "right/#drop_filter")

	return {
		Season123_2_0EquipView.New(),
		Season123_2_0EquipSpineView.New(),
		slot2,
		LuaListScrollView.New(Season123EquipItemListModel.instance, slot0:createEquipItemsParam()),
		TabViewGroup.New(1, "#go_btn")
	}
end

function slot0.createEquipItemsParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "right/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season123_2_0EquipItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = Season123_2_0EquipItem.ColumnCount
	slot1.cellWidth = 170
	slot1.cellHeight = 235
	slot1.cellSpaceH = 8.4
	slot1.cellSpaceV = 0
	slot1.frameUpdateMs = 100
	slot1.minUpdateCountInFrame = Season123_2_0EquipItem.ColumnCount

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

slot0.Close_Anim_Time = 0.2

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
