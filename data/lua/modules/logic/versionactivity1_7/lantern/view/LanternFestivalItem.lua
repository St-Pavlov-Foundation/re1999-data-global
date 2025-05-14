module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalItem", package.seeall)

local var_0_0 = class("LanternFestivalItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._puzzleId = arg_1_3
	arg_1_0._goNormalBG = gohelper.findChild(arg_1_0.viewGO, "Root/#go_NormalBG")
	arg_1_0._goSelectedBG = gohelper.findChild(arg_1_0.viewGO, "Root/#go_SelectedBG")
	arg_1_0._txtDay = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Day")
	arg_1_0._txtDayEn = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_DayEn")
	arg_1_0._goFinishedImg = gohelper.findChild(arg_1_0.viewGO, "Root/#go_FinishedImg")
	arg_1_0._goTomorrowTag = gohelper.findChild(arg_1_0.viewGO, "Root/#go_TomorrowTag")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item1")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item2")
	arg_1_0._goIcon1 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item2/#go_Icon1")
	arg_1_0._goIcon2 = gohelper.findChild(arg_1_0.viewGO, "Root/Item/#go_item2/#go_Icon2")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Name")
	arg_1_0._goFinishedBG = gohelper.findChild(arg_1_0.viewGO, "Root/#go_FinishedBG")
	arg_1_0._goTick1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	arg_1_0._goTick2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_FinishedBG/#go_Tick2")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0._goSelectedBG)
	arg_1_0._itemClick1 = gohelper.getClickWithAudio(arg_1_0._goFinishedImg)
	arg_1_0._itemClick2 = gohelper.getClickWithAudio(arg_1_0._goNormalBG)
	arg_1_0._itemAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_1_0.viewGO, false)
	TaskDispatcher.runDelay(arg_1_0._playOpen, arg_1_0, 0.03 * arg_1_0._index)

	arg_1_0._itemList = {}
	arg_1_0._item = IconMgr.instance:getCommonPropItemIcon(arg_1_0._goitem1)

	arg_1_0:_editableAddEvents()
	arg_1_0:refresh(arg_1_2, arg_1_3)
end

function var_0_0._playOpen(arg_2_0)
	gohelper.setActive(arg_2_0.viewGO, true)
	arg_2_0._itemAnimator:Play("open", 0, 0)
end

function var_0_0._editableAddEvents(arg_3_0)
	arg_3_0._itemClick:AddClickListener(arg_3_0._onItemClick, arg_3_0)
	arg_3_0._itemClick1:AddClickListener(arg_3_0._onItemClick, arg_3_0)
	arg_3_0._itemClick2:AddClickListener(arg_3_0._onItemClick, arg_3_0)
end

function var_0_0._editableRemoveEvents(arg_4_0)
	arg_4_0._itemClick:RemoveClickListener()
	arg_4_0._itemClick1:RemoveClickListener()
	arg_4_0._itemClick2:RemoveClickListener()
end

function var_0_0._onItemClick(arg_5_0)
	if not LanternFestivalModel.instance:isPuzzleUnlock(arg_5_0._puzzleId) then
		return
	end

	local var_5_0 = {
		puzzleId = arg_5_0._puzzleId,
		day = arg_5_0._index
	}

	LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.SelectPuzzleItem)
	LanternFestivalController.instance:openQuestionTipView(var_5_0)
end

function var_0_0.refresh(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._index = arg_6_1
	arg_6_0._puzzleId = arg_6_2

	local var_6_0 = LanternFestivalModel.instance:isPuzzleGiftGet(arg_6_0._puzzleId)

	gohelper.setActive(arg_6_0._goFinishedImg, var_6_0)

	local var_6_1 = not var_6_0 and LanternFestivalModel.instance:isPuzzleUnlock(arg_6_0._puzzleId)
	local var_6_2 = LanternFestivalModel.instance:getLoginCount()
	local var_6_3 = ActivityEnum.Activity.LanternFestival
	local var_6_4 = LanternFestivalConfig.instance:getAct154Co(var_6_3, arg_6_1)
	local var_6_5 = string.split(var_6_4.bonus, "|")
	local var_6_6 = #var_6_5
	local var_6_7 = var_6_6 == 1

	gohelper.setActive(arg_6_0._goitem1, var_6_7)
	gohelper.setActive(arg_6_0._goTick1, var_6_7)
	gohelper.setActive(arg_6_0._goitem2, not var_6_7)
	gohelper.setActive(arg_6_0._goTick2, not var_6_7)

	arg_6_0._txtName.text = ""

	for iter_6_0 = 1, var_6_6 do
		local var_6_8 = string.splitToNumber(var_6_5[iter_6_0], "#")
		local var_6_9 = arg_6_0._itemList[iter_6_0]

		if not var_6_9 then
			var_6_9 = IconMgr.instance:getCommonPropItemIcon(arg_6_0["_goIcon" .. iter_6_0])

			table.insert(arg_6_0._itemList, var_6_9)
		end

		arg_6_0:_refreshRewardItem(var_6_9, var_6_8)

		if iter_6_0 == 1 then
			arg_6_0:_refreshRewardItem(arg_6_0._item, var_6_8)

			if var_6_7 then
				local var_6_10 = ItemModel.instance:getItemConfig(var_6_8[1], var_6_8[2])

				arg_6_0._txtName.text = var_6_10.name
			end
		end
	end

	arg_6_0._txtDay.text = string.format("%02d", arg_6_1)
	arg_6_0._txtDayEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(arg_6_1))

	gohelper.setActive(arg_6_0._goSelectedBG, var_6_1)
	gohelper.setActive(arg_6_0._goTomorrowTag, arg_6_1 == var_6_2 + 1)
	gohelper.setActive(arg_6_0._goFinishedBG, var_6_0)
end

function var_0_0._refreshRewardItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1:setMOValue(arg_7_2[1], arg_7_2[2], arg_7_2[3])
	arg_7_1:setCountFontSize(46)
	arg_7_1:setHideLvAndBreakFlag(true)
	arg_7_1:hideEquipLvAndBreak(true)
	arg_7_1:customOnClickCallback(function()
		if not LanternFestivalModel.instance:isPuzzleGiftGet(arg_7_0._puzzleId) and LanternFestivalModel.instance:isPuzzleUnlock(arg_7_0._puzzleId) then
			arg_7_0:_onItemClick()

			return
		end

		MaterialTipController.instance:showMaterialInfo(arg_7_2[1], arg_7_2[2])
	end)
end

function var_0_0.destroy(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._playOpen, arg_9_0)
	arg_9_0:_editableRemoveEvents()
end

return var_0_0
