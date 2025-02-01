module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameTipViewContainer", package.seeall)

slot0 = class("YaXianGameTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, YaXianGameTipView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
