module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBadgeBtnComp", package.seeall)

local var_0_0 = class("Act183DungeonBadgeBtnComp", Act183DungeonBaseComp)
local var_0_1 = {
	660,
	-416
}
local var_0_2 = {
	445,
	-416
}
local var_0_3 = {
	445,
	-416
}

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._btnbadge = gohelper.getClickWithDefaultAudio(arg_1_0.go)
	arg_1_0._imagebadgebtn = gohelper.onceAddComponent(arg_1_0.go, gohelper.Type_Image)
	arg_1_0._txtusebadgenum = gohelper.findChildText(arg_1_0.go, "#txt_usebadgenum")
	arg_1_0._readyUseBadgeNum = 0
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateSelectBadgeNum, arg_2_0._onUpdateSelectBadgeNum, arg_2_0)
	arg_2_0._btnbadge:AddClickListener(arg_2_0._btnbadgeOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnbadge:RemoveClickListener()
end

function var_0_0._btnbadgeOnClick(arg_4_0)
	local var_4_0 = arg_4_0.mgr:getComp(Act183DungeonSelectBadgeComp)

	if var_4_0 then
		var_4_0:_onUpdateBadgeDetailVisible(true, arg_4_0._readyUseBadgeNum)
	end

	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateBadgeDetailVisible, true, arg_4_0._readyUseBadgeNum)
end

function var_0_0.updateInfo(arg_5_0, arg_5_1)
	var_0_0.super.updateInfo(arg_5_0, arg_5_1)

	local var_5_0 = Act183Model.instance:getActInfo()

	arg_5_0._totalBadgeNum = var_5_0 and var_5_0:getBadgeNum() or 0
	arg_5_0._useBadgeNum = arg_5_0._episodeMo:getUseBadgeNum()
	arg_5_0._readyUseBadgeNum = arg_5_0._useBadgeNum or 0
end

function var_0_0.checkIsVisible(arg_6_0)
	return arg_6_0._status ~= Act183Enum.EpisodeStatus.Locked and arg_6_0._totalBadgeNum > 0 and arg_6_0._groupType == Act183Enum.GroupType.NormalMain
end

function var_0_0.show(arg_7_0)
	var_0_0.super.show(arg_7_0)

	local var_7_0 = var_0_3
	local var_7_1 = arg_7_0.mgr:isCompVisible(Act183DungeonRepressBtnComp)

	if arg_7_0.mgr:isCompVisible(Act183DungeonRestartBtnComp) then
		var_7_0 = var_7_1 and var_0_1 or var_0_2
	end

	recthelper.setAnchor(arg_7_0.tran, var_7_0[1], var_7_0[2])
	arg_7_0:_refreshBadgeNum()
end

function var_0_0._refreshBadgeNum(arg_8_0)
	local var_8_0 = arg_8_0._readyUseBadgeNum and arg_8_0._readyUseBadgeNum > 0

	gohelper.setActive(arg_8_0._txtusebadgenum.gameObject, var_8_0)

	arg_8_0._txtusebadgenum.text = arg_8_0._readyUseBadgeNum

	local var_8_1 = var_8_0 and "v2a5_challenge_dungeon_iconbtn2" or "v2a5_challenge_dungeon_iconbtn1"

	UISpriteSetMgr.instance:setChallengeSprite(arg_8_0._imagebadgebtn, var_8_1)
end

function var_0_0._onUpdateSelectBadgeNum(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._episodeId ~= arg_9_1 then
		return
	end

	arg_9_0._readyUseBadgeNum = arg_9_2 or 0

	arg_9_0:refresh()
end

function var_0_0.onDestroy(arg_10_0)
	var_0_0.super.onDestroy(arg_10_0)
end

return var_0_0
