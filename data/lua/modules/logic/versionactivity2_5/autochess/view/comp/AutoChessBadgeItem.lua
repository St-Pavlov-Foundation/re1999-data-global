module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessBadgeItem", package.seeall)

slot0 = class("AutoChessBadgeItem", LuaCompBase)
slot0.ShowType = {
	PvpSettleView = 5,
	MainView = 2,
	CourseView = 3,
	BadgeView = 1,
	RankUpView = 4
}

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goEmpty = gohelper.findChild(slot1, "root/#go_Empty")
	slot0.goUnlock = gohelper.findChild(slot1, "root/#go_Unlock")
	slot0.simageBadgeU = gohelper.findChildSingleImage(slot1, "root/#go_Unlock/#simage_BadgeU")
	slot0.goProgress = gohelper.findChild(slot1, "root/#go_Unlock/#go_Progress")
	slot0.imageProgress = gohelper.findChildImage(slot1, "root/#go_Unlock/#go_Progress/#image_Progress")
	slot0.txtProgress = gohelper.findChildText(slot1, "root/#go_Unlock/#go_Progress/#txt_Progress")
	slot0.goLock = gohelper.findChild(slot1, "root/#go_Lock")
	slot0.simageBadgeL = gohelper.findChildSingleImage(slot1, "root/#go_Lock/#simage_BadgeL")
	slot0.txtUnlock = gohelper.findChildText(slot1, "root/#go_Lock/#txt_Unlock")
	slot0.txtName = gohelper.findChildText(slot1, "root/Name/#txt_Name")
	slot0.goReward = gohelper.findChild(slot1, "#go_Reward")
	slot0.goRewardItem = gohelper.findChild(slot1, "#go_Reward/Content/#go_RewardItem")
end

function slot0.onDestroy(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end

	slot0.simageBadgeL:UnLoadImage()
	slot0.simageBadgeU:UnLoadImage()
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0.actId = Activity182Model.instance:getCurActId()
	slot0.curScore = slot2
	slot0.rankId = slot1
	slot0.showType = slot3
	slot0.config = lua_auto_chess_rank.configDict[slot0.actId][slot1]

	if not slot0.config then
		slot0.txtName.text = luaLang("autochess_badgeitem_noget")

		gohelper.setActive(slot0.goUnlock, false)
		gohelper.setActive(slot0.goLock, false)
		gohelper.setActive(slot0.goReward, false)

		return
	end

	slot0.needScore = lua_auto_chess_rank.configDict[slot0.actId][slot0.rankId - 1] and slot4.score or 0

	if slot3 == uv0.ShowType.BadgeView then
		slot0:showReward()
	elseif slot3 == uv0.ShowType.MainView then
		slot0:showProgress()
		slot0:addClick()
	elseif slot3 == uv0.ShowType.PvpSettleView then
		slot0:showProgress()
	end

	slot0:refreshNormal()
end

function slot0.addClick(slot0)
	slot0.btnClick = gohelper.findButtonWithAudio(slot0.go)

	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
end

function slot0.refreshNormal(slot0)
	slot0.unlock = slot0.needScore <= slot0.curScore

	if slot0.unlock then
		slot0.simageBadgeU:LoadImage(ResUrl.getAutoChessIcon(slot0.config.icon, "badgeicon"))
	else
		slot0.simageBadgeL:LoadImage(ResUrl.getAutoChessIcon(slot0.config.icon, "badgeicon"))

		slot0.txtUnlock.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("autochess_badgeitem_unlock"), slot0.curScore, slot0.needScore)
	end

	slot0.txtName.text = slot0.config.name

	gohelper.setActive(slot0.goUnlock, slot0.unlock)
	gohelper.setActive(slot0.goLock, not slot0.unlock)
end

function slot0.showProgress(slot0)
	slot0.imageProgress.fillAmount = slot0.correctFillAmount(slot0.curScore / slot0.config.score)
	slot0.txtProgress.text = string.format("%d/%d", slot0.curScore, slot0.config.score)

	gohelper.setActive(slot0.goProgress, true)
end

function slot0.showReward(slot0)
	if #DungeonConfig.instance:getRewardItems(slot0.config.reward) ~= 0 then
		for slot6, slot7 in ipairs(slot1) do
			gohelper.setActive(gohelper.findChild(gohelper.cloneInPlace(slot0.goRewardItem, slot6), "go_receive"), slot0.rankId <= Activity182Model.instance:getActMo().historyInfo.maxRank)

			slot10 = IconMgr.instance:getCommonItemIcon(slot8)

			gohelper.setAsFirstSibling(slot10.go)
			slot10:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
			slot10:setCountFontSize(32)
			recthelper.setAnchorY(slot10:getCountBg().transform, 50)
		end

		gohelper.setActive(slot0.goReward, true)
		gohelper.setActive(slot0.goRewardItem, false)
	else
		gohelper.setActive(slot0.goReward, false)
	end
end

function slot0.onClick(slot0)
	ViewMgr.instance:openView(ViewName.AutoChessBadgeView)
end

function slot0.playProgressAnim(slot0, slot1)
	if slot1 == 0 then
		return
	end

	slot0.changeScore = slot1
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0.curScore - slot1, slot0.curScore, 1, slot0.frameCallback, slot0.finishCallback, slot0, nil, EaseType.Linear)
end

function slot0.frameCallback(slot0, slot1)
	if slot0.showType == uv0.ShowType.PvpSettleView then
		if slot0.changeScore > 0 then
			slot0.txtProgress.text = string.format("%d/%d<color=#44A847>(+%d)</color>", slot1, slot0.config.score, slot0.changeScore)
		else
			slot0.txtProgress.text = string.format("%d/%d<color=#E76C6C>(%d)</color>", slot1, slot0.config.score, slot0.changeScore)
		end
	else
		slot0.txtProgress.text = string.format("%d/%d", slot1, slot0.config.score)
	end

	slot0.imageProgress.fillAmount = slot0.correctFillAmount(slot1 / slot0.config.score)
end

function slot0.finishCallback(slot0)
	slot0.changeScore = nil
	slot0.tweenId = nil
end

function slot0.correctFillAmount(slot0)
	if slot0 < 0.5 then
		slot0 = 0.12 + slot0 / 0.5 * 0.38
	elseif slot0 > 0.5 then
		slot0 = 0.5 + (slot0 - 0.5) / 0.5 * 0.38
	end

	return slot0
end

return slot0
