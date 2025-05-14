module("modules.logic.season.view1_2.Season1_2MarketView", package.seeall)

local var_0_0 = class("Season1_2MarketView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._simagepage = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/left/#simage_page")
	arg_1_0._simagestageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/left/#simage_stageicon")
	arg_1_0._animatorRight = gohelper.findChildComponent(arg_1_0.viewGO, "#go_info/right", typeof(UnityEngine.Animator))
	arg_1_0._txtlevelnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn")
	arg_1_0._txtlevelnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/#txt_levelnameen")
	arg_1_0._gostageinfoitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem1")
	arg_1_0._gostageinfoitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem2")
	arg_1_0._gostageinfoitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem3")
	arg_1_0._gostageinfoitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem4")
	arg_1_0._gostageinfoitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem5")
	arg_1_0._gostageinfoitem6 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem6")
	arg_1_0._gostageinfoitem7 = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem7")
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
	arg_1_0._btnReplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/right/btns/#btn_storyreplay")
	arg_1_0._gopart = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_part")
	arg_1_0._gostage = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_part/#go_stage")
	arg_1_0._gostagelvlitem = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_part/#go_stage/list/#go_stagelvlitem")

	gohelper.setActive(arg_1_0._gostagelvlitem, false)

	arg_1_0._gounlocktype1 = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype1")
	arg_1_0._gounlocktype2 = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype2")
	arg_1_0._gounlocktype3 = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype3")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._godecorate = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/decorate")
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/position/center")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "#go_level")
	arg_1_0._anilevel = arg_1_0._golevel:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simagelvbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#simage_lvbg")
	arg_1_0._goScrollContent = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content")
	arg_1_0._golvitem = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem")
	arg_1_0._simagedecorate = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/center/backgrounds/#simage_decorate4")
	arg_1_0._txtcurlevelnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn")
	arg_1_0._txtcurlevelnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/#txt_curlevelnameen")
	arg_1_0._gostagelvitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem1")
	arg_1_0._gostagelvitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem2")
	arg_1_0._gostagelvitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem3")
	arg_1_0._gostagelvitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem4")
	arg_1_0._gostagelvitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem5")
	arg_1_0._gostagelvitem6 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem6")
	arg_1_0._gostagelvitem7 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem7")
	arg_1_0._simageuttu = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/bottom/#simage_uttu")
	arg_1_0._simageleftinfobg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#simage_leftinfobg")
	arg_1_0._simagerightinfobg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#simage_rightinfobg")
	arg_1_0._gopartempty = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_partempty")
	arg_1_0._simageempty = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/right/layout/#go_partempty/#simage_empty")
	arg_1_0._goleftscrolltopmask = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/Scroll View/mask2")

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

	arg_5_0._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	arg_5_0._animScroll:Play(UIAnimationName.Switch, 0, 0)

	arg_5_0._layer = arg_5_0._layer - 1

	TaskDispatcher.cancelTask(arg_5_0._delayShowInfo, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._delayShowInfo, arg_5_0, 0.2)
end

function var_0_0._btnnextOnClick(arg_6_0)
	if Activity104Model.instance:getAct104CurLayer() <= arg_6_0._layer then
		return
	end

	arg_6_0._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	arg_6_0._animScroll:Play(UIAnimationName.Switch, 0, 0)

	arg_6_0._layer = arg_6_0._layer + 1

	TaskDispatcher.cancelTask(arg_6_0._delayShowInfo, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._delayShowInfo, arg_6_0, 0.2)
end

function var_0_0._delayShowInfo(arg_7_0)
	arg_7_0:_showInfo()
	arg_7_0:_setStages()
	arg_7_0:updateLeftDesc()
end

function var_0_0._btnstartOnClick(arg_8_0)
	local var_8_0 = Activity104Model.instance:getCurSeasonId()
	local var_8_1 = SeasonConfig.instance:getSeasonEpisodeCo(var_8_0, arg_8_0._layer).episodeId

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(var_8_0, arg_8_0._layer, var_8_1)
end

