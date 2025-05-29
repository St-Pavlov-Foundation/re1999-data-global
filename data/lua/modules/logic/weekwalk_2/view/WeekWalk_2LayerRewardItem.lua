module("modules.logic.weekwalk_2.view.WeekWalk_2LayerRewardItem", package.seeall)

local var_0_0 = class("WeekWalk_2LayerRewardItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_bg")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_index")
	arg_1_0._scrollrewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._rewardscontent = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/info/#txt_desc")
	arg_1_0._imagestar = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/info/progress/#image_star")
	arg_1_0._goblackmask = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_blackmask")
	arg_1_0._gonotget = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_notget")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	arg_1_0._goget = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_get")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._btncollectall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/go_getall/#btn_collectall")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)
	arg_2_0._btncollectall:AddClickListener(arg_2_0._btncollectallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()
	arg_3_0._btncollectall:RemoveClickListener()
end

function var_0_0._btncollectallOnClick(arg_4_0)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnGetTaskReward, arg_4_0)

	local var_4_0 = WeekWalk_2TaskListModel.instance:getCanGetList()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk_2, arg_4_0._mo.minTypeId, var_4_0)
end

function var_0_0._btnnotfinishbgOnClick(arg_5_0)
	return
end

function var_0_0._btnfinishbgOnClick(arg_6_0)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnGetTaskReward, arg_6_0)
	TaskRpc.instance:sendFinishTaskRequest(arg_6_0._mo.id)
end

function var_0_0.playOutAnim(arg_7_0)
	gohelper.setActive(arg_7_0._goblackmask, true)
	arg_7_0._animator:Play("out", 0, 0)
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.setActive(arg_8_0._imagestar.gameObject, false)

	arg_8_0._rewardItems = arg_8_0:getUserDataTb_()
	arg_8_0._animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.getAnimator(arg_9_0)
	return arg_9_0._animator
end

