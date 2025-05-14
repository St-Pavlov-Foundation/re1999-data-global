module("modules.logic.dragonboat.view.DragonBoatFestivalItem", package.seeall)

local var_0_0 = class("DragonBoatFestivalItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._id = arg_1_2
	arg_1_0._goNormalBG = gohelper.findChild(arg_1_0.viewGO, "Root/#go_NormalBG")
	arg_1_0._goSelectedBG = gohelper.findChild(arg_1_0.viewGO, "Root/#go_SelectedBG")
	arg_1_0._txtDay = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Day")
	arg_1_0._txtDayEn = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_DayEn")
	arg_1_0._goTomorrowTag = gohelper.findChild(arg_1_0.viewGO, "Root/#go_TomorrowTag")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item1")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item2")
	arg_1_0._goIcon1 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item2/#go_Icon1")
	arg_1_0._goIcon2 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item2/#go_Icon2")
	arg_1_0._goFinishedBG = gohelper.findChild(arg_1_0.viewGO, "Root/#go_FinishedBG")
	arg_1_0._goTick1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	arg_1_0._goTick2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_FinishedBG/#go_Tick2")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Selected")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Name")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0._goSelectedBG)
	arg_1_0._itemClick1 = gohelper.getClickWithAudio(arg_1_0._goNormalBG)
	arg_1_0._itemAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_1_0.viewGO, false)
	gohelper.setActive(arg_1_0._goSelected, false)
	TaskDispatcher.runDelay(arg_1_0._playOpen, arg_1_0, 0.03 * arg_1_0._id)

	arg_1_0._itemList = {}
	arg_1_0._item = IconMgr.instance:getCommonPropItemIcon(arg_1_0._goitem1)

	arg_1_0:_editableAddEvents()
	arg_1_0:refresh(arg_1_0._id)
end

function var_0_0._playOpen(arg_2_0)
	gohelper.setActive(arg_2_0.viewGO, true)
	arg_2_0._itemAnimator:Play("open", 0, 0)
end

function var_0_0._editableAddEvents(arg_3_0)
	arg_3_0._itemClick:AddClickListener(arg_3_0._onItemClick, arg_3_0)
	arg_3_0._itemClick1:AddClickListener(arg_3_0._onItemClick, arg_3_0)
	DragonBoatFestivalController.instance:registerCallback(DragonBoatFestivalEvent.SelectItem, arg_3_0._onSelectItem, arg_3_0)
	DragonBoatFestivalController.instance:registerCallback(DragonBoatFestivalEvent.ShowMapFinished, arg_3_0._startGetReward, arg_3_0)
end

function var_0_0._editableRemoveEvents(arg_4_0)
	arg_4_0._itemClick:RemoveClickListener()
	arg_4_0._itemClick1:RemoveClickListener()
	DragonBoatFestivalController.instance:unregisterCallback(DragonBoatFestivalEvent.SelectItem, arg_4_0._onSelectItem, arg_4_0)
	DragonBoatFestivalController.instance:unregisterCallback(DragonBoatFestivalEvent.ShowMapFinished, arg_4_0._startGetReward, arg_4_0)
end

function var_0_0._onSelectItem(arg_5_0)
	local var_5_0 = DragonBoatFestivalModel.instance:getCurDay()

	gohelper.setActive(arg_5_0._goSelected, var_5_0 == arg_5_0._id)
end

function var_0_0._onItemClick(arg_6_0)
	if not DragonBoatFestivalModel.instance:isGiftUnlock(arg_6_0._id) then
		return
	end

	local var_6_0 = DragonBoatFestivalModel.instance:getCurDay()

	if DragonBoatFestivalModel.instance:isGiftGet(var_6_0) and var_6_0 == arg_6_0._id then
		return
	end

	if not DragonBoatFestivalModel.instance:isGiftGet(arg_6_0._id) then
		DragonBoatFestivalModel.instance:setCurDay(arg_6_0._id)
		arg_6_0:_startGetReward()

		return
	end

	gohelper.setActive(arg_6_0._goSelected, true)
	DragonBoatFestivalModel.instance:setCurDay(arg_6_0._id)
	UIBlockMgrExtend.setNeedCircleMv(false)
	DragonBoatFestivalController.instance:dispatchEvent(DragonBoatFestivalEvent.SelectItem)
