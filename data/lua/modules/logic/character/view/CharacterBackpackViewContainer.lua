module("modules.logic.character.view.CharacterBackpackViewContainer", package.seeall)

slot0 = class("CharacterBackpackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_container"),
		CharacterBackpackView.New(),
		CommonRainEffectView.New("bg/#go_glowcontainer")
	}
end

function slot0.playCardOpenAnimation(slot0)
	if slot0._cardScrollView then
		slot0._cardScrollView:playOpenAnimation()
	end
end

function slot0.playEquipOpenAnimation(slot0)
	if slot0._equipScrollView then
		slot0._equipScrollView:playOpenAnimation()
	end
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, slot0._closeCallback, nil, , slot0)

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		slot2 = ListScrollParam.New()
		slot2.scrollGOPath = "#scroll_card"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot2.prefabUrl = slot0._viewSetting.otherRes[1]
		slot2.cellClass = CharacterBackpackCardListItem
		slot2.scrollDir = ScrollEnum.ScrollDirV
		slot2.lineCount = 6
		slot2.cellWidth = 250
		slot2.cellHeight = 555
		slot2.cellSpaceH = 18
		slot2.cellSpaceV = 20
		slot2.startSpace = 9
		slot2.frameUpdateMs = 100

		for slot7 = 1, 12 do
		end

		slot0._cardScrollView = LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, slot2, {
			[slot7] = math.ceil((slot7 - 1) % 6) * 0.06
		})

		return {
			MultiView.New({
				slot0._cardScrollView,
				CharacterBackpackHeroView.New()
			})
		}
	end
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0._closeCallback(slot0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function slot0.onContainerOpen(slot0)
	slot0.notPlayAnimation = true
end

function slot0.onContainerClose(slot0)
	slot0.notPlayAnimation = false
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetCloseBtnAudioId(AudioEnum.UI.UI_Rolesclose)
	slot0._navigateButtonView:resetHomeBtnAudioId(AudioEnum.UI.UI_Rolesclose)
end

return slot0
