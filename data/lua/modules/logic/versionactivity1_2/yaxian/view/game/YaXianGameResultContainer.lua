module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameResultContainer", package.seeall)

slot0 = class("YaXianGameResultContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		YaXianGameResultView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
