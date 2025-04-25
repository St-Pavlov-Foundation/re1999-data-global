module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPveFirstSettleView", package.seeall)

slot0 = class("AutoChessPveFirstSettleView", BaseView)

function slot0.onInitView(slot0)
	slot0._goSpecialTarget = gohelper.findChild(slot0.viewGO, "root/#go_SpecialTarget")
	slot0._txtSpecialTarget = gohelper.findChildText(slot0.viewGO, "root/#go_SpecialTarget/#txt_SpecialTarget")
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

	slot0.config = lua_auto_chess_episode.configDict[AutoChessModel.instance.episodeId]

	if GameUtil.splitString2(slot0.config.firstBounds, true) then
		for slot6, slot7 in ipairs(slot2) do
			slot9 = IconMgr.instance:getCommonItemIcon(gohelper.cloneInPlace(slot0._goRewardItem))

			gohelper.setAsFirstSibling(slot9.go)
			slot9:setMOValue(slot7[1], slot7[2], slot7[3])
			transformhelper.setLocalScale(slot9:getCountBg().transform, 1, 1.7, 1)
			slot9:setCountFontSize(45)
		end
	else
		gohelper.setActive(slot0._goReward, false)
	end

	gohelper.setActive(slot0._goRewardItem, false)
	slot0:refreshSpecialUnlockTips()
end

function slot0.onClose(slot0)
	AutoChessController.instance:onSettleViewClose()
	AutoChessController.instance:popupRewardView()
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshSpecialUnlockTips(slot0)
	slot2 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderSlot].value)
	slot3 = lua_auto_chess_episode.configDict[AutoChessEnum.PvpEpisodeId].preEpisode

	if slot0.config.id == tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderRefresh].value) then
		slot0._txtSpecialTarget.text = luaLang("autochess_pvesettleview_tips3")
	elseif slot0.config.id == slot2 then
		slot0._txtSpecialTarget.text = luaLang("autochess_pvesettleview_tips2")
	elseif slot0.config.id == slot3 then
		slot0._txtSpecialTarget.text = luaLang("autochess_pvesettleview_tips1")
	else
		gohelper.setActive(slot0._goSpecialTarget, false)
	end
end

return slot0
