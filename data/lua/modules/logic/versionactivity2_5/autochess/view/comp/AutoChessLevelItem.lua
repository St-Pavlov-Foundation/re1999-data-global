module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessLevelItem", package.seeall)

slot0 = class("AutoChessLevelItem", LuaCompBase)
slot0.UnlockPrefsKey = "AutoChessLevelItemEpisodeUnlock"
slot0.FinishPrefsKey = "AutoChessLevelItemEpisodeFinish"

function slot0.ctor(slot0, slot1)
	slot0._handleView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot1, "#btn_Click")
	slot0._goLock = gohelper.findChild(slot1, "#go_Lock")
	slot0._txtNameL = gohelper.findChildText(slot1, "#go_Lock/#txt_NameL")
	slot0._imageNameL = gohelper.findChildImage(slot1, "#go_Lock/Name/#image_NameL")
	slot0._btnRewardL = gohelper.findChildButtonWithAudio(slot1, "#go_Lock/#btn_RewardL")
	slot0._goUnlock = gohelper.findChild(slot1, "#go_Unlock")
	slot0._txtNameU = gohelper.findChildText(slot1, "#go_Unlock/#txt_NameU")
	slot0._imageNameU = gohelper.findChildImage(slot1, "#go_Unlock/Name/#image_NameU")
	slot0._goHasGet = gohelper.findChild(slot1, "#go_Unlock/#go_HasGet")
	slot0._btnRewardU = gohelper.findChildButtonWithAudio(slot1, "#go_Unlock/#btn_RewardU")
	slot0._goRound = gohelper.findChild(slot1, "#go_Unlock/#go_Round")
	slot0._txtRound = gohelper.findChildText(slot1, "#go_Unlock/#go_Round/#txt_Round")
	slot0._btnGiveUp = gohelper.findChildButtonWithAudio(slot1, "#go_Unlock/#go_Round/#btn_GiveUp")
	slot0._goCurrent = gohelper.findChild(slot1, "#go_Unlock/#go_Current")
	slot0._goNew = gohelper.findChild(slot1, "#go_New")
	slot0._goRewardTips = gohelper.findChild(slot1, "#go_RewardTips")
	slot0._btnCloseReward = gohelper.findChildButtonWithAudio(slot1, "#go_RewardTips/#btn_CloseReward")
	slot0._goRewardDesc = gohelper.findChild(slot1, "#go_RewardTips/#go_RewardDesc")
	slot0._goTipsBg = gohelper.findChild(slot1, "#go_RewardTips/#go_Tipsbg")
	slot0._txtUnlockTips = gohelper.findChildText(slot1, "#go_RewardTips/#go_Tipsbg/#txt_UnlockTips")
	slot0._goSpecialDesc = gohelper.findChild(slot1, "#go_RewardTips/#go_SpecialDesc")
	slot0._goRewardItem = gohelper.findChild(slot1, "#go_RewardTips/#go_RewardItem")
	slot0._btnRewardTips = gohelper.findButtonWithAudio(slot0._goRewardTips)
	slot0.moduleId = AutoChessEnum.ModuleId.PVE
	slot0.anim = slot1:GetComponent(gohelper.Type_Animator)
end

