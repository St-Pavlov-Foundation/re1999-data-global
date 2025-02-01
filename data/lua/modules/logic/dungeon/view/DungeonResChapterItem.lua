module("modules.logic.dungeon.view.DungeonResChapterItem", package.seeall)

slot0 = class("DungeonResChapterItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._anim = gohelper.findChild(slot0.viewGO, "anim"):GetComponent(typeof(UnityEngine.Animator))
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "anim/#simage_icon")
	slot0._golock = gohelper.findChild(slot0.viewGO, "anim/#go_lock")
	slot0._goopentime = gohelper.findChild(slot0.viewGO, "anim/#go_opentime")
	slot0._btnclick = gohelper.findChild(slot0.viewGO, "anim/#btn_click")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "anim/#txt_deadline")
	slot0._gospecialopen = gohelper.findChild(slot0.viewGO, "anim/#go_specialopen")
	slot0._goequipmap = gohelper.findChild(slot0.viewGO, "anim/#go_equipmap")
	slot0._imagefightcountbg = gohelper.findChildImage(slot0.viewGO, "anim/#go_equipmap/fightcount/txt/#image_fightcountbg")
	slot0._txtfightcount = gohelper.findChildText(slot0.viewGO, "anim/#go_equipmap/fightcount/txt/#txt_fightcount")
	slot0._gofightcountbg = gohelper.findChild(slot0.viewGO, "anim/#go_equipmap/fightcount/bg")
	slot0._goremainfightcountbg = gohelper.findChild(slot0.viewGO, "anim/#go_equipmap/fightcount/bg2")
	slot0._goTurnBackTip = gohelper.findChild(slot0.viewGO, "anim/turnback_tipsbg")
	slot0._txtTurnBackTip = gohelper.findChildText(slot0.viewGO, "anim/turnback_tipsbg/tips")
	slot0._goDoubleDropTip = gohelper.findChild(slot0.viewGO, "anim/#go_doubledroptip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnClickDungeonCategory, slot0.replayEnterAnim, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0.onUpdateParam, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0.onUpdateParam, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, slot0.showDoubleDropTips, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.onUpdateParam, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnClickDungeonCategory, slot0.replayEnterAnim, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0.onUpdateParam, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.onUpdateParam, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, slot0.onUpdateParam, slot0)
end

slot0.AudioConfig = {
	[DungeonEnum.ChapterListType.Resource] = AudioEnum.UI.play_ui_checkpoint_sources_open,
	[DungeonEnum.ChapterListType.Insight] = AudioEnum.UI.UI_checkpoint_Insight_open
}

function slot0._btncategoryOnClick(slot0)
	if slot0._chapterCo.type == DungeonEnum.ChapterType.Gold then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GoldDungeon))

			return
		end
	elseif slot0._chapterCo.type == DungeonEnum.ChapterType.Exp then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ExperienceDungeon))

			return
		end
	elseif slot0._chapterCo.type == DungeonEnum.ChapterType.Buildings then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Buildings))

			return
		end
	elseif slot0._chapterCo.type == DungeonEnum.ChapterType.Equip and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.EquipDungeon))

		return
	end

	slot0:playAudio()

	if slot0._chapterCo.type == DungeonEnum.ChapterType.Break then
		if slot0._openTimeValid == false then
			GameFacade.showToast(ToastEnum.DungeonResChapter, slot0._chapterCo.name)

			return
		end
	elseif slot0._openTimeValid == false then
		GameFacade.showToast(ToastEnum.DungeonResChapter, slot0._chapterCo.name)

		return
	end

	DungeonModel.instance:changeCategory(slot0._chapterCo.type, false)
	DungeonController.instance:openDungeonChapterView({
		chapterId = DungeonChapterListModel.instance:getOpenTimeValidEquipChapterId(slot0._chapterCo.id)
	})
end

function slot0.playAudio(slot0)
	slot1, slot2, slot3 = DungeonModel.instance:getChapterListTypes()
	slot4 = nil

	AudioMgr.instance:trigger((not slot2 or uv0.AudioConfig[DungeonEnum.ChapterListType.Resource]) and (not slot3 or uv0.AudioConfig[DungeonEnum.ChapterListType.Insight]) and uv0.AudioConfig[DungeonEnum.ChapterListType.Resource])
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._btnclick.gameObject)
end

function slot0.onOpen(slot0)
	slot0._click:AddClickListener(slot0._btncategoryOnClick, slot0)
	slot0:initItemEffect()
end

