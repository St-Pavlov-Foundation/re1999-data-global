module("modules.logic.achievement.view.AchievementNamePlateLevelView", package.seeall)

local var_0_0 = class("AchievementNamePlateLevelView", BaseView)

var_0_0.BtnNormalAlpha = 1
var_0_0.BtnDisableAlpha = 0.3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_container")
	arg_1_0._txtpage = gohelper.findChildText(arg_1_0.viewGO, "#txt_page")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "layout/#txt_desc")
	arg_1_0._txtextradesc = gohelper.findChildText(arg_1_0.viewGO, "layout/#txt_extradesc")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_next")
	arg_1_0._btnprev = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_prev")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goIcon = gohelper.findChild(arg_1_0.viewGO, "go_icon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnprev:AddClickListener(arg_2_0._btnprevOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnprev:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_detailpanelbg"))
	NavigateMgr.instance:addEscape(arg_4_0.viewName, arg_4_0._btncloseOnClick, arg_4_0)

	arg_4_0._btnnextCanvasGroup = gohelper.onceAddComponent(arg_4_0._btnnext.gameObject, typeof(UnityEngine.CanvasGroup))
	arg_4_0._btnprevCanvasGroup = gohelper.onceAddComponent(arg_4_0._btnprev.gameObject, typeof(UnityEngine.CanvasGroup))

	arg_4_0:_initMainUI()

	arg_4_0._txtTips = gohelper.findChildText(arg_4_0.viewGO, "layout/#go_Tips/image_TipsBG/txt_Tips")
end

function var_0_0._initMainUI(arg_5_0)
	arg_5_0.levelItemList = {}

	for iter_5_0 = 1, 3 do
		local var_5_0 = {
			go = gohelper.findChild(arg_5_0._goIcon, "level" .. iter_5_0)
		}

		var_5_0.unlock = gohelper.findChild(var_5_0.go, "#go_UnLocked")
		var_5_0.lock = gohelper.findChild(var_5_0.go, "#go_Locked")
		var_5_0.gounlockbg = gohelper.findChild(var_5_0.unlock, "#simage_bg")
		var_5_0.simageunlocktitle = gohelper.findChildSingleImage(var_5_0.unlock, "#simage_title")
		var_5_0.txtunlocklevel = gohelper.findChildText(var_5_0.unlock, "#txt_level")
		var_5_0.simagelockbg = gohelper.findChildSingleImage(var_5_0.lock, "#simage_bg")
		var_5_0.simagelocktitle = gohelper.findChildSingleImage(var_5_0.lock, "#simage_title")
		var_5_0.txtlocklevel = gohelper.findChildText(var_5_0.lock, "#txt_level")

		gohelper.setActive(var_5_0.go, false)
		table.insert(arg_5_0.levelItemList, var_5_0)
	end
end

function var_0_0.onDestroyView(arg_6_0)
	NavigateMgr.instance:removeEscape(arg_6_0.viewName)
	AchievementLevelController.instance:onCloseView()

	if arg_6_0._items then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._items) do
			if iter_6_1.btnclick then
				iter_6_1.btnclick:RemoveClickListener()
			end
		end

		arg_6_0._items = nil
	end

	arg_6_0._simagebg:UnLoadImage()
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.achievementId
	local var_7_1 = arg_7_0.viewParam.achievementIds

	AchievementLevelController.instance:onOpenView(var_7_0, var_7_1)

	arg_7_0._newTaskCache = {}

	arg_7_0:addEventCb(AchievementLevelController.instance, AchievementEvent.LevelViewUpdated, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:addEventCb(AchievementController.instance, AchievementEvent.UpdateAchievements, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:checkInitItems()
	arg_7_0:refreshUI()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshInfo()
	arg_9_0:refreshSelected()
	arg_9_0:refreshMain()
end

function var_0_0.refreshInfo(arg_10_0)
	local var_10_0 = AchievementLevelModel.instance:getCurrentTask()

	if not var_10_0 then
		arg_10_0._txtdesc.text = ""
		arg_10_0._txtextradesc.text = ""

		logError("cannot find AchievementTaskConfig, achievementId = " .. tostring(AchievementLevelModel.instance:getAchievement()))

		return
	end

	arg_10_0._txtdesc.text = var_10_0.desc
	arg_10_0._txtextradesc.text = var_10_0.extraDesc

	if AchievementLevelModel.instance:getCurPageIndex() and AchievementLevelModel.instance:getTotalPageCount() then
		arg_10_0._txtpage.text = string.format("%s/%s", AchievementLevelModel.instance:getCurPageIndex(), AchievementLevelModel.instance:getTotalPageCount())
	else
		gohelper.setActive(arg_10_0._txtpage.gameObject, false)
	end

	arg_10_0._btnnextCanvasGroup.alpha = AchievementLevelModel.instance:hasNext() and var_0_0.BtnNormalAlpha or var_0_0.BtnDisableAlpha
	arg_10_0._btnprevCanvasGroup.alpha = AchievementLevelModel.instance:hasPrev() and var_0_0.BtnNormalAlpha or var_0_0.BtnDisableAlpha
end

function var_0_0.refreshSelected(arg_11_0)
	local var_11_0 = true

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._items) do
		local var_11_1 = AchievementLevelModel.instance:getTaskByIndex(iter_11_0)

		if var_11_1 then
			gohelper.setActive(iter_11_1.go, true)
			gohelper.setActive(iter_11_1.goselect, var_11_1 == AchievementLevelModel.instance:getCurrentTask())

			local var_11_2 = AchievementModel.instance:getById(var_11_1.id)
			local var_11_3 = var_11_2 and var_11_2.hasFinished

			gohelper.setActive(iter_11_1.gounachieve, not var_11_3)
			gohelper.setActive(iter_11_1.goachieve, var_11_3)
			gohelper.setActive(iter_11_1.goarrow1, not var_11_3)
			gohelper.setActive(iter_11_1.goarrow2, var_11_3)

			if not var_11_3 then
				iter_11_1.txtunachieve.text = arg_11_0:getUnAchievementTip(var_11_1, var_11_0)
			else
				if var_11_2.isNew then
					arg_11_0._newTaskCache[var_11_2.id] = true
				end

				if iter_11_1.goarrow2Animator then
					local var_11_4 = arg_11_0._newTaskCache[var_11_2.id] and 0 or 1

					iter_11_1.goarrow2Animator:Play("arrow_open", 0, var_11_4)
				end
			end

			iter_11_1.txttime.text = var_11_3 and TimeUtil.localTime2ServerTimeString(var_11_2.finishTime) or ""
			var_11_0 = var_11_3
		else
			gohelper.setActive(iter_11_1.go, false)
		end
	end
end

function var_0_0.getUnAchievementTip(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ""

	if arg_12_2 then
		local var_12_1 = AchievementConfig.instance:getAchievement(arg_12_1.achievementId)
		local var_12_2
		local var_12_3
		local var_12_4 = arg_12_1.listenerType
		local var_12_5 = AchievementUtils.getAchievementProgressBySourceType(var_12_1.rule)
		local var_12_6

		if var_12_4 and var_12_4 == "TowerPassLayer" then
			if arg_12_1.listenerParam and not string.nilorempty(arg_12_1.listenerParam) then
				local var_12_7 = string.split(arg_12_1.listenerParam, "#")

				var_12_6 = var_12_7 and var_12_7[3]
				var_12_6 = var_12_6 * 10
			end
		else
			var_12_6 = arg_12_1 and arg_12_1.maxProgress
		end

		local var_12_8 = var_12_6
		local var_12_9 = var_12_6 < var_12_5 and var_12_6 or var_12_5
		local var_12_10 = {
			var_12_9,
			var_12_8
		}

		var_12_0 = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementlevelview_taskprogress"), var_12_10)
	else
		var_12_0 = luaLang("p_achievementlevelview_unget")
	end

	return var_12_0
end

function var_0_0.refreshMain(arg_13_0)
	local var_13_0 = AchievementLevelModel.instance:getCurrentSelectIndex()
	local var_13_1 = AchievementLevelModel.instance:getCurrentTask()
	local var_13_2 = arg_13_0.levelItemList[var_13_0]
	local var_13_3
	local var_13_4
	local var_13_5
	local var_13_6 = AchievementModel.instance:getById(var_13_1.id)
	local var_13_7 = var_13_6 and var_13_6.hasFinished

	gohelper.setActive(var_13_2.unlock, var_13_7)
	gohelper.setActive(var_13_2.lock, not var_13_7)

	if var_13_1.image and not string.nilorempty(var_13_1.image) then
		local var_13_8 = string.split(var_13_1.image, "#")

		var_13_4 = var_13_8[1]
		var_13_5 = var_13_8[2]
		var_13_3 = var_13_8[3]
	end

	if var_13_7 then
		local function var_13_9()
			local var_14_0 = var_13_2._bgLoader:getInstGO()
		end

		var_13_2._bgLoader = PrefabInstantiate.Create(var_13_2.gounlockbg)

		var_13_2._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(var_13_4), var_13_9, arg_13_0)
		var_13_2.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_13_5))
	else
		var_13_2.simagelockbg:LoadImage(ResUrl.getAchievementIcon(var_13_3))
		var_13_2.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_13_5))
	end

	local var_13_10 = var_13_1.listenerType
	local var_13_11 = AchievementConfig.instance:getAchievement(var_13_1.achievementId)
	local var_13_12 = AchievementUtils.getAchievementProgressBySourceType(var_13_11.rule)
	local var_13_13

	if var_13_10 and var_13_10 == "TowerPassLayer" then
		if var_13_1.listenerParam and not string.nilorempty(var_13_1.listenerParam) then
			local var_13_14 = string.split(var_13_1.listenerParam, "#")

			var_13_13 = var_13_14 and var_13_14[3]
			var_13_13 = var_13_13 * 10
		end
	else
		var_13_13 = var_13_1 and var_13_1.maxProgress
	end

	if var_13_7 then
		var_13_2.txtunlocklevel.text = var_13_13 < var_13_12 and var_13_12 or var_13_13
		var_13_2.txtlocklevel.text = var_13_13 < var_13_12 and var_13_12 or var_13_13
	else
		var_13_2.txtunlocklevel.text = var_13_13 < var_13_12 and var_13_13 or var_13_12
		var_13_2.txtlocklevel.text = var_13_13 < var_13_12 and var_13_13 or var_13_12
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.levelItemList) do
		if var_13_0 == iter_13_0 then
			gohelper.setActive(iter_13_1.go, true)
		else
			gohelper.setActive(iter_13_1.go, false)
		end
	end
