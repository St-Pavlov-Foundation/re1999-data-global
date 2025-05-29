module("modules.logic.weekwalk.view.WeekWalkShallowSettlementView", package.seeall)

local var_0_0 = class("WeekWalkShallowSettlementView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._txtlayer = gohelper.findChildText(arg_1_0.viewGO, "overview/#txt_layer")
	arg_1_0._txtstarcount = gohelper.findChildText(arg_1_0.viewGO, "overview/#txt_starcount")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "rewards/#scroll_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "rewards/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._btnreceive = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rewards/#btn_receive")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "rewards/#go_empty")
	arg_1_0._gohasreceived = gohelper.findChild(arg_1_0.viewGO, "rewards/#go_hasreceived")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnreceive:AddClickListener(arg_2_0._btnreceiveOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreceive:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnreceiveOnClick(arg_5_0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, 2)
end

function var_0_0._editableInitView(arg_6_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	arg_6_0._simagebg1:LoadImage(ResUrl.getWeekWalkBg("full/beijing_qian.jpg"))
	arg_6_0._simagebg2:LoadImage(ResUrl.getWeekWalkBg("qianmian_tcdi.png"))
	arg_6_0._simagemask:LoadImage(ResUrl.getWeekWalkBg("zhezhao.png"))

	arg_6_0._info = WeekWalkModel.instance:getInfo()

	if arg_6_0._info.isPopShallowSettle then
		arg_6_0._info.isPopShallowSettle = false

		WeekwalkRpc.instance:sendMarkPopShallowSettleRequest()
	end

	arg_6_0:_setLayerProgress()
	arg_6_0:_setProgress()
end

function var_0_0._createItemList(arg_7_0, arg_7_1)
	if not arg_7_0._itemList then
		arg_7_0._itemList = arg_7_0:getUserDataTb_()

		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			local var_7_0 = gohelper.cloneInPlace(arg_7_0._gorewarditem)

			gohelper.setActive(var_7_0, true)

			local var_7_1 = IconMgr.instance:getCommonItemIcon(gohelper.findChild(var_7_0, "go_item"))

			var_7_1:setMOValue(iter_7_1[1], iter_7_1[2], iter_7_1[3])
			var_7_1:isShowCount(true)
			var_7_1:setCountFontSize(31)

			arg_7_0._itemList[iter_7_0] = var_7_0
		end
	end
end

function var_0_0._setProgress(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = DungeonWeekWalkView.getWeekTaskProgress()
	local var_8_3 = {
		var_8_0,
		var_8_1
	}

	arg_8_0._txtstarcount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkshallowsettlementview_starcount"), var_8_3)

	arg_8_0:_createItemList(var_8_2)

	local var_8_4 = #var_8_2 > 0

	gohelper.setActive(arg_8_0._goempty, not var_8_4)

	local var_8_5 = arg_8_0:_isGetAllTask()

	gohelper.setActive(arg_8_0._gohasreceived, var_8_4 and var_8_5)
	gohelper.setActive(arg_8_0._btnreceive, var_8_4 and not var_8_5)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._itemList) do
		local var_8_6 = gohelper.findChild(iter_8_1, "go_receive")

		gohelper.setActive(var_8_6, var_8_4 and var_8_5)
	end
end

function var_0_0._isGetAllTask(arg_9_0)
	local var_9_0 = WeekWalkTaskListModel.instance:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = WeekWalkTaskListModel.instance:getTaskMo(iter_9_1.id)

		if var_9_1 and var_9_1.finishCount <= 0 and var_9_1.hasFinished then
			return false
		end
	end

	return true
end

function var_0_0._setLayerProgress(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0:_getLastShallowLayer()
	local var_10_2 = lua_weekwalk_scene.configDict[var_10_0.sceneId]
	local var_10_3 = var_10_1 and var_10_1:getNoStarBattleIndex()
	local var_10_4 = {
		var_10_2.name,
		"0" .. (var_10_3 or 1)
	}

	arg_10_0._txtlayer.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkshallowsettlementview_layer"), var_10_4)
end

function var_0_0._getLastShallowLayer(arg_11_0)
	local var_11_0
	local var_11_1

	for iter_11_0, iter_11_1 in ipairs(lua_weekwalk.configList) do
		if WeekWalkModel.isShallowMap(iter_11_1.id) then
			var_11_1 = WeekWalkModel.instance:getMapInfo(iter_11_1.id)
			var_11_0 = iter_11_1

			if not var_11_1 or var_11_1.isFinished <= 0 then
				break
			end
		else
			break
		end
	end

	return var_11_0, var_11_1
end

function var_0_0._onWeekwalkTaskUpdate(arg_12_0)
	arg_12_0:_setProgress()
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_open)
	arg_14_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_14_0._onWeekwalkTaskUpdate, arg_14_0)
end

function var_0_0.onClose(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_close)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onCloseFinish(arg_16_0)
	if arg_16_0._info.isPopDeepSettle then
		WeekWalkController.instance:checkOpenWeekWalkDeepLayerNoticeView()

		return
	end

	WeekWalk_2Controller.instance:checkOpenWeekWalk_2DeepLayerNoticeView()
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg1:UnLoadImage()
	arg_17_0._simagebg2:UnLoadImage()
	arg_17_0._simagemask:UnLoadImage()
end

return var_0_0
