module("modules.logic.tower.view.fight.TowerDeepResultView", package.seeall)

local var_0_0 = class("TowerDeepResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagedeepRare = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_deepRare")
	arg_1_0._gobossNormal = gohelper.findChild(arg_1_0.viewGO, "boss/#go_bossNormal")
	arg_1_0._gobossEndless = gohelper.findChild(arg_1_0.viewGO, "boss/#go_bossEndless")
	arg_1_0._goresultView = gohelper.findChild(arg_1_0.viewGO, "#go_resultView")
	arg_1_0._simageplayerHead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_resultView/Left/Player/PlayerHead/#simage_playerHead")
	arg_1_0._txtplayerName = gohelper.findChildText(arg_1_0.viewGO, "#go_resultView/Left/Player/#txt_playerName")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_resultView/Left/Player/#txt_time")
	arg_1_0._txtplayerUid = gohelper.findChildText(arg_1_0.viewGO, "#go_resultView/Left/Player/#txt_playerUid")
	arg_1_0._btncloseResult = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_resultView/#btn_closeResult")
	arg_1_0._scrolllist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_resultView/Right/#scroll_list")
	arg_1_0._goteamContent = gohelper.findChild(arg_1_0.viewGO, "#go_resultView/Right/#scroll_list/Viewport/#go_teamContent")
	arg_1_0._goteamItem = gohelper.findChild(arg_1_0.viewGO, "#go_resultView/Right/#scroll_list/Viewport/#go_teamContent/#go_teamItem")
	arg_1_0._gobossView = gohelper.findChild(arg_1_0.viewGO, "#go_bossView")
	arg_1_0._imagedeepBg = gohelper.findChildImage(arg_1_0.viewGO, "#go_bossView/Score/#image_deepBg")
	arg_1_0._txtdepth = gohelper.findChildText(arg_1_0.viewGO, "#go_bossView/Score/#txt_depth")
	arg_1_0._gonewRecord = gohelper.findChild(arg_1_0.viewGO, "#go_bossView/Score/#txt_depth/#go_newRecord")
	arg_1_0._txtbossDec = gohelper.findChildText(arg_1_0.viewGO, "#go_bossView/#txt_bossDec")
	arg_1_0._btncloseBoss = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bossView/#btn_closeBoss")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseResult:AddClickListener(arg_2_0._btncloseResultOnClick, arg_2_0)
	arg_2_0._btncloseBoss:AddClickListener(arg_2_0._btncloseBossOnClick, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseResult:RemoveClickListener()
	arg_3_0._btncloseBoss:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

var_0_0.showResultViewTime = 1.267
var_0_0.showHeroItemAnimTime = 0.06

function var_0_0._btncloseResultOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseBossOnClick(arg_5_0)
	arg_5_0:onDepthTweenDone(true)
	TaskDispatcher.cancelTask(arg_5_0._btncloseBossOnClick, arg_5_0)

	arg_5_0.animView.enabled = true

	arg_5_0.animView:Play("toresult", 0, 0)
	arg_5_0.animView:Update(0)
	arg_5_0:showAllTeamItem()
	gohelper.setActive(arg_5_0._btncloseBoss.gameObject, false)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.teamItemMap = arg_6_0:getUserDataTb_()

	gohelper.setActive(arg_6_0._goteamItem, false)

	arg_6_0.animView = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.fightResult = TowerPermanentDeepModel.instance:getFightResult()
	arg_8_0.isSucc = arg_8_0.fightResult == TowerDeepEnum.FightResult.Succ
	arg_8_0.isOpenEndless = TowerPermanentDeepModel.instance.isOpenEndless
	arg_8_0.curDeepGroupMo = TowerPermanentDeepModel.instance:getCurDeepGroupMo()
	arg_8_0.curDepth = arg_8_0.curDeepGroupMo.curDeep

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0.deepRare = TowerPermanentDeepModel.instance:getDeepRare(arg_9_0.curDepth)

	arg_9_0._simagedeepRare:LoadImage(ResUrl.getFightImage(string.format("tower/fight_tower_mask_%s.png", arg_9_0.deepRare)))

	arg_9_0.fightParam = FightModel.instance:getFightParam()
	arg_9_0.heroEquipMoList = arg_9_0.fightParam:getHeroEquipAndTrialMoList(true)

	arg_9_0:refreshBossView()
	arg_9_0:refreshResultView()
end

function var_0_0.refreshBossView(arg_10_0)
	gohelper.setActive(arg_10_0._gobossNormal, not arg_10_0.isOpenEndless and not arg_10_0.isSucc)
	gohelper.setActive(arg_10_0._gobossEndless, arg_10_0.isOpenEndless or arg_10_0.isSucc)
	UISpriteSetMgr.instance:setFightTowerSprite(arg_10_0._imagedeepBg, "fight_tower_numbg_" .. arg_10_0.deepRare)

	arg_10_0._txtbossDec.text = TowerDeepConfig.instance:getConstConfigLangValue(arg_10_0.isSucc and TowerDeepEnum.ConstId.ResultBossDescSucc or TowerDeepEnum.ConstId.ResultBossDescFail)

	gohelper.setActive(arg_10_0._gonewRecord, TowerPermanentDeepModel.instance.isNewRecord)

	local var_10_0 = AchievementToastModel.instance:getWaitNamePlateToastList()

	if not var_10_0 or #var_10_0 == 0 then
		arg_10_0:startShowDepth()
	end
end

function var_0_0.startShowDepth(arg_11_0)
	local var_11_0 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)

	arg_11_0.depthTweenId = ZProj.TweenHelper.DOTweenFloat(var_11_0, arg_11_0.curDepth, 1.5, arg_11_0.onDepthFrameCallback, arg_11_0.onDepthTweenDone, arg_11_0, nil, EaseType.Linear)