function var_0_0._editableAddEvents(arg_10_0)
	gohelper.addUIClickAudio(arg_10_0._btnnotfinishbg.gameObject, AudioEnum.UI.play_ui_activity_jump)
	gohelper.addUIClickAudio(arg_10_0._btnfinishbg.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
	gohelper.addUIClickAudio(arg_10_0._btncollectall.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
end

function var_0_0._editableRemoveEvents(arg_11_0)
	return
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	if arg_12_1.isDirtyData then
		gohelper.setActive(arg_12_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_12_0.viewGO, true)

	arg_12_0._mo = arg_12_1

	gohelper.setActive(arg_12_0._gonormal, not arg_12_1.isGetAll)
	gohelper.setActive(arg_12_0._gogetall, arg_12_1.isGetAll)

	if arg_12_1.isGetAll then
		return
	end

	arg_12_0._config = lua_task_weekwalk_ver2.configDict[arg_12_1.id]
	arg_12_0._txtindex.text = "0" .. WeekWalk_2TaskListModel.instance:getSortIndex(arg_12_1)

	arg_12_0:_addRewards()
	arg_12_0:_updateStatus()

	local var_12_0 = WeekWalk_2TaskListModel.instance:getLayerTaskMapId()

	arg_12_0._isDeepTask = true

	gohelper.setActive(arg_12_0._txtdesc.gameObject, arg_12_0._isDeepTask)

	if arg_12_0._isDeepTask then
		arg_12_0._txtdesc.text = arg_12_0._config.desc
	end

	arg_12_0._scrollrewards.parentGameObject = arg_12_0._view._csListScroll.gameObject
end

function var_0_0._initStars(arg_13_0)
	if arg_13_0._starList then
		return
	end

	arg_13_0._starList = arg_13_0:getUserDataTb_()

	local var_13_0 = arg_13_0._imagestar.gameObject
	local var_13_1 = arg_13_0._isDeepTask and 1 or arg_13_0._config.maxProgress

	for iter_13_0 = #arg_13_0._starList, var_13_1 do
		local var_13_2 = gohelper.cloneInPlace(var_13_0)

		gohelper.setActive(var_13_2, true)

		local var_13_3 = var_13_2:GetComponent(gohelper.Type_Image)

		var_13_3.enabled = false

		local var_13_4 = arg_13_0._view:getResInst(arg_13_0._view.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_13_3.gameObject)

		table.insert(arg_13_0._starList, var_13_4)
	end
end

function var_0_0._updateStars(arg_14_0)
	if not arg_14_0._starList then
		return
	end

	local var_14_0 = arg_14_0._isDeepTask and 1 or arg_14_0._config.maxProgress

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._starList) do
		gohelper.setActive(iter_14_1.gameObject, iter_14_0 <= var_14_0)

		local var_14_1 = string.split(arg_14_0._config.listenerParam, "#")

		if arg_14_0._config.listenerType == "WeekwalkVer2SeasonCup" then
			WeekWalk_2Helper.setCupEffectByResult(iter_14_1, var_14_1[1])
		else
			WeekWalk_2Helper.setCupEffectByResult(iter_14_1, var_14_1[2])
		end
	end
end

function var_0_0._updateStatus(arg_15_0)
	arg_15_0._taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(arg_15_0._mo.id)

	local var_15_0 = arg_15_0._taskMo.finishCount >= arg_15_0._config.maxFinishCount

	gohelper.setActive(arg_15_0._gonotget, not var_15_0)
	gohelper.setActive(arg_15_0._goget, var_15_0)
	gohelper.setActive(arg_15_0._goblackmask, var_15_0)

	if not var_15_0 then
		local var_15_1 = arg_15_0._taskMo.hasFinished

		gohelper.setActive(arg_15_0._btnnotfinishbg.gameObject, not var_15_1)
		gohelper.setActive(arg_15_0._btnfinishbg.gameObject, var_15_1)
	end
end

function var_0_0._addRewards(arg_16_0)
	arg_16_0._scrollrewards.horizontalNormalizedPosition = 0

	local var_16_0 = string.split(arg_16_0._mo.bonus, "|")

	for iter_16_0 = 1, #var_16_0 do
		local var_16_1 = arg_16_0:_getItem(iter_16_0)
		local var_16_2 = string.splitToNumber(var_16_0[iter_16_0], "#")

		gohelper.setActive(var_16_1.parentGo, true)
		var_16_1.itemIcon:setMOValue(var_16_2[1], var_16_2[2], var_16_2[3], nil, true)
		var_16_1.itemIcon:isShowCount(var_16_2[1] ~= MaterialEnum.MaterialType.Hero)
		var_16_1.itemIcon:setCountFontSize(40)
		var_16_1.itemIcon:showStackableNum2()
		var_16_1.itemIcon:setHideLvAndBreakFlag(true)
		var_16_1.itemIcon:hideEquipLvAndBreak(true)
	end

	for iter_16_1 = #var_16_0 + 1, #arg_16_0._rewardItems do
		local var_16_3 = arg_16_0._rewardItems[iter_16_1]

		if var_16_3 then
			gohelper.setActive(var_16_3.parentGo, false)
		end
	end

	local var_16_4 = (recthelper.getWidth(arg_16_0._gorewarditem.transform) + -13) * #var_16_0

	recthelper.setWidth(arg_16_0._rewardscontent.transform, var_16_4)
end

function var_0_0._getItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._rewardItems[arg_17_1]

	if var_17_0 then
		return var_17_0
	end

	local var_17_1 = arg_17_0:getUserDataTb_()

	var_17_1.parentGo = gohelper.clone(arg_17_0._gorewarditem, arg_17_0._rewardscontent)
	var_17_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_17_1.parentGo)
	arg_17_0._rewardItems[arg_17_1] = var_17_1

	return var_17_1
end

function var_0_0.onSelect(arg_18_0, arg_18_1)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._rewardItems) do
		gohelper.destroy(iter_19_1.itemIcon.go)
		gohelper.destroy(iter_19_1.parentGo)
		iter_19_1.itemIcon:onDestroy()
	end

	arg_19_0._rewardItems = nil

	arg_19_0._simagebg:UnLoadImage()
	arg_19_0._simagegetallbg:UnLoadImage()
end

return var_0_0
