module("modules.logic.weekwalk.view.WeekWalkLayerRewardItem", package.seeall)

local var_0_0 = class("WeekWalkLayerRewardItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_bg")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_index")
	arg_1_0._scrollrewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._rewardscontent = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._gonotget = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_notget")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	arg_1_0._goblackmask = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_blackmask")
	arg_1_0._goget = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_get")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/info/#txt_desc")
	arg_1_0._imagestar = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/info/progress/#image_star")
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
	if arg_4_0._isDeepTask then
		arg_4_0:_getAllTaskReward()

		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, arg_4_0)

	local var_4_0 = WeekWalkTaskListModel.instance:getCanGetList()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, arg_4_0._mo.minTypeId, var_4_0)
end

function var_0_0._btnnotfinishbgOnClick(arg_5_0)
	return
end

function var_0_0._btnfinishbgOnClick(arg_6_0)
	if arg_6_0._isDeepTask then
		arg_6_0:_getAllTaskReward()

		return
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, arg_6_0)
	TaskRpc.instance:sendFinishTaskRequest(arg_6_0._mo.id)
end

function var_0_0._getAllTaskReward(arg_7_0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, arg_7_0)

	local var_7_0, var_7_1, var_7_2 = WeekWalkTaskListModel.instance:getAllDeepTaskInfo()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, arg_7_0._mo.minTypeId, var_7_2)
end

function var_0_0.playOutAnim(arg_8_0)
	gohelper.setActive(arg_8_0._goblackmask, true)
	arg_8_0._animator:Play("out", 0, 0)
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.setActive(arg_9_0._imagestar.gameObject, false)

	arg_9_0._rewardItems = arg_9_0:getUserDataTb_()
	arg_9_0._animator = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.getAnimator(arg_10_0)
	return arg_10_0._animator
end

