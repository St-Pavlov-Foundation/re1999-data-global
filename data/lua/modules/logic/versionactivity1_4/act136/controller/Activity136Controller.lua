module("modules.logic.versionactivity1_4.act136.controller.Activity136Controller", package.seeall)

slot0 = class("Activity136Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._onRefreshActivityState, slot0)
end

function slot0.reInit(slot0)
	TaskDispatcher.cancelTask(slot0._delayGetInfo, slot0)
end

function slot0._onRefreshActivityState(slot0)
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.SelfSelectCharacter) then
		TaskDispatcher.cancelTask(slot0._delayGetInfo, slot0)
		TaskDispatcher.runDelay(slot0._delayGetInfo, slot0, 0.2)
	end
end

function slot0._delayGetInfo(slot0)
	Activity136Rpc.instance:sendGet136InfoRequest(ActivityEnum.Activity.SelfSelectCharacter)
end

function slot0.confirmReceiveCharacterCallback(slot0)
	ViewMgr.instance:closeView(ViewName.Activity136ChoiceView)
end

function slot0.openActivity136View(slot0, slot1)
	if Activity136Model.instance:isActivity136InOpen(true) then
		ViewMgr.instance:openView(ViewName.Activity136View, slot1)
	end
end

function slot0.openActivity136ChoiceView(slot0)
	if not Activity136Model.instance:isActivity136InOpen(true) then
		return
	end

	if Activity136Model.instance:hasReceivedCharacter() then
		GameFacade.showToast(ToastEnum.Activity136AlreadyReceive)

		return
	end

	ViewMgr.instance:openView(ViewName.Activity136ChoiceView)
end

function slot0.receiveCharacter(slot0, slot1)
	if not Activity136Model.instance:isActivity136InOpen(true) then
		return
	end

	if not slot1 then
		GameFacade.showToast(ToastEnum.Activity136NotSelect)

		return
	end

	if Activity136Model.instance:hasReceivedCharacter() then
		GameFacade.showToast(ToastEnum.Activity136AlreadyReceive)

		return
	end

	slot6 = MessageBoxIdDefine.Activity136SelectCharacter
	slot7 = HeroConfig.instance:getHeroCO(slot1) and slot5.name or ""
	slot8 = ""
	slot9 = ""

	if HeroModel.instance:getByHeroId(slot1) and slot5 then
		slot10 = {}
		slot6 = (HeroModel.instance:isMaxExSkill(slot1, true) or MessageBoxIdDefine.Activity136SelectCharacterRepeat) and MessageBoxIdDefine.Activity136SelectCharacterRepeat2

		if slot10[1] and slot10[2] then
			slot14, slot15 = ItemModel.instance:getItemConfigAndIcon(slot10[1], slot10[2])
			slot8 = slot14 and slot14.name or ""
		end
	end

	GameFacade.showMessageBox(slot6, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_confirmSelect(uv1)
	end, nil, , slot0, nil, , slot7, slot8, slot9)
end

function slot0._confirmSelect(slot0, slot1)
	if Activity136Model.instance:getCurActivity136Id() then
		Activity136Rpc.instance:sendAct136SelectRequest(slot2, slot1)
	end
end

slot0.instance = slot0.New()

return slot0
