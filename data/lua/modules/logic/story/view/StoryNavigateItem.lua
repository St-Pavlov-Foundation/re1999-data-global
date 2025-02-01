module("modules.logic.story.view.StoryNavigateItem", package.seeall)

slot0 = class("StoryNavigateItem")

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._gobg = gohelper.findChild(slot1, "bg")
	slot0._goepisode = gohelper.findChild(slot1, "#go_episode")
	slot0._goepisodevideo = gohelper.findChild(slot1, "#go_episode/#go_episodevideo")
	slot0._goepisodeicon = gohelper.findChild(slot1, "#go_episode/#go_episodeicon")
	slot0._txtepisode = gohelper.findChildText(slot1, "#go_episode/#txt_episode")
	slot0._txtepisodeEn = gohelper.findChildText(slot1, "#go_episode/#txt_episodeEn")
	slot0._txtepisodeNum = gohelper.findChildText(slot1, "#go_episode/#txt_episodeNum")
	slot0._gochapter = gohelper.findChild(slot1, "#go_chapter")
	slot0._goopen = gohelper.findChild(slot1, "#go_chapter/#go_open")
	slot0._gochapteropenvideo = gohelper.findChild(slot1, "#go_chapter/#go_open/#go_chapteropenvideo")
	slot0._txtchapterName = gohelper.findChildText(slot1, "#go_chapter/#go_open/#txt_chapterName")
	slot0._txtchapterNameEn = gohelper.findChildText(slot1, "#go_chapter/#go_open/#txt_chapterNameEn")
	slot0._txtchapterNum = gohelper.findChildText(slot1, "#go_chapter/#go_open/#txt_chapterNum")
	slot0._goclose = gohelper.findChild(slot1, "#go_chapter/#go_close")
	slot0._gochapterclosevideo = gohelper.findChild(slot1, "#go_chapter/#go_close/#go_chapterclosevideo")
	slot0._txtchaptercloseNum = gohelper.findChildText(slot1, "#go_chapter/#go_close/icon/#txt_chaptercloseNum")
	slot0._gomap = gohelper.findChild(slot1, "#go_map")
	slot0._txtmapname = gohelper.findChildText(slot1, "#go_map/#txt_mapname")
	slot0._txtmapnameen = gohelper.findChildText(slot1, "#go_map/#txt_mapnameen")
	slot0._mapAnimator = slot0._gomap:GetComponent(typeof(UnityEngine.Animator))
	slot0._goActivityChapter = gohelper.findChild(slot1, "#go_activity_chapter")
	slot0._gostorm = gohelper.findChild(slot1, "#go_storm")
	slot0._stormAnim = slot0._gostorm:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtTimeNum1 = gohelper.findChildText(slot1, "#go_storm/txt_Time2/txt_TimeNum1")
	slot0._txtTimeNum2 = gohelper.findChildText(slot1, "#go_storm/txt_Time2/txt_TimeNum2")
	slot0._txtTimeEn1 = gohelper.findChildText(slot1, "#go_storm/#txt_TimeEn")
	slot0._txtTimeEn2 = gohelper.findChildText(slot1, "#go_storm/#txt_TimeEn1")
	slot0._showFunc = {
		[StoryEnum.NavigateType.Map] = slot0.showMap,
		[StoryEnum.NavigateType.Episode] = slot0.showEpisode,
		[StoryEnum.NavigateType.ChapterStart] = slot0.showChapterStart,
		[StoryEnum.NavigateType.ChapterEnd] = slot0.showChapterEnd,
		[StoryEnum.NavigateType.ActivityStart] = slot0.showActivityChapterStart,
		[StoryEnum.NavigateType.ActivityEnd] = slot0.showActivityChapterEnd,
		[StoryEnum.NavigateType.RoleStoryStart] = slot0.showRoleStoryStart,
		[StoryEnum.NavigateType.StormDeadline] = slot0.showStormDeadline
	}
end

function slot0.show(slot0, slot1)
	slot0:clear()

	slot0._navigateCo = slot1

	for slot5, slot6 in pairs(slot0._navigateCo) do
		slot0:showNavigate(slot6.navigateType, slot6)
	end
end

function slot0.showNavigate(slot0, slot1, slot2)
	if not slot0._showFunc[slot1] then
		return
	end

	slot3(slot0, slot2)
end

function slot0.showMap(slot0, slot1)
	gohelper.setActive(slot0._gomap, true)

	slot0._txtmapname.text = tonumber(slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) and luaLang(slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) or slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	slot0._txtmapnameen.text = slot1.navigateTxts[LanguageEnum.LanguageStoryType.EN]

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Story_Map_In)
	slot0._mapAnimator:Play("go_mapname_in")
	TaskDispatcher.cancelTask(slot0._mapOut, slot0)
	TaskDispatcher.runDelay(slot0._mapOut, slot0, 3)
end

function slot0._mapOut(slot0)
	slot0._mapAnimator:Play("go_mapname_out")
	TaskDispatcher.cancelTask(slot0._mapOut, slot0)
end

