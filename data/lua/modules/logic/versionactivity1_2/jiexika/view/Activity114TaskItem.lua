module("modules.logic.versionactivity1_2.jiexika.view.Activity114TaskItem", package.seeall)

local var_0_0 = class("Activity114TaskItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.go, "#simage_bg")
	arg_1_0._txtTaskDesc = gohelper.findChildText(arg_1_0.go, "#txt_taskdes")
	arg_1_0._txtTaskTotal = gohelper.findChildText(arg_1_0.go, "#txt_total")
	arg_1_0._txtTaskComplete = gohelper.findChildText(arg_1_0.go, "#txt_complete")
	arg_1_0._goNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_notget/#btn_notfinishbg")
	arg_1_0._goGetBonus = gohelper.findChild(arg_1_0.go, "#go_notget/#btn_finishbg")
	arg_1_0._goFinishBg = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_notget/#go_getbonus")
	arg_1_0._scrollreward = gohelper.findChild(arg_1_0.go, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/#go_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")

	arg_1_0._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("task/bg_renwulan.png"))

	arg_1_0._rewardItems = {}
	arg_1_0._anim = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._goFinishBg:AddClickListener(arg_2_0._goFinishBgOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._goFinishBg:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0.mo = arg_4_1
	arg_4_0._txtTaskDesc.text = arg_4_0.mo.config.desc
	arg_4_0._txtTaskTotal.text = arg_4_0.mo.config.maxProgress
	arg_4_0._txtTaskComplete.text = arg_4_0.mo.progress

	gohelper.setActive(arg_4_0._goNotFinish.gameObject, arg_4_0.mo.finishStatus == Activity114Enum.TaskStatu.NoFinish)
	gohelper.setActive(arg_4_0._goFinishBg.gameObject, arg_4_0.mo.finishStatus == Activity114Enum.TaskStatu.Finish)
	gohelper.setActive(arg_4_0._goGetBonus, arg_4_0.mo.finishStatus == Activity114Enum.TaskStatu.GetBonus)

	arg_4_0._scrollreward.parentGameObject = arg_4_0._view._csListScroll.gameObject

	if not arg_4_0.bonusItems then
		arg_4_0.bonusItems = {}
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0._rewardItems) do
		gohelper.destroy(iter_4_1.itemIcon.go)
		gohelper.destroy(iter_4_1.parentGo)
		iter_4_1.itemIcon:onDestroy()
	end

	arg_4_0._rewardItems = {}

	local var_4_0 = string.split(arg_4_1.config.bonus, "|")

	arg_4_0._gorewards:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #var_4_0 > 2

	for iter_4_2 = 1, #var_4_0 do
		local var_4_1 = {
			parentGo = gohelper.cloneInPlace(arg_4_0._gorewarditem)
		}

		gohelper.setActive(var_4_1.parentGo, true)

		local var_4_2 = string.splitToNumber(var_4_0[iter_4_2], "#")

		var_4_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_4_1.parentGo)

		var_4_1.itemIcon:setMOValue(var_4_2[1], var_4_2[2], var_4_2[3], nil, true)
		var_4_1.itemIcon:isShowCount(var_4_2[1] ~= MaterialEnum.MaterialType.Hero)
		var_4_1.itemIcon:setCountFontSize(40)
		var_4_1.itemIcon:showStackableNum2()
		var_4_1.itemIcon:setHideLvAndBreakFlag(true)
		var_4_1.itemIcon:hideEquipLvAndBreak(true)
		table.insert(arg_4_0._rewardItems, var_4_1)
	end
end

function var_0_0._goFinishBgOnClick(arg_5_0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	Activity114Rpc.instance:receiveTaskReward(Activity114Model.instance.id, arg_5_0.mo.id)
end

function var_0_0.getAnimator(arg_6_0)
	return arg_6_0._anim
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagebg:UnLoadImage()

	for iter_7_0, iter_7_1 in pairs(arg_7_0._rewardItems) do
		gohelper.destroy(iter_7_1.itemIcon.go)
		gohelper.destroy(iter_7_1.parentGo)
		iter_7_1.itemIcon:onDestroy()
	end

	arg_7_0._rewardItems = nil
end

return var_0_0
