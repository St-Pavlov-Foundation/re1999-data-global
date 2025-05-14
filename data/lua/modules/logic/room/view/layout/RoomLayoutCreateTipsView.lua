module("modules.logic.room.view.layout.RoomLayoutCreateTipsView", package.seeall)

local var_0_0 = class("RoomLayoutCreateTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetipbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_tipbg")
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_select")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/#btn_select/txt_desc/#go_select")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_cancel")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_sure")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnselect:AddClickListener(arg_2_0._btnselectOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnselect:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnsure:RemoveClickListener()
end

function var_0_0._btnselectOnClick(arg_4_0)
	arg_4_0:_setSelect(arg_4_0._isSelect == false)
end

function var_0_0._btncancelOnClick(arg_5_0)
	arg_5_0:closeThis()
	arg_5_0:_closeInvokeCallback()
end

function var_0_0._btnsureOnClick(arg_6_0)
	arg_6_0:closeThis()
	arg_6_0:_closeInvokeCallback(true)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._txtdesc = gohelper.findChildText(arg_7_0.viewGO, "root/txt_desc")

	arg_7_0:_setSelect(true)
	arg_7_0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))

	arg_7_0._txtdescTrs = arg_7_0._txtdesc.transform
	arg_7_0._descX, arg_7_0._descY = transformhelper.getLocalPos(arg_7_0._txtdescTrs)

	local var_7_0, var_7_1 = transformhelper.getLocalPos(arg_7_0._simagetipbg.transform)

	arg_7_0._hidY = var_7_1
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:_refreshInitUI()
end

function var_0_0.onOpen(arg_9_0)
	if arg_9_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_9_0.viewContainer.viewName, arg_9_0._onEscape, arg_9_0)
	end

	arg_9_0:_refreshInitUI()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
end

function var_0_0._onEscape(arg_10_0)
	arg_10_0:_btncancelOnClick()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagetipbg:UnLoadImage()
end

function var_0_0._refreshInitUI(arg_13_0)
	if arg_13_0.viewParam then
		if arg_13_0.viewParam.isSelect ~= nil then
			arg_13_0:_setSelect(arg_13_0.viewParam.isSelect)
		end

		arg_13_0._txtdesc.text = arg_13_0.viewParam.titleStr or luaLang("p_roomlayoutcreatetipsview_tips1")

		if arg_13_0.viewParam.isShowSetlect ~= nil then
			arg_13_0:_setShowSelect(arg_13_0.viewParam.isShowSetlect)
		end
	end
end

function var_0_0._closeInvokeCallback(arg_14_0, arg_14_1)
	if arg_14_1 then
		if arg_14_0.viewParam.yesCallback then
			local var_14_0 = arg_14_0._isSelect and true or false

			if arg_14_0.viewParam.callbockObj then
				arg_14_0.viewParam.yesCallback(arg_14_0.viewParam.callbockObj, var_14_0)
			else
				arg_14_0.viewParam.yesCallback(var_14_0)
			end
		end
	elseif arg_14_0.viewParam.noCallback then
		arg_14_0.viewParam.noCallback(arg_14_0.viewParam.noCallbackObj)
	end
end

function var_0_0._setSelect(arg_15_0, arg_15_1)
	arg_15_0._isSelect = arg_15_1 and true or false

	gohelper.setActive(arg_15_0._goselect, arg_15_0._isSelect)
end

function var_0_0._setShowSelect(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._btnselect, arg_16_1)
	transformhelper.setLocalPosXY(arg_16_0._txtdescTrs, arg_16_0._descX, arg_16_1 and arg_16_0._descY or arg_16_0._hidY)
end

return var_0_0
