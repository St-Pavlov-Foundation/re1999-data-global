module("modules.logic.versionactivity1_2.jiexika.view.Activity114EnterView", package.seeall)

local var_0_0 = class("Activity114EnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0.viewGO, "scale/#go_lightspine")
	arg_1_0._normalGo = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Reward")
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Enter")
	arg_1_0._goSchoolBack = gohelper.findChild(arg_1_0.viewGO, "#btn_Enter/#go_schoolback")
	arg_1_0._goSchoolEnter = gohelper.findChild(arg_1_0.viewGO, "#btn_Enter/#go_schoolenter")
	arg_1_0._btnPhoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_photos/#btn_photot")
	arg_1_0._txtphotoprogress = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_photos/title/#txt_progress")
	arg_1_0._txtdurTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_info/#txt_durTime")

	gohelper.setActive(arg_1_0._txtdurTime, false)

	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnReward:AddClickListener(arg_2_0.openTaskView, arg_2_0)
	arg_2_0._btnPhoto:AddClickListener(arg_2_0.openPhotoView, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0.enter, arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0.reset, arg_2_0)
	arg_2_0:addEventCb(Activity114Controller.instance, Activity114Event.OnCGUpdate, arg_2_0.onPhotoChange, arg_2_0)
	arg_2_0:addEventCb(Activity114Controller.instance, Activity114Event.OnEnterSchoolUpdate, arg_2_0.onEnterSchoolUpdate, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, arg_2_0._onCloseFullViewFinish, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnReward:RemoveClickListener()
	arg_3_0._btnPhoto:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnReset:RemoveClickListener()
	arg_3_0:removeEventCb(Activity114Controller.instance, Activity114Event.OnCGUpdate, arg_3_0.onPhotoChange, arg_3_0)
	arg_3_0:removeEventCb(Activity114Controller.instance, Activity114Event.OnEnterSchoolUpdate, arg_3_0.onEnterSchoolUpdate, arg_3_0)
end

var_0_0.canShowSpineView = {
	ViewName.Activity114PhotoView
}

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._taskRed = gohelper.findChild(arg_4_0.viewGO, "#btn_Reward/redPoint")
	arg_4_0._photoRed = gohelper.findChild(arg_4_0.viewGO, "#go_photos/redPoint")
	arg_4_0._photoGo = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 9 do
		arg_4_0._photoGo[iter_4_0] = gohelper.findChildImage(arg_4_0.viewGO, "#go_photos/photo/" .. iter_4_0)
	end

	RedDotController.instance:addRedDot(arg_4_0._taskRed, RedDotEnum.DotNode.ActivityJieXiKaTask)
	RedDotController.instance:addRedDot(arg_4_0._photoRed, RedDotEnum.DotNode.ActivityJieXiKaPhoto)
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0._btnReset.gameObject, Activity114Model.instance.serverData.canReset and Activity114Model.instance.serverData.isEnterSchool)
	arg_5_0:onPhotoChange()
	arg_5_0:onEnterSchoolUpdate()
	arg_5_0._viewAnim:Play("open", 0, 0)
end

function var_0_0.onOpenFinish(arg_6_0)
	arg_6_0._viewAnim.enabled = true
end

function var_0_0.openTaskView(arg_7_0)
	arg_7_0.viewContainer:switchTab(Activity114Enum.TabIndex.TaskView)
	arg_7_0._viewAnim:Play("close", 0, 0)
end

function var_0_0.enter(arg_8_0)
	if Activity114Model.instance:isEnd() then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	if Activity114Model.instance.serverData.battleEventId > 0 then
		local var_8_0 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId)

		Activity114Controller.instance:enterActivityFight(var_8_0.config.battleId)

		return
	end

	arg_8_0.viewContainer:switchTab(Activity114Enum.TabIndex.MainView)
	arg_8_0._viewAnim:Play("close", 0, 0)
end

function var_0_0.openPhotoView(arg_9_0)
	arg_9_0:playCloseAnimAndOpenView(ViewName.Activity114PhotoView)
end

function var_0_0.playCloseAnimAndOpenView(arg_10_0, arg_10_1)
	arg_10_0.viewContainer.openViewName = arg_10_1

	arg_10_0.viewContainer:playCloseTransition()
end

function var_0_0.reset(arg_11_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act114Reset, MsgBoxEnum.BoxType.Yes_No, function()
		Activity114Rpc.instance:resetRequest(Activity114Model.instance.id)
	end)
end

function var_0_0.onEnterSchoolUpdate(arg_13_0)
	gohelper.setActive(arg_13_0._goSchoolBack, Activity114Model.instance.serverData.isEnterSchool)
	gohelper.setActive(arg_13_0._btnReset.gameObject, Activity114Model.instance.serverData.canReset and Activity114Model.instance.serverData.isEnterSchool)
	gohelper.setActive(arg_13_0._goSchoolEnter, not Activity114Model.instance.serverData.isEnterSchool)
end

function var_0_0.onPhotoChange(arg_14_0)
	arg_14_0._txtphotoprogress.text = #Activity114Model.instance.serverData.photos .. "/9"

	local var_14_0 = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)

	for iter_14_0 = 1, 9 do
		if Activity114Model.instance.unLockPhotoDict[iter_14_0] then
			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(arg_14_0._photoGo[iter_14_0], var_14_0[iter_14_0].smallCg)
		elseif iter_14_0 == 9 then
			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(arg_14_0._photoGo[iter_14_0], "img_empty1")
		else
			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(arg_14_0._photoGo[iter_14_0], "img_empty2")
		end
	end
end

function var_0_0.refreshTime(arg_15_0)
	local var_15_0 = ActivityModel.instance:getActivityInfo()[Activity114Model.instance.id]

	if Activity114Model.instance:isEnd() or not var_15_0 then
		arg_15_0._txtdurTime.text = luaLang("versionactivity_1_2_114enterview_isend")
	else
		arg_15_0._txtdurTime.text = string.format(luaLang("remain"), var_15_0:getRemainTimeStr2ByEndTime())
	end
end

function var_0_0._onCloseFullViewFinish(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(var_0_0.canShowSpineView) do
		if iter_16_1 == arg_16_1 and arg_16_0._viewAnim then
			arg_16_0.viewContainer:playOpenTransition()

			return
		end
	end
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
