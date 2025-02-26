module("modules.logic.versionactivity1_2.dreamtail.view.Activity119View", package.seeall)

slot0 = class("Activity119View", BaseView)
slot1 = {
	Hard = 2,
	LockHard = 3,
	Normal = 1
}

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "bg/#txt_remainTime")
	slot0._simagebookleftbg = gohelper.findChildSingleImage(slot0.viewGO, "bookleft/bg/#simage_bookleftbg")
	slot0._simagepageNormal = gohelper.findChildSingleImage(slot0.viewGO, "bookleft/bg/exchange/#simage_pageNormal")
	slot0._simagepageHard = gohelper.findChildSingleImage(slot0.viewGO, "bookleft/bg/exchange/#simage_pageHard")
	slot0._gocategory = gohelper.findChild(slot0.viewGO, "bookleft/category/#go_category")
	slot0._gocategoryItem = gohelper.findChild(slot0.viewGO, "bookleft/category/#go_category/#go_categoryItem")
	slot0._simageleftpage = gohelper.findChildSingleImage(slot0.viewGO, "bookleft/#simage_leftpage")
	slot0._simageleftpageline = gohelper.findChildSingleImage(slot0.viewGO, "bookleft/#simage_leftpageline")
	slot0._goframehard = gohelper.findChild(slot0.viewGO, "bookleft/leftup/exchange/#go_framehard")
	slot0._goframenormal = gohelper.findChild(slot0.viewGO, "bookleft/leftup/exchange/#go_framenormal")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "bookleft/leftup/#simage_icon")
	slot0._txtpageIndex = gohelper.findChildText(slot0.viewGO, "bookleft/leftup/#txt_pageIndex")
	slot0._txtpagename = gohelper.findChildText(slot0.viewGO, "bookleft/leftup/#txt_pagename")
	slot0._goselectHard = gohelper.findChild(slot0.viewGO, "bookleft/leftmiddle/#go_selectHard")
	slot0._goselctNormal = gohelper.findChild(slot0.viewGO, "bookleft/leftmiddle/#go_selctNormal")
	slot0._golockHard = gohelper.findChild(slot0.viewGO, "bookleft/leftmiddle/#go_lockHard")
	slot0._leftmiddleAnim = ZProj.ProjAnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "bookleft/leftmiddle"))
	slot0._btnnormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "bookleft/leftmiddle/#btn_normal")
	slot0._btnhard = gohelper.findChildButtonWithAudio(slot0.viewGO, "bookleft/leftmiddle/#btn_hard")
	slot0._txtrecommendLevel = gohelper.findChildText(slot0.viewGO, "bookleft/leftdown/desc/txt/#txt_recommendLevel")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "bookleft/leftdown/desc/#txt_desc")
	slot0._gosamplehero = gohelper.findChild(slot0.viewGO, "bookleft/leftdown/samplehero/#scroll_samplehero/Viewport/#go_samplehero")
	slot0._gosampleHeroItem = gohelper.findChild(slot0.viewGO, "bookleft/leftdown/samplehero/#scroll_samplehero/Viewport/#go_samplehero/#go_sampleHeroItem")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "bookright/bg/nomal")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "bookright/bg/hard")
	slot0._simagebookrightbghard = gohelper.findChildSingleImage(slot0.viewGO, "bookright/bg/hard/#simage_bookrightbghard")
	slot0._simagebookrightpagehard = gohelper.findChildSingleImage(slot0.viewGO, "bookright/bg/hard/#simage_bookrightpagehard")
	slot0._simagebookrightbgnormal = gohelper.findChildSingleImage(slot0.viewGO, "bookright/bg/nomal/#simage_bookrightbgnormal")
	slot0._simagebookrightpagenormal = gohelper.findChildSingleImage(slot0.viewGO, "bookright/bg/nomal/#simage_bookrightpagenormal")
	slot0._simagerightpageline = gohelper.findChildSingleImage(slot0.viewGO, "bookright/bg/#simage_rightpageline")
	slot0._txtnormalTaskDesc = gohelper.findChildText(slot0.viewGO, "bookright/normalpoint/content/#txt_normalTaskDesc")
	slot0._gonormalComplete = gohelper.findChild(slot0.viewGO, "bookright/normalpoint/#go_normalComplete")
	slot0._gohardpoint = gohelper.findChild(slot0.viewGO, "bookright/#go_hardpoint")
	slot0._txthardTaskDesc1 = gohelper.findChildText(slot0.viewGO, "bookright/#go_hardpoint/hardpoint1/content/#txt_hardTaskDesc1")
	slot0._gohardComplete1 = gohelper.findChild(slot0.viewGO, "bookright/#go_hardpoint/hardpoint1/#go_hardComplete1")
	slot0._txthardTaskDesc2 = gohelper.findChildText(slot0.viewGO, "bookright/#go_hardpoint/hardpoint2/content/#txt_hardTaskDesc2")
	slot0._gohardComplete2 = gohelper.findChild(slot0.viewGO, "bookright/#go_hardpoint/hardpoint2/#go_hardComplete2")
	slot0._golockhard = gohelper.findChild(slot0.viewGO, "bookright/#go_lockhard")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "bookright/#go_reward")
	slot0._btnstarthard = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_starthard")
	slot0._btnstartnormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_startnormal")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnormal:AddClickListener(slot0._btnnormalOnClick, slot0)
	slot0._btnhard:AddClickListener(slot0._btnhardOnClick, slot0)
	slot0._btnstarthard:AddClickListener(slot0._btnstarthardOnClick, slot0)
	slot0._btnstartnormal:AddClickListener(slot0._btnstartnormalOnClick, slot0)
	slot0._eventWrap:AddEventListener("onSwitch", slot0.onAnimSwitch, slot0)
	slot0:addEventCb(Activity119Controller.instance, Activity119Event.TabChange, slot0.onTabChange, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.onUpdateLeftTime, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnormal:RemoveClickListener()
	slot0._btnhard:RemoveClickListener()
	slot0._btnstarthard:RemoveClickListener()
	slot0._btnstartnormal:RemoveClickListener()
	slot0._eventWrap:RemoveAllEventListener()
	slot0:removeEventCb(Activity119Controller.instance, Activity119Event.TabChange, slot0.onTabChange, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.onUpdateLeftTime, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
end

function slot0._btnnormalOnClick(slot0)
	slot1 = slot0._toMode

	if slot0:isHardUnLock() then
		slot0._toMode = uv0.Normal
	else
		slot0._toMode = uv0.LockHard
	end

	if Activity119Model.instance:getData().lastSelectModel ~= 1 then
		slot2.lastSelectModel = 1

		Activity119Model.instance:saveData()
	end

	if not slot1 or slot1 == slot0._toMode or slot0._toMode == uv0.LockHard or slot0._toMode ~= uv0.Hard and slot1 ~= uv0.Hard then
		slot0._animtor.enabled = true

		slot0._animtor:Play("tonomal", 0, 1)
		slot0:updateShow(slot0._toMode)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	UIBlockMgr.instance:startBlock("Activity119ViewSwitch")

	slot0._animtor.enabled = true

	slot0._animtor:Play("tonomal", 0, 0)
end

function slot0._btnhardOnClick(slot0)
	if not slot0:isHardUnLock() then
		GameFacade.showToast(ToastEnum.Act119HardLock)

		return
	end

	if Activity119Model.instance:getData().lastSelectModel ~= 2 then
		slot1.lastSelectModel = 2

		Activity119Model.instance:saveData()
	end

	slot0._toMode = uv0.Hard

	if not slot0._toMode or slot2 == slot0._toMode then
		slot0:updateShow(slot0._toMode)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	UIBlockMgr.instance:startBlock("Activity119ViewSwitch")

	slot0._animtor.enabled = true

	slot0._animtor:Play("tohard", 0, 0)
end

function slot0.onAnimSwitch(slot0)
	UIBlockMgr.instance:endBlock("Activity119ViewSwitch")
	slot0:updateShow(slot0._toMode)
end

function slot0.updateShow(slot0, slot1)
	slot0:resetTrialHeroPos()

	slot0._isHardMode = slot1 == uv0.Hard

	gohelper.setActive(slot0._golockHard, slot1 == uv0.LockHard)
	gohelper.setActive(slot0._golockhard, false)
	gohelper.setActive(slot0._gohardpoint, true)
	gohelper.setActive(slot0._btnstartnormal.gameObject, slot1 ~= uv0.Hard)
	gohelper.setActive(slot0._btnstarthard.gameObject, slot1 == uv0.Hard)

	slot2 = slot0._config.normalCO

	if slot1 == uv0.Hard then
		slot2 = slot0._config.hardCO
	end

	slot5 = lua_battle.configDict[DungeonConfig.instance:getEpisodeCO(slot2.id).battleId] and string.splitToNumber(slot4.monsterGroupIds, "#")
	slot6 = slot5 and slot5[1]
	slot7 = slot6 and lua_monster_group.configDict[slot6]
	slot8 = slot7 and slot7.monster
	slot9 = slot8 and string.splitToNumber(slot8, "#")[1]
	slot10 = slot9 and lua_monster.configDict[slot9]
	slot0._txtrecommendLevel.text = slot10 and HeroConfig.instance:getCommonLevelDisplay(slot10.level) or ""
	slot0._txtdesc.text = slot2.des

	HeroGroupTrialModel.instance:setTrialByBattleId(slot3.battleId)
	slot0:updateTrialHero()
end

function slot0.updateTrialHero(slot0)
	gohelper.setActive(slot0._gosampleHeroItem, false)

	if not slot0.heroItems then
		slot0.heroItems = {}
	end

	for slot5 = 1, #HeroGroupTrialModel.instance:getList() do
		if not slot0.heroItems[slot5] then
			slot6 = Activity119TrialHeroItem.New()

			slot6:init(gohelper.cloneInPlace(slot0._gosampleHeroItem, "Hero" .. slot5), slot5)

			slot0.heroItems[slot5] = slot6
		end

		gohelper.setActive(slot6.go, true)
		slot6:updateMO()
	end

	for slot5 = #slot1 + 1, #slot0.heroItems do
		gohelper.setActive(slot0.heroItems[slot5].go, false)
	end
end

function slot0.updateTaskInfo(slot0)
	slot1 = slot0._config.taskList
	slot0._txtnormalTaskDesc.text = slot1[1].desc
	slot0._txthardTaskDesc1.text = slot1[2].desc
	slot0._txthardTaskDesc2.text = slot1[3].desc

	for slot6 = 1, 3 do
		slot0.rewards[slot6]:setBonus(slot1[slot6].bonus, slot1[slot6].id, slot6 == 1 or slot0:isHardUnLock())
	end

	slot0:updateTaskStatus()
	UnityEngine.Canvas.ForceUpdateCanvases()
	slot0:calcTxtLen()
end

function slot0.calcTxtLen(slot0)
	if not slot0._txtnormalTaskDesc then
		return
	end

	slot0:updateLineLen(gohelper.findChildTextMesh(slot0.viewGO, "bookright/normalpoint/content/titletxt"), slot0._txtnormalTaskDesc, slot0._gonormalComplete)
	slot0:updateLineLen(gohelper.findChildTextMesh(slot0.viewGO, "bookright/#go_hardpoint/hardpoint1/content/titletxt"), slot0._txthardTaskDesc1, slot0._gohardComplete1)
	slot0:updateLineLen(gohelper.findChildTextMesh(slot0.viewGO, "bookright/#go_hardpoint/hardpoint2/content/titletxt"), slot0._txthardTaskDesc2, slot0._gohardComplete2)
end

function slot0.updateLineLen(slot0, slot1, slot2, slot3)
	recthelper.setWidth(gohelper.findChild(slot3, "img_complete1").transform, slot1:GetTextInfo(slot1.text).lineInfo[0].length + 17)

	slot7 = slot2:GetTextInfo(slot2.text).lineInfo

	recthelper.setWidth(gohelper.findChild(slot3, "img_complete2").transform, slot7[0].length + 25)

	if slot7.Length <= 1 or slot7[1].length <= 1 then
		gohelper.setActive(gohelper.findChild(slot3, "img_complete3"), false)
	else
		gohelper.setActive(slot6, true)
		recthelper.setWidth(slot6.transform, slot7[1].length + 25)
	end
end

function slot0._onUpdateTaskList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.taskInfo) do
		if slot6.type == TaskEnum.TaskType.Activity119 then
			return slot0:updateTaskStatus()
		end
	end
end

function slot0.updateTaskStatus(slot0)
	for slot5 = 1, 3 do
		slot7 = 1

		if TaskModel.instance:getTaskById(slot0._config.taskList[slot5].id) then
			if slot6.finishCount > 0 then
				slot7 = 3
			elseif slot6.hasFinished then
				slot7 = 2
			end
		end

		slot0.rewards[slot5]:updateTaskStatus(slot7)

		slot0.taskCanvasGroups[slot5].alpha = slot7 == 3 and 0.4 or 1

		if slot5 == 1 then
			gohelper.setActive(slot0._gonormalComplete, slot7 == 3)
		elseif slot5 == 2 then
			gohelper.setActive(slot0._gohardComplete1, slot7 == 3)
		elseif slot5 == 3 then
			gohelper.setActive(slot0._gohardComplete2, slot7 == 3)
		end
	end
end

function slot0._btnstarthardOnClick(slot0)
	if not ActivityModel.instance:isActOnLine(VersionActivity1_2Enum.ActivityId.DreamTail) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	slot1 = slot0._config.hardCO.id

	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
end

function slot0._btnstartnormalOnClick(slot0)
	if not ActivityModel.instance:isActOnLine(VersionActivity1_2Enum.ActivityId.DreamTail) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	slot1 = slot0._config.normalCO.id

	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
end

function slot0._editableInitView(slot0)
	slot0._eventWrap = gohelper.onceAddComponent(slot0.viewGO, typeof(ZProj.AnimationEventWrap))
	slot0._animtor = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))

	slot0._simagebg:LoadImage(ResUrl.getDreamTailImage("bg"))
	slot0._simagebookleftbg:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_left"))
	slot0._simagepageNormal:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_lefttag"))
	slot0._simagepageHard:LoadImage(ResUrl.getDreamTailImage("bg_book_dif_lefttag"))
	slot0._simageleftpage:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_lefttop"))
	slot0._simageleftpageline:LoadImage(ResUrl.getDreamTailImage("deco_left"))
	slot0._simagebookrightbgnormal:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_right"))
	slot0._simagebookrightpagenormal:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_righttop"))
	slot0._simagebookrightbghard:LoadImage(ResUrl.getDreamTailImage("bg_book_dificult_right"))
	slot0._simagebookrightpagehard:LoadImage(ResUrl.getDreamTailImage("bg_book_dif_righttop"))

	slot4 = "deco_right"

	slot0._simagerightpageline:LoadImage(ResUrl.getDreamTailImage(slot4))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_swath_open)
	gohelper.addUIClickAudio(slot0._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(slot0._btnstartnormal.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)

	slot0._openDt = os.clock()

	gohelper.setActive(slot0._gocategoryItem, false)

	slot0.tabs = {}

	for slot4 = 1, 7 do
		slot5 = Activity119TabItem.New()
		slot6 = gohelper.cloneInPlace(slot0._gocategoryItem, "Tab" .. slot4)

		gohelper.setActive(slot6, true)
		slot5:init(slot6, slot4)

		slot0.tabs[slot4] = slot5
	end

	gohelper.setActive(slot0._goreward, false)

	slot0.rewards = {}

	for slot4 = 1, 3 do
		slot5 = Activity119RewardItem.New()
		slot7 = gohelper.clone(slot0._goreward, gohelper.findChild(slot0.viewGO, "bookright/reward" .. slot4), "RewardItem")

		gohelper.setActive(slot7, true)
		slot5:init(slot7)

		slot0.rewards[slot4] = slot5
	end

	slot0.taskCanvasGroups = slot0:getUserDataTb_()
	slot0.taskCanvasGroups[1] = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "bookright/normalpoint/content"), typeof(UnityEngine.CanvasGroup))
	slot0.taskCanvasGroups[2] = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "bookright/#go_hardpoint/hardpoint1/content"), typeof(UnityEngine.CanvasGroup))
	slot0.taskCanvasGroups[3] = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "bookright/#go_hardpoint/hardpoint2/content"), typeof(UnityEngine.CanvasGroup))

	slot0:onUpdateLeftTime()
	slot0:onTabChange(Activity119Model.instance:getData().lastSelectDay)
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, 60, -1)
end

