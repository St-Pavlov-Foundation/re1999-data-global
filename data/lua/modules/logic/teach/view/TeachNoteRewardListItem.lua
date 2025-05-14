module("modules.logic.teach.view.TeachNoteRewardListItem", package.seeall)

local var_0_0 = class("TeachNoteRewardListItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_1, "right/#txt_des")
	arg_1_0._gopoint = gohelper.findChild(arg_1_1, "right/#go_process/#go_point")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_1, "right/#go_reward/#go_rewarditem")
	arg_1_0._gofinish = gohelper.findChild(arg_1_1, "#go_finish")
	arg_1_0._golock = gohelper.findChild(arg_1_1, "#go_lock")
	arg_1_0._goreceive = gohelper.findChild(arg_1_1, "#go_receive")
	arg_1_0._goreceivebg = gohelper.findChild(arg_1_1, "#go_receive/receivebg")
	arg_1_0._goreward = gohelper.findChild(arg_1_1, "right/#go_reward")
	arg_1_0._txtrewardcount = gohelper.findChildText(arg_1_1, "right/#go_reward/rewardcountbg/#txt_rewardcount")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_1, "right/#txt_index")
	arg_1_0._rewardClick = gohelper.getClick(arg_1_0._goreceive.gameObject)
	arg_1_0._rewardCanvasGroup = arg_1_0._goreward:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._processItems = arg_1_0:getUserDataTb_()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._rewardClick:AddClickListener(arg_2_0._onRewardClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._rewardClick:RemoveClickListener()
end

function var_0_0._onRewardClick(arg_4_0)
	if TeachNoteModel.instance:isRewardCouldGet(arg_4_0._mo.id) then
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_activity_act)
		DungeonRpc.instance:sendInstructionDungeonRewardRequest(arg_4_0._mo.id)
	end
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:_refreshItem()
end

function var_0_0._refreshItem(arg_6_0)
	if arg_6_0._processItems then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._processItems) do
			gohelper.setActive(iter_6_1.go, false)
		end
	end

	local var_6_0 = DungeonConfig.instance:getChapterCO(arg_6_0._mo.chapterId).name

	arg_6_0._txtDesc.text = var_6_0
	arg_6_0._txtindex.text = "NO." .. arg_6_0._index

	local var_6_1 = TeachNoteModel.instance:getTeachNoteTopicFinishedLevelCount(arg_6_0._mo.id)
	local var_6_2 = TeachNoteModel.instance:getTeachNoteTopicLevelCount(arg_6_0._mo.id)

	for iter_6_2 = 1, var_6_2 do
		if not arg_6_0._processItems[iter_6_2] then
			arg_6_0._processItems[iter_6_2] = {}
			arg_6_0._processItems[iter_6_2].go = gohelper.cloneInPlace(arg_6_0._gopoint, "point" .. iter_6_2)
			arg_6_0._processItems[iter_6_2].gofinish = gohelper.findChild(arg_6_0._processItems[iter_6_2].go, "finish")
			arg_6_0._processItems[iter_6_2].gounfinish = gohelper.findChild(arg_6_0._processItems[iter_6_2].go, "unfinish")
		end

		gohelper.setActive(arg_6_0._processItems[iter_6_2].go, true)
		gohelper.setActive(arg_6_0._processItems[iter_6_2].gofinish, iter_6_2 <= var_6_1)
		gohelper.setActive(arg_6_0._processItems[iter_6_2].gounfinish, var_6_1 < iter_6_2)
	end

	gohelper.setActive(arg_6_0._goreceive, TeachNoteModel.instance:isRewardCouldGet(arg_6_0._mo.id))
	gohelper.setActive(arg_6_0._gofinish, TeachNoteModel.instance:isTopicRewardGet(arg_6_0._mo.id))
	gohelper.setActive(arg_6_0._golock, not TeachNoteModel.instance:isTopicUnlock(arg_6_0._mo.id))
	gohelper.setActive(arg_6_0._txtDesc.gameObject, TeachNoteModel.instance:isTopicUnlock(arg_6_0._mo.id))

	arg_6_0._rewardCanvasGroup.alpha = TeachNoteModel.instance:isTopicUnlock(arg_6_0._mo.id) and 1 or 0.5

	local var_6_3 = string.splitToNumber(TeachNoteConfig.instance:getInstructionTopicCO(arg_6_0._mo.id).bonus, "#")

	if not arg_6_0._itemIcon then
		arg_6_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_6_0._gorewarditem)
	end

	arg_6_0._itemIcon:setMOValue(var_6_3[1], var_6_3[2], var_6_3[3])
	arg_6_0._itemIcon:isShowEffect(false)
	arg_6_0._itemIcon:isShowCount(false)
	arg_6_0._itemIcon:isShowQuality(false)

	arg_6_0._txtrewardcount.text = var_6_3[3]
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0._processItems then
		arg_7_0._processItems = {}
	end

	if arg_7_0._itemIcon then
		arg_7_0._itemIcon:onDestroy()
	end
end

return var_0_0