function slot0.onClose(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateParam(slot0)
	slot0._chapterCo = slot0.viewParam
	slot0._openTimeValid = true

	gohelper.setActive(slot0._golock, false)

	slot1 = LuaUtil.isEmptyStr(slot0._chapterCo.openDay) == false

	if slot0._chapterCo.id == DungeonEnum.EquipDungeonChapterId then
		slot1 = false
	end

	slot0:showEquip(slot0._chapterCo)
	slot0:showTurnBackAddition()
	slot0:showDoubleDropTips()
	gohelper.setActive(slot0._goopentime, slot1)
	gohelper.setActive(slot0._txtdeadline.gameObject, false)
	gohelper.setActive(slot0._gospecialopen, false)

	if slot1 then
		slot0._openTimeValid = false
		slot2 = ServerTime.weekDayInServerLocal()
		slot7 = "#"
		slot3 = GameUtil.splitString2(slot0._chapterCo.openDay, true, "|", slot7)
		slot0._weekTextTab = slot0:getUserDataTb_()

		for slot7 = 1, 4 do
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.findChild(slot0.viewGO, "anim/#go_opentime/everyweek/weekbg" .. tostring(slot7))
			slot8.txt = gohelper.findChildText(slot8.go, "#txt_week" .. tostring(slot7))
			slot0._weekTextTab[slot7] = slot8

			gohelper.setActive(slot0._weekTextTab[slot7].go, false)
		end

		for slot7, slot8 in ipairs(slot3) do
			for slot12, slot13 in ipairs(slot8) do
				slot14 = tonumber(slot13)

				gohelper.setActive(slot0._weekTextTab[slot12].go, true)

				slot0._weekTextTab[slot12].txt.text = TimeUtil.weekDayToLangStr(slot14)

				if slot14 == slot2 then
					slot0._openTimeValid = true
				end
			end
		end

		if slot0._chapterCo.type == DungeonEnum.ChapterType.Break then
			if slot0._openTimeValid == false then
				gohelper.setActive(slot0._golock, true)
			end
		elseif slot0._openTimeValid == false then
			gohelper.setActive(slot0._golock, true)
		end
	end

	slot0:_showGoldEffect()
	slot0:setItemEffect()
end

function slot0._showGoldEffect(slot0)
	slot1 = DungeonModel.instance:getEquipRemainingNum() > 0

	gohelper.setActive(slot0._gofightcountbg, not slot1)
	gohelper.setActive(slot0._goremainfightcountbg, slot1)
end

function slot0.initItemEffect(slot0)
	slot0._itemEffectTabs = slot0:getUserDataTb_()

	for slot5, slot6 in pairs({
		DungeonEnum.ChapterId.ResourceExp,
		DungeonEnum.ChapterId.ResourceGold,
		DungeonEnum.EquipDungeonChapterId,
		DungeonEnum.ChapterId.InsightMountain,
		DungeonEnum.ChapterId.InsightStarfall,
		DungeonEnum.ChapterId.InsightSylvanus,
		DungeonEnum.ChapterId.InsightBrutes,
		DungeonEnum.ChapterId.HarvestDungeonChapterId
	}) do
		slot7 = slot0:getUserDataTb_()
		slot7.id = slot6
		slot7.go = gohelper.findChild(slot0.viewGO, "anim/item_" .. slot1[slot5])
		slot7.anim = slot7.go:GetComponent(typeof(UnityEngine.Animator))

		gohelper.setActive(slot7.go, false)
		table.insert(slot0._itemEffectTabs, slot7)
	end
end

function slot0.setItemEffect(slot0)
	for slot4, slot5 in pairs(slot0._itemEffectTabs) do
		if slot5.id == slot0._chapterCo.id then
			gohelper.setActive(slot5.go, true)
			slot0:setLockState(slot5.anim)
		else
			gohelper.setActive(slot5.go, false)
		end
	end
end

function slot0.replayEnterAnim(slot0)
	slot0._anim:Play("dungeonreschapteritem_in", 0, 0)
end

function slot0.showEquip(slot0, slot1)
	slot2 = slot1.enterAfterFreeLimit > 0

	gohelper.setActive(slot0._goequipmap, slot2)

	if not slot2 then
		return
	end

	slot0._remainCount = DungeonModel.instance:getChapterRemainingNum(slot1.type)
	slot3 = slot0._remainCount == 0 and "#E25D34" or "#CC6230"
	slot0._txtfightcount.text = string.format("<color=%s>%s</color>", slot3, slot0._remainCount)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagefightcountbg, slot3)
end

function slot0.showTurnBackAddition(slot0)
	if TurnbackModel.instance:isShowTurnBackAddition(slot0._chapterCo.id) then
		slot0._txtTurnBackTip.text = formatLuaLang("turnback_addition", string.format("%s%%", TurnbackConfig.instance:getAdditionRate(TurnbackModel.instance:getCurTurnbackId()) / 10))
	end

	gohelper.setActive(slot0._goTurnBackTip, slot1)

	slot0.isShowAddition = slot1
end

function slot0.showDoubleDropTips(slot0)
	if slot0.isShowAddition then
		gohelper.setActive(slot0._goDoubleDropTip, false)

		return
	end

	gohelper.setActive(slot0._goDoubleDropTip, DoubleDropModel.instance:isShowDoubleByChapter(slot0._chapterCo.id, true))
end

function slot0.setLockState(slot0, slot1)
	if slot0._openTimeValid then
		slot1:Play("item_in01", 0, 0)
	else
		slot1:Play("item_in02", 0, 0)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
