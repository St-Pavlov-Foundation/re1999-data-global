module("modules.logic.sp01.sign.view.V2a9_LoginSignItem", package.seeall)

local var_0_0 = class("V2a9_LoginSignItem", Activity101SignViewItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNormalBG = gohelper.findChild(arg_1_0.viewGO, "Root/#go_NormalBG")
	arg_1_0._goNormalBG2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_NormalBG2")
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

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = string.format
local var_0_2 = string.splitToNumber
local var_0_3 = string.split

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._anim = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._itemClick = gohelper.getClickWithAudio(arg_4_0._goSelectedBG)
	arg_4_0._itemClick2 = gohelper.getClickWithAudio(arg_4_0._goNormalBG)
	arg_4_0._itemList = {}
	arg_4_0._item = IconMgr.instance:getCommonPropItemIcon(arg_4_0._goitem1)
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._itemClick:AddClickListener(arg_5_0._onItemClick, arg_5_0)
	arg_5_0._itemClick2:AddClickListener(arg_5_0._onItemClick, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._itemClick:RemoveClickListener()
	arg_6_0._itemClick2:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	if not arg_7_0._openAnim then
		arg_7_0:_playOpen()
	else
		arg_7_0:_playIdle()
	end

	arg_7_0:_refreshItem()
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0._refreshItem(arg_9_0)
	local var_9_0 = arg_9_0._mo.data[1]
	local var_9_1 = arg_9_0._index
	local var_9_2 = ActivityType101Model.instance:isType101RewardGet(var_9_0, var_9_1)
	local var_9_3 = ActivityType101Model.instance:isType101RewardCouldGet(var_9_0, var_9_1)
	local var_9_4 = ActivityType101Model.instance:getType101LoginCount(var_9_0)
	local var_9_5 = ActivityConfig.instance:getNorSignActivityCo(var_9_0, var_9_1)
	local var_9_6 = var_0_3(var_9_5.bonus, "|")
	local var_9_7 = #var_9_6
	local var_9_8 = var_9_7 == 1

	gohelper.setActive(arg_9_0._goitem1, var_9_8)
	gohelper.setActive(arg_9_0._goTick1, var_9_8)
	gohelper.setActive(arg_9_0._goitem2, not var_9_8)
	gohelper.setActive(arg_9_0._goTick2, not var_9_8)

	for iter_9_0 = 1, var_9_7 do
		local var_9_9 = var_0_2(var_9_6[iter_9_0], "#")
		local var_9_10 = arg_9_0._itemList[iter_9_0]

		if not var_9_10 then
			var_9_10 = IconMgr.instance:getCommonPropItemIcon(arg_9_0["_goIcon" .. iter_9_0])

			table.insert(arg_9_0._itemList, var_9_10)
		end

		arg_9_0:_refreshRewardItem(var_9_10, var_9_9)

		if iter_9_0 == 1 then
			arg_9_0:_refreshRewardItem(arg_9_0._item, var_9_9)
		end
	end

	arg_9_0._txtDay.text = var_9_1 < 10 and "0" .. var_9_1 or var_9_1
	arg_9_0._txtDayEn.text = var_0_1("DAY\n%s", GameUtil.getEnglishNumber(var_9_1))

	gohelper.setActive(arg_9_0._goSelectedBG, var_9_3)
	gohelper.setActive(arg_9_0._goTomorrowTag, var_9_1 ~= 10 and var_9_1 == var_9_4 + 1)
	gohelper.setActive(arg_9_0._goFinishedBG, var_9_2)

	local var_9_11 = Activity204Enum.LoginSignSpDayIndex[var_9_1]

	gohelper.setActive(arg_9_0._goNormalBG, not var_9_11)
	gohelper.setActive(arg_9_0._goNormalBG2, var_9_11)
end

function var_0_0._refreshRewardItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:setMOValue(arg_10_2[1], arg_10_2[2], arg_10_2[3], nil, true)
	arg_10_1:setCountFontSize(46)
	arg_10_1:setHideLvAndBreakFlag(true)
	arg_10_1:hideEquipLvAndBreak(true)
	arg_10_1:customOnClickCallback(function()
		local var_11_0 = arg_10_0:actId()
		local var_11_1 = arg_10_0._index

		if not ActivityModel.instance:isActOnLine(var_11_0) then
			GameFacade.showToast(ToastEnum.BattlePass)

			return
		end

		if ActivityType101Model.instance:isType101RewardCouldGet(var_11_0, var_11_1) then
			Activity101Rpc.instance:sendGet101BonusRequest(var_11_0, var_11_1)

			return
		end

		MaterialTipController.instance:showMaterialInfo(arg_10_2[1], arg_10_2[2])
	end)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._openAnim = nil

	TaskDispatcher.cancelTask(arg_12_0._playOpenInner, arg_12_0)
end

function var_0_0._onItemClick(arg_13_0)
	local var_13_0 = arg_13_0._mo.data[1]
	local var_13_1 = arg_13_0._index

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	local var_13_2 = ActivityType101Model.instance:isType101RewardCouldGet(var_13_0, var_13_1)
	local var_13_3 = ActivityType101Model.instance:getType101LoginCount(var_13_0)

	if var_13_2 then
		Activity101Rpc.instance:sendGet101BonusRequest(var_13_0, var_13_1)
	end

	if var_13_3 < var_13_1 then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function var_0_0._playOpenInner(arg_14_0)
	arg_14_0:_setActive(true)
	arg_14_0._anim:Play(UIAnimationName.Open)
end

function var_0_0._playOpen(arg_15_0)
	if arg_15_0._openAnim then
		return
	end

	arg_15_0._openAnim = true

	arg_15_0:_setActive(false)
	TaskDispatcher.runDelay(arg_15_0._playOpenInner, arg_15_0, arg_15_0._index * 0.03)
end

function var_0_0._playIdle(arg_16_0)
	if arg_16_0._openAnim then
		return
	end

	arg_16_0._anim:Play(UIAnimationName.Idle, 0, 1)
end

function var_0_0._setActive(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0.viewGO, arg_17_1)
end

return var_0_0
