module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonView", package.seeall)

local var_0_0 = class("VersionActivity1_4DungeonView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._gopath = gohelper.findChild(arg_1_0.viewGO, "root/#go_path")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "root/#go_path/#go_stages")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "root/#go_title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "root/#go_title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "root/#go_title/#go_time/#txt_limittime")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_task")
	arg_1_0._txttasknum = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#btn_task/#txt_TaskNum")
	arg_1_0._goreddotreward = gohelper.findChild(arg_1_0.viewGO, "root/#btn_task/#go_reddotreward")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._stageItemList = {}
	arg_1_0._animPath = gohelper.findChildComponent(arg_1_0.viewGO, "root/#go_path", typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_4DungeonController.instance, VersionActivity1_4DungeonEvent.OnSelectEpisodeId, arg_2_0.onSelect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_4DungeonController.instance, VersionActivity1_4DungeonEvent.OnSelectEpisodeId, arg_3_0.onSelect, arg_3_0)
end

function var_0_0._btntaskOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.Activity129View, {
		actId = VersionActivity1_4Enum.ActivityId.DungeonStore
	})
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage("singlebg/v1a4_role37_singlebg/v1a4_dungeon_fullbg.png")
end

function var_0_0.onSelect(arg_6_0)
	if VersionActivity1_4DungeonModel.instance:getSelectEpisodeId() then
		gohelper.setActive(arg_6_0._goroot, false)
		gohelper.setActive(arg_6_0._gobtns, false)
	else
		gohelper.setActive(arg_6_0._goroot, true)
		gohelper.setActive(arg_6_0._gobtns, true)
		arg_6_0:refreshStages()
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_4DungeonEpisodeView)
end

function var_0_0._onCurrencyChange(arg_8_0, arg_8_1)
	local var_8_0 = Activity129Config.instance:getConstValue1(VersionActivity1_4Enum.ActivityId.DungeonStore, Activity129Enum.ConstEnum.CostId)

	if not arg_8_1[var_8_0] then
		return
	end

	local var_8_1 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_8_0)

	arg_8_0._txttasknum.text = tostring(var_8_1)
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_revelation_open)

	arg_9_0.actId = arg_9_0.viewParam.actId

	ActivityEnterMgr.instance:enterActivity(arg_9_0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_9_0.actId
	})
	arg_9_0:refreshStages()
	TaskDispatcher.runRepeat(arg_9_0._showLeftTime, arg_9_0, 60)
	arg_9_0:_showLeftTime()

	local var_9_0 = Activity129Config.instance:getConstValue1(VersionActivity1_4Enum.ActivityId.DungeonStore, Activity129Enum.ConstEnum.CostId)
	local var_9_1 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_9_0)

	arg_9_0._txttasknum.text = tostring(var_9_1)
end

function var_0_0.refreshStages(arg_10_0)
	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes[1]
	local var_10_1
	local var_10_2
	local var_10_3 = DungeonConfig.instance:getChapterEpisodeCOList(14101)

	for iter_10_0 = 1, math.max(#arg_10_0._stageItemList, #var_10_3) do
		local var_10_4 = arg_10_0._stageItemList[iter_10_0]

		if not var_10_4 then
			local var_10_5 = gohelper.findChild(arg_10_0._gostages, "stage" .. iter_10_0)
			local var_10_6 = arg_10_0:getResInst(var_10_0, var_10_5)

			var_10_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_6, VersionActivity1_4DungeonItem, arg_10_0, iter_10_0)
			arg_10_0._stageItemList[iter_10_0] = var_10_4
		end

		local var_10_7, var_10_8 = var_10_4:refreshItem(var_10_3[iter_10_0], iter_10_0)

		if var_10_8 then
			var_10_2 = iter_10_0
		end

		if var_10_7 then
			var_10_1 = iter_10_0
		end
	end

	TaskDispatcher.cancelTask(arg_10_0.playAnim, arg_10_0)

	if var_10_1 then
		arg_10_0.animName = "go_0" .. tostring(var_10_1 - 1)

		TaskDispatcher.runDelay(arg_10_0.playAnim, arg_10_0, 1)
	else
		var_10_2 = var_10_2 or 1
		arg_10_0.animName = "idle_0" .. tostring(var_10_2 - 1)

		arg_10_0:playAnim()
	end
end

function var_0_0.playAnim(arg_11_0)
	arg_11_0._animPath:Play(arg_11_0.animName)
end

function var_0_0._showLeftTime(arg_12_0)
	local var_12_0 = ActivityModel.instance:getActMO(arg_12_0.actId)

	if not var_12_0 then
		return
	end

	arg_12_0._txtlimittime.text = string.format(luaLang("activity_warmup_remain_time"), var_12_0:getRemainTimeStr2ByEndTime())
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._showLeftTime, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.playAnim, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simagebg:UnLoadImage()
end

return var_0_0
