module("modules.logic.summon.view.SummonView", package.seeall)

slot0 = class("SummonView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")
	slot0._imageskiptxt = gohelper.findChildImage(slot0.viewGO, "#btn_skip/#image_skiptxt")
	slot0._imageskip = gohelper.findChildImage(slot0.viewGO, "#btn_skip/#image_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskip:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
	slot1 = UnityEngine.Input.mousePosition

	if GamepadController.instance.getMousePosition then
		slot1 = GamepadController.instance:getMousePosition()
	end

	SummonController.instance:trackSummonClientEvent(true, {
		st = recthelper.screenPosToAnchorPos(slot1, slot0.viewGO.transform)
	})
	SummonController.instance:dispatchEvent(SummonEvent.onSummonSkip)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._btnskip.gameObject, false)
end

function slot0._initSummonView(slot0)
end

function slot0.onUpdateParam(slot0)
	logNormal("SummonView onUpdateParam")
end

function slot0.onOpen(slot0)
	logNormal("SummonView onOpen")
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, slot0._handleSelectTab, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.startDraw, slot0)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
	SummonMainModel.instance:updateLastPoolId()
	slot0:_handleSelectTab()
end

function slot0.startDraw(slot0)
	gohelper.setActive(slot0._btnskip.gameObject, not SummonController.instance:isInSummonGuide() and not SummonModel.instance:getSendEquipFreeSummon())
end

function slot0._handleSelectTab(slot0)
	slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 1, SummonMainModel.getResultTypeById(SummonController.instance:getLastPoolId()))
end

function slot0.onDestroyView(slot0)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Close)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main and not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

return slot0