function slot0.showEpisode(slot0, slot1)
	gohelper.setActive(slot0._goepisode, true)

	if slot0._episodeIconLoader then
		slot0._episodeIconLoader:dispose()

		slot0._episodeIconLoader = nil

		SLFramework.GameObjectHelper.DestroyAllChildren(slot0._iconGo)
	end

	if slot0._episodeVideoPlayer then
		slot0._episodeVideoPlayer:Stop()
		slot0._episodeVideoPlayer:Clear()

		slot0._episodeVideoPlayer = nil
	end

	if gohelper.isNil(slot0._episodeVideoGO) then
		slot2, slot3, slot0._episodeVideoGO = AvProMgr.instance:getVideoPlayer(slot0._goepisodevideo)
	end

	if SettingsModel.instance:getVideoEnabled() == false then
		slot0._episodeVideoPlayer = AvProUGUIPlayer_adjust.instance

		slot0._episodeVideoPlayer:Play()
	else
		slot0._episodeDisplayUGUI = gohelper.onceAddComponent(slot0._episodeVideoGO, AvProMgr.Type_DisplayUGUI)
		slot0._episodeDisplayUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
		slot0._episodeVideoPlayer = gohelper.onceAddComponent(slot0._episodeVideoGO, AvProMgr.Type_AvProUGUIPlayer)

		slot0._episodeVideoPlayer:Play(slot0._episodeDisplayUGUI, langVideoUrl("story_rian_bg"), true, nil, )
	end

	slot0._episodeIconLoader = PrefabInstantiate.Create(slot0._goepisodeicon)

	slot0._episodeIconLoader:startLoad(ResUrl.getStoryEpisodeIcon(slot1.navigateLogo), function (slot0)
		uv0._iconGo = slot0:getInstGO()
	end)

	slot0._txtepisode.text = tonumber(slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) and luaLang(slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) or slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	slot0._txtepisodeEn.text = slot1.navigateTxts[LanguageEnum.LanguageStoryType.EN]
	slot0._txtepisodeNum.text = slot1.navigateChapterEn

	TaskDispatcher.cancelTask(slot0._episodeOut, slot0)
	TaskDispatcher.runDelay(slot0._episodeOut, slot0, 5.667)
end

function slot0._episodeOut(slot0)
	gohelper.setActive(slot0._goepisode, false)
	TaskDispatcher.cancelTask(slot0._episodeOut, slot0)
end

function slot0.showChapterStart(slot0, slot1)
	gohelper.setActive(slot0._gochapter, true)
	gohelper.setActive(slot0._goopen, true)
	gohelper.setActive(slot0._goclose, false)

	slot0._txtchapterName.text = slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	slot0._txtchapterNameEn.text = slot1.navigateTxts[LanguageEnum.LanguageStoryType.EN]
	slot0._txtchapterNum.text = slot1.navigateChapterEn

	if slot0._chapterOpenVideoPlayer then
		slot0._chapterOpenVideoPlayer:Stop()
		slot0._chapterOpenVideoPlayer:Clear()

		slot0._chapterOpenVideoPlayer = nil
	end

	if gohelper.isNil(slot0._chapterOpenVideoGO) then
		slot2, slot3, slot0._chapterOpenVideoGO = AvProMgr.instance:getVideoPlayer(slot0._gochapteropenvideo)
	end

	slot0._chapterOpenDisplayUGUI = gohelper.onceAddComponent(slot0._chapterOpenVideoGO, AvProMgr.Type_DisplayUGUI)
	slot0._chapterOpenDisplayUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
	slot0._chapterOpenVideoPlayer = gohelper.onceAddComponent(slot0._chapterOpenVideoGO, AvProMgr.Type_AvProUGUIPlayer)

	slot0._chapterOpenVideoPlayer:Play(slot0._chapterOpenDisplayUGUI, langVideoUrl("story_rian_bg"), true, nil, )
	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
	TaskDispatcher.cancelTask(slot0._chapterStartOut, slot0)
	TaskDispatcher.runDelay(slot0._chapterStartOut, slot0, 5.333)
end

function slot0._chapterStartOut(slot0)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	gohelper.setActive(slot0._goopen, false)
	TaskDispatcher.cancelTask(slot0._chapterStartOut, slot0)
end