function var_0_0._btnreplayOnClick(arg_9_0)
	local var_9_0 = Activity104Model.instance:getCurSeasonId()
	local var_9_1 = SeasonConfig.instance:getSeasonEpisodeCo(var_9_0, arg_9_0._layer)

	if not var_9_1 or var_9_1.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_9_1.afterStoryId)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._simagepage:LoadImage(ResUrl.getV1A2SeasonIcon("shuye.png"))
	arg_10_0._simageuttu:LoadImage(ResUrl.getV1A2SeasonIcon("uttu_zs.png"))
	arg_10_0._simageleftinfobg:LoadImage(ResUrl.getV1A2SeasonIcon("msg_xia.png"))
	arg_10_0._simagerightinfobg:LoadImage(ResUrl.getV1A2SeasonIcon("msg_shang.png"))
	arg_10_0._simageempty:LoadImage(ResUrl.getV1A2SeasonIcon("kongzhuangtai.png"))
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._layer = arg_12_0.viewParam and arg_12_0.viewParam.tarLayer or Activity104Model.instance:getAct104CurLayer()

	arg_12_0:resetData()
	TaskDispatcher.cancelTask(arg_12_0._showInfoByOpen, arg_12_0)

	if arg_12_0:isShowLevel() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
		gohelper.setActive(arg_12_0._golevel, true)
		gohelper.setActive(arg_12_0._goinfo, false)

		arg_12_0._anilevel.speed = 0

		arg_12_0:_setLevels()
		arg_12_0:_setStages()
		Activity104Model.instance:setMakertLayerMark(Activity104Model.instance:getCurSeasonId(), arg_12_0._layer)
		TaskDispatcher.runDelay(arg_12_0._showInfoByOpen, arg_12_0, 2)
	else
		arg_12_0:noAudioShowInfoByOpen()
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
	return Activity104Model.instance:isCanPlayMakertLayerAnim(Activity104Model.instance:getCurSeasonId(), arg_14_0._layer)
end

function var_0_0.noAudioShowInfoByOpen(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(arg_15_0._golevel, false)
	gohelper.setActive(arg_15_0._goinfo, true)
	arg_15_0:_showInfo()
	arg_15_0:_setStages()
	arg_15_0:updateLeftDesc()
end

function var_0_0._showInfoByOpen(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(arg_16_0._golevel, false)
	gohelper.setActive(arg_16_0._goinfo, true)
	arg_16_0:_showInfo()
	arg_16_0:_setStages()
	arg_16_0:updateLeftDesc()
end

function var_0_0._setLevels(arg_17_0)
	local var_17_0 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), arg_17_0._layer)

	arg_17_0._txtcurlevelnamecn.text = var_17_0.stageName
	arg_17_0._txtcurlevelnameen.text = var_17_0.stageNameEn

	local var_17_1 = Activity104Model.instance:getMaxLayer()
	local var_17_2 = Activity104Model.instance:getAct104CurLayer()

	if arg_17_0._layer <= 4 then
		for iter_17_0 = 1, 6 do
			local var_17_3 = gohelper.cloneInPlace(arg_17_0._golvitem)

			arg_17_0._showLvItems[iter_17_0] = Season1_2MarketShowLevelItem.New()

			arg_17_0._showLvItems[iter_17_0]:init(var_17_3, iter_17_0, var_17_2, var_17_1)
		end
	elseif arg_17_0._layer >= var_17_1 - 3 then
		for iter_17_1 = var_17_1 - 5, var_17_1 do
			local var_17_4 = gohelper.cloneInPlace(arg_17_0._golvitem)

			arg_17_0._showLvItems[iter_17_1] = Season1_2MarketShowLevelItem.New()

			arg_17_0._showLvItems[iter_17_1]:init(var_17_4, iter_17_1, var_17_2, var_17_1)
		end
	else
		for iter_17_2 = arg_17_0._layer - 4, arg_17_0._layer + 4 do
			local var_17_5 = gohelper.cloneInPlace(arg_17_0._golvitem)

			arg_17_0._showLvItems[iter_17_2] = Season1_2MarketShowLevelItem.New()

			arg_17_0._showLvItems[iter_17_2]:init(var_17_5, iter_17_2, var_17_2, var_17_1)
		end
	end

	TaskDispatcher.runDelay(arg_17_0._delayShowItem, arg_17_0, 0.1)
end

