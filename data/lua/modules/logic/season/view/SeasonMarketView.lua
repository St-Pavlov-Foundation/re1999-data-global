module("modules.logic.season.view.SeasonMarketView", package.seeall)

local var_0_0 = class("SeasonMarketView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/bg/#simage_bg1")
	arg_1_0._simagedecorate1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/right/#simage_decorate1")
	arg_1_0._simagedecorate2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/right/#simage_decorate2")
	arg_1_0._simageuttu = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/bottom/#simage_uttu")
	arg_1_0._animatorLeft = gohelper.findChildComponent(arg_1_0.viewGO, "#go_info/left", typeof(UnityEngine.Animator))
	arg_1_0._txtlevelnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn")
	arg_1_0._gostageinfoitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem1")
	arg_1_0._gostageinfoitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem2")
	arg_1_0._gostageinfoitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem3")
	arg_1_0._gostageinfoitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem4")
	arg_1_0._gostageinfoitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem5")
	arg_1_0._gostageinfoitem6 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem6")
	arg_1_0._gostageinfoitem7 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem7")
	arg_1_0._txtcurindex = gohelper.findChildText(arg_1_0.viewGO, "#go_info/left/position/center/#txt_curindex")
	arg_1_0._txtmaxindex = gohelper.findChildText(arg_1_0.viewGO, "#go_info/left/position/center/#txt_maxindex")
	arg_1_0._btnlast = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/left/position/#btn_last")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/left/position/#btn_next")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_info/left/#txt_desc")
	arg_1_0._txtenemylv = gohelper.findChildText(arg_1_0.viewGO, "#go_info/left/enemylv/#txt_enemylv")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/left/btns/#btn_start")
	arg_1_0._btnReplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/left/btns/#btn_storyreplay")
	arg_1_0._gopart = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/layout/#go_part")
	arg_1_0._gostage = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/layout/#go_part/#go_stage")
	arg_1_0._gostagelvlitem = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/layout/#go_part/#go_stage/list/#go_stagelvlitem")
	arg_1_0._gounlocktype1 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype1")
	arg_1_0._gounlocktype2 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype2")
	arg_1_0._gounlocktype3 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype3")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._godecorate = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/decorate")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "#go_level")
	arg_1_0._anilevel = arg_1_0._golevel:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simagelvbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#simage_lvbg")
	arg_1_0._simageleftinfobg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#simage_leftinfobg")
	arg_1_0._simagerightinfobg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#simage_rightinfobg")
	arg_1_0._goScrollRoot = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot")
	arg_1_0._goscrolllv = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv")
	arg_1_0._gofront = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_front")
	arg_1_0._golvitem = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_line")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selected")
	arg_1_0._txtselectindex = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selected/#txt_selectindex")
	arg_1_0._gopass = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass")
	arg_1_0._txtpassindex = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass/#txt_passindex")
	arg_1_0._gounpass = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass")
	arg_1_0._txtunpassindex = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass/#txt_unpassindex")
	arg_1_0._gorear = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_rear")
	arg_1_0._txtcurlevelnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn")
	arg_1_0._gostagelvitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem1")
	arg_1_0._gostagelvitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem2")
	arg_1_0._gostagelvitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem3")
	arg_1_0._gostagelvitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem4")
	arg_1_0._gostagelvitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem5")
	arg_1_0._gostagelvitem6 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem6")
	arg_1_0._gostagelvitem7 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem7")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlast:AddClickListener(arg_2_0._btnlastOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnReplay:AddClickListener(arg_2_0._btnreplayOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, arg_2_0._onBattleReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlast:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnReplay:RemoveClickListener()
	arg_3_0:removeEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, arg_3_0._onBattleReply, arg_3_0)
end

function var_0_0._onBattleReply(arg_4_0, arg_4_1)
	Activity104Model.instance:onStartAct104BattleReply(arg_4_1)
end

function var_0_0._btnlastOnClick(arg_5_0)
	if arg_5_0._layer < 2 then
		return
	end

	arg_5_0._animatorLeft:Play(UIAnimationName.Switch, 0, 0)

	arg_5_0._layer = arg_5_0._layer - 1

	TaskDispatcher.cancelTask(arg_5_0._delayShowInfo, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._delayShowInfo, arg_5_0, 0.2)
end

