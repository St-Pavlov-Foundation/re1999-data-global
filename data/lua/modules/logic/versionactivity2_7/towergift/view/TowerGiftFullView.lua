module("modules.logic.versionactivity2_7.towergift.view.TowerGiftFullView", package.seeall)

local var_0_0 = class("TowerGiftFullView", BaseView)

var_0_0.TaskId = 92001101

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_check")
	arg_1_0._btn1Claim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward1/go_canget/#btn_Claim")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "root/reward1/go_canget")
	arg_1_0._goreceive = gohelper.findChild(arg_1_0.viewGO, "root/reward1/go_receive")
	arg_1_0._gotaskreceive = gohelper.findChild(arg_1_0.viewGO, "root/reward2/go_receive")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "root/reward2/go_goto/#txt_progress")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/reward2/go_goto/txt_dec")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/simage_fullbg/#txt_time")
	arg_1_0._gogoto = gohelper.findChild(arg_1_0.viewGO, "root/reward2/go_goto")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "root/reward2/go_lock")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward2/go_goto/#btn_goto")
	arg_1_0._btnicon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward2/icon/click")
	arg_1_0._bgmId = nil

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
	arg_2_0._btn1Claim:AddClickListener(arg_2_0._btn1ClaimOnClick, arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0._btnicon:AddClickListener(arg_2_0._btniconOnClick, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0.checkBgm, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncheck:RemoveClickListener()
	arg_3_0._btn1Claim:RemoveClickListener()
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0._btnicon:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0.checkBgm, arg_3_0)
end

function var_0_0._btncheckOnClick(arg_4_0)
	local var_4_0 = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = TowerGiftEnum.ShowHeroList
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_4_0)
end

function var_0_0._btn1ClaimOnClick(arg_5_0)
	if not arg_5_0:checkReceied() and arg_5_0:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_5_0._actId, 1)
	end
end

function var_0_0._btngotoOnClick(arg_6_0)
	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower) then
		TowerController.instance:openTowerTaskView()

		arg_6_0._bgmId = BGMSwitchModel.instance:getCurBgm()
	else
		local var_6_0, var_6_1, var_6_2 = JumpController.instance:canJumpNew(JumpEnum.JumpView.Tower)

		if not var_6_0 then
			GameFacade.showToastWithTableParam(var_6_1, var_6_2)

			return false
		end
	end
end

function var_0_0._btniconOnClick(arg_7_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, TowerGiftEnum.StoneUpTicketId)
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower) then
		TowerRpc.instance:sendGetTowerInfoRequest()
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Tower
		})
	end

	local var_10_0 = arg_10_0.viewParam.parent

	arg_10_0._actId = arg_10_0.viewParam.actId

	gohelper.addChild(var_10_0, arg_10_0.viewGO)
	Activity101Rpc.instance:sendGet101InfosRequest(arg_10_0._actId)
	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower)
	local var_11_1

	if var_11_0 then
		var_11_1 = TowerTaskModel.instance:getActRewardTask()
	end

	local var_11_2 = var_11_1 and next(var_11_1)

	if var_11_0 then
		if not var_11_2 then
			gohelper.setActive(arg_11_0._golock, true)
			gohelper.setActive(arg_11_0._gogoto, false)
		else
			gohelper.setActive(arg_11_0._golock, false)
			gohelper.setActive(arg_11_0._gogoto, true)
		end
	else
		gohelper.setActive(arg_11_0._golock, true)
		gohelper.setActive(arg_11_0._gogoto, false)
	end

	if var_11_1 then
		local var_11_3 = var_11_1:isClaimed()

		gohelper.setActive(arg_11_0._gotaskreceive, var_11_3)
		gohelper.setActive(arg_11_0._gogoto, not var_11_3)

		if var_11_3 then
			arg_11_0._txtprogress.text = luaLang("p_v2a7_tower_fullview_txt_finished")
		end

		gohelper.setActive(arg_11_0._txtprogress.gameObject, true)

		arg_11_0._txtprogress.text = string.format("<#ec5d5d>%s</color>/%s", var_11_1.progress, var_11_1.config.maxProgress)
	end

	local var_11_4 = arg_11_0:checkReceied()
	local var_11_5 = arg_11_0:checkCanGet()

	gohelper.setActive(arg_11_0._gocanget, var_11_5)
	gohelper.setActive(arg_11_0._goreceive, var_11_4)

	arg_11_0._txttime.text = ActivityHelper.getActivityRemainTimeStr(arg_11_0._actId)
end

function var_0_0.checkReceied(arg_12_0)
	return (ActivityType101Model.instance:isType101RewardGet(arg_12_0._actId, 1))
end

function var_0_0.checkCanGet(arg_13_0)
	return (ActivityType101Model.instance:isType101RewardCouldGet(arg_13_0._actId, 1))
end

function var_0_0.checkBgm(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.TowerMainView then
		if arg_14_0._bgmId and arg_14_0._bgmId ~= -1 then
			local var_14_0 = BGMSwitchConfig.instance:getBGMSwitchCO(arg_14_0._bgmId)
			local var_14_1 = var_14_0 and var_14_0.audio

			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Main, var_14_1)
		else
			local var_14_2 = BGMSwitchModel.instance:getUsedBgmIdFromServer()

			if BGMSwitchModel.instance:isRandomBgmId(var_14_2) then
				var_14_2 = BGMSwitchModel.instance:nextBgm(1, true)
			end

			local var_14_3 = BGMSwitchConfig.instance:getBGMSwitchCO(var_14_2)
			local var_14_4 = var_14_3 and var_14_3.audio or AudioEnum.UI.Play_Replay_Music_Daytime

			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Main, var_14_4)
		end
	end
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
