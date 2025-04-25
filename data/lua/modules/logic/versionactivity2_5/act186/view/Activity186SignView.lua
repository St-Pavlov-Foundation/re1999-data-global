module("modules.logic.versionactivity2_5.act186.view.Activity186SignView", package.seeall)

slot0 = class("Activity186SignView", BaseView)

function slot0.onInitView(slot0)
	slot0.signList = {}
	slot0.signContent = gohelper.findChild(slot0.viewGO, "root/signList/Content")
	slot0.btnTaskCanget = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/avgTask/#go_reward/go_canget")
	slot0.goTaskReceive = gohelper.findChild(slot0.viewGO, "root/avgTask/#go_reward/go_receive")
	slot0.goTaskReward = gohelper.findChild(slot0.viewGO, "root/avgTask/#go_reward/go_icon")
	slot0.txtTaskDesc = gohelper.findChildTextMesh(slot0.viewGO, "root/avgTask/txtDesc")
	slot0.hasgetHookAnim = gohelper.findChildComponent(slot0.viewGO, "root/avgTask/#go_reward/go_receive/go_hasget", gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnTaskCanget, slot0.onClickBtnTaskCanget, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0.onRefreshNorSignActivity, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.SpBonusStageChange, slot0.onSpBonusStageChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		if slot0._waitRefreshList then
			slot0:refreshSignList()
		end

		if slot0._waitRefreshTask then
			slot0:refreshTask()
		end
	end
end

function slot0.onRefreshNorSignActivity(slot0)
	slot0._waitRefreshList = true
end

function slot0.onSpBonusStageChange(slot0)
	slot0._waitRefreshTask = true
end

function slot0.onClickBtnTaskCanget(slot0)
	Activity101Rpc.instance:sendAcceptAct186SpBonusRequest(slot0.signActId, slot0.actId)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.signActId = ActivityEnum.Activity.V2a5_Act186Sign
	slot0.actMo = Activity186Model.instance:getById(slot0.actId)
end

function slot0.refreshView(slot0)
	slot0:refreshSignList()
	slot0:refreshTask()
end

function slot0.refreshSignList(slot0)
	slot0._waitRefresh = false
	slot5 = #slot0.signList

	for slot5 = 1, math.max(#ActivityConfig.instance:getNorSignActivityCos(slot0.signActId), slot5) do
		slot0:getOrCreateItem(slot5):onUpdateMO(slot1[slot5])
	end
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0.signList[slot1] then
		slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.itemRes, slot0.signContent, string.format("item%s", slot1)), Activity186SignItem)

		slot2:initActId(slot0.actId)

		slot0.signList[slot1] = slot2
	end

	return slot2
end

function slot0.refreshTask(slot0)
	slot0._waitRefreshTask = false
	slot1 = slot0.actMo.spBonusStage
	slot0.txtTaskDesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_signview_task_txt"), slot1 ~= 0 and 1 or 0)

	gohelper.setActive(slot0.goTaskReceive, slot1 == 2)
	gohelper.setActive(slot0.btnTaskCanget, slot1 == 1)

	if slot1 == 2 then
		if slot0.spBonusStage and slot1 ~= slot0.spBonusStage then
			slot0.hasgetHookAnim:Play("go_hasget_in")
		else
			slot0.hasgetHookAnim:Play("go_hasget_idle")
		end
	end

	slot0.spBonusStage = slot1
	slot7 = GameUtil.splitString2(Activity186Config.instance:getConstStr(Activity186Enum.ConstId.Act101Reward), true)[1]

	if not slot0.itemIcon then
		slot0.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0.goTaskReward)
	end

	slot0.itemIcon:setMOValue(slot7[1], slot7[2], slot7[3])
	slot0.itemIcon:setScale(0.7)
	slot0.itemIcon:setCountFontSize(46)
	slot0.itemIcon:setHideLvAndBreakFlag(true)
	slot0.itemIcon:hideEquipLvAndBreak(true)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