end

var_0_0.MaxItemCount = 3

function var_0_0.checkInitItems(arg_15_0)
	if arg_15_0._items then
		return
	end

	arg_15_0._items = {}

	for iter_15_0 = 1, var_0_0.MaxItemCount do
		local var_15_0 = arg_15_0:getUserDataTb_()
		local var_15_1 = AchievementLevelModel.instance:getTaskByIndex(iter_15_0)

		var_15_0.taskCO = var_15_1
		var_15_0.go = gohelper.findChild(arg_15_0.viewGO, "#simage_bg/#go_container/#go_icon" .. tostring(iter_15_0))
		var_15_0.golevel = gohelper.findChild(var_15_0.go, "go_icon/level" .. iter_15_0)
		var_15_0.unlock = gohelper.findChild(var_15_0.golevel, "#go_UnLocked")
		var_15_0.gounlockbg = gohelper.findChild(var_15_0.unlock, "#simage_bg")
		var_15_0.simageunlocktitle = gohelper.findChildSingleImage(var_15_0.unlock, "#simage_title")
		var_15_0.txtunlocklevel = gohelper.findChildText(var_15_0.unlock, "#txt_level")
		var_15_0.goselect = gohelper.findChild(var_15_0.go, "go_select")
		var_15_0.goachieve = gohelper.findChild(var_15_0.go, "go_achieve")
		var_15_0.txttime = gohelper.findChildText(var_15_0.go, "go_achieve/txt_time")
		var_15_0.gounachieve = gohelper.findChild(var_15_0.go, "go_unachieve")
		var_15_0.txtunachieve = gohelper.findChildText(var_15_0.go, "go_unachieve/unachieve")
		var_15_0.lock = gohelper.findChild(var_15_0.gounachieve, "#go_Locked")
		var_15_0.simagelockbg = gohelper.findChildSingleImage(var_15_0.lock, "#simage_bg")
		var_15_0.simagelocktitle = gohelper.findChildSingleImage(var_15_0.lock, "#simage_title")
		var_15_0.txtlocklevel = gohelper.findChildText(var_15_0.lock, "#txt_level")
		var_15_0.goarrow1 = gohelper.findChild(var_15_0.go, "go_arrow/#go_arrow1")
		var_15_0.goarrow2 = gohelper.findChild(var_15_0.go, "go_arrow/#go_arrow2")
		var_15_0.goarrow2Animator = gohelper.onceAddComponent(var_15_0.goarrow2, gohelper.Type_Animator)
		var_15_0.btnclick = gohelper.findChildButton(var_15_0.go, "#btn_click")

		var_15_0.btnclick:AddClickListener(arg_15_0.onClickIcon, arg_15_0, iter_15_0)

		arg_15_0._items[iter_15_0] = var_15_0

		if var_15_1 then
			local var_15_2
			local var_15_3
			local var_15_4

			if var_15_1.image and not string.nilorempty(var_15_1.image) then
				local var_15_5 = string.split(var_15_1.image, "#")

				var_15_4 = var_15_5[1]
				var_15_3 = var_15_5[2]
				var_15_2 = var_15_5[3]
			end

			local var_15_6 = AchievementModel.instance:getById(var_15_1.id)
			local var_15_7 = var_15_6 and var_15_6.hasFinished

			gohelper.setActive(var_15_0.unlock, var_15_7)
			gohelper.setActive(var_15_0.lock, not var_15_7)

			if var_15_7 then
				local function var_15_8()
					local var_16_0 = var_15_0._bgLoader:getInstGO()
				end

				var_15_0._bgLoader = PrefabInstantiate.Create(var_15_0.gounlockbg)

				var_15_0._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(var_15_4), var_15_8, arg_15_0)
				var_15_0.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_15_3))
			else
				var_15_0.simagelockbg:LoadImage(ResUrl.getAchievementIcon(var_15_2))
				var_15_0.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_15_3))
			end

			local var_15_9 = var_15_1.listenerType
			local var_15_10 = AchievementConfig.instance:getAchievement(var_15_1.achievementId)
			local var_15_11 = AchievementUtils.getAchievementProgressBySourceType(var_15_10.rule)
			local var_15_12

			if var_15_9 and var_15_9 == "TowerPassLayer" then
				if var_15_1.listenerParam and not string.nilorempty(var_15_1.listenerParam) then
					local var_15_13 = string.split(var_15_1.listenerParam, "#")

					var_15_12 = var_15_13 and var_15_13[3]
					var_15_12 = var_15_12 * 10
				end
			else
				var_15_12 = var_15_1 and var_15_1.maxProgress
			end

			if var_15_7 then
				var_15_0.txtunlocklevel.text = var_15_12 < var_15_11 and var_15_11 or var_15_12
				var_15_0.txtlocklevel.text = var_15_12 < var_15_11 and var_15_11 or var_15_12
			else
				var_15_0.txtunlocklevel.text = var_15_12 < var_15_11 and var_15_12 or var_15_11
				var_15_0.txtlocklevel.text = var_15_12 < var_15_11 and var_15_12 or var_15_11
			end
		end
	end
end

function var_0_0.onClickIcon(arg_17_0, arg_17_1)
	local var_17_0 = AchievementLevelModel.instance:getTaskByIndex(arg_17_1)

	if var_17_0 then
		arg_17_0._newTaskCache = {}

		AchievementLevelController.instance:selectTask(var_17_0.id)
	end
end

function var_0_0._btncloseOnClick(arg_18_0)
	arg_18_0:closeThis()
end

function var_0_0._btnnextOnClick(arg_19_0)
	arg_19_0._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

function var_0_0._btnprevOnClick(arg_20_0)
	arg_20_0._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

return var_0_0