function var_0_0._delayShowItem(arg_18_0)
	local var_18_0 = arg_18_0._showLvItems[arg_18_0._layer]

	if var_18_0 then
		local var_18_1 = -(recthelper.getAnchorX(var_18_0.go.transform) - 105)

		recthelper.setAnchorX(arg_18_0._goScrollContent.transform, var_18_1)
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0._showLvItems) do
		iter_18_1:show()
	end

	arg_18_0._anilevel.speed = 1
end

function var_0_0._setStages(arg_19_0)
	local var_19_0 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), arg_19_0._layer)
	local var_19_1 = var_19_0.stage

	gohelper.setActive(arg_19_0._gostageinfoitem7, var_19_1 == 7)
	gohelper.setActive(arg_19_0._gostagelvitem7, var_19_1 == 7)

	for iter_19_0 = 1, 7 do
		local var_19_2 = gohelper.findChildImage(arg_19_0["_gostageinfoitem" .. iter_19_0], "dark")
		local var_19_3 = gohelper.findChildImage(arg_19_0["_gostageinfoitem" .. iter_19_0], "light")
		local var_19_4 = gohelper.findChildImage(arg_19_0["_gostagelvitem" .. iter_19_0], "dark")
		local var_19_5 = gohelper.findChildImage(arg_19_0["_gostagelvitem" .. iter_19_0], "light")

		gohelper.setActive(var_19_3.gameObject, iter_19_0 <= var_19_1)
		gohelper.setActive(var_19_2.gameObject, var_19_1 < iter_19_0)
		gohelper.setActive(var_19_5.gameObject, iter_19_0 <= var_19_1)
		gohelper.setActive(var_19_4.gameObject, var_19_1 < iter_19_0)

		local var_19_6 = iter_19_0 == 7 and "#B83838" or "#3E3E3D"
		local var_19_7 = iter_19_0 == 7 and "#B83838" or "#C1C1C2"

		SLFramework.UGUI.GuiHelper.SetColor(var_19_3, var_19_6)
		SLFramework.UGUI.GuiHelper.SetColor(var_19_5, var_19_7)
	end

	arg_19_0._simagedecorate:LoadImage(ResUrl.getV1A2SeasonIcon(string.format("icon/ct_%s.png", var_19_0.stagePicture)))
end

function var_0_0._showInfo(arg_20_0)
	arg_20_0:_setInfo()
	arg_20_0:_setParts()
end

var_0_0.NomalStageTagPos = Vector2(46.3, 2.7)
var_0_0.NewStageTagPos = Vector2(4.37, 2.7)

