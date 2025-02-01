module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapLevelView", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapLevelView", VersionActivity1_2DungeonMapLevelBaseView)

function slot0.onInitView(slot0)
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._simageactivitynormalbg = gohelper.findChildSingleImage(slot0.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	slot0._simageactivityhardbg = gohelper.findChildSingleImage(slot0.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	slot0._txtmapName = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	slot0._txtmapNameEn = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	slot0._txtmapNum = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	slot0._imagestar1 = gohelper.findChildImage(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/#image_star1")
	slot0._imagestar2 = gohelper.findChildImage(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/#image_star2")
	slot0._goswitch = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch")
	slot0._gotype1 = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	slot0._gotype2 = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	slot0._gotype3 = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	slot0._gotype4 = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	slot0._golock = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_lock")
	slot0._lockAni = gohelper.onceAddComponent(slot0._golock, typeof(UnityEngine.Animator))
	slot0._btnleftarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	slot0._btnrightarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	slot0._txtactivitydesc = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	slot0._gorecommond = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/recommend")
	slot0._txtrecommondlv = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/content/recommend/#txt_recommendlv")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/rewards")
	slot0._goactivityrewarditem = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/rewards/rewardList/#go_activityrewarditem")
	slot0._btnactivityreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/rewards/#btn_activityreward")
	slot0._gonorewards = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/#go_norewards")
	slot0._gonormalStartnode = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/node")
	slot0._btnnormalStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	slot0._txtusepowernormal = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/node/#txt_usepowernormal")
	slot0._txtnorstarttext = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	slot0._simagepower = gohelper.findChildSingleImage(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/node/#simage_power")
	slot0._btnnormalStart2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2")
	slot0._txtusepowernormal2 = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2/#txt_usepowernormal2")
	slot0._txtnorstarttext2 = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2/#txt_norstarttext2")
	slot0._simagepower2 = gohelper.findChildSingleImage(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart2/#simage_power2")
	slot0._btnhardStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	slot0._btnreplayStory = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_reviewcg")
	slot0._txtusepowerhard = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "anim/#go_righttop")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "anim/#go_lefttop")
	slot0._goruledesc = gohelper.findChild(slot0.viewGO, "anim/#go_ruledesc")
	slot0._btncloserule = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/#go_ruledesc/#btn_closerule")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "anim/#go_ruledesc/bg/#go_ruleitem")
	slot0._goruleDescList = gohelper.findChild(slot0.viewGO, "anim/#go_ruledesc/bg/#go_ruleDescList")
	slot0._gotraptip = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/#go_tip/#go_traptip")
	slot0._txtchapterindex = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_chapterindex")
	slot0._simagepowerhard = gohelper.findChildSingleImage(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#image_powerhard")
	slot0._txtlock = gohelper.findChildText(slot0._golock, "txt")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
	slot0._btnleftarrow:AddClickListener(slot0._btnleftarrowOnClick, slot0)
	slot0._btnrightarrow:AddClickListener(slot0._btnrightarrowOnClick, slot0)
	slot0._btnactivityreward:AddClickListener(slot0._btnactivityrewardOnClick, slot0)
	slot0._btnnormalStart:AddClickListener(slot0._btnnormalStartOnClick, slot0)
	slot0._btnnormalStart2:AddClickListener(slot0._btnnormalStartOnClick, slot0)
	slot0._btnhardStart:AddClickListener(slot0._btnhardStartOnClick, slot0)
	slot0._btnreplayStory:AddClickListener(slot0._btnreplayStoryOnClick, slot0)
	slot0._btncloserule:AddClickListener(slot0._btncloseruleOnClick, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseview:RemoveClickListener()
	slot0._btnleftarrow:RemoveClickListener()
	slot0._btnrightarrow:RemoveClickListener()
	slot0._btnactivityreward:RemoveClickListener()
	slot0._btnnormalStart:RemoveClickListener()
	slot0._btnnormalStart2:RemoveClickListener()
	slot0._btnhardStart:RemoveClickListener()
	slot0._btnreplayStory:RemoveClickListener()
	slot0._btncloserule:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0._simagepowerhard:LoadImage(ResUrl.getCurrencyItemIcon("204"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	uv0.super.onOpen(slot0)
	gohelper.setActive(slot0._gotraptip, VersionActivity1_2DungeonModel.instance:getTrapPutting())

	slot0._txtchapterindex.text = slot0._chapterConfig.chapterIndex .. "."
end

function slot0._btnreplayStoryOnClick(slot0)
	if not slot0.storyIdList or #slot0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(slot0.storyIdList)
end

function slot0.refreshStar(slot0)
	if not slot0.showEpisodeMo then
		return
	end

	slot1 = slot0.showEpisodeCo.id
	slot2 = DungeonConfig.instance:getEpisodeAdvancedConditionText(slot1)
	slot3 = DungeonModel.instance:getEpisodeInfo(slot1)
	slot7 = nil

	if slot0:isDungeonHardModel() then
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot0._imagestar1, "juqing_xing1_kn")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot0._imagestar2, "juqing_xing2_kn")

		slot7 = "#e43938"
	else
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot4, "juqing_xing1")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot5, "juqing_xing2")

		if slot0._cur_select_index == 1 then
			slot7 = "#e4b472"
		elseif slot0._cur_select_index == 2 then
			slot7 = "#e7853d"
		elseif slot0._cur_select_index == 3 then
			slot7 = "#ef3939"
		end
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot4, DungeonModel.instance:hasPassLevelAndStory(slot1) and slot7 or "#949494")

	if string.nilorempty(slot2) then
		gohelper.setActive(slot5.gameObject, false)
	else
		gohelper.setActive(slot5.gameObject, true)
		SLFramework.UGUI.GuiHelper.SetColor(slot5, slot9 and slot3 and DungeonEnum.StarType.Advanced <= slot3.star and slot7 or slot8)
	end
end

function slot0.isDungeonHardModel(slot0)
	return VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[slot0.showEpisodeCo.chapterId] == VersionActivity1_2DungeonEnum.DungeonMode.Hard
end

function slot0._onCurrencyChange(slot0)
	slot0:refreshStartBtn()
end

function slot0.refreshMode(slot0)
	uv0.super.refreshMode(slot0)

	slot0._txtlock.text = luaLang("p_versionactivitydungeonmaplevelview_type" .. (slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and 4 or slot0._cur_select_index))
end

return slot0
