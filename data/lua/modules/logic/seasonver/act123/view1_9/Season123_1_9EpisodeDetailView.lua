module("modules.logic.seasonver.act123.view1_9.Season123_1_9EpisodeDetailView", package.seeall)

local var_0_0 = class("Season123_1_9EpisodeDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._simagestageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/left/#simage_stageicon")
	arg_1_0._animatorRight = gohelper.findChildComponent(arg_1_0.viewGO, "#go_info/right", typeof(UnityEngine.Animator))
	arg_1_0._txtlevelnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn")
	arg_1_0._descScroll = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/Scroll View")
	arg_1_0._animScroll = arg_1_0._descScroll:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._descContent = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/Scroll View/Viewport/Content")
	arg_1_0._goDescItem = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem")
	arg_1_0._txtcurindex = gohelper.findChildText(arg_1_0.viewGO, "#go_info/right/position/center/#txt_curindex")
	arg_1_0._txtmaxindex = gohelper.findChildText(arg_1_0.viewGO, "#go_info/right/position/center/#txt_maxindex")
	arg_1_0._btnlast = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/right/position/#btn_last")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/right/position/#btn_next")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_info/right/#txt_desc")
	arg_1_0._txtenemylv = gohelper.findChildText(arg_1_0.viewGO, "#go_info/right/enemylv/enemylv/#txt_enemylv")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/right/btns/#btn_start")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/right/btns/#btn_reset")
	arg_1_0._btnReplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/right/btns/#btn_storyreplay")
	arg_1_0._gopart = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_part")
	arg_1_0._gostage = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_part/#go_stage")
	arg_1_0._gostagelvlitem = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_part/#go_stage/list/#go_stagelvlitem")
	arg_1_0._gounlocktype1 = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype1")
	arg_1_0._gounlocktype2 = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype2")
	arg_1_0._gounlocktype3 = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype3")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._godecorate = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/decorate")
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/position/center")
	arg_1_0._gopartempty = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_partempty")
	arg_1_0._simageempty = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/right/layout/#go_partempty/#simage_empty")
	arg_1_0._goleftscrolltopmask = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/Scroll View/mask2")
	arg_1_0._goreset = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_reset")
	arg_1_0._txtresettime = gohelper.findChildText(arg_1_0.viewGO, "#go_info/right/layout/#go_reset/#txt_title/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlast:AddClickListener(arg_2_0._btnlastOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlast:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gostagelvlitem, false)

	arg_4_0._txtseasondesc = gohelper.findChildText(arg_4_0.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem/txt_desc")
end

function var_0_0.onDestroyView(arg_5_0)
	Season123EpisodeDetailController.instance:onCloseView()
	arg_5_0._simagestageicon:UnLoadImage()

	if arg_5_0._showLvItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._showLvItems) do
			iter_5_1:destroy()
		end

		arg_5_0._showLvItems = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.DetailSwitchLayer, arg_6_0.handleDetailSwitchLayer, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.RefreshDetailView, arg_6_0.refreshShowInfo, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.ResetStageFinished, arg_6_0.closeThis, arg_6_0)
	Season123EpisodeDetailController.instance:onOpenView(arg_6_0.viewParam.actId, arg_6_0.viewParam.stage, arg_6_0.viewParam.layer)

	local var_6_0 = ActivityModel.instance:getActMO(arg_6_0.viewParam.actId)

	if not var_6_0 or not var_6_0:isOpen() or var_6_0:isExpired() then
		return
	end

	local var_6_1 = Season123EpisodeDetailModel.instance.layer

	arg_6_0:resetData()
	arg_6_0:noAudioShowInfoByOpen()
	arg_6_0._simageempty:LoadImage(Season123Controller.getSeasonIcon("kongzhuangtai.png", arg_6_0.viewParam.actId))
end

function var_0_0.onOpenFinish(arg_7_0)
	local var_7_0 = Season123Controller.instance:getEpisodeLoadingViewName()

	ViewMgr.instance:closeView(var_7_0, true)
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayShowInfo, arg_8_0)
end

