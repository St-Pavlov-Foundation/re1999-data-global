module("modules.logic.mail.view.MailViewContainer", package.seeall)

slot0 = class("MailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "mailtipview/#go_left/#scroll_mail"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = MailCategoryListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 523.3303
	slot2.cellHeight = 113.2241
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 2.48
	slot2.startSpace = 8

	for slot7 = 1, 6 do
	end

	table.insert(slot1, LuaListScrollViewWithAnimator.New(MailCategroyModel.instance, slot2, {
		[slot7] = 0
	}))
	table.insert(slot1, MailView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigationView
		}
	end
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Mail_close)
end

return slot0
