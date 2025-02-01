module("modules.logic.meilanni.view.MeilanniDialogBtnView", package.seeall)

slot0 = class("MeilanniDialogBtnView", BaseView)

function slot0.onInitView(slot0)
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "top_right/btncontain/#go_btntype1")
	slot0._gotalkitem = gohelper.findChild(slot0.viewGO, "top_right/btncontain/#go_btntype1/#btn_templateclick")
	slot0._gobtnpos1 = gohelper.findChild(slot0.viewGO, "top_right/btncontain/#go_btntype1/#go_btnpos1")
	slot0._gobtnpos2 = gohelper.findChild(slot0.viewGO, "top_right/btncontain/#go_btntype1/#go_btnpos2")
	slot0._gobtnpos3 = gohelper.findChild(slot0.viewGO, "top_right/btncontain/#go_btntype1/#go_btnpos3")
	slot0._btnend = gohelper.findChildButtonWithAudio(slot0.viewGO, "top_right/btncontain/#btn_end")
	slot0._txtendinfo = gohelper.findChildText(slot0.viewGO, "top_right/btncontain/#btn_end/layout/txt_info")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnend:AddClickListener(slot0._btnendOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnend:RemoveClickListener()
end

function slot0._btnresetOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._optionBtnList = slot0:getUserDataTb_()
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0._gooptions)
	slot0._endPlayer = SLFramework.AnimatorPlayer.Get(slot0._btnend.gameObject)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.startShowDialogOptionBtn, slot0._startShowDialogOptionBtn, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.refreshDialogBtnState, slot0._refreshDialogBtnState, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.showDialogOptionBtn, slot0._showDialogOptionBtn, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.showDialogEndBtn, slot0._showDialogEndBtn, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.dialogClose, slot0._dialogClose, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, slot0._resetMap, slot0)
end

function slot0._onAnimDone(slot0)
	gohelper.setActive(slot0._gooptions, slot0._showOption)
end

function slot0._refreshDialogBtnState(slot0, slot1)
	slot0._showOption = slot1

	if not slot1 then
		if not slot0._gooptions.activeSelf then
			return
		end

		slot0._animatorPlayer:Play("close", slot0._onAnimDone, slot0)

		return
	end

	gohelper.setActive(slot0._gooptions, slot1)
	slot0._animatorPlayer:Play("open", slot0._onAnimDone, slot0)
end

function slot0._onEndAnimDone(slot0)
	gohelper.setActive(slot0._btnend, slot0._showEndBtn)
end

function slot0._refreshEndBtnState(slot0, slot1)
	slot0._showEndBtn = slot1

	if not slot1 then
		if not slot0._btnend.gameObject.activeSelf then
			return
		end

		slot0._endPlayer:Play("close", slot0._onEndAnimDone, slot0)

		return
	end

	gohelper.setActive(slot0._btnend, slot1)
	slot0._endPlayer:Play("open", slot0._onEndAnimDone, slot0)
end

function slot0._startShowDialogOptionBtn(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		gohelper.setActive(slot5[1], false)
	end
end

function slot0._showDialogOptionBtn(slot0, slot1)
	slot2 = slot1[1]
	slot3 = slot2[1]
	slot5 = slot2[6]
	slot6 = slot2[2]
	slot0._optionCallbackTarget = slot1[2]
	slot0._optionCallback = slot1[3]

	if slot2[5] < 3 then
		slot7 = slot2[3] + 1
	end

	slot8 = slot0._optionBtnList[slot7] and slot0._optionBtnList[slot7][1] or gohelper.clone(slot0._gotalkitem, slot0["_gobtnpos" .. slot7])

	gohelper.setActive(slot8, true)

	gohelper.findChildText(slot8, "layout/txt_info").text = ":" .. slot6

	UISpriteSetMgr.instance:setMeilanniSprite(gohelper.findChildImage(slot8, "layout/txt_info/image_icon"), slot5 or "bg_xuanzhe_1")
	UISpriteSetMgr.instance:setMeilanniSprite(slot8:GetComponent(gohelper.Type_Image), slot3 == -1 and "btn000" or "btn001")
	gohelper.findButtonWithAudio(slot8, AudioEnum.WeekWalk.play_artificial_ui_talkchoose):AddClickListener(slot0._onOptionClick, slot0, slot2)

	if not slot0._optionBtnList[slot7] then
		slot0._optionBtnList[slot7] = {
			slot8,
			slot13
		}
		slot8.name = "talkitem_" .. tostring(slot7)
	end
end

function slot0._onOptionClick(slot0, slot1)
	slot0._optionCallback(slot0._optionCallbackTarget, slot1)
end

function slot0._showDialogEndBtn(slot0, slot1)
	slot0._txtendinfo.text = slot1[1]
	slot0._callbackTarget = slot1[2]
	slot0._callback = slot1[3]

	if not slot1[4] then
		slot0:_refreshEndBtnState(true)

		return
	end

	TaskDispatcher.cancelTask(slot0._delayShowEndBtn, slot0)
	TaskDispatcher.runDelay(slot0._delayShowEndBtn, slot0, slot3)
end

function slot0._delayShowEndBtn(slot0)
	slot0:_refreshEndBtnState(true)
end

function slot0._btnendOnClick(slot0)
	slot0._callback(slot0._callbackTarget)
end

function slot0._dialogClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayShowEndBtn, slot0)
	slot0:_refreshEndBtnState(false)
	slot0:_refreshDialogBtnState(false)
end

function slot0._resetMap(slot0)
	slot0:_dialogClose()
end

function slot0.onClose(slot0)
	slot0:_dialogClose()

	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2]:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
