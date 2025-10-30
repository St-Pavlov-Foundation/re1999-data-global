module("modules.logic.season.view3_0.Season3_0MarketView", package.seeall)

local var_0_0 = class("Season3_0MarketView", BaseView)

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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlast:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnReplay:RemoveClickListener()
end

function var_0_0._btnlastOnClick(arg_4_0)
	if arg_4_0._layer < 2 then
		return
	end

	arg_4_0._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	arg_4_0._animScroll:Play(UIAnimationName.Switch, 0, 0)

	arg_4_0._layer = arg_4_0._layer - 1

	TaskDispatcher.cancelTask(arg_4_0._delayShowInfo, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._delayShowInfo, arg_4_0, 0.2)
end

function var_0_0._btnnextOnClick(arg_5_0)
	if Activity104Model.instance:getAct104CurLayer() <= arg_5_0._layer then
		return
	end

	arg_5_0._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	arg_5_0._animScroll:Play(UIAnimationName.Switch, 0, 0)

	arg_5_0._layer = arg_5_0._layer + 1

	TaskDispatcher.cancelTask(arg_5_0._delayShowInfo, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._delayShowInfo, arg_5_0, 0.2)
end

function var_0_0._delayShowInfo(arg_6_0)
	arg_6_0:_showInfo()
	arg_6_0:_setStages()
	arg_6_0:updateLeftDesc()
end

function var_0_0._btnstartOnClick(arg_7_0)
	local var_7_0 = Activity104Model.instance:getCurSeasonId()
	local var_7_1 = SeasonConfig.instance:getSeasonEpisodeCo(var_7_0, arg_7_0._layer).episodeId

	Activity104Model.instance:enterAct104Battle(var_7_1, arg_7_0._layer)
end

function var_0_0._btnreplayOnClick(arg_8_0)
	local var_8_0 = Activity104Model.instance:getCurSeasonId()
	local var_8_1 = SeasonConfig.instance:getSeasonEpisodeCo(var_8_0, arg_8_0._layer)

	if not var_8_1 or var_8_1.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_8_1.afterStoryId)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._simagepage:LoadImage(SeasonViewHelper.getSeasonIcon("shuye.png"))
	arg_9_0._simageuttu:LoadImage(SeasonViewHelper.getSeasonIcon("uttu_zs.png"))
	arg_9_0._simageleftinfobg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_xia.png"))
	arg_9_0._simagerightinfobg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_shang.png"))
	arg_9_0._simageempty:LoadImage(SeasonViewHelper.getSeasonIcon("kongzhuangtai.png"))
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._layer = arg_11_0.viewParam and arg_11_0.viewParam.tarLayer or Activity104Model.instance:getAct104CurLayer()

	arg_11_0:resetData()
	TaskDispatcher.cancelTask(arg_11_0._showInfoByOpen, arg_11_0)

	if arg_11_0:isShowLevel() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
		gohelper.setActive(arg_11_0._golevel, true)
		gohelper.setActive(arg_11_0._goinfo, false)

		arg_11_0._anilevel.speed = 0

		arg_11_0:_setLevels()
		arg_11_0:_setStages()
		Activity104Model.instance:setMakertLayerMark(Activity104Model.instance:getCurSeasonId(), arg_11_0._layer)
		TaskDispatcher.runDelay(arg_11_0._showInfoByOpen, arg_11_0, 2)
	else
		arg_11_0:noAudioShowInfoByOpen()
	end
end

function var_0_0.resetData(arg_12_0)
	arg_12_0._showLvItems = {}
	arg_12_0._showStageItems = {}
	arg_12_0._infoStageItems = {}
	arg_12_0._equipReward = {}
	arg_12_0._rewardItems = {}
	arg_12_0._partStageItems = {}
end

function var_0_0.isShowLevel(arg_13_0)
	return Activity104Model.instance:isCanPlayMakertLayerAnim(Activity104Model.instance:getCurSeasonId(), arg_13_0._layer)
