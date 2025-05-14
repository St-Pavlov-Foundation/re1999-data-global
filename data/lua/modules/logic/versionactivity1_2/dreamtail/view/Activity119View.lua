module("modules.logic.versionactivity1_2.dreamtail.view.Activity119View", package.seeall)

local var_0_0 = class("Activity119View", BaseView)
local var_0_1 = {
	Hard = 2,
	LockHard = 3,
	Normal = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "bg/#txt_remainTime")
	arg_1_0._simagebookleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookleft/bg/#simage_bookleftbg")
	arg_1_0._simagepageNormal = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookleft/bg/exchange/#simage_pageNormal")
	arg_1_0._simagepageHard = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookleft/bg/exchange/#simage_pageHard")
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "bookleft/category/#go_category")
	arg_1_0._gocategoryItem = gohelper.findChild(arg_1_0.viewGO, "bookleft/category/#go_category/#go_categoryItem")
	arg_1_0._simageleftpage = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookleft/#simage_leftpage")
	arg_1_0._simageleftpageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookleft/#simage_leftpageline")
	arg_1_0._goframehard = gohelper.findChild(arg_1_0.viewGO, "bookleft/leftup/exchange/#go_framehard")
	arg_1_0._goframenormal = gohelper.findChild(arg_1_0.viewGO, "bookleft/leftup/exchange/#go_framenormal")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookleft/leftup/#simage_icon")
	arg_1_0._txtpageIndex = gohelper.findChildText(arg_1_0.viewGO, "bookleft/leftup/#txt_pageIndex")
	arg_1_0._txtpagename = gohelper.findChildText(arg_1_0.viewGO, "bookleft/leftup/#txt_pagename")
	arg_1_0._goselectHard = gohelper.findChild(arg_1_0.viewGO, "bookleft/leftmiddle/#go_selectHard")
	arg_1_0._goselctNormal = gohelper.findChild(arg_1_0.viewGO, "bookleft/leftmiddle/#go_selctNormal")
	arg_1_0._golockHard = gohelper.findChild(arg_1_0.viewGO, "bookleft/leftmiddle/#go_lockHard")
	arg_1_0._leftmiddleAnim = ZProj.ProjAnimatorPlayer.Get(gohelper.findChild(arg_1_0.viewGO, "bookleft/leftmiddle"))
	arg_1_0._btnnormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bookleft/leftmiddle/#btn_normal")
	arg_1_0._btnhard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bookleft/leftmiddle/#btn_hard")
	arg_1_0._txtrecommendLevel = gohelper.findChildText(arg_1_0.viewGO, "bookleft/leftdown/desc/txt/#txt_recommendLevel")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "bookleft/leftdown/desc/#txt_desc")
	arg_1_0._gosamplehero = gohelper.findChild(arg_1_0.viewGO, "bookleft/leftdown/samplehero/#scroll_samplehero/Viewport/#go_samplehero")
	arg_1_0._gosampleHeroItem = gohelper.findChild(arg_1_0.viewGO, "bookleft/leftdown/samplehero/#scroll_samplehero/Viewport/#go_samplehero/#go_sampleHeroItem")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "bookright/bg/nomal")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "bookright/bg/hard")
	arg_1_0._simagebookrightbghard = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookright/bg/hard/#simage_bookrightbghard")
	arg_1_0._simagebookrightpagehard = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookright/bg/hard/#simage_bookrightpagehard")
	arg_1_0._simagebookrightbgnormal = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookright/bg/nomal/#simage_bookrightbgnormal")
	arg_1_0._simagebookrightpagenormal = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookright/bg/nomal/#simage_bookrightpagenormal")
	arg_1_0._simagerightpageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "bookright/bg/#simage_rightpageline")
	arg_1_0._txtnormalTaskDesc = gohelper.findChildText(arg_1_0.viewGO, "bookright/normalpoint/content/#txt_normalTaskDesc")
	arg_1_0._gonormalComplete = gohelper.findChild(arg_1_0.viewGO, "bookright/normalpoint/#go_normalComplete")
	arg_1_0._gohardpoint = gohelper.findChild(arg_1_0.viewGO, "bookright/#go_hardpoint")
	arg_1_0._txthardTaskDesc1 = gohelper.findChildText(arg_1_0.viewGO, "bookright/#go_hardpoint/hardpoint1/content/#txt_hardTaskDesc1")
	arg_1_0._gohardComplete1 = gohelper.findChild(arg_1_0.viewGO, "bookright/#go_hardpoint/hardpoint1/#go_hardComplete1")
	arg_1_0._txthardTaskDesc2 = gohelper.findChildText(arg_1_0.viewGO, "bookright/#go_hardpoint/hardpoint2/content/#txt_hardTaskDesc2")
	arg_1_0._gohardComplete2 = gohelper.findChild(arg_1_0.viewGO, "bookright/#go_hardpoint/hardpoint2/#go_hardComplete2")
	arg_1_0._golockhard = gohelper.findChild(arg_1_0.viewGO, "bookright/#go_lockhard")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "bookright/#go_reward")
	arg_1_0._btnstarthard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_starthard")
	arg_1_0._btnstartnormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_startnormal")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnormal:AddClickListener(arg_2_0._btnnormalOnClick, arg_2_0)
	arg_2_0._btnhard:AddClickListener(arg_2_0._btnhardOnClick, arg_2_0)
	arg_2_0._btnstarthard:AddClickListener(arg_2_0._btnstarthardOnClick, arg_2_0)
	arg_2_0._btnstartnormal:AddClickListener(arg_2_0._btnstartnormalOnClick, arg_2_0)
	arg_2_0._eventWrap:AddEventListener("onSwitch", arg_2_0.onAnimSwitch, arg_2_0)
	arg_2_0:addEventCb(Activity119Controller.instance, Activity119Event.TabChange, arg_2_0.onTabChange, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.onUpdateLeftTime, arg_2_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_2_0._onUpdateTaskList, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnormal:RemoveClickListener()
	arg_3_0._btnhard:RemoveClickListener()
	arg_3_0._btnstarthard:RemoveClickListener()
	arg_3_0._btnstartnormal:RemoveClickListener()
	arg_3_0._eventWrap:RemoveAllEventListener()
	arg_3_0:removeEventCb(Activity119Controller.instance, Activity119Event.TabChange, arg_3_0.onTabChange, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.onUpdateLeftTime, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, arg_3_0._onUpdateTaskList, arg_3_0)
end

function var_0_0._btnnormalOnClick(arg_4_0)
	local var_4_0 = arg_4_0._toMode

	if arg_4_0:isHardUnLock() then
		arg_4_0._toMode = var_0_1.Normal
	else
		arg_4_0._toMode = var_0_1.LockHard
	end

	local var_4_1 = Activity119Model.instance:getData()

	if var_4_1.lastSelectModel ~= 1 then
		var_4_1.lastSelectModel = 1

		Activity119Model.instance:saveData()
	end

	if not var_4_0 or var_4_0 == arg_4_0._toMode or arg_4_0._toMode == var_0_1.LockHard or arg_4_0._toMode ~= var_0_1.Hard and var_4_0 ~= var_0_1.Hard then
		arg_4_0._animtor.enabled = true

		arg_4_0._animtor:Play("tonomal", 0, 1)
		arg_4_0:updateShow(arg_4_0._toMode)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	UIBlockMgr.instance:startBlock("Activity119ViewSwitch")

	arg_4_0._animtor.enabled = true

	arg_4_0._animtor:Play("tonomal", 0, 0)
end

function var_0_0._btnhardOnClick(arg_5_0)
	if not arg_5_0:isHardUnLock() then
		GameFacade.showToast(ToastEnum.Act119HardLock)

		return
	end

	local var_5_0 = Activity119Model.instance:getData()

	if var_5_0.lastSelectModel ~= 2 then
		var_5_0.lastSelectModel = 2

		Activity119Model.instance:saveData()
	end

	local var_5_1 = arg_5_0._toMode

	arg_5_0._toMode = var_0_1.Hard

	if not var_5_1 or var_5_1 == arg_5_0._toMode then
		arg_5_0:updateShow(arg_5_0._toMode)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	UIBlockMgr.instance:startBlock("Activity119ViewSwitch")

	arg_5_0._animtor.enabled = true

	arg_5_0._animtor:Play("tohard", 0, 0)
end

function var_0_0.onAnimSwitch(arg_6_0)
	UIBlockMgr.instance:endBlock("Activity119ViewSwitch")
	arg_6_0:updateShow(arg_6_0._toMode)
end

function var_0_0.updateShow(arg_7_0, arg_7_1)
	arg_7_0:resetTrialHeroPos()

	arg_7_0._isHardMode = arg_7_1 == var_0_1.Hard

	gohelper.setActive(arg_7_0._golockHard, arg_7_1 == var_0_1.LockHard)
	gohelper.setActive(arg_7_0._golockhard, false)
	gohelper.setActive(arg_7_0._gohardpoint, true)
	gohelper.setActive(arg_7_0._btnstartnormal.gameObject, arg_7_1 ~= var_0_1.Hard)
	gohelper.setActive(arg_7_0._btnstarthard.gameObject, arg_7_1 == var_0_1.Hard)

	local var_7_0 = arg_7_0._config.normalCO

	if arg_7_1 == var_0_1.Hard then
		var_7_0 = arg_7_0._config.hardCO
	end

	local var_7_1 = DungeonConfig.instance:getEpisodeCO(var_7_0.id)
	local var_7_2 = lua_battle.configDict[var_7_1.battleId]
	local var_7_3 = var_7_2 and string.splitToNumber(var_7_2.monsterGroupIds, "#")
	local var_7_4 = var_7_3 and var_7_3[1]
	local var_7_5 = var_7_4 and lua_monster_group.configDict[var_7_4]
	local var_7_6 = var_7_5 and var_7_5.monster
	local var_7_7 = var_7_6 and string.splitToNumber(var_7_6, "#")[1]
	local var_7_8 = var_7_7 and lua_monster.configDict[var_7_7]
	local var_7_9 = var_7_8 and HeroConfig.instance:getCommonLevelDisplay(var_7_8.level) or ""

	arg_7_0._txtrecommendLevel.text = var_7_9
	arg_7_0._txtdesc.text = var_7_0.des

	HeroGroupTrialModel.instance:setTrialByBattleId(var_7_1.battleId)
	arg_7_0:updateTrialHero()
end

function var_0_0.updateTrialHero(arg_8_0)
	gohelper.setActive(arg_8_0._gosampleHeroItem, false)

	if not arg_8_0.heroItems then
		arg_8_0.heroItems = {}
	end

	local var_8_0 = HeroGroupTrialModel.instance:getList()

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = arg_8_0.heroItems[iter_8_0]

		if not var_8_1 then
			var_8_1 = Activity119TrialHeroItem.New()

			local var_8_2 = gohelper.cloneInPlace(arg_8_0._gosampleHeroItem, "Hero" .. iter_8_0)

			var_8_1:init(var_8_2, iter_8_0)

			arg_8_0.heroItems[iter_8_0] = var_8_1
		end

		gohelper.setActive(var_8_1.go, true)
		var_8_1:updateMO()
	end

	for iter_8_1 = #var_8_0 + 1, #arg_8_0.heroItems do
		gohelper.setActive(arg_8_0.heroItems[iter_8_1].go, false)
	end
end

function var_0_0.updateTaskInfo(arg_9_0)
	local var_9_0 = arg_9_0._config.taskList

	arg_9_0._txtnormalTaskDesc.text = var_9_0[1].desc
	arg_9_0._txthardTaskDesc1.text = var_9_0[2].desc
	arg_9_0._txthardTaskDesc2.text = var_9_0[3].desc

	local var_9_1 = arg_9_0:isHardUnLock()

	for iter_9_0 = 1, 3 do
		arg_9_0.rewards[iter_9_0]:setBonus(var_9_0[iter_9_0].bonus, var_9_0[iter_9_0].id, iter_9_0 == 1 or var_9_1)
	end

	arg_9_0:updateTaskStatus()
	UnityEngine.Canvas.ForceUpdateCanvases()
	arg_9_0:calcTxtLen()
end

function var_0_0.calcTxtLen(arg_10_0)
	if not arg_10_0._txtnormalTaskDesc then
		return
	end

	arg_10_0:updateLineLen(gohelper.findChildTextMesh(arg_10_0.viewGO, "bookright/normalpoint/content/titletxt"), arg_10_0._txtnormalTaskDesc, arg_10_0._gonormalComplete)
	arg_10_0:updateLineLen(gohelper.findChildTextMesh(arg_10_0.viewGO, "bookright/#go_hardpoint/hardpoint1/content/titletxt"), arg_10_0._txthardTaskDesc1, arg_10_0._gohardComplete1)
	arg_10_0:updateLineLen(gohelper.findChildTextMesh(arg_10_0.viewGO, "bookright/#go_hardpoint/hardpoint2/content/titletxt"), arg_10_0._txthardTaskDesc2, arg_10_0._gohardComplete2)
end

function var_0_0.updateLineLen(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.findChild(arg_11_3, "img_complete1")
	local var_11_1 = gohelper.findChild(arg_11_3, "img_complete2")
	local var_11_2 = gohelper.findChild(arg_11_3, "img_complete3")
	local var_11_3 = arg_11_1:GetTextInfo(arg_11_1.text).lineInfo

	recthelper.setWidth(var_11_0.transform, var_11_3[0].length + 17)

	local var_11_4 = arg_11_2:GetTextInfo(arg_11_2.text).lineInfo

	recthelper.setWidth(var_11_1.transform, var_11_4[0].length + 25)

	if var_11_4.Length <= 1 or var_11_4[1].length <= 1 then
		gohelper.setActive(var_11_2, false)
	else
		gohelper.setActive(var_11_2, true)
		recthelper.setWidth(var_11_2.transform, var_11_4[1].length + 25)
	end
end

function var_0_0._onUpdateTaskList(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1.taskInfo) do
		if iter_12_1.type == TaskEnum.TaskType.Activity119 then
			return arg_12_0:updateTaskStatus()
		end
	end
end

function var_0_0.updateTaskStatus(arg_13_0)
	local var_13_0 = arg_13_0._config.taskList

	for iter_13_0 = 1, 3 do
		local var_13_1 = TaskModel.instance:getTaskById(var_13_0[iter_13_0].id)
		local var_13_2 = 1

		if var_13_1 then
			if var_13_1.finishCount > 0 then
				var_13_2 = 3
			elseif var_13_1.hasFinished then
				var_13_2 = 2
			end
		end

		arg_13_0.rewards[iter_13_0]:updateTaskStatus(var_13_2)

		arg_13_0.taskCanvasGroups[iter_13_0].alpha = var_13_2 == 3 and 0.4 or 1

		if iter_13_0 == 1 then
			gohelper.setActive(arg_13_0._gonormalComplete, var_13_2 == 3)
		elseif iter_13_0 == 2 then
			gohelper.setActive(arg_13_0._gohardComplete1, var_13_2 == 3)
		elseif iter_13_0 == 3 then
			gohelper.setActive(arg_13_0._gohardComplete2, var_13_2 == 3)
		end
	end
end

function var_0_0._btnstarthardOnClick(arg_14_0)
	if not ActivityModel.instance:isActOnLine(VersionActivity1_2Enum.ActivityId.DreamTail) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local var_14_0 = arg_14_0._config.hardCO.id
	local var_14_1 = DungeonConfig.instance:getEpisodeCO(var_14_0)

	DungeonFightController.instance:enterFight(var_14_1.chapterId, var_14_0)
end

function var_0_0._btnstartnormalOnClick(arg_15_0)
	if not ActivityModel.instance:isActOnLine(VersionActivity1_2Enum.ActivityId.DreamTail) then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local var_15_0 = arg_15_0._config.normalCO.id
	local var_15_1 = DungeonConfig.instance:getEpisodeCO(var_15_0)

	DungeonFightController.instance:enterFight(var_15_1.chapterId, var_15_0)
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0._eventWrap = gohelper.onceAddComponent(arg_16_0.viewGO, typeof(ZProj.AnimationEventWrap))
	arg_16_0._animtor = gohelper.onceAddComponent(arg_16_0.viewGO, typeof(UnityEngine.Animator))

	arg_16_0._simagebg:LoadImage(ResUrl.getDreamTailImage("bg"))
	arg_16_0._simagebookleftbg:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_left"))
	arg_16_0._simagepageNormal:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_lefttag"))
	arg_16_0._simagepageHard:LoadImage(ResUrl.getDreamTailImage("bg_book_dif_lefttag"))
	arg_16_0._simageleftpage:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_lefttop"))
	arg_16_0._simageleftpageline:LoadImage(ResUrl.getDreamTailImage("deco_left"))
	arg_16_0._simagebookrightbgnormal:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_right"))
	arg_16_0._simagebookrightpagenormal:LoadImage(ResUrl.getDreamTailImage("bg_book_nor_righttop"))
	arg_16_0._simagebookrightbghard:LoadImage(ResUrl.getDreamTailImage("bg_book_dificult_right"))
	arg_16_0._simagebookrightpagehard:LoadImage(ResUrl.getDreamTailImage("bg_book_dif_righttop"))
	arg_16_0._simagerightpageline:LoadImage(ResUrl.getDreamTailImage("deco_right"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_swath_open)
	gohelper.addUIClickAudio(arg_16_0._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(arg_16_0._btnstartnormal.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)

	arg_16_0._openDt = os.clock()

	gohelper.setActive(arg_16_0._gocategoryItem, false)

	arg_16_0.tabs = {}

	for iter_16_0 = 1, 7 do
		local var_16_0 = Activity119TabItem.New()
		local var_16_1 = gohelper.cloneInPlace(arg_16_0._gocategoryItem, "Tab" .. iter_16_0)

		gohelper.setActive(var_16_1, true)
		var_16_0:init(var_16_1, iter_16_0)

		arg_16_0.tabs[iter_16_0] = var_16_0
	end

	gohelper.setActive(arg_16_0._goreward, false)

	arg_16_0.rewards = {}

	for iter_16_1 = 1, 3 do
		local var_16_2 = Activity119RewardItem.New()
		local var_16_3 = gohelper.findChild(arg_16_0.viewGO, "bookright/reward" .. iter_16_1)
		local var_16_4 = gohelper.clone(arg_16_0._goreward, var_16_3, "RewardItem")

		gohelper.setActive(var_16_4, true)
		var_16_2:init(var_16_4)

		arg_16_0.rewards[iter_16_1] = var_16_2
	end

	arg_16_0.taskCanvasGroups = arg_16_0:getUserDataTb_()
	arg_16_0.taskCanvasGroups[1] = gohelper.onceAddComponent(gohelper.findChild(arg_16_0.viewGO, "bookright/normalpoint/content"), typeof(UnityEngine.CanvasGroup))
	arg_16_0.taskCanvasGroups[2] = gohelper.onceAddComponent(gohelper.findChild(arg_16_0.viewGO, "bookright/#go_hardpoint/hardpoint1/content"), typeof(UnityEngine.CanvasGroup))
	arg_16_0.taskCanvasGroups[3] = gohelper.onceAddComponent(gohelper.findChild(arg_16_0.viewGO, "bookright/#go_hardpoint/hardpoint2/content"), typeof(UnityEngine.CanvasGroup))

	arg_16_0:onUpdateLeftTime()

	local var_16_5 = Activity119Model.instance:getData()

	arg_16_0:onTabChange(var_16_5.lastSelectDay)
	TaskDispatcher.runRepeat(arg_16_0.refreshTime, arg_16_0, 60, -1)
end

function var_0_0.onOpenFinish(arg_17_0)
	for iter_17_0 = 1, 7 do
		arg_17_0.tabs[iter_17_0]:playUnLockAnim()
	end
end

function var_0_0.onUpdateLeftTime(arg_18_0)
	local var_18_0 = ActivityModel.instance:getActMO(VersionActivity1_2Enum.ActivityId.DreamTail)

	if not var_18_0 or not arg_18_0.tabs then
		return
	end

	local var_18_1 = math.ceil((ServerTime.now() - var_18_0:getRealStartTimeStamp()) / 86400)
	local var_18_2 = Activity119Model.instance:getData()
	local var_18_3 = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, var_18_2.lastSelectDay)

	if not var_18_3 or var_18_1 < var_18_3.normalCO.openDay then
		var_18_2.lastSelectDay = 1

		Activity119Model.instance:saveData()
	end

	for iter_18_0 = 1, 7 do
		arg_18_0.tabs[iter_18_0]:updateLock(var_18_1)
	end

	if os.clock() - arg_18_0._openDt > 1 then
		for iter_18_1 = 1, 7 do
			arg_18_0.tabs[iter_18_1]:playUnLockAnim()
		end
	end

	arg_18_0:refreshTime()
end

function var_0_0.refreshTime(arg_19_0)
	local var_19_0 = ActivityModel.instance:getActMO(VersionActivity1_2Enum.ActivityId.DreamTail)

	if not var_19_0 or not var_19_0.online then
		arg_19_0._txtremainTime.text = luaLang("versionactivity_1_2_114enterview_isend")
	else
		arg_19_0._txtremainTime.text = string.format(luaLang("remain"), var_19_0:getRemainTimeStr2ByEndTime())
	end
end

function var_0_0.isHardUnLock(arg_20_0)
	return DungeonModel.instance:hasPassLevel(arg_20_0._config.normalCO.id)
end

function var_0_0.onTabChange(arg_21_0, arg_21_1)
	if arg_21_0.curIndex == arg_21_1 then
		return
	end

	arg_21_0._leftmiddleAnim:Stop()

	local var_21_0 = Activity119Model.instance:getData()

	if var_21_0.lastSelectDay ~= arg_21_1 then
		var_21_0.lastSelectDay = arg_21_1

		Activity119Model.instance:saveData()
	end

	if arg_21_0.curIndex then
		arg_21_0.tabs[arg_21_0.curIndex]:changeSelect(false)
	end

	arg_21_0._config = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, arg_21_1)
	arg_21_0.curIndex = arg_21_1

	arg_21_0.tabs[arg_21_0.curIndex]:changeSelect(true)

	if var_21_0.lastSelectModel == 1 or not arg_21_0:isHardUnLock() then
		arg_21_0:_btnnormalOnClick()
	else
		arg_21_0:_btnhardOnClick()
	end

	arg_21_0._simageicon:LoadImage(ResUrl.getDreamTailImage(arg_21_0._config.normalCO.icon))

	arg_21_0._txtpageIndex.text = string.format("%02d", arg_21_0.curIndex)
	arg_21_0._txtpagename.text = arg_21_0._config.normalCO.name

	arg_21_0:updateTaskInfo()
	TaskDispatcher.cancelTask(arg_21_0.playUnLockAnim, arg_21_0)

	if arg_21_0:isHardUnLock() and not tabletool.indexOf(var_21_0.unLockHardList, arg_21_1) then
		table.insert(var_21_0.unLockHardList, arg_21_1)
		Activity119Model.instance:saveData()

		if os.clock() - arg_21_0._openDt > 1 then
			arg_21_0._leftmiddleAnim:Play(UIAnimationName.Unlock, arg_21_0.onUnLockEnd, arg_21_0)
		else
			arg_21_0._leftmiddleAnim:Play(UIAnimationName.Idle)
			TaskDispatcher.runDelay(arg_21_0.playUnLockAnim, arg_21_0, 1)
		end
	else
		arg_21_0._leftmiddleAnim:Play(UIAnimationName.Idle)
	end

	arg_21_0:resetTrialHeroPos()
end

function var_0_0.resetTrialHeroPos(arg_22_0)
	local var_22_0 = arg_22_0._gosamplehero.transform
	local var_22_1 = var_22_0.localPosition

	transformhelper.setLocalPosXY(var_22_0, 0, var_22_1.y)
end

function var_0_0.playUnLockAnim(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.playUnLockAnim, arg_23_0)
	arg_23_0._leftmiddleAnim:Play(UIAnimationName.Unlock, arg_23_0.onUnLockEnd, arg_23_0)
end

function var_0_0.onUnLockEnd(arg_24_0)
	return
end

function var_0_0.onDestroyView(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.refreshTime, arg_25_0)
	arg_25_0._simagebg:UnLoadImage()
	arg_25_0._simagebookleftbg:UnLoadImage()
	arg_25_0._simagepageNormal:UnLoadImage()
	arg_25_0._simagepageHard:UnLoadImage()
	arg_25_0._simageleftpage:UnLoadImage()
	arg_25_0._simageleftpageline:UnLoadImage()
	arg_25_0._simagebookrightbgnormal:UnLoadImage()
	arg_25_0._simagebookrightpagenormal:UnLoadImage()
	arg_25_0._simagebookrightbghard:UnLoadImage()
	arg_25_0._simagebookrightpagehard:UnLoadImage()
	arg_25_0._simagerightpageline:UnLoadImage()
	arg_25_0._simageicon:UnLoadImage()
	UIBlockMgr.instance:endBlock("Activity119ViewSwitch")
	TaskDispatcher.cancelTask(arg_25_0.playUnLockAnim, arg_25_0)

	for iter_25_0 = 1, #arg_25_0.tabs do
		arg_25_0.tabs[iter_25_0]:dispose()
	end

	arg_25_0.tabs = nil

	for iter_25_1 = 1, #arg_25_0.heroItems do
		arg_25_0.heroItems[iter_25_1]:dispose()
	end

	arg_25_0.heroItems = nil

	for iter_25_2 = 1, #arg_25_0.rewards do
		arg_25_0.rewards[iter_25_2]:dispose()
	end

	arg_25_0.rewards = nil
end

return var_0_0
