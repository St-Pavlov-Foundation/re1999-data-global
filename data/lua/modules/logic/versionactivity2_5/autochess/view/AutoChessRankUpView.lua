module("modules.logic.versionactivity2_5.autochess.view.AutoChessRankUpView", package.seeall)

slot0 = class("AutoChessRankUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._goBadgeRoot = gohelper.findChild(slot0.viewGO, "#go_BadgeRoot")
	slot0._goReward = gohelper.findChild(slot0.viewGO, "root/#go_Reward")
	slot0._goRewardItem = gohelper.findChild(slot0.viewGO, "root/#go_Reward/reward/#go_RewardItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)

	slot0.actMo = Activity182Model.instance:getActMo()

	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.BadgeItemPath, slot0._goBadgeRoot), AutoChessBadgeItem):setData(slot0.actMo.rank, slot0.actMo.score, AutoChessBadgeItem.ShowType.RankUpView)

	if slot0.actMo.newRankUp then
		if lua_auto_chess_rank.configDict[slot0.actMo.activityId][slot0.actMo.rank] then
			for slot8, slot9 in ipairs(DungeonConfig.instance:getRewardItems(slot3.reward)) do
				slot11 = IconMgr.instance:getCommonItemIcon(gohelper.cloneInPlace(slot0._goRewardItem, slot8))

				gohelper.setAsFirstSibling(slot11.go)
				slot11:setMOValue(slot9[1], slot9[2], slot9[3], nil, true)
				slot11:setCountFontSize(32)
			end

			gohelper.setActive(slot0.goReward, #slot4 ~= 0)
		end
	else
		gohelper.setActive(slot0.goReward, false)
	end

	gohelper.setActive(slot0._goRewardItem, false)
end

function slot0.onClose(slot0)
	slot0.actMo:clearRankUpMark()
	AutoChessController.instance:popupRewardView()
end

function slot0.onDestroyView(slot0)
end

return slot0