function slot0.onOpenFinish(slot0)
	for slot4 = 1, 7 do
		slot0.tabs[slot4]:playUnLockAnim()
	end
end

function slot0.onUpdateLeftTime(slot0)
	if not ActivityModel.instance:getActMO(VersionActivity1_2Enum.ActivityId.DreamTail) or not slot0.tabs then
		return
	end

	if not Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, Activity119Model.instance:getData().lastSelectDay) or math.ceil((ServerTime.now() - slot1:getRealStartTimeStamp()) / 86400) < slot4.normalCO.openDay then
		slot3.lastSelectDay = 1

		Activity119Model.instance:saveData()
	end

	for slot8 = 1, 7 do
		slot0.tabs[slot8]:updateLock(slot2)
	end

	if os.clock() - slot0._openDt > 1 then
		for slot8 = 1, 7 do
			slot0.tabs[slot8]:playUnLockAnim()
		end
	end

	slot0:refreshTime()
end

function slot0.refreshTime(slot0)
	if not ActivityModel.instance:getActMO(VersionActivity1_2Enum.ActivityId.DreamTail) or not slot1.online then
		slot0._txtremainTime.text = luaLang("versionactivity_1_2_114enterview_isend")
	else
		slot0._txtremainTime.text = string.format(luaLang("remain"), slot1:getRemainTimeStr2ByEndTime())
	end
