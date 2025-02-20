module("modules.logic.versionactivity1_2.jiexika.view.Activity114EnterView", package.seeall)

slot0 = class("Activity114EnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._golightspine = gohelper.findChild(slot0.viewGO, "scale/#go_lightspine")
	slot0._normalGo = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._btnReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Reward")
	slot0._btnReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Enter")
	slot0._goSchoolBack = gohelper.findChild(slot0.viewGO, "#btn_Enter/#go_schoolback")
	slot0._goSchoolEnter = gohelper.findChild(slot0.viewGO, "#btn_Enter/#go_schoolenter")
	slot0._btnPhoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_photos/#btn_photot")
	slot0._txtphotoprogress = gohelper.findChildTextMesh(slot0.viewGO, "#go_photos/title/#txt_progress")
	slot0._txtdurTime = gohelper.findChildTextMesh(slot0.viewGO, "#go_info/#txt_durTime")

	gohelper.setActive(slot0._txtdurTime, false)

	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnReward:AddClickListener(slot0.openTaskView, slot0)
	slot0._btnPhoto:AddClickListener(slot0.openPhotoView, slot0)
	slot0._btnEnter:AddClickListener(slot0.enter, slot0)
	slot0._btnReset:AddClickListener(slot0.reset, slot0)
	slot0:addEventCb(Activity114Controller.instance, Activity114Event.OnCGUpdate, slot0.onPhotoChange, slot0)
	slot0:addEventCb(Activity114Controller.instance, Activity114Event.OnEnterSchoolUpdate, slot0.onEnterSchoolUpdate, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, slot0._onCloseFullViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.removeEvents(slot0)
	slot0._btnReward:RemoveClickListener()
	slot0._btnPhoto:RemoveClickListener()
	slot0._btnEnter:RemoveClickListener()
	slot0._btnReset:RemoveClickListener()
	slot0:removeEventCb(Activity114Controller.instance, Activity114Event.OnCGUpdate, slot0.onPhotoChange, slot0)
	slot0:removeEventCb(Activity114Controller.instance, Activity114Event.OnEnterSchoolUpdate, slot0.onEnterSchoolUpdate, slot0)
end

slot0.canShowSpineView = {
	ViewName.Activity114PhotoView
}

function slot0._editableInitView(slot0)
	slot0._taskRed = gohelper.findChild(slot0.viewGO, "#btn_Reward/redPoint")
	slot4 = "#go_photos/redPoint"
	slot0._photoRed = gohelper.findChild(slot0.viewGO, slot4)
	slot0._photoGo = slot0:getUserDataTb_()

	for slot4 = 1, 9 do
		slot0._photoGo[slot4] = gohelper.findChildImage(slot0.viewGO, "#go_photos/photo/" .. slot4)
	end

	RedDotController.instance:addRedDot(slot0._taskRed, RedDotEnum.DotNode.ActivityJieXiKaTask)
	RedDotController.instance:addRedDot(slot0._photoRed, RedDotEnum.DotNode.ActivityJieXiKaPhoto)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._btnReset.gameObject, Activity114Model.instance.serverData.canReset and Activity114Model.instance.serverData.isEnterSchool)
	slot0:onPhotoChange()
	slot0:onEnterSchoolUpdate()
	slot0._viewAnim:Play("open", 0, 0)
end

function slot0.onOpenFinish(slot0)
	slot0._viewAnim.enabled = true
end

function slot0.openTaskView(slot0)
	slot0.viewContainer:switchTab(Activity114Enum.TabIndex.TaskView)
	slot0._viewAnim:Play("close", 0, 0)
end

function slot0.enter(slot0)
	if Activity114Model.instance:isEnd() then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	if Activity114Model.instance.serverData.battleEventId > 0 then
		Activity114Controller.instance:enterActivityFight(Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId).config.battleId)

		return
	end

	slot0.viewContainer:switchTab(Activity114Enum.TabIndex.MainView)
	slot0._viewAnim:Play("close", 0, 0)
end

function slot0.openPhotoView(slot0)
	slot0:playCloseAnimAndOpenView(ViewName.Activity114PhotoView)
end

function slot0.playCloseAnimAndOpenView(slot0, slot1)
	slot0.viewContainer.openViewName = slot1

	slot0.viewContainer:playCloseTransition()
end

function slot0.reset(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act114Reset, MsgBoxEnum.BoxType.Yes_No, function ()
		Activity114Rpc.instance:resetRequest(Activity114Model.instance.id)
	end)
end

function slot0.onEnterSchoolUpdate(slot0)
	gohelper.setActive(slot0._goSchoolBack, Activity114Model.instance.serverData.isEnterSchool)
	gohelper.setActive(slot0._btnReset.gameObject, Activity114Model.instance.serverData.canReset and Activity114Model.instance.serverData.isEnterSchool)
	gohelper.setActive(slot0._goSchoolEnter, not Activity114Model.instance.serverData.isEnterSchool)
end

function slot0.onPhotoChange(slot0)
	slot0._txtphotoprogress.text = #Activity114Model.instance.serverData.photos .. "/9"

	for slot5 = 1, 9 do
		if Activity114Model.instance.unLockPhotoDict[slot5] then
			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(slot0._photoGo[slot5], Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)[slot5].smallCg)
		elseif slot5 == 9 then
			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(slot0._photoGo[slot5], "img_empty1")
		else
			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(slot0._photoGo[slot5], "img_empty2")
		end
	end
end

function slot0.refreshTime(slot0)
	if Activity114Model.instance:isEnd() or not ActivityModel.instance:getActivityInfo()[Activity114Model.instance.id] then
		slot0._txtdurTime.text = luaLang("versionactivity_1_2_114enterview_isend")
	else
		slot0._txtdurTime.text = string.format(luaLang("remain"), slot1:getRemainTimeStr2ByEndTime())
	end
end

function slot0._onCloseFullViewFinish(slot0, slot1)
	for slot5, slot6 in pairs(uv0.canShowSpineView) do
		if slot6 == slot1 and slot0._viewAnim then
			slot0.viewContainer:playOpenTransition()

			return
		end
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
