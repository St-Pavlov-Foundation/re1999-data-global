module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessBadgeItem", package.seeall)

local var_0_0 = class("AutoChessBadgeItem", LuaCompBase)

var_0_0.ShowType = {
	PvpSettleView = 5,
	MainView = 2,
	CourseView = 3,
	BadgeView = 1,
	RankUpView = 4
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goUnlock = gohelper.findChild(arg_1_1, "root/#go_Unlock")
	arg_1_0.goProgress = gohelper.findChild(arg_1_1, "root/#go_Unlock/#go_Progress")
	arg_1_0.imageProgress = gohelper.findChildImage(arg_1_1, "root/#go_Unlock/#go_Progress/#image_Progress")
	arg_1_0.txtProgress = gohelper.findChildText(arg_1_1, "root/#go_Unlock/#go_Progress/#txt_Progress")
	arg_1_0.simageBadgeU = gohelper.findChildSingleImage(arg_1_1, "root/#go_Unlock/#simage_BadgeU")
	arg_1_0.goStar = gohelper.findChild(arg_1_1, "root/#go_Unlock/#go_Star")
	arg_1_0.goLock = gohelper.findChild(arg_1_1, "root/#go_Lock")
	arg_1_0.simageBadgeL = gohelper.findChildSingleImage(arg_1_1, "root/#go_Lock/#simage_BadgeL")
	arg_1_0.txtUnlock = gohelper.findChildText(arg_1_1, "root/#go_Lock/#txt_Unlock")
	arg_1_0.txtName = gohelper.findChildText(arg_1_1, "root/Name/#txt_Name")
	arg_1_0.goReward = gohelper.findChild(arg_1_1, "#go_Reward")
	arg_1_0.goRewardItem = gohelper.findChild(arg_1_1, "#go_Reward/Content/#go_RewardItem")
end

function var_0_0.onDestroy(arg_2_0)
	if arg_2_0.tweenId then
		ZProj.TweenHelper.KillById(arg_2_0.tweenId)
	end

	arg_2_0.simageBadgeL:UnLoadImage()
	arg_2_0.simageBadgeU:UnLoadImage()
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.actId = Activity182Model.instance:getCurActId()
	arg_3_0.curScore = arg_3_2
	arg_3_0.rankId = arg_3_1
	arg_3_0.showType = arg_3_3
	arg_3_0.config = lua_auto_chess_rank.configDict[arg_3_0.actId][arg_3_1]

	if not arg_3_0.config then
		logError(string.format("段位ID: %s 配置不存在", arg_3_1))

		return
	end

	local var_3_0 = lua_auto_chess_rank.configDict[arg_3_0.actId][arg_3_0.rankId - 1]

	arg_3_0.needScore = var_3_0 and var_3_0.score or 0

	if arg_3_3 == var_0_0.ShowType.BadgeView then
		arg_3_0:showReward()
	elseif arg_3_3 == var_0_0.ShowType.MainView then
		arg_3_0:showProgress()
		arg_3_0:addClick()
	elseif arg_3_3 == var_0_0.ShowType.PvpSettleView then
		arg_3_0:showProgress()
	end

	arg_3_0:refreshNormal()
end

function var_0_0.addClick(arg_4_0)
	arg_4_0.btnClick = gohelper.findButtonWithAudio(arg_4_0.go)

	arg_4_0:addClickCb(arg_4_0.btnClick, arg_4_0.onClick, arg_4_0)
end

function var_0_0.refreshNormal(arg_5_0)
	if arg_5_0.config.score == 0 then
		arg_5_0.txtName.text = luaLang("autochess_badgeitem_noget")
	else
		arg_5_0.unlock = arg_5_0.needScore <= arg_5_0.curScore

		if arg_5_0.unlock then
			arg_5_0.simageBadgeU:LoadImage(ResUrl.getAutoChessIcon(arg_5_0.config.icon, "badgeicon"))
		else
			arg_5_0.simageBadgeL:LoadImage(ResUrl.getAutoChessIcon(arg_5_0.config.icon, "badgeicon"))

			local var_5_0 = luaLang("autochess_badgeitem_unlock")

			arg_5_0.txtUnlock.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_5_0, arg_5_0.curScore, arg_5_0.needScore)
		end

		arg_5_0.txtName.text = arg_5_0.config.name

		gohelper.setActive(arg_5_0.goUnlock, arg_5_0.unlock)
		gohelper.setActive(arg_5_0.goLock, not arg_5_0.unlock)
	end

	gohelper.setActive(arg_5_0.simageBadgeU, arg_5_0.config.score ~= 0)
	gohelper.setActive(arg_5_0.goStar, arg_5_0.config.score ~= 0)
