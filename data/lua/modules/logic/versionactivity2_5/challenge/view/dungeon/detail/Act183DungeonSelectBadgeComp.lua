module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonSelectBadgeComp", package.seeall)

local var_0_0 = class("Act183DungeonSelectBadgeComp", Act183DungeonBaseComp)
local var_0_1 = {
	610,
	-416
}
local var_0_2 = {
	395,
	-416
}
local var_0_3 = {
	394.33,
	-416
}

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gobadgeitem = gohelper.findChild(arg_1_0.go, "#go_badges/#go_badgeitem")
	arg_1_0._btnresetbadge = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_badges/#btn_resetbadge")
	arg_1_0._btnclosebadge = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_closebadge")
	arg_1_0._badgeItemTab = arg_1_0:getUserDataTb_()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateBadgeDetailVisible, arg_2_0._onUpdateBadgeDetailVisible, arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateSelectBadgeNum, arg_2_0._onUpdateSelectBadgeNum, arg_2_0)
	arg_2_0._btnresetbadge:AddClickListener(arg_2_0._btnresetbadgeOnClick, arg_2_0)
	arg_2_0._btnclosebadge:AddClickListener(arg_2_0._btnclosebadgeOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnresetbadge:RemoveClickListener()
	arg_3_0._btnclosebadge:RemoveClickListener()
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	var_0_0.super.updateInfo(arg_4_0, arg_4_1)

	arg_4_0._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(arg_4_0._episodeId)
	arg_4_0._useBadgeNum = arg_4_0._episodeMo:getUseBadgeNum()
	arg_4_0._readyUseBadgeNum = arg_4_0._useBadgeNum or 0

	local var_4_0 = Act183Model.instance:getActInfo()

	arg_4_0._totalBadgeNum = var_4_0 and var_4_0:getBadgeNum() or 0
	arg_4_0._isVisibe = false
end

function var_0_0.checkIsVisible(arg_5_0)
	return arg_5_0._isVisibe
end

function var_0_0.show(arg_6_0)
	var_0_0.super.show(arg_6_0)
	arg_6_0:createObjListNum(arg_6_0._totalBadgeNum, arg_6_0._badgeItemTab, arg_6_0._gobadgeitem, arg_6_0._initBadgeItemFunc, arg_6_0._refreshBadgeItemFunc, arg_6_0._defaultItemFreeFunc)
	arg_6_0:_setPosition()
end

function var_0_0._setPosition(arg_7_0)
	local var_7_0 = var_0_3
	local var_7_1 = arg_7_0.mgr:isCompVisible(Act183DungeonRepressBtnComp)

	if arg_7_0.mgr:isCompVisible(Act183DungeonRestartBtnComp) then
		var_7_0 = var_7_1 and var_0_1 or var_0_2
	end

	recthelper.setAnchor(arg_7_0.tran, var_7_0[1], var_7_0[2])
end

function var_0_0._initBadgeItemFunc(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1.imageicon = gohelper.findChildImage(arg_8_1.go, "image_icon")
	arg_8_1.btnclick = gohelper.findChildButtonWithAudio(arg_8_1.go, "btn_click")

	arg_8_1.btnclick:AddClickListener(arg_8_0._onClickBadgeItem, arg_8_0, arg_8_2)
end

function var_0_0._refreshBadgeItemFunc(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_3 <= arg_9_0._readyUseBadgeNum and "v2a5_challenge_badge1" or "v2a5_challenge_badge2"

	UISpriteSetMgr.instance:setChallengeSprite(arg_9_1.imageicon, var_9_0)
end

function var_0_0._releaseBadgeItems(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._badgeItemTab) do
		iter_10_1.btnclick:RemoveClickListener()
	end
end

function var_0_0._onClickBadgeItem(arg_11_0, arg_11_1)
	if arg_11_0._readyUseBadgeNum == arg_11_1 then
		return
	end

	arg_11_0._readyUseBadgeNum = arg_11_1

	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateSelectBadgeNum, arg_11_0._episodeId, arg_11_0._readyUseBadgeNum)
end

function var_0_0._btnresetbadgeOnClick(arg_12_0)
	if arg_12_0._readyUseBadgeNum == 0 then
		return
	end

	arg_12_0._readyUseBadgeNum = 0

	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateSelectBadgeNum, arg_12_0._episodeId, arg_12_0._readyUseBadgeNum)
end

function var_0_0._btnclosebadgeOnClick(arg_13_0)
	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateBadgeDetailVisible, false, arg_13_0._readyUseBadgeNum)
end

function var_0_0._onUpdateSelectBadgeNum(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._episodeId ~= arg_14_1 or not arg_14_0._isVisibe then
		return
	end

	arg_14_0._readyUseBadgeNum = arg_14_2

	arg_14_0:refresh()
end

function var_0_0.getReadyUseBadgeNum(arg_15_0)
	return arg_15_0._readyUseBadgeNum or 0
end

function var_0_0._onUpdateBadgeDetailVisible(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._isVisibe = arg_16_1
	arg_16_0._readyUseBadgeNum = arg_16_2 or 0

	arg_16_0:refresh()
end

function var_0_0.onDestroy(arg_17_0)
	arg_17_0:_releaseBadgeItems()
	var_0_0.super.onDestroy(arg_17_0)
end

return var_0_0
