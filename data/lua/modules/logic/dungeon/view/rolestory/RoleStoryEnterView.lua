module("modules.logic.dungeon.view.rolestory.RoleStoryEnterView", package.seeall)

local var_0_0 = class("RoleStoryEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_LimitTime")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#image_reddot")
	arg_1_0._simagephoto = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Photo")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0.rewardItems = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._onClickEnter, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenter:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.actId = arg_5_0.viewContainer.activityId

	var_0_0.super.onOpen(arg_5_0)
	arg_5_0:refreshUI()
end

function var_0_0.onClose(arg_6_0)
	var_0_0.super.onClose(arg_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0._simagephoto then
		arg_7_0._simagephoto:UnLoadImage()

		arg_7_0._simagephoto = nil
	end

	if arg_7_0.rewardItems then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.rewardItems) do
			iter_7_1:onDestroy()
		end

		arg_7_0.rewardItems = nil
	end
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshRemainTime()
	arg_8_0:refreshStory()
end

function var_0_0.refreshStory(arg_9_0)
	local var_9_0 = RoleStoryModel.instance:getCurActStoryId()

	if not var_9_0 or var_9_0 == 0 then
		var_9_0 = RoleStoryConfig.instance:getStoryIdByActivityId(arg_9_0.actId)
	end

	if var_9_0 and var_9_0 > 0 then
		local var_9_1 = RoleStoryConfig.instance:getStoryById(var_9_0).photo

		arg_9_0._simagephoto:LoadImage(ResUrl.getRoleStoryPhotoIcon(var_9_1))
	end

	local var_9_2 = ActivityConfig.instance:getActivityCo(arg_9_0.actId)

	RedDotController.instance:addRedDot(arg_9_0._goreddot, var_9_2.redDotId)

	arg_9_0._txtdesc.text = var_9_2.actDesc

	local var_9_3 = GameUtil.splitString2(var_9_2.activityBonus, true) or {}

	for iter_9_0 = 1, math.max(#var_9_3, #arg_9_0.rewardItems) do
		local var_9_4 = arg_9_0.rewardItems[iter_9_0]
		local var_9_5 = var_9_3[iter_9_0]

		if not var_9_4 then
			var_9_4 = IconMgr.instance:getCommonPropItemIcon(arg_9_0._gorewardcontent)

			table.insert(arg_9_0.rewardItems, var_9_4)
		end

		if var_9_5 then
			gohelper.setActive(var_9_4.go, true)
			var_9_4:setMOValue(var_9_5[1], var_9_5[2], var_9_5[3] or 1, nil, true)
			var_9_4:isShowEquipAndItemCount(false)
			var_9_4:hideEquipLvAndBreak(true)
		else
			gohelper.setActive(var_9_4.go, false)
		end
	end
end

function var_0_0.everySecondCall(arg_10_0)
	arg_10_0:refreshRemainTime()
end

function var_0_0.refreshRemainTime(arg_11_0)
	local var_11_0 = ActivityModel.instance:getActMO(arg_11_0.actId):getRealEndTimeStamp() - ServerTime.now()

	gohelper.setActive(arg_11_0._txttime.gameObject, var_11_0 > 0)

	if var_11_0 > 0 then
		local var_11_1 = TimeUtil.SecondToActivityTimeFormat(var_11_0)

		arg_11_0._txttime.text = var_11_1
	end
end

function var_0_0._onClickEnter(arg_12_0)
	RoleStoryController.instance:openRoleStoryDispatchMainView()
end

return var_0_0
