module("modules.logic.weekwalk.view.WeekWalkLayerRewardView", package.seeall)

local var_0_0 = class("WeekWalkLayerRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txttitlecn = gohelper.findChildText(arg_1_0.viewGO, "#txt_titlecn")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_titlecn/#txt_name")
	arg_1_0._txtstar = gohelper.findChildText(arg_1_0.viewGO, "#txt_star")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#scroll_reward")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_reward/viewport/#go_rewardcontent")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtdeeptip = gohelper.findChildText(arg_1_0.viewGO, "#txt_deeptip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_5_0._onWeekwalkTaskUpdate, arg_5_0)
	arg_5_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetTaskReward, arg_5_0._getTaskBouns, arg_5_0)
	arg_5_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnChangeLayerRewardMapId, arg_5_0._onChangeLayerRewardMapId, arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("img_bg_black.png"))
end

function var_0_0._updateTask(arg_6_0)
	local var_6_0 = WeekWalkRewardView.getTaskType(arg_6_0._mapId)

	WeekWalkTaskListModel.instance:showLayerTaskList(var_6_0, arg_6_0._mapId)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0._onChangeLayerRewardMapId(arg_8_0, arg_8_1)
	arg_8_0._mapId = arg_8_1

	gohelper.setActive(arg_8_0._txtdeeptip.gameObject, not WeekWalkModel.isShallowMap(arg_8_0._mapId))
	arg_8_0:_updateTask()
	arg_8_0:_updateInfo()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:_onChangeLayerRewardMapId(arg_9_0.viewParam.mapId)
end

function var_0_0._onWeekwalkTaskUpdate(arg_10_0)
	if not arg_10_0._getTaskBonusItem then
		return
	end

	arg_10_0._getTaskBonusItem:playOutAnim()

	arg_10_0._getTaskBonusItem = nil

	UIBlockMgr.instance:startBlock("WeekWalkLayerRewardView bonus")
	TaskDispatcher.runDelay(arg_10_0._showRewards, arg_10_0, 0.3)
end

function var_0_0._getTaskBouns(arg_11_0, arg_11_1)
	arg_11_0._getTaskBonusItem = arg_11_1
end

function var_0_0._showRewards(arg_12_0)
	arg_12_0:_updateTask()
	arg_12_0:_updateInfo()
	UIBlockMgr.instance:endBlock("WeekWalkLayerRewardView bonus")

	local var_12_0 = WeekWalkTaskListModel.instance:getTaskRewardList()

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_12_0)
end

function var_0_0._updateInfo(arg_13_0)
	local var_13_0 = WeekWalkTaskListModel.instance:getList()
	local var_13_1 = 0
	local var_13_2 = 0

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_1.maxProgress then
			var_13_2 = math.max(var_13_2, iter_13_1.maxProgress)
		end
	end

	local var_13_3 = lua_weekwalk.configDict[arg_13_0._mapId].sceneId
	local var_13_4 = lua_weekwalk_scene.configDict[var_13_3]

	arg_13_0._txtname.text = var_13_4.name
	arg_13_0._txttitlecn.text = luaLang(WeekWalkModel.instance.isShallowMap(arg_13_0._mapId) and "p_weekwalklayerrewardview_shallowtitle" or "p_weekwalklayerrewardview_deeptitle")
	arg_13_0._mapInfo = WeekWalkModel.instance:getMapInfo(arg_13_0._mapId)

	if arg_13_0._mapInfo then
		var_13_1 = arg_13_0._mapInfo:getCurStarInfo()
	end

	arg_13_0._txtstar.text = string.format("%s/%s", var_13_1, var_13_2)
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._showRewards, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simagebg:UnLoadImage()
end

return var_0_0
