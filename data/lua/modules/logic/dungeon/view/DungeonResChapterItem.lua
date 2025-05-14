module("modules.logic.dungeon.view.DungeonResChapterItem", package.seeall)

local var_0_0 = class("DungeonResChapterItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = gohelper.findChild(arg_1_0.viewGO, "anim"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/#simage_icon")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "anim/#go_lock")
	arg_1_0._goopentime = gohelper.findChild(arg_1_0.viewGO, "anim/#go_opentime")
	arg_1_0._btnclick = gohelper.findChild(arg_1_0.viewGO, "anim/#btn_click")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "anim/#txt_deadline")
	arg_1_0._gospecialopen = gohelper.findChild(arg_1_0.viewGO, "anim/#go_specialopen")
	arg_1_0._goequipmap = gohelper.findChild(arg_1_0.viewGO, "anim/#go_equipmap")
	arg_1_0._imagefightcountbg = gohelper.findChildImage(arg_1_0.viewGO, "anim/#go_equipmap/fightcount/txt/#image_fightcountbg")
	arg_1_0._txtfightcount = gohelper.findChildText(arg_1_0.viewGO, "anim/#go_equipmap/fightcount/txt/#txt_fightcount")
	arg_1_0._gofightcountbg = gohelper.findChild(arg_1_0.viewGO, "anim/#go_equipmap/fightcount/bg")
	arg_1_0._goremainfightcountbg = gohelper.findChild(arg_1_0.viewGO, "anim/#go_equipmap/fightcount/bg2")
	arg_1_0._goTurnBackTip = gohelper.findChild(arg_1_0.viewGO, "anim/turnback_tipsbg")
	arg_1_0._txtTurnBackTip = gohelper.findChildText(arg_1_0.viewGO, "anim/turnback_tipsbg/tips")
	arg_1_0._goDoubleDropTip = gohelper.findChild(arg_1_0.viewGO, "anim/#go_doubledroptip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnClickDungeonCategory, arg_2_0.replayEnterAnim, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0.onUpdateParam, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0.onUpdateParam, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_2_0.showDoubleDropTips, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.onUpdateParam, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnClickDungeonCategory, arg_3_0.replayEnterAnim, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_3_0.onUpdateParam, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.onUpdateParam, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_3_0.onUpdateParam, arg_3_0)
end

var_0_0.AudioConfig = {
	[DungeonEnum.ChapterListType.Resource] = AudioEnum.UI.play_ui_checkpoint_sources_open,
	[DungeonEnum.ChapterListType.Insight] = AudioEnum.UI.UI_checkpoint_Insight_open
}

function var_0_0._btncategoryOnClick(arg_4_0)
	if arg_4_0._chapterCo.type == DungeonEnum.ChapterType.Gold then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GoldDungeon))

			return
		end
	elseif arg_4_0._chapterCo.type == DungeonEnum.ChapterType.Exp then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ExperienceDungeon))

			return
		end
	elseif arg_4_0._chapterCo.type == DungeonEnum.ChapterType.Buildings then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Buildings))

			return
		end
	elseif arg_4_0._chapterCo.type == DungeonEnum.ChapterType.Equip and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.EquipDungeon))

		return
	end

	arg_4_0:playAudio()

	if arg_4_0._chapterCo.type == DungeonEnum.ChapterType.Break then
		if arg_4_0._openTimeValid == false then
			GameFacade.showToast(ToastEnum.DungeonResChapter, arg_4_0._chapterCo.name)

			return
		end
	elseif arg_4_0._openTimeValid == false then
		GameFacade.showToast(ToastEnum.DungeonResChapter, arg_4_0._chapterCo.name)

		return
	end

	DungeonModel.instance:changeCategory(arg_4_0._chapterCo.type, false)

	local var_4_0 = {
		chapterId = DungeonChapterListModel.instance:getOpenTimeValidEquipChapterId(arg_4_0._chapterCo.id)
	}

	DungeonController.instance:openDungeonChapterView(var_4_0)
end

function var_0_0.playAudio(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = DungeonModel.instance:getChapterListTypes()
	local var_5_3

	if var_5_1 then
		var_5_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Resource]
	elseif var_5_2 then
		var_5_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Insight]
	else
		var_5_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Resource]
	end

	AudioMgr.instance:trigger(var_5_3)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._click = SLFramework.UGUI.UIClickListener.Get(arg_6_0._btnclick.gameObject)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._click:AddClickListener(arg_7_0._btncategoryOnClick, arg_7_0)
	arg_7_0:initItemEffect()
end