function var_0_0._setInfo(arg_21_0)
	local var_21_0 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), arg_21_0._layer)

	if not var_21_0 then
		return
	end

	local var_21_1 = Activity104Model.instance:isEpisodeAfterStory(Activity104Model.instance:getCurSeasonId(), arg_21_0._layer)

	gohelper.setActive(arg_21_0._btnReplay, var_21_1 and var_21_0.afterStoryId ~= 0 or false)

	arg_21_0._txtlevelnamecn.text = var_21_0.stageName
	arg_21_0._txtlevelnameen.text = var_21_0.stageNameEn
	arg_21_0._txtdesc.text = DungeonConfig.instance:getEpisodeCO(var_21_0.episodeId).desc
	arg_21_0._txtcurindex.text = string.format("%02d", arg_21_0._layer)

	local var_21_2 = Activity104Model.instance:getMaxLayer()

	arg_21_0._txtmaxindex.text = string.format("%02d", var_21_2)

	local var_21_3 = Activity104Model.instance:getAct104CurStage()
	local var_21_4 = Activity104Model.instance:isNextLayerNewStage(arg_21_0._layer)

	gohelper.setActive(arg_21_0._godecorate, var_21_4)

	local var_21_5 = var_21_4 and var_0_0.NewStageTagPos or var_0_0.NomalStageTagPos

	recthelper.setAnchor(arg_21_0._gocenter.transform, var_21_5.x, var_21_5.y)
	arg_21_0._simagestageicon:LoadImage(ResUrl.getV1A2SeasonIcon(string.format("icon/ct_%s.png", var_21_0.stagePicture)))
	gohelper.setActive(arg_21_0._gorewarditem, false)

	local var_21_6 = DungeonModel.instance:getEpisodeFirstBonus(var_21_0.episodeId)

	for iter_21_0 = 2, math.max(#arg_21_0._rewardItems - 1, #var_21_6) + 1 do
		local var_21_7 = arg_21_0._rewardItems[iter_21_0] or arg_21_0:createRewardItem(iter_21_0)

		arg_21_0:refreshRewardItem(var_21_7, var_21_6[iter_21_0 - 1])
	end

	arg_21_0:refreshEquipCardItem()

	arg_21_0._btnlast.button.interactable = arg_21_0._layer > 1
	arg_21_0._btnnext.button.interactable = arg_21_0._layer < Activity104Model.instance:getAct104CurLayer()
end

function var_0_0.refreshEquipCardItem(arg_22_0)
	if not arg_22_0._rewardItems[1] then
		arg_22_0._rewardItems[1] = arg_22_0:createRewardItem(1)
	end

	local var_22_0 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), arg_22_0._layer)

	gohelper.setActive(arg_22_0._rewardItems[1].go, var_22_0.firstPassEquipId > 0)

	if var_22_0.firstPassEquipId > 0 then
		local var_22_1 = arg_22_0._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getEpisodeState(arg_22_0._layer) > 0

		if not arg_22_0._rewardItems[1].itemIcon then
			arg_22_0._rewardItems[1].itemIcon = Season1_2CelebrityCardItem.New()

			arg_22_0._rewardItems[1].itemIcon:setColorDark(var_22_1)
			arg_22_0._rewardItems[1].itemIcon:init(arg_22_0._rewardItems[1].cardParent, var_22_0.firstPassEquipId)
		else
			arg_22_0._rewardItems[1].itemIcon:setColorDark(var_22_1)
			arg_22_0._rewardItems[1].itemIcon:reset(var_22_0.firstPassEquipId)
		end

		gohelper.setActive(arg_22_0._rewardItems[1].cardParent, true)
		gohelper.setActive(arg_22_0._rewardItems[1].itemParent, false)
		gohelper.setActive(arg_22_0._rewardItems[1].receive, var_22_1)
	end
end

function var_0_0.createRewardItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getUserDataTb_()
	local var_23_1 = gohelper.cloneInPlace(arg_23_0._gorewarditem, "reward_" .. tostring(arg_23_1))

	var_23_0.go = var_23_1
	var_23_0.itemParent = gohelper.findChild(var_23_1, "go_prop")
	var_23_0.cardParent = gohelper.findChild(var_23_1, "go_card")
	var_23_0.receive = gohelper.findChild(var_23_1, "go_receive")
	arg_23_0._rewardItems[arg_23_1] = var_23_0

	return var_23_0
end

function var_0_0.refreshRewardItem(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_2 or not next(arg_24_2) then
		gohelper.setActive(arg_24_1.go, false)

		return
	end

	if not arg_24_1.itemIcon then
		arg_24_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_24_1.itemParent)
	end

	gohelper.setActive(arg_24_1.cardParent, false)
	gohelper.setActive(arg_24_1.itemParent, true)
	arg_24_1.itemIcon:setMOValue(tonumber(arg_24_2[1]), tonumber(arg_24_2[2]), tonumber(arg_24_2[3]), nil, true)
	arg_24_1.itemIcon:isShowCount(tonumber(arg_24_2[1]) ~= MaterialEnum.MaterialType.Hero)
	arg_24_1.itemIcon:setCountFontSize(40)
	arg_24_1.itemIcon:showStackableNum2()
	arg_24_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_24_1.itemIcon:hideEquipLvAndBreak(true)
	gohelper.setActive(arg_24_1.go, true)

	local var_24_0 = arg_24_0._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getEpisodeState(arg_24_0._layer) > 0

	gohelper.setActive(arg_24_1.receive, var_24_0)

	local var_24_1 = var_24_0 and "#7b7b7b" or "#ffffff"

	arg_24_1.itemIcon:setItemColor(var_24_1)
end