function var_0_0._btnnextOnClick(arg_6_0)
	if Activity104Model.instance:getAct104CurLayer() <= arg_6_0._layer then
		return
	end

	arg_6_0._animatorLeft:Play(UIAnimationName.Switch, 0, 0)

	arg_6_0._layer = arg_6_0._layer + 1

	TaskDispatcher.cancelTask(arg_6_0._delayShowInfo, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._delayShowInfo, arg_6_0, 0.2)
end

function var_0_0._delayShowInfo(arg_7_0)
	arg_7_0:_showInfo()
	arg_7_0:_setStages()
end

function var_0_0._btnstartOnClick(arg_8_0)
	local var_8_0 = ActivityEnum.Activity.Season
	local var_8_1 = SeasonConfig.instance:getSeasonEpisodeCo(var_8_0, arg_8_0._layer).episodeId

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(var_8_0, arg_8_0._layer, var_8_1)
end

function var_0_0._btnreplayOnClick(arg_9_0)
	local var_9_0 = ActivityEnum.Activity.Season
	local var_9_1 = SeasonConfig.instance:getSeasonEpisodeCo(var_9_0, arg_9_0._layer)

	if not var_9_1 or var_9_1.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_9_1.afterStoryId)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/bgyahei.png"))
	arg_10_0._simagedecorate1:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
	arg_10_0._simageleftinfobg:LoadImage(ResUrl.getV1A2SeasonIcon("msg_xia.png"))
	arg_10_0._simagerightinfobg:LoadImage(ResUrl.getV1A2SeasonIcon("msg_shang.png"))
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._layer = arg_12_0.viewParam and arg_12_0.viewParam.tarLayer or Activity104Model.instance:getAct104CurLayer()

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
	arg_12_0:resetData()
	TaskDispatcher.cancelTask(arg_12_0._showInfoByOpen, arg_12_0)

	if arg_12_0:isShowLevel() then
		gohelper.setActive(arg_12_0._golevel, true)
		gohelper.setActive(arg_12_0._goinfo, false)

		arg_12_0._anilevel.speed = 0

		arg_12_0:_setLevels()
		arg_12_0:_setStages()
		Activity104Model.instance:setMakertLayerMark(ActivityEnum.Activity.Season, arg_12_0._layer)
		TaskDispatcher.runDelay(arg_12_0._showInfoByOpen, arg_12_0, 2)
	else
		arg_12_0:_showInfoByOpen()
	end
end

function var_0_0.resetData(arg_13_0)
	arg_13_0._showLvItems = {}
	arg_13_0._showStageItems = {}
	arg_13_0._infoStageItems = {}
	arg_13_0._equipReward = {}
	arg_13_0._rewardItems = {}
	arg_13_0._partStageItems = {}
end

function var_0_0.isShowLevel(arg_14_0)
	return Activity104Model.instance:isCanPlayMakertLayerAnim(ActivityEnum.Activity.Season, arg_14_0._layer)
end

function var_0_0._showInfoByOpen(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(arg_15_0._golevel, false)
	gohelper.setActive(arg_15_0._goinfo, true)
	arg_15_0:_showInfo()
	arg_15_0:_setStages()
end

function var_0_0._setLevels(arg_16_0)
	local var_16_0 = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, arg_16_0._layer)

	arg_16_0._txtcurlevelnamecn.text = var_16_0.stageName

	local var_16_1 = Activity104Model.instance:getMaxLayer()
	local var_16_2 = Activity104Model.instance:getAct104CurLayer()

	if arg_16_0._layer <= 4 then
		gohelper.setActive(arg_16_0._gofront, true)
		gohelper.setActive(arg_16_0._gorear, false)

		for iter_16_0 = 1, 6 do
			local var_16_3 = gohelper.cloneInPlace(arg_16_0._golvitem)

			arg_16_0._showLvItems[iter_16_0] = SeasonMarketShowLevelItem.New()

			arg_16_0._showLvItems[iter_16_0]:init(var_16_3, iter_16_0, var_16_2, var_16_1)
		end
	elseif arg_16_0._layer >= var_16_1 - 3 then
		gohelper.setActive(arg_16_0._gofront, false)
		gohelper.setActive(arg_16_0._gorear, true)

		for iter_16_1 = var_16_1 - 5, var_16_1 do
			local var_16_4 = gohelper.cloneInPlace(arg_16_0._golvitem)

			arg_16_0._showLvItems[iter_16_1] = SeasonMarketShowLevelItem.New()

			arg_16_0._showLvItems[iter_16_1]:init(var_16_4, iter_16_1, var_16_2, var_16_1)
		end
	else
		gohelper.setActive(arg_16_0._gofront, false)
		gohelper.setActive(arg_16_0._gorear, var_16_1 - arg_16_0._layer < 2)

		for iter_16_2 = arg_16_0._layer - 4, arg_16_0._layer + 4 do
			local var_16_5 = gohelper.cloneInPlace(arg_16_0._golvitem)

			arg_16_0._showLvItems[iter_16_2] = SeasonMarketShowLevelItem.New()

			arg_16_0._showLvItems[iter_16_2]:init(var_16_5, iter_16_2, var_16_2, var_16_1)
		end
	end

	TaskDispatcher.runDelay(arg_16_0._delayShowItem, arg_16_0, 0.1)
	gohelper.setAsLastSibling(arg_16_0._gorear)
