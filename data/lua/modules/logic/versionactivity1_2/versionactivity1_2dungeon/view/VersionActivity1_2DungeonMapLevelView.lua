module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapLevelView", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapLevelView", VersionActivity1_2DungeonMapLevelBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._simageactivitynormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	arg_1_0._simageactivityhardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	arg_1_0._txtmapName = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	arg_1_0._txtmapNameEn = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	arg_1_0._txtmapNum = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	arg_1_0._imagestar1 = gohelper.findChildImage(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/#image_star1")
	arg_1_0._imagestar2 = gohelper.findChildImage(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/#image_star2")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch")
	arg_1_0._gotype1 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	arg_1_0._gotype2 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	arg_1_0._gotype3 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	arg_1_0._gotype4 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_lock")
	arg_1_0._lockAni = gohelper.onceAddComponent(arg_1_0._golock, typeof(UnityEngine.Animator))
	arg_1_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	arg_1_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	arg_1_0._txtactivitydesc = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	arg_1_0._gorecommond = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/recommend")
	arg_1_0._txtrecommondlv = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/content/recommend/#txt_recommendlv")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/rewards")
	arg_1_0._goactivityrewarditem = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/rewards/rewardList/#go_activityrewarditem")
	arg_1_0._btnactivityreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/rewards/#btn_activityreward")
	arg_1_0._gonorewards = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_norewards")
	arg_1_0._gonormalStartnode = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/node")
	arg_1_0._btnnormalStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	arg_1_0._txtusepowernormal = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/node/#txt_usepowernormal")
	arg_1_0._txtnorstarttext = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	arg_1_0._simagepower = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/node/#simage_power")
	arg_1_0._btnnormalStart2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2")
	arg_1_0._txtusepowernormal2 = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2/#txt_usepowernormal2")
	arg_1_0._txtnorstarttext2 = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2/#txt_norstarttext2")
	arg_1_0._simagepower2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2/#simage_power2")
	arg_1_0._btnhardStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	arg_1_0._btnreplayStory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_reviewcg")
	arg_1_0._txtusepowerhard = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_righttop")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_lefttop")
	arg_1_0._goruledesc = gohelper.findChild(arg_1_0.viewGO, "anim/#go_ruledesc")
	arg_1_0._btncloserule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#go_ruledesc/#btn_closerule")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "anim/#go_ruledesc/bg/#go_ruleitem")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0.viewGO, "anim/#go_ruledesc/bg/#go_ruleDescList")
	arg_1_0._gotraptip = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_tip/#go_traptip")
	arg_1_0._txtchapterindex = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_chapterindex")
	arg_1_0._simagepowerhard = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#image_powerhard")
	arg_1_0._txtlock = gohelper.findChildText(arg_1_0._golock, "txt")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnleftarrow:AddClickListener(arg_2_0._btnleftarrowOnClick, arg_2_0)
	arg_2_0._btnrightarrow:AddClickListener(arg_2_0._btnrightarrowOnClick, arg_2_0)
	arg_2_0._btnactivityreward:AddClickListener(arg_2_0._btnactivityrewardOnClick, arg_2_0)
	arg_2_0._btnnormalStart:AddClickListener(arg_2_0._btnnormalStartOnClick, arg_2_0)
	arg_2_0._btnnormalStart2:AddClickListener(arg_2_0._btnnormalStartOnClick, arg_2_0)
	arg_2_0._btnhardStart:AddClickListener(arg_2_0._btnhardStartOnClick, arg_2_0)
	arg_2_0._btnreplayStory:AddClickListener(arg_2_0._btnreplayStoryOnClick, arg_2_0)
	arg_2_0._btncloserule:AddClickListener(arg_2_0._btncloseruleOnClick, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnleftarrow:RemoveClickListener()
	arg_3_0._btnrightarrow:RemoveClickListener()
	arg_3_0._btnactivityreward:RemoveClickListener()
	arg_3_0._btnnormalStart:RemoveClickListener()
	arg_3_0._btnnormalStart2:RemoveClickListener()
	arg_3_0._btnhardStart:RemoveClickListener()
	arg_3_0._btnreplayStory:RemoveClickListener()
	arg_3_0._btncloserule:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._simagepowerhard:LoadImage(ResUrl.getCurrencyItemIcon("204"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	var_0_0.super.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._gotraptip, VersionActivity1_2DungeonModel.instance:getTrapPutting())

	arg_4_0._txtchapterindex.text = arg_4_0._chapterConfig.chapterIndex .. "."
end

function var_0_0._btnreplayStoryOnClick(arg_5_0)
	if not arg_5_0.storyIdList or #arg_5_0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(arg_5_0.storyIdList)
end

function var_0_0.refreshStar(arg_6_0)
	if not arg_6_0.showEpisodeMo then
		return
	end

	local var_6_0 = arg_6_0.showEpisodeCo.id
	local var_6_1 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_6_0)
	local var_6_2 = DungeonModel.instance:getEpisodeInfo(var_6_0)
	local var_6_3 = arg_6_0._imagestar1
	local var_6_4 = arg_6_0._imagestar2
	local var_6_5 = arg_6_0:isDungeonHardModel()
	local var_6_6

	if var_6_5 then
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(var_6_3, "juqing_xing1_kn")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(var_6_4, "juqing_xing2_kn")

		var_6_6 = "#e43938"
	else
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(var_6_3, "juqing_xing1")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(var_6_4, "juqing_xing2")

		if arg_6_0._cur_select_index == 1 then
			var_6_6 = "#e4b472"
		elseif arg_6_0._cur_select_index == 2 then
			var_6_6 = "#e7853d"
		elseif arg_6_0._cur_select_index == 3 then
			var_6_6 = "#ef3939"
		end
	end

	local var_6_7 = "#949494"
	local var_6_8 = DungeonModel.instance:hasPassLevelAndStory(var_6_0)

	SLFramework.UGUI.GuiHelper.SetColor(var_6_3, var_6_8 and var_6_6 or var_6_7)

	if string.nilorempty(var_6_1) then
		gohelper.setActive(var_6_4.gameObject, false)
	else
		gohelper.setActive(var_6_4.gameObject, true)
		SLFramework.UGUI.GuiHelper.SetColor(var_6_4, var_6_8 and var_6_2 and var_6_2.star >= DungeonEnum.StarType.Advanced and var_6_6 or var_6_7)
	end
end

function var_0_0.isDungeonHardModel(arg_7_0)
	return VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[arg_7_0.showEpisodeCo.chapterId] == VersionActivity1_2DungeonEnum.DungeonMode.Hard
end

function var_0_0._onCurrencyChange(arg_8_0)
	arg_8_0:refreshStartBtn()
end

function var_0_0.refreshMode(arg_9_0)
	var_0_0.super.refreshMode(arg_9_0)

	local var_9_0 = arg_9_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and 4 or arg_9_0._cur_select_index

	arg_9_0._txtlock.text = luaLang("p_versionactivitydungeonmaplevelview_type" .. var_9_0)
end

return var_0_0
