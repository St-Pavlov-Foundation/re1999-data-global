module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonEpisodeViewContainer", package.seeall)

slot0 = class("VersionActivity1_4DungeonEpisodeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity1_4DungeonEpisodeView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_righttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.Power
		})

		return {
			slot0.currencyView
		}
	end
end

return slot0
