module("modules.logic.story.view.StoryNavigateItem", package.seeall)

local var_0_0 = class("StoryNavigateItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._gobg = gohelper.findChild(arg_1_1, "bg")
	arg_1_0._goepisode = gohelper.findChild(arg_1_1, "#go_episode")
	arg_1_0._goepisodevideo = gohelper.findChild(arg_1_1, "#go_episode/#go_episodevideo")
	arg_1_0._goepisodeicon = gohelper.findChild(arg_1_1, "#go_episode/#go_episodeicon")
	arg_1_0._txtepisode = gohelper.findChildText(arg_1_1, "#go_episode/#txt_episode")
	arg_1_0._txtepisodeEn = gohelper.findChildText(arg_1_1, "#go_episode/#txt_episodeEn")
	arg_1_0._txtepisodeNum = gohelper.findChildText(arg_1_1, "#go_episode/#txt_episodeNum")
	arg_1_0._gochapter = gohelper.findChild(arg_1_1, "#go_chapter")
	arg_1_0._goopen = gohelper.findChild(arg_1_1, "#go_chapter/#go_open")
	arg_1_0._gochapteropenvideo = gohelper.findChild(arg_1_1, "#go_chapter/#go_open/#go_chapteropenvideo")
	arg_1_0._txtchapterName = gohelper.findChildText(arg_1_1, "#go_chapter/#go_open/#txt_chapterName")
	arg_1_0._txtchapterNameEn = gohelper.findChildText(arg_1_1, "#go_chapter/#go_open/#txt_chapterNameEn")
	arg_1_0._txtchapterNum = gohelper.findChildText(arg_1_1, "#go_chapter/#go_open/#txt_chapterNum")
	arg_1_0._goclose = gohelper.findChild(arg_1_1, "#go_chapter/#go_close")
	arg_1_0._gochapterclosevideo = gohelper.findChild(arg_1_1, "#go_chapter/#go_close/#go_chapterclosevideo")
	arg_1_0._txtchaptercloseNum = gohelper.findChildText(arg_1_1, "#go_chapter/#go_close/icon/#txt_chaptercloseNum")
	arg_1_0._gomap = gohelper.findChild(arg_1_1, "#go_map")
	arg_1_0._txtmapname = gohelper.findChildText(arg_1_1, "#go_map/#txt_mapname")
	arg_1_0._txtmapnameen = gohelper.findChildText(arg_1_1, "#go_map/#txt_mapnameen")
	arg_1_0._mapAnimator = arg_1_0._gomap:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goActivityChapter = gohelper.findChild(arg_1_1, "#go_activity_chapter")
	arg_1_0._gostorm = gohelper.findChild(arg_1_1, "#go_storm")
	arg_1_0._stormAnim = arg_1_0._gostorm:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtTimeNum1 = gohelper.findChildText(arg_1_1, "#go_storm/txt_Time2/txt_TimeNum1")
	arg_1_0._txtTimeNum2 = gohelper.findChildText(arg_1_1, "#go_storm/txt_Time2/txt_TimeNum2")
	arg_1_0._txtTimeEn1 = gohelper.findChildText(arg_1_1, "#go_storm/#txt_TimeEn")
	arg_1_0._txtTimeEn2 = gohelper.findChildText(arg_1_1, "#go_storm/#txt_TimeEn1")
	arg_1_0._showFunc = {
		[StoryEnum.NavigateType.Map] = arg_1_0.showMap,
		[StoryEnum.NavigateType.Episode] = arg_1_0.showEpisode,
		[StoryEnum.NavigateType.ChapterStart] = arg_1_0.showChapterStart,
		[StoryEnum.NavigateType.ChapterEnd] = arg_1_0.showChapterEnd,
		[StoryEnum.NavigateType.ActivityStart] = arg_1_0.showActivityChapterStart,
		[StoryEnum.NavigateType.ActivityEnd] = arg_1_0.showActivityChapterEnd,
		[StoryEnum.NavigateType.RoleStoryStart] = arg_1_0.showRoleStoryStart,
		[StoryEnum.NavigateType.StormDeadline] = arg_1_0.showStormDeadline
	}
end

function var_0_0.show(arg_2_0, arg_2_1)
	arg_2_0:clear()

	arg_2_0._navigateCo = arg_2_1

	for iter_2_0, iter_2_1 in pairs(arg_2_0._navigateCo) do
		arg_2_0:showNavigate(iter_2_1.navigateType, iter_2_1)
	end
end

function var_0_0.showNavigate(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._showFunc[arg_3_1]

	if not var_3_0 then
		return
	end

	var_3_0(arg_3_0, arg_3_2)
end

function var_0_0.showMap(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._gomap, true)

	arg_4_0._txtmapname.text = tonumber(arg_4_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) and luaLang(arg_4_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) or arg_4_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	arg_4_0._txtmapnameen.text = arg_4_1.navigateTxts[LanguageEnum.LanguageStoryType.EN]

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Story_Map_In)
	arg_4_0._mapAnimator:Play("go_mapname_in")
	TaskDispatcher.cancelTask(arg_4_0._mapOut, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._mapOut, arg_4_0, 3)
end

function var_0_0._mapOut(arg_5_0)
	arg_5_0._mapAnimator:Play("go_mapname_out")
	TaskDispatcher.cancelTask(arg_5_0._mapOut, arg_5_0)
end

function var_0_0.showEpisode(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goepisode, true)

	if arg_6_0._episodeIconLoader then
		arg_6_0._episodeIconLoader:dispose()

		arg_6_0._episodeIconLoader = nil

		SLFramework.GameObjectHelper.DestroyAllChildren(arg_6_0._iconGo)
	end

	if arg_6_0._episodeVideoPlayer then
		arg_6_0._episodeVideoPlayer:Stop()
		arg_6_0._episodeVideoPlayer:Clear()

		arg_6_0._episodeVideoPlayer = nil
	end

	if gohelper.isNil(arg_6_0._episodeVideoGO) then
		local var_6_0, var_6_1, var_6_2 = AvProMgr.instance:getVideoPlayer(arg_6_0._goepisodevideo)

		arg_6_0._episodeVideoGO = var_6_2
	end

	if SettingsModel.instance:getVideoEnabled() == false then
		arg_6_0._episodeVideoPlayer = AvProUGUIPlayer_adjust.instance

		arg_6_0._episodeVideoPlayer:Play()
	else
		arg_6_0._episodeDisplayUGUI = gohelper.onceAddComponent(arg_6_0._episodeVideoGO, AvProMgr.Type_DisplayUGUI)
		arg_6_0._episodeDisplayUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
		arg_6_0._episodeVideoPlayer = gohelper.onceAddComponent(arg_6_0._episodeVideoGO, AvProMgr.Type_AvProUGUIPlayer)

		arg_6_0._episodeVideoPlayer:Play(arg_6_0._episodeDisplayUGUI, langVideoUrl("story_rian_bg"), true, nil, nil)
	end

	arg_6_0._episodeIconLoader = PrefabInstantiate.Create(arg_6_0._goepisodeicon)

	arg_6_0._episodeIconLoader:startLoad(ResUrl.getStoryEpisodeIcon(arg_6_1.navigateLogo), function(arg_7_0)
		arg_6_0._iconGo = arg_7_0:getInstGO()
	end)

	arg_6_0._txtepisode.text = tonumber(arg_6_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) and luaLang(arg_6_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) or arg_6_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	arg_6_0._txtepisodeEn.text = arg_6_1.navigateTxts[LanguageEnum.LanguageStoryType.EN]
	arg_6_0._txtepisodeNum.text = arg_6_1.navigateChapterEn

	TaskDispatcher.cancelTask(arg_6_0._episodeOut, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._episodeOut, arg_6_0, 5.667)
end

function var_0_0._episodeOut(arg_8_0)
	gohelper.setActive(arg_8_0._goepisode, false)
	TaskDispatcher.cancelTask(arg_8_0._episodeOut, arg_8_0)
end

function var_0_0.showChapterStart(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._gochapter, true)
	gohelper.setActive(arg_9_0._goopen, true)
	gohelper.setActive(arg_9_0._goclose, false)

	arg_9_0._txtchapterName.text = arg_9_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	arg_9_0._txtchapterNameEn.text = arg_9_1.navigateTxts[LanguageEnum.LanguageStoryType.EN]
	arg_9_0._txtchapterNum.text = arg_9_1.navigateChapterEn

	if arg_9_0._chapterOpenVideoPlayer then
		arg_9_0._chapterOpenVideoPlayer:Stop()
		arg_9_0._chapterOpenVideoPlayer:Clear()

		arg_9_0._chapterOpenVideoPlayer = nil
	end

	if gohelper.isNil(arg_9_0._chapterOpenVideoGO) then
		local var_9_0, var_9_1, var_9_2 = AvProMgr.instance:getVideoPlayer(arg_9_0._gochapteropenvideo)

		arg_9_0._chapterOpenVideoGO = var_9_2
	end

	arg_9_0._chapterOpenDisplayUGUI = gohelper.onceAddComponent(arg_9_0._chapterOpenVideoGO, AvProMgr.Type_DisplayUGUI)
	arg_9_0._chapterOpenDisplayUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
	arg_9_0._chapterOpenVideoPlayer = gohelper.onceAddComponent(arg_9_0._chapterOpenVideoGO, AvProMgr.Type_AvProUGUIPlayer)

	arg_9_0._chapterOpenVideoPlayer:Play(arg_9_0._chapterOpenDisplayUGUI, langVideoUrl("story_rian_bg"), true, nil, nil)
	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
	TaskDispatcher.cancelTask(arg_9_0._chapterStartOut, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0._chapterStartOut, arg_9_0, 5.333)
end

function var_0_0._chapterStartOut(arg_10_0)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	gohelper.setActive(arg_10_0._goopen, false)
	TaskDispatcher.cancelTask(arg_10_0._chapterStartOut, arg_10_0)
end

function var_0_0.showChapterEnd(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goepisode, false)
	gohelper.setActive(arg_11_0._gochapter, true)
	gohelper.setActive(arg_11_0._goclose, true)
	gohelper.setActive(arg_11_0._goopen, false)

	local var_11_0 = arg_11_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	if var_11_0 == "" then
		var_11_0 = arg_11_1.navigateChapterEn
	end

	arg_11_0._txtchaptercloseNum.text = var_11_0

	if arg_11_0._chapterCloseVideoPlayer then
		arg_11_0._chapterCloseVideoPlayer:Stop()
		arg_11_0._chapterCloseVideoPlayer:Clear()

		arg_11_0._chapterCloseVideoPlayer = nil
	end

	if gohelper.isNil(arg_11_0._chapterCloseVideoGO) then
		local var_11_1, var_11_2, var_11_3 = AvProMgr.instance:getVideoPlayer(arg_11_0._gochapterclosevideo)

		arg_11_0._chapterCloseVideoGO = var_11_3
	end

	arg_11_0._chapterCloseDisplayUGUI = gohelper.onceAddComponent(arg_11_0._chapterCloseVideoGO, AvProMgr.Type_DisplayUGUI)
	arg_11_0._chapterCloseDisplayUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
	arg_11_0._chapterCloseVideoPlayer = gohelper.onceAddComponent(arg_11_0._chapterCloseVideoGO, AvProMgr.Type_AvProUGUIPlayer)

	arg_11_0._chapterCloseVideoPlayer:Play(arg_11_0._chapterCloseDisplayUGUI, langVideoUrl("story_rian_bg"), true, nil, nil)
	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_End)
	TaskDispatcher.cancelTask(arg_11_0._chapterEndOut, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0._chapterEndOut, arg_11_0, 3.2)
