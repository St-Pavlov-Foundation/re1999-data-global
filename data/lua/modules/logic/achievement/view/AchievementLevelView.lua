module("modules.logic.achievement.view.AchievementLevelView", package.seeall)

local var_0_0 = class("AchievementLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "layout/#txt_desc")
	arg_1_0._txtextradesc = gohelper.findChildText(arg_1_0.viewGO, "layout/#txt_extradesc")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_next")
	arg_1_0._btnprev = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_prev")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_container")
	arg_1_0._txtpage = gohelper.findChildText(arg_1_0.viewGO, "#txt_page")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "layout/#go_Tips")

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

	arg_4_0:checkInitItems()

	arg_4_0._txtTips = gohelper.findChildText(arg_4_0.viewGO, "layout/#go_Tips/image_TipsBG/txt_Tips")
end

function var_0_0.onDestroyView(arg_5_0)
	NavigateMgr.instance:removeEscape(arg_5_0.viewName)
	AchievementLevelController.instance:onCloseView()

	if arg_5_0._items then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._items) do
			iter_5_1.icon:dispose()
		end

		arg_5_0._items = nil
	end

	arg_5_0._simagebg:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.achievementId
	local var_6_1 = arg_6_0.viewParam.achievementIds

	AchievementLevelController.instance:onOpenView(var_6_0, var_6_1)

	arg_6_0._newTaskCache = {}

	arg_6_0:addEventCb(AchievementLevelController.instance, AchievementEvent.LevelViewUpdated, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(AchievementController.instance, AchievementEvent.UpdateAchievements, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshInfo()
	arg_8_0:refreshSelected()
end

var_0_0.BtnNormalAlpha = 1
var_0_0.BtnDisableAlpha = 0.3

function var_0_0.refreshInfo(arg_9_0)
	local var_9_0 = AchievementLevelModel.instance:getCurrentTask()

	if not var_9_0 then
		arg_9_0._txtdesc.text = ""
		arg_9_0._txtextradesc.text = ""

		logError("cannot find AchievementTaskConfig, achievementId = " .. tostring(AchievementLevelModel.instance:getAchievement()))

		return
	end

	arg_9_0._txtdesc.text = var_9_0.desc
	arg_9_0._txtextradesc.text = var_9_0.extraDesc

	local var_9_1 = AchievementConfig.instance:getAchievement(var_9_0.achievementId)

	if var_9_1 then
		arg_9_0._txtname.text = var_9_1.name

		arg_9_0:updateUpGradeTipsVisible(var_9_0.id, var_9_1.groupId)
	else
		arg_9_0._txtname.text = ""
	end

	arg_9_0._txtpage.text = string.format("%s/%s", AchievementLevelModel.instance:getCurPageIndex(), AchievementLevelModel.instance:getTotalPageCount())
	arg_9_0._btnnextCanvasGroup.alpha = AchievementLevelModel.instance:hasNext() and var_0_0.BtnNormalAlpha or var_0_0.BtnDisableAlpha
	arg_9_0._btnprevCanvasGroup.alpha = AchievementLevelModel.instance:hasPrev() and var_0_0.BtnNormalAlpha or var_0_0.BtnDisableAlpha
end

function var_0_0.updateUpGradeTipsVisible(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = AchievementConfig.instance:getGroup(arg_10_2)
	local var_10_1 = false

	if var_10_0 and var_10_0.unLockAchievement == arg_10_1 then
		var_10_1 = not AchievementModel.instance:isAchievementTaskFinished(arg_10_1)
	end

	gohelper.setActive(arg_10_0._goTips, var_10_1)

	arg_10_0._txtTips.text = formatLuaLang("achievementlevelview_upgradetips", var_10_0 and var_10_0.name or "")
end

var_0_0.UnFinishIconColor = "#4D4D4D"
var_0_0.FinishIconColor = "#FFFFFF"

function var_0_0.refreshSelected(arg_11_0)
	local var_11_0 = true

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._items) do
		local var_11_1 = AchievementLevelModel.instance:getTaskByIndex(iter_11_0)

		if var_11_1 then
			gohelper.setActive(iter_11_1.go, true)
			iter_11_1.icon:setData(var_11_1)
			gohelper.setActive(iter_11_1.goselect, var_11_1 == AchievementLevelModel.instance:getCurrentTask())

			local var_11_2 = AchievementModel.instance:getById(var_11_1.id)
			local var_11_3 = var_11_2 and var_11_2.hasFinished

			gohelper.setActive(iter_11_1.gounachieve, not var_11_3)
			gohelper.setActive(iter_11_1.goachieve, var_11_3)
			gohelper.setActive(iter_11_1.goarrow1, not var_11_3)
			gohelper.setActive(iter_11_1.goarrow2, var_11_3)

			if not var_11_3 then
				iter_11_1.txtunachieve.text = arg_11_0:getUnAchievementTip(var_11_2, var_11_1, var_11_0)
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

			iter_11_1.icon:setIconColor(var_11_3 and var_0_0.FinishIconColor or var_0_0.UnFinishIconColor)
			iter_11_1.icon:setSelectIconVisible(false)

			var_11_0 = var_11_3
		else
			gohelper.setActive(iter_11_1.go, false)
		end
	end
end

function var_0_0.getUnAchievementTip(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = ""

	if arg_12_3 then
		local var_12_1 = arg_12_2 and arg_12_2.maxProgress or 0
		local var_12_2 = arg_12_1 and arg_12_1.progress or 0
		local var_12_3 = {
			var_12_2,
			var_12_1
		}

		var_12_0 = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementlevelview_taskprogress"), var_12_3)
	else
		var_12_0 = luaLang("p_achievementlevelview_unget")
	end

	return var_12_0
end

var_0_0.MaxItemCount = 3

function var_0_0.checkInitItems(arg_13_0)
	if arg_13_0._items then
		return
	end

	arg_13_0._items = {}

	for iter_13_0 = 1, var_0_0.MaxItemCount do
		local var_13_0 = arg_13_0:getUserDataTb_()

		var_13_0.go = gohelper.findChild(arg_13_0.viewGO, "#simage_bg/#go_container/#go_icon" .. tostring(iter_13_0))
		var_13_0.goselect = gohelper.findChild(var_13_0.go, "go_select")
		var_13_0.goachieve = gohelper.findChild(var_13_0.go, "go_achieve")
		var_13_0.txttime = gohelper.findChildText(var_13_0.go, "go_achieve/txt_time")
		var_13_0.gounachieve = gohelper.findChild(var_13_0.go, "go_unachieve")
		var_13_0.txtunachieve = gohelper.findChildText(var_13_0.go, "go_unachieve/unachieve")
		var_13_0.goarrow1 = gohelper.findChild(var_13_0.go, "go_arrow/#go_arrow1")
		var_13_0.goarrow2 = gohelper.findChild(var_13_0.go, "go_arrow/#go_arrow2")
		var_13_0.goarrow2Animator = gohelper.onceAddComponent(var_13_0.goarrow2, gohelper.Type_Animator)

		local var_13_1 = gohelper.findChild(var_13_0.go, "go_pos")
		local var_13_2 = arg_13_0:getResInst(AchievementEnum.MainIconPath, var_13_1, "icon")

		var_13_0.icon = AchievementMainIcon.New()

		var_13_0.icon:init(var_13_2)
		var_13_0.icon:setNameTxtVisible(false)
		var_13_0.icon:setClickCall(arg_13_0.onClickIcon, arg_13_0, iter_13_0)

		arg_13_0._items[iter_13_0] = var_13_0
	end
end

function var_0_0.onClickIcon(arg_14_0, arg_14_1)
	local var_14_0 = AchievementLevelModel.instance:getTaskByIndex(arg_14_1)

	if var_14_0 then
		arg_14_0._newTaskCache = {}

		AchievementLevelController.instance:selectTask(var_14_0.id)
	end
end

function var_0_0._btncloseOnClick(arg_15_0)
	arg_15_0:closeThis()
end

function var_0_0._btnnextOnClick(arg_16_0)
	arg_16_0._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

function var_0_0._btnprevOnClick(arg_17_0)
	arg_17_0._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

return var_0_0
