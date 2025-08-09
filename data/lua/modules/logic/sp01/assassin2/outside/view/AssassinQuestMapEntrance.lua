module("modules.logic.sp01.assassin2.outside.view.AssassinQuestMapEntrance", package.seeall)

local var_0_0 = class("AssassinQuestMapEntrance", BaseViewExtended)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._mapId = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._golock = gohelper.findChild(arg_2_0.viewGO, "go_lock")
	arg_2_0._txtname1 = gohelper.findChildText(arg_2_0.viewGO, "go_lock/txt_name")
	arg_2_0._txtprogress1 = gohelper.findChildText(arg_2_0.viewGO, "go_lock/txt_progress1")
	arg_2_0._gounlock = gohelper.findChild(arg_2_0.viewGO, "go_unlock")
	arg_2_0._txtname2 = gohelper.findChildText(arg_2_0.viewGO, "go_unlock/txt_name")
	arg_2_0._txtprogress2 = gohelper.findChildText(arg_2_0.viewGO, "go_unlock/txt_progress2")
	arg_2_0._gofinish = gohelper.findChild(arg_2_0.viewGO, "go_finish")
	arg_2_0._txtname3 = gohelper.findChildText(arg_2_0.viewGO, "go_finish/txt_name")
	arg_2_0._txtprogress3 = gohelper.findChildText(arg_2_0.viewGO, "go_finish/txt_progress3")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
	arg_3_0:addEventCb(AssassinController.instance, AssassinEvent.OnFinishQuest, arg_3_0._onFinishQuest, arg_3_0)
	arg_3_0:addEventCb(AssassinController.instance, AssassinEvent.OnUnlockQuestContent, arg_3_0._onUnlockQuestContent, arg_3_0)
	arg_3_0:addEventCb(AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, arg_3_0.refresh, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
	arg_4_0:removeEventCb(AssassinController.instance, AssassinEvent.OnFinishQuest, arg_4_0._onFinishQuest, arg_4_0)
	arg_4_0:removeEventCb(AssassinController.instance, AssassinEvent.OnUnlockQuestContent, arg_4_0._onUnlockQuestContent, arg_4_0)
	arg_4_0:removeEventCb(AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, arg_4_0.refresh, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0)
end

function var_0_0._btnclickOnClick(arg_5_0, arg_5_1, arg_5_2)
	if AssassinOutsideModel.instance:getQuestMapStatus(arg_5_0._mapId) == AssassinEnum.MapStatus.Locked then
		return
	end

	AssassinController.instance:openAssassinQuestMapView({
		mapId = arg_5_0._mapId,
		questId = arg_5_1,
		fightReturnStealthGame = arg_5_2
	})
end

function var_0_0._onFinishQuest(arg_6_0)
	arg_6_0:refreshStatus()
	arg_6_0:refreshProgress()
end

function var_0_0._onUnlockQuestContent(arg_7_0)
	arg_7_0:refresh()
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	arg_8_0:checkUnlockAnim()
end

function var_0_0._editableInitView(arg_9_0)
	local var_9_0 = AssassinConfig.instance:getMapTitle(arg_9_0._mapId)

	arg_9_0._txtname1.text = var_9_0
	arg_9_0._txtname2.text = var_9_0
	arg_9_0._txtname3.text = var_9_0
	arg_9_0._unlockanimator = arg_9_0._gounlock:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:refresh()

	local var_10_0 = arg_10_0.viewContainer.viewParam

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0.questMapId

	if var_10_1 and arg_10_0._mapId == var_10_1 then
		arg_10_0:_btnclickOnClick()

		return
	end

	local var_10_2
	local var_10_3 = var_10_0.fightReturnStealthGame

	if var_10_3 then
		var_10_2 = AssassinOutsideModel.instance:getProcessingQuest()
	else
		var_10_2 = var_10_0.questId
	end

	if var_10_2 and var_10_2 ~= 0 then
		local var_10_4 = AssassinConfig.instance:getQuestMapId(var_10_2)

		if var_10_4 and arg_10_0._mapId == var_10_4 then
			arg_10_0:_btnclickOnClick(var_10_2, var_10_3)
		end
	end
end

function var_0_0.refresh(arg_11_0)
	arg_11_0:refreshStatus()
	arg_11_0:refreshProgress()
end

function var_0_0.refreshStatus(arg_12_0)
	local var_12_0 = AssassinOutsideModel.instance:getQuestMapStatus(arg_12_0._mapId)

	gohelper.setActive(arg_12_0._golock, var_12_0 == AssassinEnum.MapStatus.Locked)
	gohelper.setActive(arg_12_0._gounlock, var_12_0 == AssassinEnum.MapStatus.Unlocked)
	gohelper.setActive(arg_12_0._gofinish, var_12_0 == AssassinEnum.MapStatus.Finished)
	arg_12_0:checkUnlockAnim()
end

function var_0_0.checkUnlockAnim(arg_13_0)
	local var_13_0 = ViewMgr.instance:getOpenViewNameList()

	if var_13_0[#var_13_0] ~= ViewName.AssassinMapView then
		return
	end

	local var_13_1 = AssassinOutsideModel.instance:getQuestMapStatus(arg_13_0._mapId)
	local var_13_2 = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.MapPlayUnlockAnim, arg_13_0._mapId)
	local var_13_3 = not AssassinOutsideModel.instance:getCacheKeyData(var_13_2)

	if var_13_1 == AssassinEnum.MapStatus.Unlocked then
		if var_13_3 then
			arg_13_0._unlockanimator:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_unlockmap)
			AssassinController.instance:setHasPlayedAnimation(var_13_2)
		else
			arg_13_0._unlockanimator:Play("idle", 0, 0)
		end
	end
end

function var_0_0.refreshProgress(arg_14_0)
	local var_14_0, var_14_1 = AssassinOutsideModel.instance:getQuestMapProgress(arg_14_0._mapId)

	arg_14_0._txtprogress1.text = var_14_1
	arg_14_0._txtprogress2.text = var_14_1
	arg_14_0._txtprogress3.text = var_14_1
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
