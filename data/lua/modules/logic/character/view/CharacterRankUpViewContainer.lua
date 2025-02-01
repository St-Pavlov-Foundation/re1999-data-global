module("modules.logic.character.view.CharacterRankUpViewContainer", package.seeall)

slot0 = class("CharacterRankUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {
		CharacterRankUpView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
	slot2 = HelpShowView.New()

	slot2:setHelpId(HelpEnum.HelpId.CharacterRankUp)
	slot2:setDelayTime(0.5)
	table.insert(slot1, slot2)

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			HelpModel.instance:isShowedHelp(HelpEnum.HelpId.CharacterRankUp)
		}, HelpEnum.HelpId.CharacterRankUp)

		return {
			slot0._navigateButtonView
		}
	end

	if slot1 == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Gold
			})
		}
	end
end

function slot0.refreshHelp(slot0)
	if slot0._navigateButtonView then
		slot0._navigateButtonView:setParam({
			true,
			true,
			HelpModel.instance:isShowedHelp(HelpEnum.HelpId.CharacterRankUp)
		})
	end
end

return slot0
