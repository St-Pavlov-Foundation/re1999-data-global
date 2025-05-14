module("modules.logic.dungeon.view.rolestory.RoleStoryActivityView", package.seeall)

local var_0_0 = class("RoleStoryActivityView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._actViewGO = gohelper.findChild(arg_1_0.viewGO, "actview")
	arg_1_0.btnMonster = gohelper.findChildButtonWithAudio(arg_1_0._actViewGO, "BG/#simage_frame")
	arg_1_0.simageMonster = gohelper.findChildSingleImage(arg_1_0._actViewGO, "BG/#simage_frame/#simage_photo")
	arg_1_0.itemPos = gohelper.findChild(arg_1_0._actViewGO, "BG/itemPos")
	arg_1_0.timeTxt = gohelper.findChildTextMesh(arg_1_0._actViewGO, "timebg/#txt_time")
	arg_1_0.btnEnter = gohelper.findChildButtonWithAudio(arg_1_0._actViewGO, "#btn_enter")
	arg_1_0.goEnterRed = gohelper.findChild(arg_1_0._actViewGO, "#btn_enter/#go_reddot")
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0._actViewGO, "BG/title/ani/#txt_title")
	arg_1_0.txtTitleEn = gohelper.findChildTextMesh(arg_1_0._actViewGO, "BG/title/ani/#txt_en")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnEnter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0.btnMonster:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnEnter:RemoveClickListener()
	arg_3_0.btnMonster:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	RedDotController.instance:addRedDot(arg_4_0.goEnterRed, RedDotEnum.DotNode.RoleStoryChallenge)
end

function var_0_0._btnscoreOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function var_0_0._btnenterOnClick(arg_6_0)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeMainViewShow, false)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.refreshView(arg_10_0)
	arg_10_0.storyId = RoleStoryModel.instance:getCurActStoryId()
	arg_10_0.storyMo = RoleStoryModel.instance:getById(arg_10_0.storyId)

	if not arg_10_0.storyMo then
		return
	end

	arg_10_0:refreshMonsterItem()
	arg_10_0:refreshRoleItem()
	arg_10_0:refreshLeftTime()
	arg_10_0:refreshTitle()
	TaskDispatcher.cancelTask(arg_10_0.refreshLeftTime, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0.refreshLeftTime, arg_10_0, 1)
end

function var_0_0.refreshTitle(arg_11_0)
	if not arg_11_0.storyMo then
		return
	end

	local var_11_0 = arg_11_0.storyMo.cfg.name
	local var_11_1 = GameUtil.utf8len(var_11_0)
	local var_11_2 = GameUtil.utf8sub(var_11_0, 1, 1)
	local var_11_3 = ""
	local var_11_4 = ""

	if var_11_1 > 1 then
		var_11_3 = GameUtil.utf8sub(var_11_0, 2, 2)
	end

	if var_11_1 > 3 then
		var_11_4 = GameUtil.utf8sub(var_11_0, 4, var_11_1 - 3)
	end

	arg_11_0.txtTitle.text = string.format("<size=99>%s</size><size=70>%s</size>%s", var_11_2, var_11_3, var_11_4)
	arg_11_0.txtTitleEn.text = arg_11_0.storyMo.cfg.nameEn
end

function var_0_0.refreshMonsterItem(arg_12_0)
	if not arg_12_0.storyMo then
		return
	end

	local var_12_0 = arg_12_0.storyMo.cfg.monster_pic
	local var_12_1 = string.format("singlebg/dungeon/rolestory_photo_singlebg/%s_2.png", var_12_0)

	arg_12_0.simageMonster:LoadImage(var_12_1)
end

function var_0_0.refreshRoleItem(arg_13_0)
	if not arg_13_0.roleItem then
		local var_13_0 = arg_13_0:getResInst(arg_13_0.viewContainer:getSetting().otherRes.itemRes, arg_13_0.itemPos)

		arg_13_0.roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_0, RoleStoryActivityItem)

		arg_13_0.roleItem:initInternal(var_13_0, arg_13_0)
	end

	arg_13_0.roleItem:onUpdateMO(arg_13_0.storyMo)
end

function var_0_0.refreshLeftTime(arg_14_0)
	local var_14_0 = arg_14_0.storyMo

	if not var_14_0 then
		return
	end

	local var_14_1, var_14_2 = var_14_0:getActTime()
	local var_14_3 = var_14_2 - ServerTime.now()

	if var_14_3 > 0 then
		arg_14_0.timeTxt.text = arg_14_0:_getTimeText(var_14_3)
	else
		TaskDispatcher.cancelTask(arg_14_0.refreshLeftTime, arg_14_0)
	end
end

function var_0_0.onDestroyView(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.refreshLeftTime, arg_15_0)
end

function var_0_0._getTimeText(arg_16_0, arg_16_1)
	local var_16_0, var_16_1, var_16_2, var_16_3 = TimeUtil.secondsToDDHHMMSS(arg_16_1)
	local var_16_4 = luaLang("time_day")
	local var_16_5 = luaLang("time_hour2")
	local var_16_6 = luaLang("time_minute2")
	local var_16_7 = luaLang("activity_remain")

	if LangSettings.instance:isEn() then
		var_16_4 = var_16_4 .. " "
		var_16_5 = var_16_5 .. " "
		var_16_6 = var_16_6 .. " "
		var_16_7 = var_16_7 .. " "
	end

	local var_16_8 = "<color=#f09a5a>%s</color>%s<color=#f09a5a>%s</color>%s"
	local var_16_9

	if var_16_0 > 0 then
		var_16_9 = string.format(var_16_8, var_16_0, var_16_4, var_16_1, luaLang("time_hour2"))
	elseif var_16_1 > 0 then
		var_16_9 = string.format(var_16_8, var_16_1, var_16_5, var_16_2, luaLang("time_minute2"))
	else
		var_16_9 = string.format(var_16_8, var_16_2, var_16_6, var_16_3, luaLang("time_second"))
	end

	return var_16_7 .. var_16_9
end

return var_0_0