function var_0_0.handleDetailSwitchLayer(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.isNext

	arg_9_0._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	arg_9_0._animScroll:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.cancelTask(arg_9_0._delayShowInfo, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0._delayShowInfo, arg_9_0, 0.2)
end

function var_0_0._delayShowInfo(arg_10_0)
	arg_10_0:_showInfo()
end

function var_0_0.refreshShowInfo(arg_11_0)
	arg_11_0:_showInfo()
end

function var_0_0._btnstartOnClick(arg_12_0)
	local var_12_0 = Season123EpisodeDetailModel.instance.activityId
	local var_12_1 = Season123EpisodeDetailModel.instance.stage
	local var_12_2 = Season123EpisodeDetailModel.instance.layer
	local var_12_3 = Season123Config.instance:getSeasonEpisodeCo(var_12_0, var_12_1, var_12_2).episodeId

	Season123EpisodeDetailController.instance:checkEnterFightScene()
end

function var_0_0.resetData(arg_13_0)
	arg_13_0._showLvItems = {}
	arg_13_0._showStageItems = {}
	arg_13_0._infoStageItems = {}
	arg_13_0._equipReward = {}
	arg_13_0._rewardItems = {}
	arg_13_0._partStageItems = {}
end

function var_0_0.noAudioShowInfoByOpen(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(arg_14_0._goinfo, true)
	arg_14_0:_showInfo()
end

function var_0_0._showInfo(arg_15_0)
	arg_15_0:_setInfo()
	arg_15_0:_setParts()
	arg_15_0:_setButton()
	arg_15_0:_setResetInfo()
end

function var_0_0._setButton(arg_16_0)
	local var_16_0 = Season123EpisodeDetailController.instance:isStageNeedClean() or Season123EpisodeDetailController.instance:isNextLayersNeedClean()

	gohelper.setActive(arg_16_0._btnreset, var_16_0)
	gohelper.setActive(arg_16_0._btnstart, not var_16_0)
end

function var_0_0._setResetInfo(arg_17_0)
	local var_17_0 = Season123EpisodeDetailController.instance:isStageNeedClean() or Season123EpisodeDetailController.instance:isNextLayersNeedClean()

	gohelper.setActive(arg_17_0._goreset, var_17_0)
	gohelper.setActive(arg_17_0._txtresettime, var_17_0)

	if var_17_0 then
		local var_17_1 = Season123EpisodeDetailModel.instance:getCurFinishRound()

		if var_17_1 and var_17_1 > 0 then
			local var_17_2 = Season123EpisodeDetailModel.instance.activityId
			local var_17_3 = Season123EpisodeDetailModel.instance.stage
			local var_17_4 = Season123EpisodeDetailModel.instance.layer
			local var_17_5 = Season123Controller.instance:isReduceRound(var_17_2, var_17_3, var_17_4) and "<color=#eecd8c>%s</color>" or "%s"

			arg_17_0._txtresettime.text = string.format(var_17_5, tostring(var_17_1))
		else
			arg_17_0._txtresettime.text = "--"
		end
	end
end

var_0_0.NomalStageTagPos = Vector2(46.3, 2.7)
var_0_0.NewStageTagPos = Vector2(4.37, 2.7)

function var_0_0._setInfo(arg_18_0)
	local var_18_0 = Season123EpisodeDetailModel.instance.activityId
	local var_18_1 = Season123EpisodeDetailModel.instance.stage
	local var_18_2 = Season123EpisodeDetailModel.instance.layer
	local var_18_3 = Season123Config.instance:getSeasonEpisodeCo(var_18_0, var_18_1, var_18_2)

	if not var_18_3 then
		return
	end

	local var_18_4 = Season123Model.instance:isEpisodeAfterStory(var_18_0, var_18_1, var_18_2)

	gohelper.setActive(arg_18_0._btnReplay, var_18_4 and var_18_3.afterStoryId and var_18_3.afterStoryId ~= 0 or false)

	arg_18_0._txtlevelnamecn.text = var_18_3.layerName
	arg_18_0._txtseasondesc.text = var_18_3.desc
	arg_18_0._txtdesc.text = DungeonConfig.instance:getEpisodeCO(var_18_3.episodeId).desc
	arg_18_0._txtcurindex.text = string.format("%02d", var_18_2)

	local var_18_5 = Season123ProgressUtils.getMaxLayer(var_18_0, var_18_1)

	arg_18_0._txtmaxindex.text = string.format("%02d", var_18_5)

	local var_18_6 = Season123EpisodeDetailModel.instance:isNextLayerNewStarGroup(var_18_2)

	gohelper.setActive(arg_18_0._godecorate, var_18_6)

	local var_18_7 = var_18_6 and var_0_0.NewStageTagPos or var_0_0.NomalStageTagPos

	recthelper.setAnchor(arg_18_0._gocenter.transform, var_18_7.x, var_18_7.y)

	local var_18_8 = Season123Model.instance:getSingleBgFolder()
	local var_18_9 = ResUrl.getSeason123LayerDetailBg(var_18_8, var_18_3.layerPicture)

	if not string.nilorempty(var_18_9) then
		arg_18_0._simagestageicon:LoadImage(var_18_9)
	end

	gohelper.setActive(arg_18_0._gorewarditem, false)

	local var_18_10 = DungeonModel.instance:getEpisodeFirstBonus(var_18_3.episodeId)

	for iter_18_0 = 2, math.max(#arg_18_0._rewardItems - 1, #var_18_10) + 1 do
		local var_18_11 = arg_18_0._rewardItems[iter_18_0] or arg_18_0:createRewardItem(iter_18_0)

		arg_18_0:refreshRewardItem(var_18_11, var_18_10[iter_18_0 - 1])
	end

	arg_18_0:refreshEquipCardItem()

	arg_18_0._btnlast.button.interactable = var_18_2 > 1
	arg_18_0._btnnext.button.interactable = var_18_2 < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer()
end

function var_0_0.refreshEquipCardItem(arg_19_0)
	if not arg_19_0._rewardItems[1] then
		arg_19_0._rewardItems[1] = arg_19_0:createRewardItem(1)
	end

	local var_19_0 = Season123EpisodeDetailModel.instance.activityId
	local var_19_1 = Season123EpisodeDetailModel.instance.stage
	local var_19_2 = Season123EpisodeDetailModel.instance.layer
	local var_19_3 = Season123Config.instance:getSeasonEpisodeCo(var_19_0, var_19_1, var_19_2)

	gohelper.setActive(arg_19_0._rewardItems[1].go, var_19_3.firstPassEquipId and var_19_3.firstPassEquipId > 0)

	if var_19_3.firstPassEquipId and var_19_3.firstPassEquipId > 0 then
		local var_19_4 = var_19_2 < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer() or Season123EpisodeDetailModel.instance:alreadyPassEpisode(var_19_2)

		if not arg_19_0._rewardItems[1].itemIcon then
			arg_19_0._rewardItems[1].itemIcon = Season123_1_9CelebrityCardItem.New()

			arg_19_0._rewardItems[1].itemIcon:setColorDark(var_19_4)
			arg_19_0._rewardItems[1].itemIcon:init(arg_19_0._rewardItems[1].cardParent, var_19_3.firstPassEquipId)
		else
			arg_19_0._rewardItems[1].itemIcon:setColorDark(var_19_4)
			arg_19_0._rewardItems[1].itemIcon:reset(var_19_3.firstPassEquipId)
		end

		gohelper.setActive(arg_19_0._rewardItems[1].cardParent, true)
		gohelper.setActive(arg_19_0._rewardItems[1].itemParent, false)
		gohelper.setActive(arg_19_0._rewardItems[1].receive, var_19_4)
	end
end

function var_0_0.createRewardItem(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getUserDataTb_()
	local var_20_1 = gohelper.cloneInPlace(arg_20_0._gorewarditem, "reward_" .. tostring(arg_20_1))

	var_20_0.go = var_20_1
	var_20_0.itemParent = gohelper.findChild(var_20_1, "go_prop")
	var_20_0.cardParent = gohelper.findChild(var_20_1, "go_card")
	var_20_0.receive = gohelper.findChild(var_20_1, "go_receive")
	arg_20_0._rewardItems[arg_20_1] = var_20_0

	return var_20_0
end

function var_0_0.refreshRewardItem(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_2 or not next(arg_21_2) then
		gohelper.setActive(arg_21_1.go, false)

		return
	end

	if not arg_21_1.itemIcon then
		arg_21_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_21_1.itemParent)
	end

	gohelper.setActive(arg_21_1.cardParent, false)
	gohelper.setActive(arg_21_1.itemParent, true)
	arg_21_1.itemIcon:setMOValue(tonumber(arg_21_2[1]), tonumber(arg_21_2[2]), tonumber(arg_21_2[3]), nil, true)
	arg_21_1.itemIcon:isShowCount(tonumber(arg_21_2[1]) ~= MaterialEnum.MaterialType.Hero)
	arg_21_1.itemIcon:setCountFontSize(40)
	arg_21_1.itemIcon:showStackableNum2()
	arg_21_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_21_1.itemIcon:hideEquipLvAndBreak(true)
	gohelper.setActive(arg_21_1.go, true)

	local var_21_0 = Season123EpisodeDetailModel.instance.layer
	local var_21_1 = var_21_0 < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer() or Season123EpisodeDetailModel.instance:alreadyPassEpisode(var_21_0)

	gohelper.setActive(arg_21_1.receive, var_21_1)

	local var_21_2 = var_21_1 and "#7b7b7b" or "#ffffff"

	arg_21_1.itemIcon:setItemColor(var_21_2)
end

function var_0_0._setParts(arg_22_0)
	local var_22_0 = Season123EpisodeDetailModel.instance.activityId
	local var_22_1 = Season123EpisodeDetailModel.instance.stage
	local var_22_2 = Season123EpisodeDetailModel.instance.layer
	local var_22_3 = Season123Config.instance:getSeasonEpisodeCo(var_22_0, var_22_1, var_22_2)

	arg_22_0._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(var_22_3.level)

	if var_22_2 < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer() or var_22_2 > Season123ProgressUtils.getMaxLayer(var_22_0, var_22_1) then
		gohelper.setActive(arg_22_0._gopart, false)
		gohelper.setActive(arg_22_0._gopartempty, true)
		gohelper.setActive(arg_22_0._gounlocktype1, false)
		gohelper.setActive(arg_22_0._gounlocktype2, false)
		gohelper.setActive(arg_22_0._gounlocktype3, false)
	else
		local var_22_4 = Season123EpisodeDetailModel.instance:isNextLayerNewStarGroup(var_22_2)

		gohelper.setActive(arg_22_0._gostage, var_22_4)

		if var_22_4 then
			local var_22_5 = Season123EpisodeDetailModel.instance:getCurStarGroup(var_22_0, var_22_2)

			arg_22_0:_showPartStarGroupItem(var_22_5 + 1)
		end

		local var_22_6 = string.splitToNumber(var_22_3.unlockEquipIndex, "#")

		if #var_22_6 > 0 then
			local var_22_7 = var_22_6[1]

			gohelper.setActive(arg_22_0._gounlocktype1, Season123HeroGroupUtils.getUnlockIndexSlot(var_22_7) == 1)
			gohelper.setActive(arg_22_0._gounlocktype2, Season123HeroGroupUtils.getUnlockIndexSlot(var_22_7) == 2)
			gohelper.setActive(arg_22_0._gounlocktype3, Season123HeroGroupUtils.getUnlockIndexSlot(var_22_7) == 3)
		else
			gohelper.setActive(arg_22_0._gounlocktype1, false)
			gohelper.setActive(arg_22_0._gounlocktype2, false)
			gohelper.setActive(arg_22_0._gounlocktype3, false)
		end

		gohelper.setActive(arg_22_0._gopart, var_22_4 or #var_22_6 > 0)
		gohelper.setActive(arg_22_0._gopartempty, not var_22_4 and not (#var_22_6 > 0))
	end
end

var_0_0.UnLockStageItemAlpha = 1
var_0_0.LockStageItemAlpha = 0.3

function var_0_0._showPartStarGroupItem(arg_23_0, arg_23_1)
	if arg_23_1 < 7 then
		if arg_23_0._partStageItems[7] then
			gohelper.setActive(arg_23_0._partStageItems[7].go, false)
		end

		for iter_23_0 = 1, 6 do
			if not arg_23_0._partStageItems[iter_23_0] then
				local var_23_0 = arg_23_0:getUserDataTb_()
				local var_23_1 = gohelper.cloneInPlace(arg_23_0._gostagelvlitem, "partstageitem_" .. tostring(iter_23_0))

				var_23_0.go = var_23_1
				var_23_0.current = gohelper.findChild(var_23_1, "current")
				var_23_0.next = gohelper.findChild(var_23_1, "next")
				var_23_0.canvasgroup = gohelper.onceAddComponent(var_23_1, typeof(UnityEngine.CanvasGroup))
				arg_23_0._partStageItems[iter_23_0] = var_23_0
			end

			gohelper.setActive(arg_23_0._partStageItems[iter_23_0].go, true)
			gohelper.setActive(arg_23_0._partStageItems[iter_23_0].next, iter_23_0 == arg_23_1)
			gohelper.setActive(arg_23_0._partStageItems[iter_23_0].current, iter_23_0 ~= arg_23_1)

			arg_23_0._partStageItems[iter_23_0].canvasgroup.alpha = iter_23_0 <= arg_23_1 and var_0_0.UnLockStageItemAlpha or var_0_0.LockStageItemAlpha
		end
	else
		for iter_23_1 = 1, 7 do
			if not arg_23_0._partStageItems[iter_23_1] then
				local var_23_2 = arg_23_0:getUserDataTb_()
				local var_23_3 = gohelper.cloneInPlace(arg_23_0._gostagelvlitem, "partstageitem_" .. tostring(iter_23_1))

				var_23_2.go = var_23_3
				var_23_2.current = gohelper.findChild(var_23_3, "current")
				var_23_2.next = gohelper.findChild(var_23_3, "next")
				var_23_2.canvasgroup = gohelper.onceAddComponent(var_23_3, typeof(UnityEngine.CanvasGroup))
				arg_23_0._partStageItems[iter_23_1] = var_23_2
			end

			gohelper.setActive(arg_23_0._partStageItems[iter_23_1].go, true)
			gohelper.setActive(arg_23_0._partStageItems[iter_23_1].next, iter_23_1 == arg_23_1)
			gohelper.setActive(arg_23_0._partStageItems[iter_23_1].current, iter_23_1 ~= arg_23_1)

			arg_23_0._partStageItems[iter_23_1].canvasgroup.alpha = iter_23_1 <= arg_23_1 and var_0_0.UnLockStageItemAlpha or var_0_0.LockStageItemAlpha
		end
	end
end

function var_0_0._btnlastOnClick(arg_24_0)
	if Season123EpisodeDetailController.instance:canSwitchLayer(false) then
		Season123EpisodeDetailController.instance:switchLayer(false)
	end
end

function var_0_0._btnnextOnClick(arg_25_0)
	if Season123EpisodeDetailController.instance:canSwitchLayer(true) then
		Season123EpisodeDetailController.instance:switchLayer(true)
	end
end

function var_0_0._btnresetOnClick(arg_26_0)
	Season123Controller.instance:openResetView({
		actId = Season123EpisodeDetailModel.instance.activityId,
		stage = Season123EpisodeDetailModel.instance.stage,
		layer = Season123EpisodeDetailModel.instance.layer
	})
end

return var_0_0
