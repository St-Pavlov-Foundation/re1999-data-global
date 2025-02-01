module("modules.logic.room.view.layout.RoomLayoutCreateTipsView", package.seeall)

slot0 = class("RoomLayoutCreateTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagetipbg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_tipbg")
	slot0._btnselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_select")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "root/#btn_select/txt_desc/#go_select")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#btn_cancel")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#btn_sure")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnselect:AddClickListener(slot0._btnselectOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnselect:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnsure:RemoveClickListener()
end

function slot0._btnselectOnClick(slot0)
	slot0:_setSelect(slot0._isSelect == false)
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
	slot0:_closeInvokeCallback()
end

function slot0._btnsureOnClick(slot0)
	slot0:closeThis()
	slot0:_closeInvokeCallback(true)
end

function slot0._editableInitView(slot0)
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/txt_desc")

	slot0:_setSelect(true)
	slot0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))

	slot0._txtdescTrs = slot0._txtdesc.transform
	slot0._descX, slot0._descY = transformhelper.getLocalPos(slot0._txtdescTrs)
	slot1, slot0._hidY = transformhelper.getLocalPos(slot0._simagetipbg.transform)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshInitUI()
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._onEscape, slot0)
	end

	slot0:_refreshInitUI()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
end

function slot0._onEscape(slot0)
	slot0:_btncancelOnClick()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagetipbg:UnLoadImage()
end

function slot0._refreshInitUI(slot0)
	if slot0.viewParam then
		if slot0.viewParam.isSelect ~= nil then
			slot0:_setSelect(slot0.viewParam.isSelect)
		end

		slot0._txtdesc.text = slot0.viewParam.titleStr or luaLang("p_roomlayoutcreatetipsview_tips1")

		if slot0.viewParam.isShowSetlect ~= nil then
			slot0:_setShowSelect(slot0.viewParam.isShowSetlect)
		end
	end
end

function slot0._closeInvokeCallback(slot0, slot1)
	if slot1 then
		if slot0.viewParam.yesCallback then
			if slot0.viewParam.callbockObj then
				slot0.viewParam.yesCallback(slot0.viewParam.callbockObj, slot0._isSelect and true or false)
			else
				slot0.viewParam.yesCallback(slot2)
			end
		end
	elseif slot0.viewParam.noCallback then
		slot0.viewParam.noCallback(slot0.viewParam.noCallbackObj)
	end
end

function slot0._setSelect(slot0, slot1)
	slot0._isSelect = slot1 and true or false

	gohelper.setActive(slot0._goselect, slot0._isSelect)
end

function slot0._setShowSelect(slot0, slot1)
	gohelper.setActive(slot0._btnselect, slot1)
	transformhelper.setLocalPosXY(slot0._txtdescTrs, slot0._descX, slot1 and slot0._descY or slot0._hidY)
end

return slot0
