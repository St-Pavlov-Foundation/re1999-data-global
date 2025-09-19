module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErTeamItem", package.seeall)

local var_0_0 = class("MoLiDeErTeamItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "image_HeadBG/#go_Selected")
	arg_1_0._simageHead = gohelper.findChildSingleImage(arg_1_0.viewGO, "image_HeadBG/image/#simage_Head")
	arg_1_0._goCD = gohelper.findChild(arg_1_0.viewGO, "image_HeadBG/#go_CD")
	arg_1_0._btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "image_HeadBG/#btn_Detail")
	arg_1_0._goBuff = gohelper.findChild(arg_1_0.viewGO, "image_HeadBG/#go_Buff")
	arg_1_0._imageHeadBG = gohelper.findChildImage(arg_1_0.viewGO, "image_HeadBG")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._imageHead = gohelper.findChildImage(arg_2_0.viewGO, "image_HeadBG/image/#simage_Head")
	arg_2_0._animator = gohelper.findChildComponent(arg_2_0.viewGO, "image_HeadBG", typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnDetail:AddClickListener(arg_3_0.onDetailClick, arg_3_0)
	arg_3_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.UIDispatchTeam, arg_3_0.onDispatchTeam, arg_3_0)
	arg_3_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.UIWithDrawTeam, arg_3_0.onWithDrawTeam, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnDetail:RemoveClickListener()
	arg_4_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.UIDispatchTeam, arg_4_0.onDispatchTeam, arg_4_0)
	arg_4_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.UIWithDrawTeam, arg_4_0.onWithDrawTeam, arg_4_0)
end

function var_0_0.onWithDrawTeam(arg_5_0, arg_5_1)
	if arg_5_0.teamId == nil then
		return
	end

	if arg_5_0.viewGO.activeSelf == true and arg_5_0.state == MoLiDeErEnum.DispatchState.Main and arg_5_1 == arg_5_0.teamId then
		arg_5_0:showAnim(MoLiDeErEnum.AnimName.RoleItemOut, true)
		TaskDispatcher.runDelay(arg_5_0.onFadeOutEnd, arg_5_0, 0.5)
	end
end

function var_0_0.onFadeOutEnd(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onFadeOutEnd, arg_6_0)
	arg_6_0:showAnim(MoLiDeErEnum.AnimName.RoleItemIn, false)
end

function var_0_0.onDispatchTeam(arg_7_0, arg_7_1)
	if arg_7_0.teamId == nil then
		return
	end

	if arg_7_0.viewGO.activeSelf == true and arg_7_0.state == MoLiDeErEnum.DispatchState.Main and arg_7_1 == arg_7_0.teamId then
		arg_7_0:showAnim(MoLiDeErEnum.AnimName.RoleItemIn, true)
	end
end

function var_0_0.showAnim(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2 and 0 or 1

	arg_8_0._animator:Play(arg_8_1, 0, var_8_0)
	logNormal("莫莉德尔 角色活动 播放角色item动画：" .. arg_8_1 .. " time: " .. tostring(var_8_0))
end

function var_0_0.onDetailClick(arg_9_0)
	if arg_9_0.teamId == MoLiDeErGameModel.instance:getSelectTeamId() then
		return
	end

	local var_9_0 = MoLiDeErGameModel.instance:getSelectOptionId()

	if arg_9_0.state == MoLiDeErEnum.DispatchState.Dispatch and var_9_0 ~= 0 and var_9_0 ~= nil then
		local var_9_1 = MoLiDeErGameModel.instance:getCurGameInfo()
		local var_9_2, var_9_3 = MoLiDeErHelper.isTeamCanChose(var_9_1, arg_9_0.info, var_9_0)

		if var_9_2 == false then
			if var_9_3 ~= nil then
				GameFacade.showToast(var_9_3)
			end

			return
		end
	end

	MoLiDeErGameModel.instance:setSelectTeamId(arg_9_0.teamId)
end

function var_0_0.setData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.info = arg_10_1
	arg_10_0.teamId = arg_10_1.teamId
	arg_10_0.state = arg_10_2
	arg_10_0._teamConfig = MoLiDeErConfig.instance:getTeamConfig(arg_10_1.teamId)

	arg_10_0:refreshUI()
end

function var_0_0.setActive(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0.viewGO, arg_11_1)
end

function var_0_0.setSelect(arg_12_0, arg_12_1)
	if arg_12_0.teamId == nil then
		return
	end

	gohelper.setActive(arg_12_0.viewGO, not arg_12_1)
	gohelper.setActive(arg_12_0._goSelected, arg_12_1)
	arg_12_0:refreshBuffState()
end

function var_0_0.refreshUI(arg_13_0)
	local var_13_0 = arg_13_0._teamConfig

	if not string.nilorempty(var_13_0.picture) then
		arg_13_0._simageHead:LoadImage(var_13_0.picture, MoLiDeErHelper.handleImage, {
			imgTransform = arg_13_0._simageHead.transform,
			offsetParam = var_13_0.iconOffset
		})
	end

	arg_13_0:refreshState()
end

function var_0_0.refreshState(arg_14_0)
	if arg_14_0.teamId == nil then
		return
	end

	local var_14_0 = MoLiDeErGameModel.instance:getCurGameInfo()
	local var_14_1 = (arg_14_0.state == MoLiDeErEnum.DispatchState.Dispatch or arg_14_0.state == MoLiDeErEnum.DispatchState.Main) and var_14_0:isInDispatching(arg_14_0.info.teamId)
	local var_14_2 = MoLiDeErGameModel.instance:getSelectOptionId()
	local var_14_3 = true

	if arg_14_0.state == MoLiDeErEnum.DispatchState.Dispatch or arg_14_0.state == MoLiDeErEnum.DispatchState.Main and var_14_2 then
		var_14_3 = MoLiDeErHelper.isTeamEnable(var_14_2, arg_14_0.teamId)
	end

	local var_14_4 = arg_14_0.info.roundActionTime > 0 and arg_14_0.info.roundActedTime < arg_14_0.info.roundActionTime

	gohelper.setActive(arg_14_0._goCD, var_14_1)

	local var_14_5

	if not var_14_1 and var_14_3 and var_14_4 then
		var_14_5 = MoLiDeErEnum.EventBgColor.Normal
	else
		var_14_5 = MoLiDeErEnum.EventBgColor.Dispatching
	end

	UIColorHelper.set(arg_14_0._imageHeadBG, var_14_5)
	UIColorHelper.set(arg_14_0._imageHead, var_14_5)
	arg_14_0:refreshBuffState()
end

function var_0_0.refreshBuffState(arg_15_0)
	local var_15_0 = MoLiDeErGameModel.instance:getSelectOptionId()

	if arg_15_0.state == MoLiDeErEnum.DispatchState.Dispatch then
		local var_15_1 = var_15_0 ~= nil and MoLiDeErHelper.isTeamBuffed(var_15_0, arg_15_0.teamId)

		gohelper.setActive(arg_15_0._goBuff, var_15_1)
	else
		gohelper.setActive(arg_15_0._goBuff, false)
	end
end

function var_0_0.clear(arg_16_0)
	arg_16_0.teamId = nil
	arg_16_0.state = nil
	arg_16_0.info = nil
	arg_16_0._teamConfig = nil
end

function var_0_0.onDestroy(arg_17_0)
	return
end

return var_0_0
