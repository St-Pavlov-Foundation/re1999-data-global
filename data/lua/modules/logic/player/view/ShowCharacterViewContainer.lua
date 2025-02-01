module("modules.logic.player.view.ShowCharacterViewContainer", package.seeall)

slot0 = class("ShowCharacterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_rolecontainer/#scroll_card"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = ShowCharacterCardItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 7
	slot2.cellWidth = 267
	slot2.cellHeight = 550
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot2.frameUpdateMs = 100

	for slot7 = 1, 14 do
	end

	table.insert(slot1, LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, slot2, {
		[slot7] = math.ceil(slot7 - 1) % 7 * 0.06
	}))
	table.insert(slot1, ShowCharacterView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 101, slot0.onClose, slot0.onClose, nil, slot0)

	return {
		slot0.navigationView
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Open)
	slot0.navigationView:resetHomeBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

function slot0.onClose(slot0)
	PlayerRpc.instance:sendSetShowHeroUniqueIdsRequest(PlayerModel.instance:getShowHeroUid())
end

return slot0
