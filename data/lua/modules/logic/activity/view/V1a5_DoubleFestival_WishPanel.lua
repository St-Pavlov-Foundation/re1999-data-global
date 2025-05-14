module("modules.logic.activity.view.V1a5_DoubleFestival_WishPanel", package.seeall)

local var_0_0 = class("V1a5_DoubleFestival_WishPanel", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#txt_TitleEn")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "scroll/viewport/content/#txt_Descr")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "scroll/viewport/content/#txt_Descr/#image_Icon")
	arg_1_0._txtDec = gohelper.findChildText(arg_1_0.viewGO, "#txt_Dec")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = ActivityEnum.Activity.DoubleFestivalSign_1_5
local var_0_2
local var_0_3 = 294

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._txtDescrTran = arg_4_0._txtDescr.transform
	arg_4_0._scroll = gohelper.findChildComponent(arg_4_0.viewGO, "scroll", gohelper.Type_ScrollRect)
	arg_4_0._imageIconTran = arg_4_0._imageIcon.transform
	arg_4_0._scrollContentTran = arg_4_0._scroll.content

	arg_4_0._simagePanelBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_news_bigitembg"))

	var_0_2 = var_0_2 or recthelper.getHeight(arg_4_0._imageIconTran)
	arg_4_0._txtDescr.text = ""
	arg_4_0._txtTitle.text = ""
	arg_4_0._txtTitleEn.text = ""
	arg_4_0._txtDec.text = ""
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam.day

	arg_5_0:_refresh(var_5_0)

	local var_5_1 = arg_5_0._txtDescrTran.sizeDelta.y
	local var_5_2 = var_5_1 + var_0_2

	if var_5_1 <= var_0_3 then
		var_5_2 = 630
	end

	recthelper.setHeight(arg_5_0._scrollContentTran, var_5_2)
end

function var_0_0._refresh(arg_6_0, arg_6_1)
	local var_6_0 = ActivityType101Config.instance:getDoubleFestivalCOByDay(var_0_1, arg_6_1)

	GameUtil.setActive01(arg_6_0._imageIconTran, var_6_0 ~= nil)

	if not var_6_0 then
		return
	end

	UISpriteSetMgr.instance:setV1a5DfSignSprite(arg_6_0._imageIcon, var_6_0.blessSpriteName)

	arg_6_0._txtTitle.text = var_6_0.blessTitle
	arg_6_0._txtTitleEn.text = var_6_0.blessTitleEn
	arg_6_0._txtDescr.text = var_6_0.blessContent
	arg_6_0._txtDec.text = var_6_0.blessDesc
	arg_6_0._txtDescrTran.sizeDelta = Vector2(arg_6_0._txtDescrTran.sizeDelta.x, math.max(var_0_3, arg_6_0._txtDescr.preferredHeight))
end

function var_0_0.onClickModalMask(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onClose(arg_8_0)
	local var_8_0 = arg_8_0.viewParam

	if var_8_0.popupViewBlockKey then
		PopupController.instance:setPause(var_8_0.popupViewBlockKey, false)

		var_8_0.popupViewBlockKey = nil
	end
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