end

function slot0.isHardUnLock(slot0)
	return DungeonModel.instance:hasPassLevel(slot0._config.normalCO.id)
end

function slot0.onTabChange(slot0, slot1)
	if slot0.curIndex == slot1 then
		return
	end

	slot0._leftmiddleAnim:Stop()

	if Activity119Model.instance:getData().lastSelectDay ~= slot1 then
		slot2.lastSelectDay = slot1

		Activity119Model.instance:saveData()
	end

	if slot0.curIndex then
		slot0.tabs[slot0.curIndex]:changeSelect(false)
	end

	slot0._config = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, slot1)
	slot0.curIndex = slot1

	slot0.tabs[slot0.curIndex]:changeSelect(true)

	if slot2.lastSelectModel == 1 or not slot0:isHardUnLock() then
		slot0:_btnnormalOnClick()
	else
		slot0:_btnhardOnClick()
	end

	slot0._simageicon:LoadImage(ResUrl.getDreamTailImage(slot0._config.normalCO.icon))

	slot0._txtpageIndex.text = string.format("%02d", slot0.curIndex)
	slot0._txtpagename.text = slot0._config.normalCO.name

	slot0:updateTaskInfo()
	TaskDispatcher.cancelTask(slot0.playUnLockAnim, slot0)

	if slot0:isHardUnLock() and not tabletool.indexOf(slot2.unLockHardList, slot1) then
		table.insert(slot2.unLockHardList, slot1)
		Activity119Model.instance:saveData()

		if os.clock() - slot0._openDt > 1 then
			slot0._leftmiddleAnim:Play(UIAnimationName.Unlock, slot0.onUnLockEnd, slot0)
		else
			slot0._leftmiddleAnim:Play(UIAnimationName.Idle)
			TaskDispatcher.runDelay(slot0.playUnLockAnim, slot0, 1)
		end
	else
		slot0._leftmiddleAnim:Play(UIAnimationName.Idle)
	end

	slot0:resetTrialHeroPos()