end

function var_0_0._delayShowItem(arg_17_0)
	local var_17_0, var_17_1 = transformhelper.getPos(arg_17_0._showLvItems[arg_17_0._layer].point.transform)

	transformhelper.setPos(arg_17_0._goScrollRoot.transform, -var_17_0, 0, 0)

	local var_17_2 = recthelper.getAnchorX(arg_17_0._goScrollRoot.transform)

	recthelper.setAnchorX(arg_17_0._goScrollRoot.transform, var_17_2 + 115.2)

	for iter_17_0, iter_17_1 in pairs(arg_17_0._showLvItems) do
		iter_17_1:show()
	end

	arg_17_0._anilevel.speed = 1
end

function var_0_0._setStages(arg_18_0)
	local var_18_0 = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, arg_18_0._layer).stage

	gohelper.setActive(arg_18_0._gostageinfoitem7, var_18_0 == 7)
	gohelper.setActive(arg_18_0._gostagelvitem7, var_18_0 == 7)

	for iter_18_0 = 1, 7 do
		local var_18_1 = gohelper.findChildImage(arg_18_0["_gostageinfoitem" .. iter_18_0], "dark")
		local var_18_2 = gohelper.findChildImage(arg_18_0["_gostageinfoitem" .. iter_18_0], "light")
		local var_18_3 = gohelper.findChildImage(arg_18_0["_gostagelvitem" .. iter_18_0], "dark")
		local var_18_4 = gohelper.findChildImage(arg_18_0["_gostagelvitem" .. iter_18_0], "light")

		gohelper.setActive(var_18_2.gameObject, iter_18_0 <= var_18_0)
		gohelper.setActive(var_18_1.gameObject, var_18_0 < iter_18_0)
		gohelper.setActive(var_18_4.gameObject, iter_18_0 <= var_18_0)
		gohelper.setActive(var_18_3.gameObject, var_18_0 < iter_18_0)

		local var_18_5 = iter_18_0 == 7 and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(var_18_2, var_18_5)
		SLFramework.UGUI.GuiHelper.SetColor(var_18_4, var_18_5)
	end
end

function var_0_0._showInfo(arg_19_0)
	arg_19_0:_setInfo()
	arg_19_0:_setParts()
end

