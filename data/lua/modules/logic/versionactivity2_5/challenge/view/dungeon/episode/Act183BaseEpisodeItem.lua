module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183BaseEpisodeItem", package.seeall)

local var_0_0 = class("Act183BaseEpisodeItem", LuaCompBase)

function var_0_0.Get(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getEpisodeId()
	local var_1_1 = arg_1_1:getEpisodeType()
	local var_1_2 = arg_1_1:getGroupType()
	local var_1_3 = arg_1_1:getConfigOrder()
	local var_1_4 = Act183Helper.getEpisodeClsKey(var_1_2, var_1_1)
	local var_1_5 = Act183Enum.EpisodeClsType[var_1_4]
	local var_1_6 = var_1_5.getItemParentPath(var_1_3)
	local var_1_7 = gohelper.findChild(arg_1_0, var_1_6)

	if gohelper.isNil(var_1_7) then
		logError(string.format("挑战玩法关卡挂点不存在 episodeId = %s, parentPath = %s", var_1_0, var_1_6))
	end

	local var_1_8 = var_1_5.getItemTemplatePath()
	local var_1_9 = var_1_5.getItemTemplateGo(arg_1_0, var_1_8)
	local var_1_10 = "item_" .. var_1_3
	local var_1_11 = gohelper.clone(var_1_9, var_1_7, var_1_10)
	local var_1_12 = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_11, var_1_5)

	var_1_12.parentGo = var_1_7

	var_1_12:initPosAndRotation()

	return var_1_12
end

function var_0_0.getItemParentPath(arg_2_0)
	return ""
end

function var_0_0.getItemTemplateGo(arg_3_0, arg_3_1)
	return (gohelper.findChild(arg_3_0, arg_3_1))
end

function var_0_0.getItemTemplatePath(arg_4_0)
	return ""
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.go = arg_5_1
	arg_5_0._golock = gohelper.findChild(arg_5_0.go, "go_lock")
	arg_5_0._gounlock = gohelper.findChild(arg_5_0.go, "go_unlock")
	arg_5_0._gofinish = gohelper.findChild(arg_5_0.go, "go_finish")
	arg_5_0._gocheck = gohelper.findChild(arg_5_0.go, "go_finish/image")
	arg_5_0._btnclick = gohelper.findChildButton(arg_5_0.go, "btn_click")
	arg_5_0._goselect = gohelper.findChild(arg_5_0.go, "go_select")
	arg_5_0._simageicon = gohelper.findChildSingleImage(arg_5_0.go, "image_icon")
	arg_5_0._animfinish = gohelper.onceAddComponent(arg_5_0._gofinish, gohelper.Type_Animator)
end

function var_0_0.initPosAndRotation(arg_6_0)
	local var_6_0 = gohelper.findChild(arg_6_0.parentGo, "positions")

	if gohelper.isNil(var_6_0) then
		return
	end

	local var_6_1 = var_6_0.transform
	local var_6_2 = var_6_1.childCount

	for iter_6_0 = 1, var_6_2 do
		local var_6_3 = var_6_1:GetChild(iter_6_0 - 1)

		arg_6_0:setTranPosition(var_6_3)
	end
end

function var_0_0.setTranPosition(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.gameObject.name
	local var_7_1 = gohelper.findChild(arg_7_0.go, var_7_0)

	if gohelper.isNil(var_7_1) then
		logError(string.format("设置关卡ui坐标失败 节点不存在 rootName = %s, goPath = %s", arg_7_0.parentGo.name, var_7_0))

		return
	end

	local var_7_2, var_7_3 = recthelper.getAnchor(arg_7_1)
	local var_7_4, var_7_5, var_7_6 = transformhelper.getLocalRotation(arg_7_1)

	recthelper.setAnchor(var_7_1.transform, var_7_2 or 0, var_7_3 or 0)
	transformhelper.setLocalRotation(var_7_1.transform, var_7_4, var_7_5, var_7_6)
end

function var_0_0.addEventListeners(arg_8_0)
	arg_8_0._btnclick:AddClickListener(arg_8_0._btnclickOnClick, arg_8_0)
	arg_8_0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, arg_8_0._onSelectEpisode, arg_8_0)
	arg_8_0:addEventCb(Act183Controller.instance, Act183Event.EpisodeStartPlayFinishAnim, arg_8_0._checkPlayFinishAnim, arg_8_0)
