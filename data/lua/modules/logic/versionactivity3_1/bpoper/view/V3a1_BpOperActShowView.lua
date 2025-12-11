module("modules.logic.versionactivity3_1.bpoper.view.V3a1_BpOperActShowView", package.seeall)

local var_0_0 = class("V3a1_BpOperActShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._goskin = gohelper.findChild(arg_1_0.viewGO, "Left/image_Skin")
	arg_1_0._skinClick = gohelper.getClickWithAudio(arg_1_0._goskin, AudioEnum.UI.play_artificial_ui_carddisappear)
	arg_1_0._simagelogo2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_logo2")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Info")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_desc")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_remainTime")
	arg_1_0._goscrollList = gohelper.findChild(arg_1_0.viewGO, "Right/#go_scroll_List")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_scroll_List/Viewport/Content/#go_item")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "Right/Bottom/Level/icon/#txt_lv")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "Right/Bottom/txt_decibel/#txt_total")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/Bottom/#go_reddot")
	arg_1_0._btnarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Bottom/#btn_arrow")
	arg_1_0._gomax = gohelper.findChild(arg_1_0.viewGO, "Right/#go_max")
	arg_1_0._txtmax = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_max/txt_MAX")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnInfo:AddClickListener(arg_2_0._btnInfoOnClick, arg_2_0)
	arg_2_0._btnarrow:AddClickListener(arg_2_0._btnarrowOnClick, arg_2_0)
	arg_2_0._skinClick:AddClickListener(arg_2_0._onSkinClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnInfo:RemoveClickListener()
	arg_3_0._btnarrow:RemoveClickListener()
	arg_3_0._skinClick:RemoveClickListener()
end

function var_0_0._btnarrowOnClick(arg_4_0)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.BpOperActLvUpReddotShow, 0)
	gohelper.setActive(arg_4_0._goreddot, false)
	arg_4_0:closeThis()

	if ViewMgr.instance:isOpen(ViewName.ActivityBeginnerView) then
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	end

	BpController.instance:openBattlePassView()
end

function var_0_0._btnInfoOnClick(arg_5_0)
	local var_5_0 = CommonConfig.instance:getConstStr(ConstEnum.BPOperActTitle)
	local var_5_1 = CommonConfig.instance:getConstStr(ConstEnum.BPOperActDesc)

	HelpController.instance:openStoreTipView(var_5_1, var_5_0)
end

function var_0_0._onSkinClick(arg_6_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._taskItems = {}

	arg_7_0:_addEvents()
end

function var_0_0._getInfoSuccess(arg_8_0, arg_8_1)
	local var_8_0 = false

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if iter_8_1 == TaskEnum.TaskType.BpOperAct then
			var_8_0 = true
		end
	end

	if not var_8_0 then
		return
	end

	arg_8_0:_refresh(true)
end

function var_0_0._addEvents(arg_9_0)
	arg_9_0:addEventCb(BpController.instance, BpEvent.OnLevelUp, arg_9_0._onBpLevelUp, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_9_0._updateTask, arg_9_0)
end

function var_0_0._removeEvents(arg_10_0)
	arg_10_0:removeEventCb(BpController.instance, BpEvent.OnLevelUp, arg_10_0._onBpLevelUp, arg_10_0)
	arg_10_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_10_0._updateTask, arg_10_0)
end

function var_0_0._onBpLevelUp(arg_11_0, arg_11_1)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.BpOperActLvUpReddotShow, arg_11_1)
	arg_11_0:_refresh()
end

function var_0_0._updateTask(arg_12_0)
	arg_12_0:_refresh()
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	local var_14_0 = arg_14_0.viewParam.parent

	gohelper.addChild(var_14_0, arg_14_0.viewGO)
	AudioMgr.instance:trigger(AudioEnum3_1.BpOperAct.play_ui_bpoper_turn_card)

	arg_14_0._actId = arg_14_0.viewParam.actId
	arg_14_0._config = ActivityConfig.instance:getActivityCo(arg_14_0._actId)
	arg_14_0._txtdesc.text = arg_14_0._config.actDesc

	arg_14_0:_refreshRemainTime()
	gohelper.setActive(arg_14_0._gomax, false)
	arg_14_0:_refresh(true)
	TaskDispatcher.runRepeat(arg_14_0._refreshRemainTime, arg_14_0, TimeUtil.OneMinuteSecond)
end

function var_0_0._refreshRemainTime(arg_15_0)
	arg_15_0._txtremainTime.text = arg_15_0:_getRemainTimeStr()
end

function var_0_0._getRemainTimeStr(arg_16_0)
	local var_16_0 = ActivityModel.instance:getRemainTimeSec(arg_16_0._actId) or 0

	if var_16_0 <= 0 then
		return luaLang("turnback_end")
	end

	local var_16_1, var_16_2, var_16_3, var_16_4 = TimeUtil.secondsToDDHHMMSS(var_16_0)

	if var_16_1 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_16_1,
			var_16_2
		})
	elseif var_16_2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			var_16_2,
			var_16_3
		})
	elseif var_16_3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			var_16_3
		})
	elseif var_16_4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function var_0_0._refresh(arg_17_0, arg_17_1)
	local var_17_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_17_1 = math.floor(BpModel.instance.score / var_17_0)
	local var_17_2 = BpModel.instance.score % var_17_0

	arg_17_0._txtlv.text = var_17_1
	arg_17_0._txttotal.text = var_17_2 .. "/" .. var_17_0

	local var_17_3 = NationalGiftModel.instance:isNeedShowReddot()

	gohelper.setActive(arg_17_0._goreddot, var_17_3)
	arg_17_0:_refreshTask(arg_17_1)
end

function var_0_0._refreshTask(arg_18_0, arg_18_1)
	local var_18_0 = V3a1_BpOperActModel.instance:isAllTaskFinihshed()
	local var_18_1 = BpModel.instance:isMaxLevel()

	gohelper.setActive(arg_18_0._gomax, var_18_0 or var_18_1)

	if var_18_0 then
		arg_18_0._txtmax.text = luaLang("v3a1_bpoperactshowview_txt_finish")
	end

	if var_18_1 then
		arg_18_0._txtmax.text = luaLang("v3a1_bpoperactshowview_txt_MAX")
	end

	local var_18_2 = V3a1_BpOperActModel.instance:getAllShowTask()

	for iter_18_0, iter_18_1 in pairs(arg_18_0._taskItems) do
		iter_18_1:show(false)
	end

	for iter_18_2, iter_18_3 in ipairs(var_18_2) do
		local var_18_3 = V3a1_BpOperActConfig.instance:getTaskCO(iter_18_3)

		if not arg_18_0._taskItems[var_18_3.id] then
			arg_18_0._taskItems[var_18_3.id] = V3a1_BpOperActShowTaskItem.New()

			local var_18_4 = gohelper.cloneInPlace(arg_18_0._goitem)

			arg_18_0._taskItems[var_18_3.id]:init(var_18_4, var_18_3, iter_18_2)
		end

		gohelper.setSibling(arg_18_0._taskItems[var_18_3.id].go, iter_18_2 - 1)
		arg_18_0._taskItems[var_18_3.id]:show(true, arg_18_1)
		arg_18_0._taskItems[var_18_3.id]:refresh()
	end
end

function var_0_0.onClose(arg_19_0)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.BpOperActLvUpReddotShow, 0)
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_20_0._refreshRemainTime, arg_20_0)

	if arg_20_0._taskItems then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._taskItems) do
			iter_20_1:destroy()
		end

		arg_20_0._taskItems = nil
	end
end

return var_0_0