end

function var_0_0._chapterEndOut(arg_12_0)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_End)
	TaskDispatcher.cancelTask(arg_12_0._chapterEndOut, arg_12_0)
end

function var_0_0.showActivityChapterStart(arg_13_0, arg_13_1)
	if not arg_13_0.activityChapterPlayer then
		arg_13_0.activityChapterPlayer = StoryActivityChapterPlayer.New(arg_13_0._goActivityChapter)
	end

	arg_13_0.activityChapterPlayer:playStart(arg_13_1)
end

function var_0_0.showActivityChapterEnd(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._gobg, true)

	if not arg_14_0.activityChapterPlayer then
		arg_14_0.activityChapterPlayer = StoryActivityChapterPlayer.New(arg_14_0._goActivityChapter)
	end

	arg_14_0.activityChapterPlayer:playEnd(arg_14_1)
end

function var_0_0.showRoleStoryStart(arg_15_0, arg_15_1)
	if not arg_15_0.activityChapterPlayer then
		arg_15_0.activityChapterPlayer = StoryActivityChapterPlayer.New(arg_15_0._goActivityChapter)
	end

	arg_15_0.activityChapterPlayer:playRoleStoryStart(arg_15_1)
end

function var_0_0.showStormDeadline(arg_16_0, arg_16_1)
	AudioMgr.instance:trigger(AudioEnum.Story.Play_Storm_Deadline)

	local var_16_0 = string.splitToNumber(arg_16_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "#")

	gohelper.setActive(arg_16_0._gostorm, true)
	arg_16_0._stormAnim:Play("open", 0, 0)

	arg_16_0._txtTimeNum1.text = var_16_0[1]
	arg_16_0._txtTimeNum2.text = var_16_0[1] - var_16_0[2]

	local var_16_1 = "%s HOURS\nBEFORE THE STORM"

	arg_16_0._txtTimeEn1.text = string.format(var_16_1, var_16_0[1])
	arg_16_0._txtTimeEn2.text = string.format(var_16_1, var_16_0[1] - var_16_0[2])