function var_0_0._setParts(arg_25_0)
	local var_25_0 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), arg_25_0._layer)

	arg_25_0._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(var_25_0.level)

	if arg_25_0._layer < Activity104Model.instance:getAct104CurLayer() or arg_25_0._layer >= Activity104Model.instance:getMaxLayer() then
		gohelper.setActive(arg_25_0._gopart, false)
		gohelper.setActive(arg_25_0._gopartempty, true)
		gohelper.setActive(arg_25_0._gounlocktype1, false)
		gohelper.setActive(arg_25_0._gounlocktype2, false)
		gohelper.setActive(arg_25_0._gounlocktype3, false)
	else
		local var_25_1 = Activity104Model.instance:isNextLayerNewStage(arg_25_0._layer)

		gohelper.setActive(arg_25_0._gostage, var_25_1)

		if var_25_1 then
			local var_25_2 = Activity104Model.instance:getAct104CurStage()

			arg_25_0:_showPartStageItem(var_25_2 + 1)
		end

		local var_25_3 = string.splitToNumber(var_25_0.unlockEquipIndex, "#")

		if #var_25_3 > 0 then
			gohelper.setActive(arg_25_0._gounlocktype1, var_25_3[1] < 5)
			gohelper.setActive(arg_25_0._gounlocktype2, var_25_3[1] > 4 and var_25_3[1] < 9)
			gohelper.setActive(arg_25_0._gounlocktype3, var_25_3[1] == 9)
		else
			gohelper.setActive(arg_25_0._gounlocktype1, false)
			gohelper.setActive(arg_25_0._gounlocktype2, false)
			gohelper.setActive(arg_25_0._gounlocktype3, false)
		end

		gohelper.setActive(arg_25_0._gopart, var_25_1 or #var_25_3 > 0)
		gohelper.setActive(arg_25_0._gopartempty, not var_25_1 and not (#var_25_3 > 0))
	end
end

var_0_0.UnLockStageItemAlpha = 1
var_0_0.LockStageItemAlpha = 0.3

function var_0_0._showPartStageItem(arg_26_0, arg_26_1)
	if arg_26_1 < 7 then
		if arg_26_0._partStageItems[7] then
			gohelper.setActive(arg_26_0._partStageItems[7].go, false)
		end

		for iter_26_0 = 1, 6 do
			if not arg_26_0._partStageItems[iter_26_0] then
				local var_26_0 = arg_26_0:getUserDataTb_()
				local var_26_1 = gohelper.cloneInPlace(arg_26_0._gostagelvlitem, "partstageitem_" .. tostring(iter_26_0))

				var_26_0.go = var_26_1
				var_26_0.current = gohelper.findChild(var_26_1, "current")
				var_26_0.next = gohelper.findChild(var_26_1, "next")
				var_26_0.canvasgroup = gohelper.onceAddComponent(var_26_1, typeof(UnityEngine.CanvasGroup))
				arg_26_0._partStageItems[iter_26_0] = var_26_0
			end

			gohelper.setActive(arg_26_0._partStageItems[iter_26_0].go, true)
			gohelper.setActive(arg_26_0._partStageItems[iter_26_0].next, iter_26_0 == arg_26_1)
			gohelper.setActive(arg_26_0._partStageItems[iter_26_0].current, iter_26_0 ~= arg_26_1)

			arg_26_0._partStageItems[iter_26_0].canvasgroup.alpha = iter_26_0 <= arg_26_1 and var_0_0.UnLockStageItemAlpha or var_0_0.LockStageItemAlpha
		end
	else
		for iter_26_1 = 1, 7 do
			if not arg_26_0._partStageItems[iter_26_1] then
				local var_26_2 = arg_26_0:getUserDataTb_()
				local var_26_3 = gohelper.cloneInPlace(arg_26_0._gostagelvlitem, "partstageitem_" .. tostring(iter_26_1))

				var_26_2.go = var_26_3
				var_26_2.current = gohelper.findChild(var_26_3, "current")
				var_26_2.next = gohelper.findChild(var_26_3, "next")
				var_26_2.canvasgroup = gohelper.onceAddComponent(var_26_3, typeof(UnityEngine.CanvasGroup))
				arg_26_0._partStageItems[iter_26_1] = var_26_2
			end

			gohelper.setActive(arg_26_0._partStageItems[iter_26_1].go, true)
			gohelper.setActive(arg_26_0._partStageItems[iter_26_1].next, iter_26_1 == arg_26_1)
			gohelper.setActive(arg_26_0._partStageItems[iter_26_1].current, iter_26_1 ~= arg_26_1)

			arg_26_0._partStageItems[iter_26_1].canvasgroup.alpha = iter_26_1 <= arg_26_1 and var_0_0.UnLockStageItemAlpha or var_0_0.LockStageItemAlpha
		end
	end
end

function var_0_0.updateLeftDesc(arg_27_0)
	if not arg_27_0.descItems then
		arg_27_0.descItems = {}
	end

	local var_27_0 = Activity104Model.instance:getAct104CurStage(Activity104Model.instance:getCurSeasonId(), arg_27_0._layer)
	local var_27_1 = Activity104Model.instance:getStageEpisodeList(var_27_0)

	arg_27_0._curDescItem = nil

	for iter_27_0 = 1, math.max(#var_27_1, #arg_27_0.descItems) do
		local var_27_2 = arg_27_0.descItems[iter_27_0]

		if not var_27_2 then
			var_27_2 = arg_27_0:createLeftDescItem(iter_27_0)
			arg_27_0.descItems[iter_27_0] = var_27_2
		end

		arg_27_0:updateLeftDescItem(var_27_2, var_27_1[iter_27_0])
	end

	gohelper.setActive(arg_27_0._goleftscrolltopmask, arg_27_0._curDescItem.index ~= 1)
	TaskDispatcher.runDelay(arg_27_0.moveToCurDesc, arg_27_0, 0.02)
end

function var_0_0.createLeftDescItem(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getUserDataTb_()

	var_28_0.index = arg_28_1
	var_28_0.go = gohelper.cloneInPlace(arg_28_0._goDescItem, "desc" .. arg_28_1)
	var_28_0.txt = gohelper.findChildTextMesh(var_28_0.go, "txt_desc")
	var_28_0.goLine = gohelper.findChild(var_28_0.go, "go_underline")

	return var_28_0
end

function var_0_0.updateLeftDescItem(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_2 then
		gohelper.setActive(arg_29_1.go, false)

		return
	end

	gohelper.setActive(arg_29_1.go, true)

	local var_29_0 = arg_29_2.desc

	if arg_29_2.layer == arg_29_0._layer then
		gohelper.setActive(arg_29_1.goLine, true)

		arg_29_1.txt.text = var_29_0
		arg_29_1.txt.lineSpacing = 49.75

		ZProj.UGUIHelper.SetColorAlpha(arg_29_1.txt, 1)

		arg_29_0._curDescItem = arg_29_1
	else
		gohelper.setActive(arg_29_1.goLine, false)

		arg_29_1.txt.text = var_29_0
		arg_29_1.txt.lineSpacing = -12.5

		ZProj.UGUIHelper.SetColorAlpha(arg_29_1.txt, 0.7)
	end
end

function var_0_0.moveToCurDesc(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.moveToCurDesc, arg_30_0)

	local var_30_0 = arg_30_0._curDescItem

	if not var_30_0 then
		return
	end

	local var_30_1 = var_30_0.txt.preferredHeight
	local var_30_2 = recthelper.getHeight(arg_30_0._descScroll.transform)
	local var_30_3 = math.max(0, recthelper.getHeight(arg_30_0._descContent.transform) - var_30_2)
	local var_30_4 = (var_30_2 - var_30_1) * 0.5
	local var_30_5 = recthelper.getAnchorY(var_30_0.go.transform) + var_30_4

	recthelper.setAnchorY(arg_30_0._descContent.transform, Mathf.Clamp(-var_30_5, 0, -var_30_5))
end

function var_0_0.onClose(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._delayShowInfo, arg_31_0)
end

function var_0_0.onDestroyView(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._showInfoByOpen, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0.moveToCurDesc, arg_32_0)
	arg_32_0._simagestageicon:UnLoadImage()
	arg_32_0._simagepage:UnLoadImage()
	arg_32_0._simageuttu:UnLoadImage()
	arg_32_0._simageleftinfobg:UnLoadImage()
	arg_32_0._simagerightinfobg:UnLoadImage()

	if arg_32_0._showLvItems then
		for iter_32_0, iter_32_1 in pairs(arg_32_0._showLvItems) do
			iter_32_1:destroy()
		end

		arg_32_0._showLvItems = nil
	end
end

return var_0_0