function var_0_0.onClose(arg_8_0)
	arg_8_0._click:RemoveClickListener()
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0._chapterCo = arg_9_0.viewParam
	arg_9_0._openTimeValid = true

	gohelper.setActive(arg_9_0._golock, false)

	local var_9_0 = LuaUtil.isEmptyStr(arg_9_0._chapterCo.openDay) == false

	if arg_9_0._chapterCo.id == DungeonEnum.EquipDungeonChapterId then
		var_9_0 = false
	end

	arg_9_0:showEquip(arg_9_0._chapterCo)
	arg_9_0:showTurnBackAddition()
	arg_9_0:showDoubleDropTips()
	gohelper.setActive(arg_9_0._goopentime, var_9_0)
	gohelper.setActive(arg_9_0._txtdeadline.gameObject, false)
	gohelper.setActive(arg_9_0._gospecialopen, false)

	if var_9_0 then
		arg_9_0._openTimeValid = false

		local var_9_1 = ServerTime.weekDayInServerLocal()
		local var_9_2 = GameUtil.splitString2(arg_9_0._chapterCo.openDay, true, "|", "#")

		arg_9_0._weekTextTab = arg_9_0:getUserDataTb_()

		for iter_9_0 = 1, 4 do
			local var_9_3 = arg_9_0:getUserDataTb_()

			var_9_3.go = gohelper.findChild(arg_9_0.viewGO, "anim/#go_opentime/everyweek/weekbg" .. tostring(iter_9_0))
			var_9_3.txt = gohelper.findChildText(var_9_3.go, "#txt_week" .. tostring(iter_9_0))
			arg_9_0._weekTextTab[iter_9_0] = var_9_3

			gohelper.setActive(arg_9_0._weekTextTab[iter_9_0].go, false)
		end

		for iter_9_1, iter_9_2 in ipairs(var_9_2) do
			for iter_9_3, iter_9_4 in ipairs(iter_9_2) do
				local var_9_4 = tonumber(iter_9_4)

				gohelper.setActive(arg_9_0._weekTextTab[iter_9_3].go, true)

				arg_9_0._weekTextTab[iter_9_3].txt.text = TimeUtil.weekDayToLangStr(var_9_4)

				if var_9_4 == var_9_1 then
					arg_9_0._openTimeValid = true
				end
			end
		end

		if arg_9_0._chapterCo.type == DungeonEnum.ChapterType.Break then
			if arg_9_0._openTimeValid == false then
				gohelper.setActive(arg_9_0._golock, true)
			end
		elseif arg_9_0._openTimeValid == false then
			gohelper.setActive(arg_9_0._golock, true)
		end
	end

	arg_9_0:_showGoldEffect()
	arg_9_0:setItemEffect()
end

function var_0_0._showGoldEffect(arg_10_0)
	local var_10_0 = DungeonModel.instance:getEquipRemainingNum() > 0

	gohelper.setActive(arg_10_0._gofightcountbg, not var_10_0)
	gohelper.setActive(arg_10_0._goremainfightcountbg, var_10_0)
end

function var_0_0.initItemEffect(arg_11_0)
	local var_11_0 = {
		DungeonEnum.ChapterId.ResourceExp,
		DungeonEnum.ChapterId.ResourceGold,
		DungeonEnum.EquipDungeonChapterId,
		DungeonEnum.ChapterId.InsightMountain,
		DungeonEnum.ChapterId.InsightStarfall,
		DungeonEnum.ChapterId.InsightSylvanus,
		DungeonEnum.ChapterId.InsightBrutes,
		DungeonEnum.ChapterId.HarvestDungeonChapterId
	}

	arg_11_0._itemEffectTabs = arg_11_0:getUserDataTb_()

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_1 = arg_11_0:getUserDataTb_()

		var_11_1.id = iter_11_1
		var_11_1.go = gohelper.findChild(arg_11_0.viewGO, "anim/item_" .. var_11_0[iter_11_0])
		var_11_1.anim = var_11_1.go:GetComponent(typeof(UnityEngine.Animator))

		gohelper.setActive(var_11_1.go, false)
		table.insert(arg_11_0._itemEffectTabs, var_11_1)
	end
end

function var_0_0.setItemEffect(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._itemEffectTabs) do
		if iter_12_1.id == arg_12_0._chapterCo.id then
			gohelper.setActive(iter_12_1.go, true)
			arg_12_0:setLockState(iter_12_1.anim)
		else
			gohelper.setActive(iter_12_1.go, false)
		end
	end
end

function var_0_0.replayEnterAnim(arg_13_0)
	arg_13_0._anim:Play("dungeonreschapteritem_in", 0, 0)
end

function var_0_0.showEquip(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.enterAfterFreeLimit > 0

	gohelper.setActive(arg_14_0._goequipmap, var_14_0)

	if not var_14_0 then
		return
	end

	arg_14_0._remainCount = DungeonModel.instance:getChapterRemainingNum(arg_14_1.type)

	local var_14_1 = arg_14_0._remainCount == 0 and "#E25D34" or "#CC6230"

	arg_14_0._txtfightcount.text = string.format("<color=%s>%s</color>", var_14_1, arg_14_0._remainCount)

	SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._imagefightcountbg, var_14_1)
end

function var_0_0.showTurnBackAddition(arg_15_0)
	local var_15_0 = TurnbackModel.instance:isShowTurnBackAddition(arg_15_0._chapterCo.id)

	if var_15_0 then
		local var_15_1 = TurnbackModel.instance:getCurTurnbackId()
		local var_15_2 = TurnbackConfig.instance:getAdditionRate(var_15_1)
		local var_15_3 = string.format("%s%%", var_15_2 / 10)

		arg_15_0._txtTurnBackTip.text = formatLuaLang("turnback_addition", var_15_3)
	end

	gohelper.setActive(arg_15_0._goTurnBackTip, var_15_0)

	arg_15_0.isShowAddition = var_15_0
end

function var_0_0.showDoubleDropTips(arg_16_0)
	if arg_16_0.isShowAddition then
		gohelper.setActive(arg_16_0._goDoubleDropTip, false)

		return
	end

	local var_16_0 = DoubleDropModel.instance:isShowDoubleByChapter(arg_16_0._chapterCo.id, true)

	gohelper.setActive(arg_16_0._goDoubleDropTip, var_16_0)
end

function var_0_0.setLockState(arg_17_0, arg_17_1)
	if arg_17_0._openTimeValid then
		arg_17_1:Play("item_in01", 0, 0)
	else
		arg_17_1:Play("item_in02", 0, 0)
	end
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
