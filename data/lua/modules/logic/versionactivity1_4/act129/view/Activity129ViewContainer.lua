module("modules.logic.versionactivity1_4.act129.view.Activity129ViewContainer", package.seeall)

slot0 = class("Activity129ViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.heroView = Activity129HeroView.New()
	slot0.entranceView = Activity129EntranceView.New()
	slot0.rewardView = Activity129RewardView.New()

	table.insert(slot1, slot0.heroView)
	table.insert(slot1, slot0.entranceView)
	table.insert(slot1, slot0.rewardView)
	table.insert(slot1, Activity129View.New())
	table.insert(slot1, Activity129PrizeView.New())
	table.insert(slot1, Activity129ResultView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(slot1, TabViewGroup.New(2, "#go_CurrenyBar"))

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_Result/#go_BigList/#scroll_GetRewardList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = CommonPropItemIcon
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 4
	slot2.cellWidth = 210
	slot2.cellHeight = 210
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(Activity129ResultModel.instance, slot2))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonsView:setOverrideClose(slot0.overrideClose, slot0)

		return {
			slot0._navigateButtonsView
		}
	end

	if slot1 == 2 then
		slot0.currencyView = CurrencyView.New({
			Activity129Config.instance:getConstValue1(slot0.viewParam.actId, Activity129Enum.ConstEnum.CostId)
		})
		slot0.currencyView.foreHideBtn = true

		return {
			slot0.currencyView
		}
	end
end

function slot0.overrideClose(slot0)
	if Activity129Model.instance:getSelectPoolId() then
		Activity129Model.instance:setSelectPoolId()

		return
	end

	slot0:closeThis()
end

return slot0
