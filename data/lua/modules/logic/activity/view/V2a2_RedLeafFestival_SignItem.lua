module("modules.logic.activity.view.V2a2_RedLeafFestival_SignItem", package.seeall)

local var_0_0 = class("V2a2_RedLeafFestival_SignItem", Activity101SignViewItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNormalBG = gohelper.findChild(arg_1_0.viewGO, "Root/#go_NormalBG")
	arg_1_0._goSelectedBG = gohelper.findChild(arg_1_0.viewGO, "Root/#go_SelectedBG")
	arg_1_0._txtDay = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Day")
	arg_1_0._txtDayEn = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_DayEn")
	arg_1_0._goTomorrowTag = gohelper.findChild(arg_1_0.viewGO, "Root/#go_TomorrowTag")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item1")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item2")
	arg_1_0._goIcon1 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item2/#go_Icon1")
	arg_1_0._goIcon2 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item2/#go_Icon2")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Name")
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
	arg_4_0:_setActive_kelingquGo(false)

	arg_4_0._anim = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
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

function var_0_0.onRefresh(arg_7_0)
	local var_7_0 = arg_7_0._mo.data[1]
	local var_7_1 = arg_7_0._index
	local var_7_2 = ActivityType101Model.instance:isType101RewardGet(var_7_0, var_7_1)
	local var_7_3 = ActivityType101Model.instance:isType101RewardCouldGet(var_7_0, var_7_1)
	local var_7_4 = ActivityType101Model.instance:getType101LoginCount(var_7_0)
	local var_7_5 = ActivityConfig.instance:getNorSignActivityCo(var_7_0, var_7_1)
	local var_7_6 = var_0_3(var_7_5.bonus, "|")
	local var_7_7 = #var_7_6
	local var_7_8 = var_7_7 == 1

	gohelper.setActive(arg_7_0._goitem1, var_7_8)
	gohelper.setActive(arg_7_0._goTick1, var_7_8)
	gohelper.setActive(arg_7_0._goitem2, not var_7_8)
	gohelper.setActive(arg_7_0._goTick2, not var_7_8)

	arg_7_0._txtName.text = ""

	for iter_7_0 = 1, var_7_7 do
		local var_7_9 = var_0_2(var_7_6[iter_7_0], "#")
		local var_7_10 = arg_7_0._itemList[iter_7_0]

		if not var_7_10 then
			var_7_10 = IconMgr.instance:getCommonPropItemIcon(arg_7_0["_goIcon" .. iter_7_0])

			table.insert(arg_7_0._itemList, var_7_10)
		end

		arg_7_0:_refreshRewardItem(var_7_10, var_7_9)

		if iter_7_0 == 1 then
			arg_7_0:_refreshRewardItem(arg_7_0._item, var_7_9)

			if var_7_8 then
				local var_7_11 = ItemModel.instance:getItemConfig(var_7_9[1], var_7_9[2])

				arg_7_0._txtName.text = var_7_11.name
			end
		end

		var_7_10:setCountTxtSize(35)
		var_7_10:SetCountBgHeight(22.72)
	end

	arg_7_0._txtDay.text = var_7_1 < 10 and "0" .. var_7_1 or var_7_1
	arg_7_0._txtDayEn.text = var_0_1("DAY\n%s", GameUtil.getEnglishNumber(var_7_1))

	gohelper.setActive(arg_7_0._goSelectedBG, var_7_3)
	gohelper.setActive(arg_7_0._goFinishedBG, var_7_2)
end

function var_0_0._onItemClick(arg_8_0)
	local var_8_0 = arg_8_0:actId()
	local var_8_1 = arg_8_0._index

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if not ActivityModel.instance:isActOnLine(var_8_0) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local var_8_2 = ActivityType101Model.instance:isType101RewardCouldGet(var_8_0, var_8_1)
	local var_8_3 = ActivityType101Model.instance:getType101LoginCount(var_8_0)

	if var_8_2 then
		arg_8_0:viewContainer():setOnceGotRewardFetch101Infos(true)
		Activity101Rpc.instance:sendGet101BonusRequest(var_8_0, var_8_1)
	end

	if var_8_3 < var_8_1 then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function var_0_0._refreshRewardItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:setMOValue(arg_9_2[1], arg_9_2[2], arg_9_2[3])
	arg_9_1:setCountFontSize(46)
	arg_9_1:setHideLvAndBreakFlag(true)
	arg_9_1:hideEquipLvAndBreak(true)
	arg_9_1:customOnClickCallback(function()
		local var_10_0 = arg_9_0:actId()
		local var_10_1 = arg_9_0._index

		if not ActivityModel.instance:isActOnLine(var_10_0) then
			GameFacade.showToast(ToastEnum.BattlePass)

			return
		end

		if ActivityType101Model.instance:isType101RewardCouldGet(var_10_0, var_10_1) then
			arg_9_0:viewContainer():setOnceGotRewardFetch101Infos(true)
			Activity101Rpc.instance:sendGet101BonusRequest(var_10_0, var_10_1)

			return
		end

		MaterialTipController.instance:showMaterialInfo(arg_9_2[1], arg_9_2[2])
	end)
end

return var_0_0