function var_0_0._setInfo(arg_20_0)
	local var_20_0 = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, arg_20_0._layer)

	if not var_20_0 then
		return
	end

	local var_20_1 = Activity104Model.instance:isEpisodeAfterStory(ActivityEnum.Activity.Season, arg_20_0._layer)

	gohelper.setActive(arg_20_0._btnReplay, var_20_1 and var_20_0.afterStoryId ~= 0 or false)

	arg_20_0._txtlevelnamecn.text = var_20_0.stageName
	arg_20_0._txtdesc.text = DungeonConfig.instance:getEpisodeCO(var_20_0.episodeId).desc
	arg_20_0._txtcurindex.text = string.format("%02d", arg_20_0._layer)

	local var_20_2 = Activity104Model.instance:getMaxLayer()

	arg_20_0._txtmaxindex.text = string.format("%02d", var_20_2)

	local var_20_3 = Activity104Model.instance:getAct104CurStage()
	local var_20_4 = Activity104Model.instance:isNextLayerNewStage(arg_20_0._layer)

	gohelper.setActive(arg_20_0._godecorate, var_20_4)
	arg_20_0._simagedecorate2:LoadImage(ResUrl.getSeasonMarketIcon(var_20_0.stagePicture))
	gohelper.setActive(arg_20_0._gorewarditem, false)

	local var_20_5 = DungeonModel.instance:getEpisodeFirstBonus(var_20_0.episodeId)

	for iter_20_0 = 2, math.max(#arg_20_0._rewardItems - 1, #var_20_5) + 1 do
		local var_20_6 = arg_20_0._rewardItems[iter_20_0] or arg_20_0:createRewardItem(iter_20_0)

		arg_20_0:refreshRewardItem(var_20_6, var_20_5[iter_20_0 - 1])
	end

	arg_20_0:refreshEquipCardItem()

	arg_20_0._btnlast.button.interactable = arg_20_0._layer > 1
	arg_20_0._btnnext.button.interactable = arg_20_0._layer < Activity104Model.instance:getAct104CurLayer()
end

function var_0_0.refreshEquipCardItem(arg_21_0)
	if not arg_21_0._rewardItems[1] then
		arg_21_0._rewardItems[1] = arg_21_0:createRewardItem(1)
	end

	local var_21_0 = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, arg_21_0._layer)

	gohelper.setActive(arg_21_0._rewardItems[1].go, var_21_0.firstPassEquipId > 0)

	if var_21_0.firstPassEquipId > 0 then
		local var_21_1 = arg_21_0._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getEpisodeState(arg_21_0._layer) > 0

		if not arg_21_0._rewardItems[1].itemIcon then
			arg_21_0._rewardItems[1].itemIcon = SeasonCelebrityCardItem.New()

			arg_21_0._rewardItems[1].itemIcon:setColorDark(var_21_1)
			arg_21_0._rewardItems[1].itemIcon:init(arg_21_0._rewardItems[1].cardParent, var_21_0.firstPassEquipId)
		else
			arg_21_0._rewardItems[1].itemIcon:setColorDark(var_21_1)
			arg_21_0._rewardItems[1].itemIcon:reset(var_21_0.firstPassEquipId)
		end

		gohelper.setActive(arg_21_0._rewardItems[1].cardParent, true)
		gohelper.setActive(arg_21_0._rewardItems[1].itemParent, false)
		gohelper.setActive(arg_21_0._rewardItems[1].receive, var_21_1)
	end
end

function var_0_0.createRewardItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getUserDataTb_()
	local var_22_1 = gohelper.cloneInPlace(arg_22_0._gorewarditem, "reward_" .. tostring(arg_22_1))

	var_22_0.go = var_22_1
	var_22_0.itemParent = gohelper.findChild(var_22_1, "go_prop")
	var_22_0.cardParent = gohelper.findChild(var_22_1, "go_card")
	var_22_0.receive = gohelper.findChild(var_22_1, "go_receive")
	arg_22_0._rewardItems[arg_22_1] = var_22_0

	return var_22_0
end

function var_0_0.refreshRewardItem(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_2 or not next(arg_23_2) then
		gohelper.setActive(arg_23_1.go, false)

		return
	end

	if not arg_23_1.itemIcon then
		arg_23_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_23_1.itemParent)
	end

	gohelper.setActive(arg_23_1.cardParent, false)
	gohelper.setActive(arg_23_1.itemParent, true)
	arg_23_1.itemIcon:setMOValue(tonumber(arg_23_2[1]), tonumber(arg_23_2[2]), tonumber(arg_23_2[3]), nil, true)
	arg_23_1.itemIcon:isShowCount(tonumber(arg_23_2[1]) ~= MaterialEnum.MaterialType.Hero)
	arg_23_1.itemIcon:setCountFontSize(40)
	arg_23_1.itemIcon:showStackableNum2()
	arg_23_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_23_1.itemIcon:hideEquipLvAndBreak(true)
	gohelper.setActive(arg_23_1.go, true)

	local var_23_0 = arg_23_0._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getEpisodeState(arg_23_0._layer) > 0

	gohelper.setActive(arg_23_1.receive, var_23_0)

	local var_23_1 = var_23_0 and "#7b7b7b" or "#ffffff"

	arg_23_1.itemIcon:setItemColor(var_23_1)
end