end

function slot0.resetTrialHeroPos(slot0)
	slot1 = slot0._gosamplehero.transform

	transformhelper.setLocalPosXY(slot1, 0, slot1.localPosition.y)
end

function slot0.playUnLockAnim(slot0)
	TaskDispatcher.cancelTask(slot0.playUnLockAnim, slot0)
	slot0._leftmiddleAnim:Play(UIAnimationName.Unlock, slot0.onUnLockEnd, slot0)
end

function slot0.onUnLockEnd(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagebookleftbg:UnLoadImage()
	slot0._simagepageNormal:UnLoadImage()
	slot0._simagepageHard:UnLoadImage()
	slot0._simageleftpage:UnLoadImage()
	slot0._simageleftpageline:UnLoadImage()
	slot0._simagebookrightbgnormal:UnLoadImage()
	slot0._simagebookrightpagenormal:UnLoadImage()
	slot0._simagebookrightbghard:UnLoadImage()
	slot0._simagebookrightpagehard:UnLoadImage()
	slot0._simagerightpageline:UnLoadImage()
	slot0._simageicon:UnLoadImage()
	UIBlockMgr.instance:endBlock("Activity119ViewSwitch")
	TaskDispatcher.cancelTask(slot0.playUnLockAnim, slot0)

	for slot4 = 1, #slot0.tabs do
		slot0.tabs[slot4]:dispose()
	end

	slot0.tabs = nil

	for slot4 = 1, #slot0.heroItems do
		slot0.heroItems[slot4]:dispose()
	end

	slot0.heroItems = nil

	for slot4 = 1, #slot0.rewards do
		slot0.rewards[slot4]:dispose()
	end

	slot0.rewards = nil
end

return slot0
