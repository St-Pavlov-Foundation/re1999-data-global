module("modules.logic.weekwalk_2.view.WeekWalk_2LayerRewardView", package.seeall)

local var_0_0 = class("WeekWalk_2LayerRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goicons1 = gohelper.findChild(arg_1_0.viewGO, "go_star/starlist/#go_icons1")
	arg_1_0._txtchapternum1 = gohelper.findChildText(arg_1_0.viewGO, "go_star/starlist/#go_icons1/#txt_chapternum1")
	arg_1_0._goicons2 = gohelper.findChild(arg_1_0.viewGO, "go_star/starlist/#go_icons2")
	arg_1_0._txtchapternum2 = gohelper.findChildText(arg_1_0.viewGO, "go_star/starlist/#go_icons2/#txt_chapternum2")
	arg_1_0._txttitlecn = gohelper.findChildText(arg_1_0.viewGO, "#txt_titlecn")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_titlecn/#txt_name")
	arg_1_0._txtmaintitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_maintitle")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#scroll_reward")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_reward/fade/viewport/#go_rewardcontent")

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
	arg_5_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, arg_5_0._onWeekwalkTaskUpdate, arg_5_0)
	arg_5_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetTaskReward, arg_5_0._getTaskBouns, arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("img_bg_black.png"))
end

function var_0_0._updateTask(arg_6_0)
	local var_6_0 = arg_6_0._mapId == 0 and WeekWalk_2Enum.TaskType.Once or WeekWalk_2Enum.TaskType.Season

	WeekWalk_2TaskListModel.instance:showLayerTaskList(var_6_0, arg_6_0._mapId)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._mapId = arg_8_0.viewParam.mapId

	arg_8_0:_updateTask()
	arg_8_0:_updateInfo()
	arg_8_0:_showBattleInfo()
end

function var_0_0._showBattleInfo(arg_9_0)
	arg_9_0._mapInfo = WeekWalk_2Model.instance:getLayerInfo(arg_9_0._mapId)

	gohelper.setActive(arg_9_0._txtmaintitle, arg_9_0._mapId == 0)
	gohelper.setActive(arg_9_0._txttitlecn, arg_9_0._mapId ~= 0)

	if not arg_9_0._mapInfo then
		local var_9_0 = gohelper.findChild(arg_9_0.viewGO, "go_star")

		gohelper.setActive(var_9_0, false)

		local var_9_1 = gohelper.findChild(arg_9_0.viewGO, "txt_deeptip")

		gohelper.setActive(var_9_1, false)

		return
	end

	arg_9_0:_showBattle(arg_9_0._goicons1, arg_9_0._mapInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First))
	arg_9_0:_showBattle(arg_9_0._goicons2, arg_9_0._mapInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second))
end

function var_0_0._showBattle(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = gohelper.findChild(arg_10_1, "icon")

	gohelper.setActive(var_10_0, false)

	for iter_10_0 = 1, WeekWalk_2Enum.MaxStar do
		local var_10_1 = gohelper.cloneInPlace(var_10_0)

		gohelper.setActive(var_10_1, true)

		local var_10_2 = gohelper.findChildImage(var_10_1, "icon")

		var_10_2.enabled = false

		local var_10_3 = arg_10_0:getResInst(arg_10_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_10_2.gameObject)
		local var_10_4 = arg_10_2:getCupInfo(iter_10_0)
		local var_10_5 = var_10_4 and var_10_4.result or WeekWalk_2Enum.CupType.None

		if var_10_5 == WeekWalk_2Enum.CupType.None then
			var_10_5 = WeekWalk_2Enum.CupType.None2
		end

		WeekWalk_2Helper.setCupEffectByResult(var_10_3, var_10_5)
	end

	local var_10_6 = gohelper.findChild(arg_10_1, "go_finished")
	local var_10_7 = gohelper.findChild(arg_10_1, "go_unfinish")
	local var_10_8 = arg_10_2.status == WeekWalk_2Enum.BattleStatus.Finished

	gohelper.setActive(var_10_6, var_10_8)
	gohelper.setActive(var_10_7, not var_10_8)
end

function var_0_0._onWeekwalkTaskUpdate(arg_11_0)
	if not arg_11_0._getTaskBonusItem then
		return
	end

	arg_11_0._getTaskBonusItem:playOutAnim()

	arg_11_0._getTaskBonusItem = nil

	UIBlockMgr.instance:startBlock("WeekWalk_2LayerRewardView bonus")
	TaskDispatcher.runDelay(arg_11_0._showRewards, arg_11_0, 0.3)
end

function var_0_0._getTaskBouns(arg_12_0, arg_12_1)
	arg_12_0._getTaskBonusItem = arg_12_1
end

function var_0_0._showRewards(arg_13_0)
	arg_13_0:_updateTask()
	arg_13_0:_updateInfo()
	UIBlockMgr.instance:endBlock("WeekWalk_2LayerRewardView bonus")

	local var_13_0 = WeekWalk_2TaskListModel.instance:getTaskRewardList()

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_13_0)
end

function var_0_0._updateInfo(arg_14_0)
	local var_14_0 = WeekWalk_2TaskListModel.instance:getList()
	local var_14_1 = 0
	local var_14_2 = 0

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1.maxProgress then
			var_14_2 = math.max(var_14_2, iter_14_1.maxProgress)
		end
	end

	arg_14_0._mapInfo = WeekWalk_2Model.instance:getLayerInfo(arg_14_0._mapId)

	if arg_14_0._mapInfo then
		arg_14_0._txttitlecn.text = arg_14_0._mapInfo.sceneConfig.battleName
		arg_14_0._txtname.text = arg_14_0._mapInfo.sceneConfig.name
	end
end

function var_0_0.onClose(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._showRewards, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagebg:UnLoadImage()
end

return var_0_0