end

function var_0_0.noAudioShowInfoByOpen(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(arg_14_0._golevel, false)
	gohelper.setActive(arg_14_0._goinfo, true)
	arg_14_0:_showInfo()
	arg_14_0:_setStages()
	arg_14_0:updateLeftDesc()
end

function var_0_0._showInfoByOpen(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(arg_15_0._golevel, false)
	gohelper.setActive(arg_15_0._goinfo, true)
	arg_15_0:_showInfo()
	arg_15_0:_setStages()
	arg_15_0:updateLeftDesc()
end

function var_0_0._setLevels(arg_16_0)
	local var_16_0 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), arg_16_0._layer)

	arg_16_0._txtcurlevelnamecn.text = var_16_0.stageName
	arg_16_0._txtcurlevelnameen.text = var_16_0.stageNameEn

	local var_16_1 = Activity104Model.instance:getMaxLayer()
	local var_16_2 = Activity104Model.instance:getAct104CurLayer()

	if arg_16_0._layer <= 4 then
		for iter_16_0 = 1, 6 do
			local var_16_3 = gohelper.cloneInPlace(arg_16_0._golvitem)

			arg_16_0._showLvItems[iter_16_0] = Season3_0MarketShowLevelItem.New()

			arg_16_0._showLvItems[iter_16_0]:init(var_16_3, iter_16_0, var_16_2, var_16_1)
		end
	elseif arg_16_0._layer >= var_16_1 - 3 then
		for iter_16_1 = var_16_1 - 5, var_16_1 do
			local var_16_4 = gohelper.cloneInPlace(arg_16_0._golvitem)

			arg_16_0._showLvItems[iter_16_1] = Season3_0MarketShowLevelItem.New()

			arg_16_0._showLvItems[iter_16_1]:init(var_16_4, iter_16_1, var_16_2, var_16_1)
		end
	else
		for iter_16_2 = arg_16_0._layer - 4, arg_16_0._layer + 4 do
			local var_16_5 = gohelper.cloneInPlace(arg_16_0._golvitem)

			arg_16_0._showLvItems[iter_16_2] = Season3_0MarketShowLevelItem.New()

			arg_16_0._showLvItems[iter_16_2]:init(var_16_5, iter_16_2, var_16_2, var_16_1)
		end
	end

	TaskDispatcher.runDelay(arg_16_0._delayShowItem, arg_16_0, 0.1)
end

function var_0_0._delayShowItem(arg_17_0)
	local var_17_0 = arg_17_0._showLvItems[arg_17_0._layer]

	if var_17_0 then
		local var_17_1 = -(recthelper.getAnchorX(var_17_0.go.transform) - 105)

		recthelper.setAnchorX(arg_17_0._goScrollContent.transform, var_17_1)
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0._showLvItems) do
		iter_17_1:show()
	end

	arg_17_0._anilevel.speed = 1
end

function var_0_0._setStages(arg_18_0)
	local var_18_0 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), arg_18_0._layer)
	local var_18_1 = var_18_0.stage
	local var_18_2 = Activity104Model.instance:getMaxStage()

	for iter_18_0 = 1, 7 do
		arg_18_0:refreshLeftStage(arg_18_0["_gostageinfoitem" .. iter_18_0], iter_18_0, var_18_1, var_18_2, "#3E3E3D")
		arg_18_0:refreshLeftStage(arg_18_0["_gostagelvitem" .. iter_18_0], iter_18_0, var_18_1, var_18_2, "#C1C1C2")
	end

	arg_18_0._simagedecorate:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/b_chatu_%s.png", var_18_0.stagePicture)))
end

