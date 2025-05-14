module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsMainReadItem", package.seeall)

local var_0_0 = class("SportsNewsMainReadItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageItemBG = gohelper.findChildImage(arg_1_0.viewGO, "#image_ItemBG")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Info/Click")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "txt_TitleEn")
	arg_1_0._scrolldesc = gohelper.findChild(arg_1_0.viewGO, "Scroll View")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Scroll View/Viewport/#txt_Descr")
	arg_1_0._goredpoint = gohelper.findChild(arg_1_0.viewGO, "#go_redpoint")
	arg_1_0._imagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "image_Pic")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnInfo:AddClickListener(arg_2_0._btnInfoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnInfo:RemoveClickListener()
end

function var_0_0._btnInfoOnClick(arg_4_0)
	if arg_4_0.orderMO.status ~= ActivityWarmUpEnum.OrderStatus.Finished then
		local var_4_0 = VersionActivity1_5Enum.ActivityId.SportsNews

		SportsNewsModel.instance:onReadEnd(var_4_0, arg_4_0.orderMO.id)
	end

	ViewMgr.instance:openView(ViewName.SportsNewsReadView, {
		orderMO = arg_4_0.orderMO
	})
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtDescr.overflowMode = TMPro.TextOverflowModes.Ellipsis
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0:removeEvents()
	arg_9_0._imagepic:UnLoadImage()
end

function var_0_0.initData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.viewGO = arg_10_1
	arg_10_0.index = arg_10_2

	arg_10_0:onInitView()
	arg_10_0:addEvents()
end

function var_0_0.onRefresh(arg_11_0, arg_11_1)
	arg_11_0.orderMO = arg_11_1
	arg_11_0._txttitle.text = tostring(arg_11_1.cfg.name)
	arg_11_0._txtTitleEn.text = tostring(arg_11_1.cfg.titledesc)
	arg_11_0._txtDescr.text = arg_11_0.orderMO.cfg.desc

	local var_11_0 = arg_11_1.cfg.bossPic

	arg_11_0._imagepic:LoadImage(ResUrl.getV1a5News(var_11_0))
	RedDotController.instance:addRedDot(arg_11_0._goredpoint, RedDotEnum.DotNode.v1a5NewsOrder, arg_11_1.id)

	arg_11_0._scrolldesc:GetComponent(gohelper.Type_LimitedScrollRect).verticalNormalizedPosition = 1
end

function var_0_0.onFinish(arg_12_0)
	return
end

function var_0_0.StopAnim(arg_13_0)
	return
end

return var_0_0
