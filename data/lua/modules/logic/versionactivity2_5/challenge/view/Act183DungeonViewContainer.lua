module("modules.logic.versionactivity2_5.challenge.view.Act183DungeonViewContainer", package.seeall)

slot0 = class("Act183DungeonViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "root/#go_topleft"))

	slot0._mainView = Act183DungeonView.New()

	table.insert(slot1, slot0._mainView)
	table.insert(slot1, Act183DungeonView_Animation.New())
	table.insert(slot1, Act183DungeonView_Detail.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			slot0:_getHelpId() ~= nil
		}, slot2)

		return {
			slot0.navigateView
		}
	end
end

function slot0._getHelpId(slot0)
	if HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Act183EnterDungeon) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Act183Repress) then
		return HelpEnum.HelpId.Act183DungeonAndRepress
	elseif slot2 ~= slot1 then
		if slot2 then
			return HelpEnum.HelpId.Act183Repress
		else
			return HelpEnum.HelpId.Act183EnterDungeon
		end
	end
end

function slot0.getMainView(slot0)
	return slot0._mainView
end

function slot0.refreshHelpId(slot0)
	if slot0:_getHelpId() ~= nil then
		slot0.navigateView:setHelpId(slot1)
	end
end

function slot0.onContainerInit(slot0)
	slot0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.refreshHelpId, slot0)
end

return slot0
