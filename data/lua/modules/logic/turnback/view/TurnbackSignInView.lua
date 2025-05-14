module("modules.logic.turnback.view.TurnbackSignInView", package.seeall)

local var_0_0 = class("TurnbackSignInView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "tips/#txt_desc")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "tips/#txt_time")
	arg_1_0._scrolldaylist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_daylist")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_daylist/Viewport/#go_content")
	arg_1_0._rectMask2d = gohelper.findChild(arg_1_0.viewGO, "#scroll_daylist/Viewport"):GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_1_0._mask = gohelper.findChild(arg_1_0.viewGO, "#scroll_daylist/Viewport"):GetComponent(typeof(UnityEngine.UI.Mask))
	arg_1_0._maskImage = gohelper.findChild(arg_1_0.viewGO, "#scroll_daylist/Viewport"):GetComponent(gohelper.Type_Image)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshSignInScroll, arg_2_0._refreshScrollPos, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_2_0._refreshRemainTime, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0._refreshUI, arg_2_0)
	arg_2_0._scrolldaylist:AddOnValueChanged(arg_2_0._onScrollValueChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshSignInScroll, arg_3_0._refreshScrollPos, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_3_0._refreshRemainTime, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_3_0._refreshUI, arg_3_0)
	arg_3_0._scrolldaylist:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_signfullbg"))
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam.parent

	arg_5_0.viewConfig = TurnbackConfig.instance:getTurnbackSubModuleCo(arg_5_0.viewParam.actId)

	gohelper.addChild(var_5_0, arg_5_0.viewGO)
	arg_5_0:_refreshUI()
	TurnbackSignInModel.instance:setOpenTimeStamp()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0._txtdesc.text = arg_6_0.viewConfig.actDesc

	arg_6_0:_refreshRemainTime()
	arg_6_0:_refreshScrollPos()
	arg_6_0:_refreshMaskShowState()
end

function var_0_0._refreshRemainTime(arg_7_0)
	arg_7_0._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function var_0_0._refreshScrollPos(arg_8_0)
	local var_8_0 = TurnbackSignInModel.instance:getTheFirstCanGetIndex()
	local var_8_1 = TurnbackModel.instance:getCurSignInDay()
	local var_8_2 = GameUtil.getTabLen(TurnbackSignInModel.instance:getSignInInfoMoList())
	local var_8_3 = arg_8_0.viewContainer._scrollView:getCsListScroll()
	local var_8_4 = arg_8_0.viewContainer._scrollParam
	local var_8_5 = var_8_4.cellWidth
	local var_8_6 = var_8_4.cellSpaceH
	local var_8_7 = 0
	local var_8_8 = var_8_2 - 7
	local var_8_9 = var_8_5 + var_8_6

	if var_8_0 ~= 0 then
		var_8_7 = var_8_8 < var_8_0 - 1 and var_8_9 * (var_8_8 + 1) or var_8_9 * math.max(0, var_8_0 - 2)
	else
		var_8_7 = var_8_8 < var_8_1 and var_8_9 * (var_8_8 + 1) or var_8_9 * (var_8_1 - 1)
	end

	var_8_3.HorizontalScrollPixel = math.max(0, var_8_7)

	var_8_3:UpdateCells(true)
end

function var_0_0._onScrollValueChange(arg_9_0)
	arg_9_0._rectMask2d.enabled = arg_9_0._scrolldaylist.horizontalNormalizedPosition < 0.95
end

function var_0_0._refreshMaskShowState(arg_10_0)
	local var_10_0 = recthelper.getWidth(arg_10_0._scrolldaylist.gameObject.transform) < recthelper.getWidth(arg_10_0._gocontent.transform)

	arg_10_0._rectMask2d.enabled = var_10_0
	arg_10_0._mask.enabled = var_10_0
	arg_10_0._maskImage.enabled = var_10_0
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