end

function var_0_0.removeEventListeners(arg_9_0)
	arg_9_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_ClickEpisode)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode, arg_10_0._episodeId)
end

function var_0_0._onSelectEpisode(arg_11_0, arg_11_1)
	arg_11_0:onSelect(arg_11_1 == arg_11_0._episodeId)
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goselect, arg_12_1)
end

function var_0_0.onUpdateMo(arg_13_0, arg_13_1)
	arg_13_0._episodeMo = arg_13_1
	arg_13_0._status = arg_13_1:getStatus()
	arg_13_0._episodeId = arg_13_1:getEpisodeId()

	local var_13_0 = Act183Model.instance:getNewFinishEpisodeId()

	arg_13_0._isFinishedButNotNew = arg_13_0._status == Act183Enum.EpisodeStatus.Finished and var_13_0 ~= arg_13_0._episodeId

	gohelper.setActive(arg_13_0._goselect, false)
	gohelper.setActive(arg_13_0._golock, arg_13_0._status == Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(arg_13_0._gounlock, arg_13_0._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(arg_13_0._gofinish, arg_13_0._isFinishedButNotNew)
	Act183Helper.setEpisodeIcon(arg_13_0._episodeId, arg_13_0._status, arg_13_0._simageicon)
	arg_13_0:setVisible(true)
end

function var_0_0.getConfigOrder(arg_14_0)
	local var_14_0 = arg_14_0._episodeMo and arg_14_0._episodeMo:getConfig()

	return var_14_0 and var_14_0.order
end

function var_0_0.setVisible(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0.go, arg_15_1)
end

function var_0_0.getIconTran(arg_16_0)
	return arg_16_0._simageicon.transform
end

function var_0_0.playFinishAnim(arg_17_0)
	gohelper.setActive(arg_17_0._gofinish, true)
	arg_17_0._animfinish:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished)
end

function var_0_0._checkPlayFinishAnim(arg_18_0, arg_18_1)
	if arg_18_0._episodeId ~= arg_18_1 then
		return
	end

	arg_18_0:playFinishAnim()
end

function var_0_0.refreshPassStarList(arg_19_0, arg_19_1)
	if arg_19_0._status ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local var_19_0 = arg_19_0._episodeMo and arg_19_0._episodeMo:getTotalStarCount() or 0
	local var_19_1 = arg_19_0._episodeMo and arg_19_0._episodeMo:getFinishStarCount() or 0
	local var_19_2 = {}

	for iter_19_0 = 1, var_19_0 do
		local var_19_3 = arg_19_0._starItemTab[iter_19_0]

		if not var_19_3 then
			var_19_3 = arg_19_0:getUserDataTb_()
			var_19_3.go = gohelper.cloneInPlace(arg_19_1, "star_" .. iter_19_0)
			var_19_3.imagestar = var_19_3.go:GetComponent(gohelper.Type_Image)
			arg_19_0._starItemTab[iter_19_0] = var_19_3
		end

		local var_19_4 = iter_19_0 <= var_19_1 and "#F77040" or "#87898C"

		UISpriteSetMgr.instance:setCommonSprite(var_19_3.imagestar, "zhuxianditu_pt_xingxing_001", true)
		SLFramework.UGUI.GuiHelper.SetColor(var_19_3.imagestar, var_19_4)
		gohelper.setActive(var_19_3.go, true)

		var_19_2[var_19_3] = true
	end

	for iter_19_1, iter_19_2 in pairs(arg_19_0._starItemTab) do
		if not var_19_2[iter_19_2] then
			gohelper.setActive(iter_19_2.go, false)
		end
	end
end

function var_0_0.destroySelf(arg_20_0)
	gohelper.destroy(arg_20_0.go)
end

function var_0_0.onDestroy(arg_21_0)
	return
end

return var_0_0