function var_0_0._setParts(arg_24_0)
	local var_24_0 = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, arg_24_0._layer)

	arg_24_0._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(var_24_0.level)

	if arg_24_0._layer < Activity104Model.instance:getAct104CurLayer() or arg_24_0._layer >= Activity104Model.instance:getMaxLayer() then
		gohelper.setActive(arg_24_0._gopart, false)
		gohelper.setActive(arg_24_0._gounlocktype1, false)
		gohelper.setActive(arg_24_0._gounlocktype2, false)
		gohelper.setActive(arg_24_0._gounlocktype3, false)
	else
		local var_24_1 = Activity104Model.instance:isNextLayerNewStage(arg_24_0._layer)

		gohelper.setActive(arg_24_0._gostage, var_24_1)

		if var_24_1 then
			local var_24_2 = Activity104Model.instance:getAct104CurStage()

			arg_24_0:_showPartStageItem(var_24_2 + 1)
		end

		local var_24_3 = string.splitToNumber(var_24_0.unlockEquipIndex, "#")

		if #var_24_3 > 0 then
			gohelper.setActive(arg_24_0._gounlocktype1, var_24_3[1] < 5)
			gohelper.setActive(arg_24_0._gounlocktype2, var_24_3[1] > 4 and var_24_3[1] < 9)
			gohelper.setActive(arg_24_0._gounlocktype3, var_24_3[1] == 9)
		end

		gohelper.setActive(arg_24_0._gopart, var_24_1 or #var_24_3 > 0)
	end
end

var_0_0.UnLockStageItemAlpha = 1
var_0_0.LockStageItemAlpha = 0.3

function var_0_0._showPartStageItem(arg_25_0, arg_25_1)
	if arg_25_1 < 7 then
		if arg_25_0._partStageItems[7] then
			gohelper.setActive(arg_25_0._partStageItems[7].go, false)
		end

		for iter_25_0 = 1, 6 do
			if not arg_25_0._partStageItems[iter_25_0] then
				local var_25_0 = arg_25_0:getUserDataTb_()
				local var_25_1 = gohelper.cloneInPlace(arg_25_0._gostagelvlitem, "partstageitem_" .. tostring(iter_25_0))

				var_25_0.go = var_25_1
				var_25_0.current = gohelper.findChild(var_25_1, "current")
				var_25_0.next = gohelper.findChild(var_25_1, "next")
				var_25_0.canvasgroup = gohelper.onceAddComponent(var_25_1, typeof(UnityEngine.CanvasGroup))
				arg_25_0._partStageItems[iter_25_0] = var_25_0
			end

			gohelper.setActive(arg_25_0._partStageItems[iter_25_0].go, true)
			gohelper.setActive(arg_25_0._partStageItems[iter_25_0].next, iter_25_0 == arg_25_1)
			gohelper.setActive(arg_25_0._partStageItems[iter_25_0].current, iter_25_0 ~= arg_25_1)

			arg_25_0._partStageItems[iter_25_0].canvasgroup.alpha = iter_25_0 <= arg_25_1 and var_0_0.UnLockStageItemAlpha or var_0_0.LockStageItemAlpha
		end
	else
		for iter_25_1 = 1, 7 do
			if not arg_25_0._partStageItems[iter_25_1] then
				local var_25_2 = arg_25_0:getUserDataTb_()
				local var_25_3 = gohelper.cloneInPlace(arg_25_0._gostagelvlitem, "partstageitem_" .. tostring(iter_25_1))

				var_25_2.go = var_25_3
				var_25_2.current = gohelper.findChild(var_25_3, "current")
				var_25_2.next = gohelper.findChild(var_25_3, "next")
				var_25_2.canvasgroup = gohelper.onceAddComponent(var_25_3, typeof(UnityEngine.CanvasGroup))
				arg_25_0._partStageItems[iter_25_1] = var_25_2
			end

			gohelper.setActive(arg_25_0._partStageItems[iter_25_1].go, true)
			gohelper.setActive(arg_25_0._partStageItems[iter_25_1].next, iter_25_1 == arg_25_1)
			gohelper.setActive(arg_25_0._partStageItems[iter_25_1].current, iter_25_1 ~= arg_25_1)

			arg_25_0._partStageItems[iter_25_1].canvasgroup.alpha = iter_25_1 <= arg_25_1 and var_0_0.UnLockStageItemAlpha or var_0_0.LockStageItemAlpha
		end
	end
end

function var_0_0.onClose(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._delayShowInfo, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._showInfoByOpen, arg_27_0)
	arg_27_0._simagedecorate1:UnLoadImage()
	arg_27_0._simagedecorate2:UnLoadImage()
	arg_27_0._simageleftinfobg:UnLoadImage()
	arg_27_0._simagerightinfobg:UnLoadImage()
	arg_27_0._simagebg1:UnLoadImage()

	if arg_27_0._showLvItems then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._showLvItems) do
			iter_27_1:destroy()
		end

		arg_27_0._showLvItems = nil
	end
end

return var_0_0