end

function var_0_0.clear(arg_17_0)
	if arg_17_0.activityChapterPlayer then
		arg_17_0.activityChapterPlayer:hide()
	end

	gohelper.setActive(arg_17_0._goepisode, false)
	gohelper.setActive(arg_17_0._gochapter, false)
	gohelper.setActive(arg_17_0._gomap, false)
	gohelper.setActive(arg_17_0._gobg, false)
end

function var_0_0.destroy(arg_18_0)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_End)
	TaskDispatcher.cancelTask(arg_18_0._mapOut, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._episodeOut, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._chapterStartOut, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._chapterEndOut, arg_18_0)

	if arg_18_0._episodeIconLoader then
		arg_18_0._episodeIconLoader:dispose()

		arg_18_0._episodeIconLoader = nil

		SLFramework.GameObjectHelper.DestroyAllChildren(arg_18_0._iconGo)
	end

	if arg_18_0._episodeVideoPlayer then
		if not BootNativeUtil.isIOS() then
			arg_18_0._episodeVideoPlayer:Stop()
		end

		arg_18_0._episodeVideoPlayer:Clear()

		arg_18_0._episodeVideoPlayer = nil
	end

	if arg_18_0._episodeVideoGO then
		gohelper.destroy(arg_18_0._episodeVideoGO)

		arg_18_0._episodeVideoGO = nil
	end

	if arg_18_0._chapterOpenVideoPlayer then
		if not BootNativeUtil.isIOS() then
			arg_18_0._chapterOpenVideoPlayer:Stop()
		end

		arg_18_0._chapterOpenVideoPlayer:Clear()

		arg_18_0._chapterOpenVideoPlayer = nil
	end

	if arg_18_0._chapterOpenVideoGO then
		gohelper.destroy(arg_18_0._chapterOpenVideoGO)

		arg_18_0._chapterOpenVideoGO = nil
	end

	if arg_18_0._chapterCloseVideoPlayer then
		if not BootNativeUtil.isIOS() then
			arg_18_0._chapterCloseVideoPlayer:Stop()
		end

		arg_18_0._chapterCloseVideoPlayer:Clear()

		arg_18_0._chapterCloseVideoPlayer = nil
	end

	if arg_18_0._chapterCloseVideoGO then
		gohelper.destroy(arg_18_0._chapterCloseVideoGO)

		arg_18_0._chapterCloseVideoGO = nil
	end

	if arg_18_0._mapLoader then
		arg_18_0._mapLoader:dispose()

		arg_18_0._mapLoader = nil
	end

	if arg_18_0.activityChapterPlayer then
		arg_18_0.activityChapterPlayer:dispose()

		arg_18_0.activityChapterPlayer = nil
	end

	gohelper.setActive(arg_18_0._go, false)
end

return var_0_0