function var_0_0.refreshLeftStage(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	if gohelper.isNil(arg_19_1) then
		return
	end

	local var_19_0 = arg_19_2 == arg_19_4

	if arg_19_4 < arg_19_2 or var_19_0 and arg_19_3 < arg_19_2 then
		gohelper.setActive(arg_19_1, false)

		return
	end

	gohelper.setActive(arg_19_1, true)

	local var_19_1 = gohelper.findChild(arg_19_1, "light")
	local var_19_2 = gohelper.findChild(arg_19_1, "dark")
	local var_19_3 = arg_19_2 <= arg_19_3

	gohelper.setActive(var_19_1, var_19_3)
	gohelper.setActive(var_19_2, not var_19_3)

	if var_19_3 then
		local var_19_4 = var_19_0 and "#B83838" or arg_19_5
		local var_19_5 = gohelper.findChildImage(arg_19_1, "light")

		SLFramework.UGUI.GuiHelper.SetColor(var_19_5, var_19_4)
	end
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
	arg_21_0._simagestageicon:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/a_chatu_%s.png", var_21_0.stagePicture)))
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
			arg_22_0._rewardItems[1].itemIcon = Season3_0CelebrityCardItem.New()

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
			local var_25_3 = Activity104Model.instance:getMaxStage()

			arg_25_0:_showPartStageItem(var_25_2 + 1, var_25_3)
		end

		local var_25_4 = string.splitToNumber(var_25_0.unlockEquipIndex, "#")

		if #var_25_4 > 0 then
			gohelper.setActive(arg_25_0._gounlocktype1, var_25_4[1] < 5)
			gohelper.setActive(arg_25_0._gounlocktype2, var_25_4[1] > 4 and var_25_4[1] < 9)
			gohelper.setActive(arg_25_0._gounlocktype3, var_25_4[1] == 9)
		else
			gohelper.setActive(arg_25_0._gounlocktype1, false)
			gohelper.setActive(arg_25_0._gounlocktype2, false)
			gohelper.setActive(arg_25_0._gounlocktype3, false)
		end

		gohelper.setActive(arg_25_0._gopart, var_25_1 or #var_25_4 > 0)
		gohelper.setActive(arg_25_0._gopartempty, not var_25_1 and not (#var_25_4 > 0))
	end
end

var_0_0.UnLockStageItemAlpha = 1
var_0_0.LockStageItemAlpha = 0.3

function var_0_0._showPartStageItem(arg_26_0, arg_26_1, arg_26_2)
	for iter_26_0 = 1, 7 do
		if not arg_26_0._partStageItems[iter_26_0] then
			local var_26_0 = arg_26_0:getUserDataTb_()
			local var_26_1 = gohelper.cloneInPlace(arg_26_0._gostagelvlitem, "partstageitem_" .. tostring(iter_26_0))

			var_26_0.go = var_26_1
			var_26_0.current = gohelper.findChild(var_26_1, "current")
			var_26_0.next = gohelper.findChild(var_26_1, "next")
			var_26_0.canvasgroup = gohelper.onceAddComponent(var_26_1, typeof(UnityEngine.CanvasGroup))
			var_26_0.index = iter_26_0
			arg_26_0._partStageItems[iter_26_0] = var_26_0
		end

		arg_26_0:_refreshPartStage(arg_26_0._partStageItems[iter_26_0], arg_26_1, arg_26_2)
	end
end

function var_0_0._refreshPartStage(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_1.index
	local var_27_1 = var_27_0 == arg_27_3

	if arg_27_3 < var_27_0 or var_27_1 and arg_27_2 < var_27_0 then
		gohelper.setActive(arg_27_1.go, false)

		return
	end

	gohelper.setActive(arg_27_1.go, true)
	gohelper.setActive(arg_27_1.next, var_27_0 == arg_27_2)
	gohelper.setActive(arg_27_1.current, var_27_0 ~= arg_27_2)

	arg_27_1.canvasgroup.alpha = var_27_0 <= arg_27_2 and var_0_0.UnLockStageItemAlpha or var_0_0.LockStageItemAlpha
end

function var_0_0.updateLeftDesc(arg_28_0)
	if not arg_28_0.descItems then
		arg_28_0.descItems = {}
	end

	local var_28_0 = Activity104Model.instance:getAct104CurStage(Activity104Model.instance:getCurSeasonId(), arg_28_0._layer)
	local var_28_1 = Activity104Model.instance:getStageEpisodeList(var_28_0)

	arg_28_0._curDescItem = nil

	for iter_28_0 = 1, math.max(#var_28_1, #arg_28_0.descItems) do
		local var_28_2 = arg_28_0.descItems[iter_28_0]

		if not var_28_2 then
			var_28_2 = arg_28_0:createLeftDescItem(iter_28_0)
			arg_28_0.descItems[iter_28_0] = var_28_2
		end

		arg_28_0:updateLeftDescItem(var_28_2, var_28_1[iter_28_0])
	end

	gohelper.setActive(arg_28_0._goleftscrolltopmask, arg_28_0._curDescItem.index ~= 1)
	TaskDispatcher.runDelay(arg_28_0.moveToCurDesc, arg_28_0, 0.02)
end

function var_0_0.createLeftDescItem(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getUserDataTb_()

	var_29_0.index = arg_29_1
	var_29_0.go = gohelper.cloneInPlace(arg_29_0._goDescItem, "desc" .. arg_29_1)
	var_29_0.txt = gohelper.findChildTextMesh(var_29_0.go, "txt_desc")
	var_29_0.goLine = gohelper.findChild(var_29_0.go, "go_underline")

	return var_29_0
end

function var_0_0.updateLeftDescItem(arg_30_0, arg_30_1, arg_30_2)
	if not arg_30_2 then
		gohelper.setActive(arg_30_1.go, false)

		return
	end

	gohelper.setActive(arg_30_1.go, true)

	local var_30_0 = arg_30_2.desc

	if arg_30_2.layer == arg_30_0._layer then
		gohelper.setActive(arg_30_1.goLine, true)

		arg_30_1.txt.text = var_30_0
		arg_30_1.txt.lineSpacing = 49.75

		ZProj.UGUIHelper.SetColorAlpha(arg_30_1.txt, 1)

		arg_30_0._curDescItem = arg_30_1
	else
		gohelper.setActive(arg_30_1.goLine, false)

		arg_30_1.txt.text = var_30_0
		arg_30_1.txt.lineSpacing = -12.5

		ZProj.UGUIHelper.SetColorAlpha(arg_30_1.txt, 0.7)
	end
end

function var_0_0.moveToCurDesc(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.moveToCurDesc, arg_31_0)

	local var_31_0 = arg_31_0._curDescItem

	if not var_31_0 then
		return
	end

	local var_31_1 = var_31_0.txt.preferredHeight
	local var_31_2 = recthelper.getHeight(arg_31_0._descScroll.transform)
	local var_31_3 = math.max(0, recthelper.getHeight(arg_31_0._descContent.transform) - var_31_2)
	local var_31_4 = (var_31_2 - var_31_1) * 0.5
	local var_31_5 = recthelper.getAnchorY(var_31_0.go.transform) + var_31_4

	recthelper.setAnchorY(arg_31_0._descContent.transform, Mathf.Clamp(-var_31_5, 0, -var_31_5))
end

function var_0_0.onClose(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._delayShowInfo, arg_32_0)
end

function var_0_0.onDestroyView(arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._showInfoByOpen, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0.moveToCurDesc, arg_33_0)
	arg_33_0._simagestageicon:UnLoadImage()
	arg_33_0._simagepage:UnLoadImage()
	arg_33_0._simageuttu:UnLoadImage()
	arg_33_0._simageleftinfobg:UnLoadImage()
	arg_33_0._simagerightinfobg:UnLoadImage()

	if arg_33_0._showLvItems then
		for iter_33_0, iter_33_1 in pairs(arg_33_0._showLvItems) do
			iter_33_1:destroy()
		end

		arg_33_0._showLvItems = nil
	end
end

return var_0_0
