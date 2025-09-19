module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessLevelItem", package.seeall)

local var_0_0 = class("AutoChessLevelItem", LuaCompBase)

var_0_0.UnlockPrefsKey = "AutoChessLevelItemEpisodeUnlock"
var_0_0.FinishPrefsKey = "AutoChessLevelItemEpisodeFinish"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._handleView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._btnClick = gohelper.findChildButtonWithAudio(arg_2_1, "#btn_Click")
	arg_2_0._goLock = gohelper.findChild(arg_2_1, "#go_Lock")
	arg_2_0._txtNameL = gohelper.findChildText(arg_2_1, "#go_Lock/#txt_NameL")
	arg_2_0._imageNameL = gohelper.findChildImage(arg_2_1, "#go_Lock/Name/#image_NameL")
	arg_2_0._btnRewardL = gohelper.findChildButtonWithAudio(arg_2_1, "#go_Lock/#btn_RewardL")
	arg_2_0._goUnlock = gohelper.findChild(arg_2_1, "#go_Unlock")
	arg_2_0._txtNameU = gohelper.findChildText(arg_2_1, "#go_Unlock/#txt_NameU")
	arg_2_0._imageNameU = gohelper.findChildImage(arg_2_1, "#go_Unlock/Name/#image_NameU")
	arg_2_0._goHasGet = gohelper.findChild(arg_2_1, "#go_Unlock/#go_HasGet")
	arg_2_0._btnRewardU = gohelper.findChildButtonWithAudio(arg_2_1, "#go_Unlock/#btn_RewardU")
	arg_2_0._goRound = gohelper.findChild(arg_2_1, "#go_Unlock/#go_Round")
	arg_2_0._txtRound = gohelper.findChildText(arg_2_1, "#go_Unlock/#go_Round/#txt_Round")
	arg_2_0._btnGiveUp = gohelper.findChildButtonWithAudio(arg_2_1, "#go_Unlock/#go_Round/#btn_GiveUp")
	arg_2_0._goCurrent = gohelper.findChild(arg_2_1, "#go_Unlock/#go_Current")
	arg_2_0._goNew = gohelper.findChild(arg_2_1, "#go_New")
	arg_2_0._goRewardTips = gohelper.findChild(arg_2_1, "#go_RewardTips")
	arg_2_0._btnCloseReward = gohelper.findChildButtonWithAudio(arg_2_1, "#go_RewardTips/#btn_CloseReward")
	arg_2_0._goRewardDesc = gohelper.findChild(arg_2_1, "#go_RewardTips/#go_RewardDesc")
	arg_2_0._goTipsBg = gohelper.findChild(arg_2_1, "#go_RewardTips/#go_Tipsbg")
	arg_2_0._txtUnlockTips = gohelper.findChildText(arg_2_1, "#go_RewardTips/#go_Tipsbg/#txt_UnlockTips")
	arg_2_0._goSpecialDesc = gohelper.findChild(arg_2_1, "#go_RewardTips/#go_SpecialDesc")
	arg_2_0._goRewardItem = gohelper.findChild(arg_2_1, "#go_RewardTips/#go_RewardItem")
	arg_2_0._btnRewardTips = gohelper.findButtonWithAudio(arg_2_0._goRewardTips)
	arg_2_0.moduleId = AutoChessEnum.ModuleId.PVE
	arg_2_0.anim = arg_2_1:GetComponent(gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnClick:AddClickListener(arg_3_0._btnClickOnClick, arg_3_0)
	arg_3_0._btnRewardU:AddClickListener(arg_3_0._btnRewardOnClick, arg_3_0)
	arg_3_0._btnRewardL:AddClickListener(arg_3_0._btnRewardOnClick, arg_3_0)
	arg_3_0._btnGiveUp:AddClickListener(arg_3_0._btnGiveUpOnClick, arg_3_0)
	arg_3_0._btnCloseReward:AddClickListener(arg_3_0._btnCloseRewardOnClick, arg_3_0)
	arg_3_0:addEventCb(Activity182Controller.instance, Activity182Event.UpdateInfo, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnClick:RemoveClickListener()
	arg_4_0._btnRewardU:RemoveClickListener()
	arg_4_0._btnRewardL:RemoveClickListener()
	arg_4_0._btnGiveUp:RemoveClickListener()
	arg_4_0._btnCloseReward:RemoveClickListener()
end

function var_0_0._btnClickOnClick(arg_5_0)
	arg_5_0._handleView:onClickItem(arg_5_0.co.id)
end

function var_0_0._btnRewardOnClick(arg_6_0)
	arg_6_0._handleView:onOpenItemReward(arg_6_0.co.id)
end

function var_0_0._btnGiveUpOnClick(arg_7_0)
	arg_7_0._handleView:onGiveUpGame(arg_7_0.co.id)
end

function var_0_0._btnCloseRewardOnClick(arg_8_0)
	arg_8_0._handleView:onCloseItemReward(arg_8_0.co.id)
end

function var_0_0.setData(arg_9_0, arg_9_1)
	arg_9_0.actId = Activity182Model.instance:getCurActId()
	arg_9_0.co = arg_9_1

	if arg_9_1 then
		arg_9_0:refreshSpecialUnlockTips()
		arg_9_0:refreshUI()

		local var_9_0 = GameUtil.splitString2(arg_9_0.co.firstBounds, true)

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_1 = gohelper.cloneInPlace(arg_9_0._goRewardItem)
			local var_9_2 = IconMgr.instance:getCommonItemIcon(var_9_1)

			var_9_2:setMOValue(iter_9_1[1], iter_9_1[2], iter_9_1[3])

			local var_9_3 = var_9_2:getCountBg()

			transformhelper.setLocalScale(var_9_3.transform, 1, 1.7, 1)
			var_9_2:setCountFontSize(45)
		end

		gohelper.setActive(arg_9_0._goRewardItem, false)
		gohelper.setActive(arg_9_0._btnRewardU, not arg_9_0.isPass)
		gohelper.setActive(arg_9_0._goHasGet, arg_9_0.isPass)
	end
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0.actMo = Activity182Model.instance:getActMo()

	arg_10_0:refreshLock()
	arg_10_0:refreshSelect()
	arg_10_0:refreshFinish()
	arg_10_0:refreshBtnSate()

	if arg_10_0.unlock and arg_10_0.isSelect then
		arg_10_0.anim:Play("challenge", 0, 0)
	end
end

function var_0_0.refreshSelect(arg_11_0)
	local var_11_0 = arg_11_0.actMo:getGameMo(arg_11_0.actId, arg_11_0.moduleId)

	arg_11_0.isSelect = var_11_0.episodeId == arg_11_0.co.id

	if arg_11_0.isSelect then
		arg_11_0._txtRound.text = string.format("%d/%d", var_11_0.currRound, arg_11_0.co.maxRound)
	end

	gohelper.setActive(arg_11_0._goCurrent, arg_11_0.isSelect)
	gohelper.setActive(arg_11_0._goRound, arg_11_0.isSelect)
end

function var_0_0.refreshLock(arg_12_0)
	arg_12_0.unlock = arg_12_0.actMo:isEpisodeUnlock(arg_12_0.co.id)

	gohelper.setActive(arg_12_0._goLock, not arg_12_0.unlock)
	gohelper.setActive(arg_12_0._goUnlock, arg_12_0.unlock)
	ZProj.UGUIHelper.SetGrayscale(arg_12_0.goArrow, not arg_12_0.unlock)

	if arg_12_0.unlock then
		arg_12_0._txtNameU.text = arg_12_0.co.name

		UISpriteSetMgr.instance:setAutoChessSprite(arg_12_0._imageNameU, arg_12_0.co.image)

		local var_12_0 = var_0_0.UnlockPrefsKey .. arg_12_0.co.id

		if AutoChessHelper.getPlayerPrefs(var_12_0, 0) == 0 then
			gohelper.setActive(arg_12_0._goLock, true)
			arg_12_0.anim:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
			AutoChessHelper.setPlayerPrefs(var_12_0, 1)
		end
	else
		arg_12_0._txtNameL.text = arg_12_0.co.name

		UISpriteSetMgr.instance:setAutoChessSprite(arg_12_0._imageNameL, arg_12_0.co.image)
	end
end

function var_0_0.refreshFinish(arg_13_0)
	arg_13_0.isPass = arg_13_0.actMo:isEpisodePass(arg_13_0.co.id)

	if arg_13_0.isPass then
		gohelper.setActive(arg_13_0._goHasGet, true)

		local var_13_0 = var_0_0.FinishPrefsKey .. arg_13_0.co.id

		if AutoChessHelper.getPlayerPrefs(var_13_0, 0) == 0 then
			arg_13_0.anim:Play("finish", 0, 0)
			AutoChessHelper.setPlayerPrefs(var_13_0, 1)
		end
	end
end

function var_0_0.refreshSpecialUnlockTips(arg_14_0)
	local var_14_0 = AutoChessConfig.instance:getPvpEpisodeCo(arg_14_0.actId)
	local var_14_1 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderRefresh].value)
	local var_14_2 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderSlot].value)
	local var_14_3 = var_14_0.preEpisode

	if arg_14_0.co.id == var_14_1 then
		arg_14_0._txtUnlockTips.text = luaLang("autochess_levelview_unlocktips3")
	elseif arg_14_0.co.id == var_14_2 then
		arg_14_0._txtUnlockTips.text = luaLang("autochess_levelview_unlocktips2")
	elseif arg_14_0.co.id == var_14_3 then
		arg_14_0._txtUnlockTips.text = luaLang("autochess_levelview_unlocktips1")
	else
		gohelper.setActive(arg_14_0._goRewardDesc, true)
		gohelper.setActive(arg_14_0._goTipsBg, false)
		gohelper.setActive(arg_14_0._goSpecialDesc, false)
	end
end

function var_0_0.refreshBtnSate(arg_15_0)
	gohelper.setActive(arg_15_0._btnGiveUp, GuideModel.instance:isGuideFinish(25406))
end

function var_0_0.openReward(arg_16_0)
	gohelper.setActive(arg_16_0._goRewardTips, true)
end

function var_0_0.closeReward(arg_17_0)
	gohelper.setActive(arg_17_0._goRewardTips, false)
end

function var_0_0.enterLevel(arg_18_0)
	if arg_18_0.unlock then
		AutoChessController.instance:startGame(arg_18_0.actId, arg_18_0.moduleId, arg_18_0.co)
	else
		GameFacade.showToast(ToastEnum.AutoChessEpisodeLock)
	end
end

return var_0_0
