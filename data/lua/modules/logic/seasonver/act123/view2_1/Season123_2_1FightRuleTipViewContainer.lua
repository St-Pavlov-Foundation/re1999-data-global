-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1FightRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1FightRuleTipViewContainer", package.seeall)

local Season123_2_1FightRuleTipViewContainer = class("Season123_2_1FightRuleTipViewContainer", BaseViewContainer)

function Season123_2_1FightRuleTipViewContainer:buildViews()
	local views = {
		TabViewGroup.New(1, "root/contain"),
		Season123_2_1FightRuleTipView.New()
	}

	return views
end

function Season123_2_1FightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		Season123_2_1FightRuleView.New(),
		Season123_2_1FightCardView.New()
	}
end

function Season123_2_1FightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return Season123_2_1FightRuleTipViewContainer
