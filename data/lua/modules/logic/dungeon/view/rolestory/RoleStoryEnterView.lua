module("modules.logic.dungeon.view.rolestory.RoleStoryEnterView", package.seeall)

local var_0_0 = class("RoleStoryEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#txt_LimitTime")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#image_reddot")
	arg_1_0._simagephoto = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Photo")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/Title/#txt_Title")
	arg_1_0._txttitleen = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/Title/#txt_Titleen")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_signature")
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

	if arg_7_0._simagesignature then
		arg_7_0._simagesignature:UnLoadImage()

		arg_7_0._simagesignature = nil
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
		local var_9_1 = RoleStoryConfig.instance:getStoryById(var_9_0)

		arg_9_0:refreshTitle(var_9_1)

		local var_9_2 = var_9_1.photo

		arg_9_0._simagephoto:LoadImage(ResUrl.getRoleStoryPhotoIcon(var_9_2))
		arg_9_0._simagesignature:LoadImage(ResUrl.getSignature(var_9_1.signature))
	end

	local var_9_3 = ActivityConfig.instance:getActivityCo(arg_9_0.actId)

	RedDotController.instance:addRedDot(arg_9_0._goreddot, var_9_3.redDotId)

	local var_9_4 = GameUtil.splitString2(var_9_3.activityBonus, true) or {}

	for iter_9_0 = 1, math.max(#var_9_4, #arg_9_0.rewardItems) do
		local var_9_5 = arg_9_0.rewardItems[iter_9_0]
		local var_9_6 = var_9_4[iter_9_0]

		if not var_9_5 then
			var_9_5 = IconMgr.instance:getCommonPropItemIcon(arg_9_0._gorewardcontent)

			table.insert(arg_9_0.rewardItems, var_9_5)
		end

		if var_9_6 then
			gohelper.setActive(var_9_5.go, true)
			var_9_5:setMOValue(var_9_6[1], var_9_6[2], var_9_6[3] or 1, nil, true)
			var_9_5:isShowEquipAndItemCount(false)
			var_9_5:hideEquipLvAndBreak(true)
		else
			gohelper.setActive(var_9_5.go, false)
		end
	end
end

function var_0_0.refreshTitle(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_1.name
	local var_10_1 = GameUtil.utf8len(var_10_0)
	local var_10_2 = GameUtil.utf8sub(var_10_0, 1, 1)
	local var_10_3 = ""
	local var_10_4 = ""

	if var_10_1 > 1 then
		var_10_3 = GameUtil.utf8sub(var_10_0, 2, 2)
	end

	if var_10_1 > 3 then
		var_10_4 = GameUtil.utf8sub(var_10_0, 4, var_10_1 - 3)
	end

	arg_10_0._txttitle.text = string.format("<size=105>%s</size><size=70>%s</size>%s", var_10_2, var_10_3, var_10_4)
	arg_10_0._txttitleen.text = arg_10_1.nameEn
end

function var_0_0.everySecondCall(arg_11_0)
	arg_11_0:refreshRemainTime()
end

function var_0_0.refreshRemainTime(arg_12_0)
	local var_12_0 = ActivityModel.instance:getActMO(arg_12_0.actId):getRealEndTimeStamp() - ServerTime.now()

	gohelper.setActive(arg_12_0._txttime, var_12_0 > 0)

	if var_12_0 > 0 then
		local var_12_1, var_12_2, var_12_3, var_12_4 = TimeUtil.secondsToDDHHMMSS(var_12_0)
		local var_12_5

		if LangSettings.instance:isEn() then
			local var_12_6 = "<color=#BC5E18>%s</color>%s <color=#BC5E18>%s</color>%s"

			if var_12_1 > 0 then
				var_12_5 = string.format(var_12_6, var_12_1, luaLang("time_day"), var_12_2, luaLang("time_hour2"))
			elseif var_12_2 > 0 then
				var_12_5 = string.format(var_12_6, var_12_2, luaLang("time_hour2"), var_12_3, luaLang("time_minute2"))
			else
				var_12_5 = string.format(var_12_6, var_12_3, luaLang("time_minute2"), var_12_4, luaLang("time_second"))
			end
		elseif var_12_1 > 0 then
			var_12_5 = string.format("<color=#BC5E18>%s</color>%s<color=#BC5E18>%s</color>%s", var_12_1, luaLang("time_day"), var_12_2, luaLang("time_hour2"))
		elseif var_12_2 > 0 then
			var_12_5 = string.format("<color=#BC5E18>%s</color>%s<color=#BC5E18>%s</color>%s", var_12_2, luaLang("time_hour2"), var_12_3, luaLang("time_minute2"))
		else
			var_12_5 = string.format("<color=#BC5E18>%s</color>%s<color=#BC5E18>%s</color>%s", var_12_3, luaLang("time_minute2"), var_12_4, luaLang("time_second"))
		end

		arg_12_0._txttime.text = string.format("%s%s", luaLang("activity_remain"), var_12_5)
	end
end

function var_0_0._onClickEnter(arg_13_0)
	local var_13_0 = RoleStoryModel.instance:getCurActStoryId()

	NecrologistStoryController.instance:openGameView(var_13_0)
end

return var_0_0