function var_0_0._editableAddEvents(arg_11_0)
	arg_11_0._simagegetallbg:LoadImage(ResUrl.getWeekWalkBg("btn_yijiandi.png"))
	gohelper.addUIClickAudio(arg_11_0._btnnotfinishbg.gameObject, AudioEnum.UI.play_ui_activity_jump)
	gohelper.addUIClickAudio(arg_11_0._btnfinishbg.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
	gohelper.addUIClickAudio(arg_11_0._btncollectall.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
end

function var_0_0._editableRemoveEvents(arg_12_0)
	return
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	if arg_13_1.isDirtyData then
		gohelper.setActive(arg_13_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_13_0.viewGO, true)

	arg_13_0._mo = arg_13_1

	gohelper.setActive(arg_13_0._gonormal, not arg_13_1.isGetAll)
	gohelper.setActive(arg_13_0._gogetall, arg_13_1.isGetAll)

	local var_13_0 = WeekWalkTaskListModel.instance:getLayerTaskMapId()

	arg_13_0._isDeepTask = not WeekWalkModel.isShallowMap(var_13_0)

	if arg_13_1.isGetAll then
		return
	end

	arg_13_0._config = lua_task_weekwalk.configDict[arg_13_1.id]
	arg_13_0._txtindex.text = "0" .. WeekWalkTaskListModel.instance:getSortIndex(arg_13_1)

	arg_13_0:_addRewards()
	arg_13_0:_updateStatus()
	gohelper.setActive(arg_13_0._txtdesc.gameObject, arg_13_0._isDeepTask)

	if arg_13_0._isDeepTask then
		arg_13_0._txtdesc.text = arg_13_0._config.desc
	end

	arg_13_0:_initStars()
	arg_13_0:_updateStars()

	arg_13_0._scrollrewards.parentGameObject = arg_13_0._view._csListScroll.gameObject
end

function var_0_0._initStars(arg_14_0)
	if not arg_14_0._starList then
		arg_14_0._starList = arg_14_0:getUserDataTb_()
	end

	local var_14_0 = arg_14_0._imagestar.gameObject

	local function var_14_1()
		local var_15_0 = gohelper.cloneInPlace(var_14_0)

		gohelper.setActive(var_15_0, true)
		table.insert(arg_14_0._starList, var_15_0:GetComponent(gohelper.Type_Image))
	end

	if arg_14_0._isDeepTask then
		if LangSettings.instance:isZh() or LangSettings.instance:isTw() then
			var_14_1()
		end
	else
		for iter_14_0 = #arg_14_0._starList, arg_14_0._config.maxProgress do
			var_14_1()
		end
	end
end

function var_0_0._updateStars(arg_16_0)
	if not arg_16_0._starList then
		return
	end

	local var_16_0 = arg_16_0._isDeepTask and 1 or arg_16_0._config.maxProgress

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._starList) do
		gohelper.setActive(iter_16_1.gameObject, iter_16_0 <= var_16_0)
		UISpriteSetMgr.instance:setWeekWalkSprite(iter_16_1, (iter_16_0 <= arg_16_0._taskMo.progress or arg_16_0._isDeepTask) and "star_highlight4" or "star_null4")
	end
end

function var_0_0._updateStatus(arg_17_0)
	arg_17_0._taskMo = WeekWalkTaskListModel.instance:getTaskMo(arg_17_0._mo.id)

	local var_17_0 = arg_17_0._taskMo.finishCount >= arg_17_0._config.maxFinishCount

	gohelper.setActive(arg_17_0._gonotget, not var_17_0)
	gohelper.setActive(arg_17_0._goget, var_17_0)
	gohelper.setActive(arg_17_0._goblackmask, var_17_0)

	if not var_17_0 then
		local var_17_1 = arg_17_0._taskMo.hasFinished

		gohelper.setActive(arg_17_0._btnnotfinishbg.gameObject, not var_17_1)
		gohelper.setActive(arg_17_0._btnfinishbg.gameObject, var_17_1)
	end

	local var_17_2 = not var_17_0 and arg_17_0._taskMo.hasFinished and "img_bg_claim_hl.png" or "img_bg_claim_nor.png"

	arg_17_0._simagebg:LoadImage(ResUrl.getWeekWalkBg(var_17_2))
end

function var_0_0._addRewards(arg_18_0)
	arg_18_0._scrollrewards.horizontalNormalizedPosition = 0

	local var_18_0 = string.split(arg_18_0._mo.bonus, "|")

	for iter_18_0 = 1, #var_18_0 do
		local var_18_1 = arg_18_0:_getItem(iter_18_0)
		local var_18_2 = string.splitToNumber(var_18_0[iter_18_0], "#")

		gohelper.setActive(var_18_1.parentGo, true)
		var_18_1.itemIcon:setMOValue(var_18_2[1], var_18_2[2], var_18_2[3], nil, true)
		var_18_1.itemIcon:isShowCount(var_18_2[1] ~= MaterialEnum.MaterialType.Hero)
		var_18_1.itemIcon:setCountFontSize(40)
		var_18_1.itemIcon:showStackableNum2()
		var_18_1.itemIcon:setHideLvAndBreakFlag(true)
		var_18_1.itemIcon:hideEquipLvAndBreak(true)
	end

	for iter_18_1 = #var_18_0 + 1, #arg_18_0._rewardItems do
		local var_18_3 = arg_18_0._rewardItems[iter_18_1]

		if var_18_3 then
			gohelper.setActive(var_18_3.parentGo, false)
		end
	end

	local var_18_4 = (recthelper.getWidth(arg_18_0._gorewarditem.transform) + -13) * #var_18_0

	recthelper.setWidth(arg_18_0._rewardscontent.transform, var_18_4)
end

function var_0_0._getItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._rewardItems[arg_19_1]

	if var_19_0 then
		return var_19_0
	end

	local var_19_1 = arg_19_0:getUserDataTb_()

	var_19_1.parentGo = gohelper.clone(arg_19_0._gorewarditem, arg_19_0._rewardscontent)
	var_19_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_19_1.parentGo)
	arg_19_0._rewardItems[arg_19_1] = var_19_1

	return var_19_1
end

function var_0_0.onSelect(arg_20_0, arg_20_1)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._rewardItems) do
		gohelper.destroy(iter_21_1.itemIcon.go)
		gohelper.destroy(iter_21_1.parentGo)
		iter_21_1.itemIcon:onDestroy()
	end

	arg_21_0._rewardItems = nil

	arg_21_0._simagebg:UnLoadImage()
	arg_21_0._simagegetallbg:UnLoadImage()
end

return var_0_0