function slot0.showChapterEnd(slot0, slot1)
	gohelper.setActive(slot0._goepisode, false)
	gohelper.setActive(slot0._gochapter, true)
	gohelper.setActive(slot0._goclose, true)
	gohelper.setActive(slot0._goopen, false)

	if slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == "" then
		slot2 = slot1.navigateChapterEn
	end

	slot0._txtchaptercloseNum.text = slot2

	if slot0._chapterCloseVideoPlayer then
		slot0._chapterCloseVideoPlayer:Stop()
		slot0._chapterCloseVideoPlayer:Clear()

		slot0._chapterCloseVideoPlayer = nil
	end

	if gohelper.isNil(slot0._chapterCloseVideoGO) then
		slot3, slot4, slot0._chapterCloseVideoGO = AvProMgr.instance:getVideoPlayer(slot0._gochapterclosevideo)
	end

	slot0._chapterCloseDisplayUGUI = gohelper.onceAddComponent(slot0._chapterCloseVideoGO, AvProMgr.Type_DisplayUGUI)
	slot0._chapterCloseDisplayUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
	slot0._chapterCloseVideoPlayer = gohelper.onceAddComponent(slot0._chapterCloseVideoGO, AvProMgr.Type_AvProUGUIPlayer)

	slot0._chapterCloseVideoPlayer:Play(slot0._chapterCloseDisplayUGUI, langVideoUrl("story_rian_bg"), true, nil, )
	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_End)
	TaskDispatcher.cancelTask(slot0._chapterEndOut, slot0)
	TaskDispatcher.runDelay(slot0._chapterEndOut, slot0, 3.2)
end

function slot0._chapterEndOut(slot0)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_End)
	TaskDispatcher.cancelTask(slot0._chapterEndOut, slot0)
end

function slot0.showActivityChapterStart(slot0, slot1)
	if not slot0.activityChapterPlayer then
		slot0.activityChapterPlayer = StoryActivityChapterPlayer.New(slot0._goActivityChapter)
	end

	slot0.activityChapterPlayer:playStart(slot1)
end

function slot0.showActivityChapterEnd(slot0, slot1)
	gohelper.setActive(slot0._gobg, true)

	if not slot0.activityChapterPlayer then
		slot0.activityChapterPlayer = StoryActivityChapterPlayer.New(slot0._goActivityChapter)
	end

	slot0.activityChapterPlayer:playEnd(slot1)
end

function slot0.showRoleStoryStart(slot0, slot1)
	if not slot0.activityChapterPlayer then
		slot0.activityChapterPlayer = StoryActivityChapterPlayer.New(slot0._goActivityChapter)
	end

	slot0.activityChapterPlayer:playRoleStoryStart(slot1)
end

function slot0.showStormDeadline(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.Story.Play_Storm_Deadline)

	slot2 = string.splitToNumber(slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "#")

	gohelper.setActive(slot0._gostorm, true)
	slot0._stormAnim:Play("open", 0, 0)

	slot0._txtTimeNum1.text = slot2[1]
	slot0._txtTimeNum2.text = slot2[1] - slot2[2]
	slot3 = "%s HOURS\nBEFORE THE STORM"
	slot0._txtTimeEn1.text = string.format(slot3, slot2[1])
	slot0._txtTimeEn2.text = string.format(slot3, slot2[1] - slot2[2])
end

function slot0.clear(slot0)
	if slot0.activityChapterPlayer then
		slot0.activityChapterPlayer:hide()
	end

	gohelper.setActive(slot0._goepisode, false)
	gohelper.setActive(slot0._gochapter, false)
	gohelper.setActive(slot0._gomap, false)
	gohelper.setActive(slot0._gobg, false)
end

function slot0.destroy(slot0)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_End)
	TaskDispatcher.cancelTask(slot0._mapOut, slot0)
	TaskDispatcher.cancelTask(slot0._episodeOut, slot0)
	TaskDispatcher.cancelTask(slot0._chapterStartOut, slot0)
	TaskDispatcher.cancelTask(slot0._chapterEndOut, slot0)

	if slot0._episodeIconLoader then
		slot0._episodeIconLoader:dispose()

		slot0._episodeIconLoader = nil

		SLFramework.GameObjectHelper.DestroyAllChildren(slot0._iconGo)
	end

	if slot0._episodeVideoPlayer then
		if not BootNativeUtil.isIOS() then
			slot0._episodeVideoPlayer:Stop()
		end

		slot0._episodeVideoPlayer:Clear()

		slot0._episodeVideoPlayer = nil
	end

	if slot0._episodeVideoGO then
		gohelper.destroy(slot0._episodeVideoGO)

		slot0._episodeVideoGO = nil
	end

	if slot0._chapterOpenVideoPlayer then
		if not BootNativeUtil.isIOS() then
			slot0._chapterOpenVideoPlayer:Stop()
		end

		slot0._chapterOpenVideoPlayer:Clear()

		slot0._chapterOpenVideoPlayer = nil
	end

	if slot0._chapterOpenVideoGO then
		gohelper.destroy(slot0._chapterOpenVideoGO)

		slot0._chapterOpenVideoGO = nil
	end

	if slot0._chapterCloseVideoPlayer then
		if not BootNativeUtil.isIOS() then
			slot0._chapterCloseVideoPlayer:Stop()
		end

		slot0._chapterCloseVideoPlayer:Clear()

		slot0._chapterCloseVideoPlayer = nil
	end

	if slot0._chapterCloseVideoGO then
		gohelper.destroy(slot0._chapterCloseVideoGO)

		slot0._chapterCloseVideoGO = nil
	end

	if slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end

	if slot0.activityChapterPlayer then
		slot0.activityChapterPlayer:dispose()

		slot0.activityChapterPlayer = nil
	end

	gohelper.setActive(slot0._go, false)
end

return slot0