end

function var_0_0.showProgress(arg_6_0)
	if arg_6_0.config.score ~= 0 then
		arg_6_0.imageProgress.fillAmount = arg_6_0.correctFillAmount(arg_6_0.curScore / arg_6_0.config.score)
		arg_6_0.txtProgress.text = string.format("%d/%d", arg_6_0.curScore, arg_6_0.config.score)

		gohelper.setActive(arg_6_0.goProgress, true)
	end
end

function var_0_0.showReward(arg_7_0)
	local var_7_0 = DungeonConfig.instance:getRewardItems(arg_7_0.config.reward)

	if #var_7_0 ~= 0 then
		local var_7_1 = Activity182Model.instance:getActMo()

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			local var_7_2 = gohelper.cloneInPlace(arg_7_0.goRewardItem, iter_7_0)
			local var_7_3 = gohelper.findChild(var_7_2, "go_receive")

			gohelper.setActive(var_7_3, arg_7_0.rankId <= var_7_1.historyInfo.maxRank)

			local var_7_4 = IconMgr.instance:getCommonItemIcon(var_7_2)

			gohelper.setAsFirstSibling(var_7_4.go)
			var_7_4:setMOValue(iter_7_1[1], iter_7_1[2], iter_7_1[3], nil, true)
			var_7_4:setCountFontSize(32)

			local var_7_5 = var_7_4:getCountBg()

			recthelper.setAnchorY(var_7_5.transform, 50)
		end

		gohelper.setActive(arg_7_0.goReward, true)
		gohelper.setActive(arg_7_0.goRewardItem, false)
	else
		gohelper.setActive(arg_7_0.goReward, false)
	end
end

function var_0_0.onClick(arg_8_0)
	AutoChessController.instance:statButtonClick(ViewName.AutoChessMainView, "btnBadgeItemOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessBadgeView)
end

function var_0_0.playProgressAnim(arg_9_0, arg_9_1)
	if arg_9_1 == 0 then
		return
	end

	arg_9_0.changeScore = arg_9_1

	local var_9_0 = arg_9_0.curScore - arg_9_1

	arg_9_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_9_0, arg_9_0.curScore, 1, arg_9_0.frameCallback, arg_9_0.finishCallback, arg_9_0, nil, EaseType.Linear)
end

function var_0_0.frameCallback(arg_10_0, arg_10_1)
	if arg_10_0.showType == var_0_0.ShowType.PvpSettleView then
		if arg_10_0.changeScore > 0 then
			arg_10_0.txtProgress.text = string.format("%d/%d<color=#44A847>(+%d)</color>", arg_10_1, arg_10_0.config.score, arg_10_0.changeScore)
		else
			arg_10_0.txtProgress.text = string.format("%d/%d<color=#E76C6C>(%d)</color>", arg_10_1, arg_10_0.config.score, arg_10_0.changeScore)
		end
	else
		arg_10_0.txtProgress.text = string.format("%d/%d", arg_10_1, arg_10_0.config.score)
	end

	arg_10_0.imageProgress.fillAmount = arg_10_0.correctFillAmount(arg_10_1 / arg_10_0.config.score)
end

function var_0_0.finishCallback(arg_11_0)
	arg_11_0.changeScore = nil
	arg_11_0.tweenId = nil
end

function var_0_0.correctFillAmount(arg_12_0)
	if arg_12_0 < 0.5 then
		arg_12_0 = 0.12 + arg_12_0 / 0.5 * 0.38
	elseif arg_12_0 > 0.5 then
		arg_12_0 = 0.5 + (arg_12_0 - 0.5) / 0.5 * 0.38
	end

	return arg_12_0
end

return var_0_0