function slot0.addEventListeners(slot0)
	slot0._btnClick:AddClickListener(slot0._btnClickOnClick, slot0)
	slot0._btnRewardU:AddClickListener(slot0._btnRewardOnClick, slot0)
	slot0._btnRewardL:AddClickListener(slot0._btnRewardOnClick, slot0)
	slot0._btnGiveUp:AddClickListener(slot0._btnGiveUpOnClick, slot0)
	slot0._btnCloseReward:AddClickListener(slot0._btnCloseRewardOnClick, slot0)
	slot0:addEventCb(Activity182Controller.instance, Activity182Event.UpdateInfo, slot0.refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnClick:RemoveClickListener()
	slot0._btnRewardU:RemoveClickListener()
	slot0._btnRewardL:RemoveClickListener()
	slot0._btnGiveUp:RemoveClickListener()
	slot0._btnCloseReward:RemoveClickListener()
end

function slot0._btnClickOnClick(slot0)
	slot0._handleView:onClickItem(slot0.co.id)
end

function slot0._btnRewardOnClick(slot0)
	slot0._handleView:onOpenItemReward(slot0.co.id)
end

function slot0._btnGiveUpOnClick(slot0)
	slot0._handleView:onGiveUpGame(slot0.co.id)
end

function slot0._btnCloseRewardOnClick(slot0)
	slot0._handleView:onCloseItemReward(slot0.co.id)
end

function slot0.setData(slot0, slot1)
	slot0.co = slot1

	if slot1 then
		slot0:refreshSpecialUnlockTips()
		slot0:refreshUI()

		for slot6, slot7 in ipairs(GameUtil.splitString2(slot0.co.firstBounds, true)) do
			slot9 = IconMgr.instance:getCommonItemIcon(gohelper.cloneInPlace(slot0._goRewardItem))

			slot9:setMOValue(slot7[1], slot7[2], slot7[3])
			transformhelper.setLocalScale(slot9:getCountBg().transform, 1, 1.7, 1)
			slot9:setCountFontSize(45)
		end

		gohelper.setActive(slot0._goRewardItem, false)
		gohelper.setActive(slot0._btnRewardU, not slot0.isPass)
		gohelper.setActive(slot0._goHasGet, slot0.isPass)
	end
end

function slot0.refreshUI(slot0)
	slot0.actMo = Activity182Model.instance:getActMo()

	slot0:refreshLock()
	slot0:refreshSelect()
	slot0:refreshFinish()
	slot0:refreshBtnSate()

	if slot0.unlock and slot0.isSelect then
		slot0.anim:Play("challenge", 0, 0)
	end
end

function slot0.refreshSelect(slot0)
	slot0.isSelect = slot0.actMo.gameMoDic[slot0.moduleId].episodeId == slot0.co.id

	if slot0.isSelect then
		slot0._txtRound.text = string.format("%d/%d", slot1.currRound, slot0.co.maxRound)
	end

	gohelper.setActive(slot0._goCurrent, slot0.isSelect)
	gohelper.setActive(slot0._goRound, slot0.isSelect)
end

function slot0.refreshLock(slot0)
	slot0.unlock = slot0.actMo:isEpisodeUnlock(slot0.co.id)

	gohelper.setActive(slot0._goLock, not slot0.unlock)
	gohelper.setActive(slot0._goUnlock, slot0.unlock)
	ZProj.UGUIHelper.SetGrayscale(slot0.goArrow, not slot0.unlock)

	if slot0.unlock then
		slot0._txtNameU.text = slot0.co.name

		UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageNameU, slot0.co.image)

		if AutoChessHelper.getPlayerPrefs(uv0.UnlockPrefsKey .. slot0.co.id, 0) == 0 then
			gohelper.setActive(slot0._goLock, true)
			slot0.anim:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
			AutoChessHelper.setPlayerPrefs(slot1, 1)
		end
	else
		slot0._txtNameL.text = slot0.co.name

		UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageNameL, slot0.co.image)
	end
end

function slot0.refreshFinish(slot0)
	slot0.isPass = slot0.actMo:isEpisodePass(slot0.co.id)

	if slot0.isPass then
		gohelper.setActive(slot0._goHasGet, true)

		if AutoChessHelper.getPlayerPrefs(uv0.FinishPrefsKey .. slot0.co.id, 0) == 0 then
			slot0.anim:Play("finish", 0, 0)
			AutoChessHelper.setPlayerPrefs(slot1, 1)
		end
	end
end

function slot0.refreshSpecialUnlockTips(slot0)
	slot2 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderSlot].value)
	slot3 = lua_auto_chess_episode.configDict[AutoChessEnum.PvpEpisodeId].preEpisode

	if slot0.co.id == tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderRefresh].value) then
		slot0._txtUnlockTips.text = luaLang("autochess_levelview_unlocktips3")
	elseif slot0.co.id == slot2 then
		slot0._txtUnlockTips.text = luaLang("autochess_levelview_unlocktips2")
	elseif slot0.co.id == slot3 then
		slot0._txtUnlockTips.text = luaLang("autochess_levelview_unlocktips1")
	else
		gohelper.setActive(slot0._goRewardDesc, true)
		gohelper.setActive(slot0._goTipsBg, false)
		gohelper.setActive(slot0._goSpecialDesc, false)
	end
end

function slot0.refreshBtnSate(slot0)
	gohelper.setActive(slot0._btnGiveUp, GuideModel.instance:isGuideFinish(25406))
end

function slot0.openReward(slot0)
	gohelper.setActive(slot0._goRewardTips, true)
end

function slot0.closeReward(slot0)
	gohelper.setActive(slot0._goRewardTips, false)
end

function slot0.enterLevel(slot0)
	if slot0.unlock then
		AutoChessController.instance:startGame(slot0.moduleId, slot0.co.id)
	else
		GameFacade.showToast(ToastEnum.AutoChessEpisodeLock)
	end
end

return slot0