end

function var_0_0.onDepthFrameCallback(arg_12_0, arg_12_1)
	arg_12_0._txtdepth.text = string.format("%dM", arg_12_1)
end

function var_0_0.onDepthTweenDone(arg_13_0, arg_13_1)
	arg_13_0._txtdepth.text = string.format("%dM", arg_13_0.curDepth)

	if arg_13_0.depthTweenId then
		ZProj.TweenHelper.KillById(arg_13_0.depthTweenId)

		arg_13_0.depthTweenId = nil
	end

	if not arg_13_1 then
		TaskDispatcher.runDelay(arg_13_0._btncloseBossOnClick, arg_13_0, var_0_0.showResultViewTime)
	end
end

function var_0_0.refreshResultView(arg_14_0)
	arg_14_0:refreshPlayerInfo()
	arg_14_0:createTeamsItem()
end

function var_0_0.refreshPlayerInfo(arg_15_0)
	local var_15_0 = PlayerModel.instance:getPlayinfo()

	arg_15_0._txtplayerUid.text = string.format("UID:%s", var_15_0.userId)
	arg_15_0._txtplayerName.text = var_15_0.name

	if not arg_15_0._liveHeadIcon then
		arg_15_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_15_0._simageplayerHead)
	end

	arg_15_0._liveHeadIcon:setLiveHead(var_15_0.portrait)

	arg_15_0._txttime.text = os.date("%Y.%m.%d %H:%M:%S", arg_15_0.curDeepGroupMo.createTime)
end

function var_0_0.createTeamsItem(arg_16_0)
	local var_16_0 = arg_16_0.curDeepGroupMo:getTeamDataList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = arg_16_0.teamItemMap[iter_16_0]

		if not var_16_1 then
			var_16_1 = {
				go = gohelper.clone(arg_16_0._goteamItem, arg_16_0._goteamContent, "teamItem" .. iter_16_0)
			}
			var_16_1.teamComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_1.go, TowerDeepResultTeamItem)
			arg_16_0.teamItemMap[iter_16_0] = var_16_1
		end

		var_16_1.teamComp:refreshUI(iter_16_0, var_16_0)
	end
end

function var_0_0.showAllTeamItem(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.teamItemMap) do
		iter_17_1.teamComp:showTeamItem(iter_17_0 * var_0_0.showHeroItemAnimTime)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mingdi_boss_clearing)

	arg_17_0._scrolllist.verticalNormalizedPosition = 1
	arg_17_0.scrollTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, arg_17_0.setScrollPos, arg_17_0.setScrollPosDone, arg_17_0)
end

function var_0_0.setScrollPos(arg_18_0, arg_18_1)
	arg_18_0._scrolllist.verticalNormalizedPosition = arg_18_1
end

function var_0_0.setScrollPosDone(arg_19_0)
	arg_19_0._scrolllist.verticalNormalizedPosition = 0
end

function var_0_0._onCloseViewFinish(arg_20_0, arg_20_1)
	if arg_20_1 == ViewName.AchievementNamePlateUnlockView then
		arg_20_0:startShowDepth()
	end
end

function var_0_0.onClose(arg_21_0)
	FightController.onResultViewClose()
	TaskDispatcher.cancelTask(arg_21_0._btncloseBossOnClick, arg_21_0)

	if arg_21_0.depthTweenId then
		ZProj.TweenHelper.KillById(arg_21_0.depthTweenId)

		arg_21_0.depthTweenId = nil
	end

	if arg_21_0.scrollTweenId then
		ZProj.TweenHelper.KillById(arg_21_0.scrollTweenId)

		arg_21_0.scrollTweenId = nil
	end
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0._simageplayerHead:UnLoadImage()
end

return var_0_0
