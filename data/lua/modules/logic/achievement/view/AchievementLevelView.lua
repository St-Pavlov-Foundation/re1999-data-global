module("modules.logic.achievement.view.AchievementLevelView", package.seeall)

slot0 = class("AchievementLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "layout/#txt_desc")
	slot0._txtextradesc = gohelper.findChildText(slot0.viewGO, "layout/#txt_extradesc")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_next")
	slot0._btnprev = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_prev")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#simage_bg/#go_container")
	slot0._txtpage = gohelper.findChildText(slot0.viewGO, "#txt_page")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "layout/#go_Tips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnprev:AddClickListener(slot0._btnprevOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseview:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnprev:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_detailpanelbg"))
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)

	slot0._btnnextCanvasGroup = gohelper.onceAddComponent(slot0._btnnext.gameObject, typeof(UnityEngine.CanvasGroup))
	slot0._btnprevCanvasGroup = gohelper.onceAddComponent(slot0._btnprev.gameObject, typeof(UnityEngine.CanvasGroup))

	slot0:checkInitItems()

	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "layout/#go_Tips/image_TipsBG/txt_Tips")
end

function slot0.onDestroyView(slot0)
	NavigateMgr.instance:removeEscape(slot0.viewName)
	AchievementLevelController.instance:onCloseView()

	if slot0._items then
		for slot4, slot5 in pairs(slot0._items) do
			slot5.icon:dispose()
		end

		slot0._items = nil
	end

	slot0._simagebg:UnLoadImage()
end

function slot0.onOpen(slot0)
	AchievementLevelController.instance:onOpenView(slot0.viewParam.achievementId, slot0.viewParam.achievementIds)

	slot0._newTaskCache = {}

	slot0:addEventCb(AchievementLevelController.instance, AchievementEvent.LevelViewUpdated, slot0.refreshUI, slot0)
	slot0:addEventCb(AchievementController.instance, AchievementEvent.UpdateAchievements, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshInfo()
	slot0:refreshSelected()
end

slot0.BtnNormalAlpha = 1
slot0.BtnDisableAlpha = 0.3

function slot0.refreshInfo(slot0)
	if not AchievementLevelModel.instance:getCurrentTask() then
		slot0._txtdesc.text = ""
		slot0._txtextradesc.text = ""

		logError("cannot find AchievementTaskConfig, achievementId = " .. tostring(AchievementLevelModel.instance:getAchievement()))

		return
	end

	slot0._txtdesc.text = slot1.desc
	slot0._txtextradesc.text = slot1.extraDesc

	if AchievementConfig.instance:getAchievement(slot1.achievementId) then
		slot0._txtname.text = slot2.name

		slot0:updateUpGradeTipsVisible(slot1.id, slot2.groupId)
	else
		slot0._txtname.text = ""
	end

	slot0._txtpage.text = string.format("%s/%s", AchievementLevelModel.instance:getCurPageIndex(), AchievementLevelModel.instance:getTotalPageCount())
	slot0._btnnextCanvasGroup.alpha = AchievementLevelModel.instance:hasNext() and uv0.BtnNormalAlpha or uv0.BtnDisableAlpha
	slot0._btnprevCanvasGroup.alpha = AchievementLevelModel.instance:hasPrev() and uv0.BtnNormalAlpha or uv0.BtnDisableAlpha
end

function slot0.updateUpGradeTipsVisible(slot0, slot1, slot2)
	slot4 = false

	if AchievementConfig.instance:getGroup(slot2) and slot3.unLockAchievement == slot1 then
		slot4 = not AchievementModel.instance:isAchievementTaskFinished(slot1)
	end

	gohelper.setActive(slot0._goTips, slot4)

	slot0._txtTips.text = formatLuaLang("achievementlevelview_upgradetips", slot3 and slot3.name or "")
end

slot0.UnFinishIconColor = "#4D4D4D"
slot0.FinishIconColor = "#FFFFFF"

function slot0.refreshSelected(slot0)
	for slot5, slot6 in ipairs(slot0._items) do
		if AchievementLevelModel.instance:getTaskByIndex(slot5) then
			gohelper.setActive(slot6.go, true)
			slot6.icon:setData(slot7)
			gohelper.setActive(slot6.goselect, slot7 == AchievementLevelModel.instance:getCurrentTask())

			slot9 = AchievementModel.instance:getById(slot7.id) and slot8.hasFinished

			gohelper.setActive(slot6.gounachieve, not slot9)
			gohelper.setActive(slot6.goachieve, slot9)
			gohelper.setActive(slot6.goarrow1, not slot9)
			gohelper.setActive(slot6.goarrow2, slot9)

			if not slot9 then
				slot6.txtunachieve.text = slot0:getUnAchievementTip(slot8, slot7, true)
			else
				if slot8.isNew then
					slot0._newTaskCache[slot8.id] = true
				end

				if slot6.goarrow2Animator then
					slot6.goarrow2Animator:Play("arrow_open", 0, slot0._newTaskCache[slot8.id] and 0 or 1)
				end
			end

			slot6.txttime.text = slot9 and TimeUtil.localTime2ServerTimeString(slot8.finishTime) or ""

			slot6.icon:setIconColor(slot9 and uv0.FinishIconColor or uv0.UnFinishIconColor)
			slot6.icon:setSelectIconVisible(false)

			slot1 = slot9
		else
			gohelper.setActive(slot6.go, false)
		end
	end
end

function slot0.getUnAchievementTip(slot0, slot1, slot2, slot3)
	slot4 = ""

	return (not slot3 or GameUtil.getSubPlaceholderLuaLang(luaLang("achievementlevelview_taskprogress"), {
		slot1 and slot1.progress or 0,
		slot2 and slot2.maxProgress or 0
	})) and luaLang("p_achievementlevelview_unget")
end

slot0.MaxItemCount = 3

function slot0.checkInitItems(slot0)
	if slot0._items then
		return
	end

	slot0._items = {}

	for slot4 = 1, uv0.MaxItemCount do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "#simage_bg/#go_container/#go_icon" .. tostring(slot4))
		slot5.goselect = gohelper.findChild(slot5.go, "go_select")
		slot5.goachieve = gohelper.findChild(slot5.go, "go_achieve")
		slot5.txttime = gohelper.findChildText(slot5.go, "go_achieve/txt_time")
		slot5.gounachieve = gohelper.findChild(slot5.go, "go_unachieve")
		slot5.txtunachieve = gohelper.findChildText(slot5.go, "go_unachieve/unachieve")
		slot5.goarrow1 = gohelper.findChild(slot5.go, "go_arrow/#go_arrow1")
		slot5.goarrow2 = gohelper.findChild(slot5.go, "go_arrow/#go_arrow2")
		slot5.goarrow2Animator = gohelper.onceAddComponent(slot5.goarrow2, gohelper.Type_Animator)
		slot5.icon = AchievementMainIcon.New()

		slot5.icon:init(slot0:getResInst(AchievementEnum.MainIconPath, gohelper.findChild(slot5.go, "go_pos"), "icon"))
		slot5.icon:setNameTxtVisible(false)
		slot5.icon:setClickCall(slot0.onClickIcon, slot0, slot4)

		slot0._items[slot4] = slot5
	end
end

function slot0.onClickIcon(slot0, slot1)
	if AchievementLevelModel.instance:getTaskByIndex(slot1) then
		slot0._newTaskCache = {}

		AchievementLevelController.instance:selectTask(slot2.id)
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnnextOnClick(slot0)
	slot0._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

function slot0._btnprevOnClick(slot0)
	slot0._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

return slot0