end

function var_0_0._startGetReward(arg_7_0)
	local var_7_0 = DragonBoatFestivalModel.instance:isGiftGet(arg_7_0._id)
	local var_7_1 = DragonBoatFestivalModel.instance:isGiftUnlock(arg_7_0._id)

	if not var_7_0 and var_7_1 then
		local var_7_2 = ActivityEnum.Activity.DragonBoatFestival

		Activity101Rpc.instance:sendGet101BonusRequest(var_7_2, arg_7_0._id)
	end
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0._id = arg_8_1

	local var_8_0 = ActivityEnum.Activity.DragonBoatFestival
	local var_8_1 = DragonBoatFestivalModel.instance:isGiftGet(arg_8_0._id)
	local var_8_2 = DragonBoatFestivalModel.instance:isGiftUnlock(arg_8_0._id)
	local var_8_3 = DragonBoatFestivalModel.instance:getLoginCount()
	local var_8_4 = DragonBoatFestivalModel.instance:getCurDay()
	local var_8_5 = ActivityConfig.instance:getNorSignActivityCo(var_8_0, arg_8_0._id)
	local var_8_6 = string.split(var_8_5.bonus, "|")
	local var_8_7 = #var_8_6
	local var_8_8 = var_8_7 == 1

	arg_8_0._txtName.text = ""

	for iter_8_0 = 1, var_8_7 do
		local var_8_9 = string.splitToNumber(var_8_6[iter_8_0], "#")
		local var_8_10 = arg_8_0._itemList[iter_8_0]

		if not var_8_10 then
			var_8_10 = IconMgr.instance:getCommonPropItemIcon(arg_8_0["_goIcon" .. iter_8_0])

			table.insert(arg_8_0._itemList, var_8_10)
		end

		arg_8_0:_refreshRewardItem(var_8_10, var_8_9)

		if iter_8_0 == 1 then
			arg_8_0:_refreshRewardItem(arg_8_0._item, var_8_9)

			if var_8_8 then
				local var_8_11 = ItemModel.instance:getItemConfig(var_8_9[1], var_8_9[2])

				arg_8_0._txtName.text = var_8_11.name
			end
		end
	end

	arg_8_0._txtDay.text = string.format("%02d", arg_8_0._id)
	arg_8_0._txtDayEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(arg_8_0._id))

	gohelper.setActive(arg_8_0._goitem1, var_8_8)
	gohelper.setActive(arg_8_0._goTick1, var_8_8)
	gohelper.setActive(arg_8_0._goitem2, not var_8_8)
	gohelper.setActive(arg_8_0._goTick2, not var_8_8)
	gohelper.setActive(arg_8_0._goSelectedBG, not var_8_1 and var_8_2)
	gohelper.setActive(arg_8_0._goTomorrowTag, arg_8_0._id == var_8_3 + 1)
	gohelper.setActive(arg_8_0._goFinishedBG, var_8_1)

	local var_8_12 = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	local var_8_13 = DragonBoatFestivalModel.instance:isGiftGet(var_8_12)

	if arg_8_0._id == var_8_12 and not var_8_13 then
		gohelper.setActive(arg_8_0._goSelected, arg_8_0._goSelected.activeSelf)
	else
		gohelper.setActive(arg_8_0._goSelected, arg_8_0._id == var_8_4)
	end
end

function var_0_0._refreshRewardItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:setMOValue(arg_9_2[1], arg_9_2[2], arg_9_2[3])
	arg_9_1:setCountFontSize(46)
	arg_9_1:setHideLvAndBreakFlag(true)
	arg_9_1:hideEquipLvAndBreak(true)
	arg_9_1:customOnClickCallback(function()
		if not DragonBoatFestivalModel.instance:isGiftGet(arg_9_0._id) and DragonBoatFestivalModel.instance:isGiftUnlock(arg_9_0._id) then
			arg_9_0:_onItemClick()

			return
		end

		MaterialTipController.instance:showMaterialInfo(arg_9_2[1], arg_9_2[2])
	end)
end

function var_0_0.destroy(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._playOpen, arg_11_0)
	arg_11_0:_editableRemoveEvents()
end

return var_0_0
