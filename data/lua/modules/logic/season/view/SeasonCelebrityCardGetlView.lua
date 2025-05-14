module("modules.logic.season.view.SeasonCelebrityCardGetlView", package.seeall)

local var_0_0 = class("SeasonCelebrityCardGetlView", BaseViewExtended)

var_0_0.OpenType = {
	Get = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._simagebg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg3")
	arg_1_0._simagebg4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg4")
	arg_1_0._simagebg5 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg5")
	arg_1_0._goselfSelect = gohelper.findChild(arg_1_0.viewGO, "#go_selfSelect")
	arg_1_0._gocardget = gohelper.findChild(arg_1_0.viewGO, "#go_cardget")
	arg_1_0._scrollcardget = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_cardget/mask/#scroll_cardget")
	arg_1_0._gocardContent = gohelper.findChild(arg_1_0.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent/#go_carditem")
	arg_1_0._btnclose = gohelper.getClick(arg_1_0.viewGO)
	arg_1_0._contentGrid = arg_1_0._gocardContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	arg_1_0._contentSizeFitter = arg_1_0._gocardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_get)
	arg_5_0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	arg_5_0._simagebg3:LoadImage(ResUrl.getSeasonIcon("bg_zs.png"))
	arg_5_0._simagebg5:LoadImage(ResUrl.getSeasonIcon("bg_zs2.png"))
	arg_5_0._simagebg4:LoadImage(ResUrl.getSeasonIcon("full/img_bg2.png"))
	gohelper.setActive(arg_5_0._goselfSelect, false)
	gohelper.setActive(arg_5_0._gocardget, true)
	arg_5_0:_showGetCard()
	Activity104Rpc.instance:sendGetUnlockActivity104EquipIdsRequest(Activity104Model.instance:getCurSeasonId())
end

function var_0_0._showGetCard(arg_6_0)
	arg_6_0:com_loadAsset("ui/viewres/season/seasoncelebritycarditem.prefab", arg_6_0._onCardItemLoaded)
end

function var_0_0._onCardItemLoaded(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetResource()
	local var_7_1 = gohelper.clone(var_7_0, gohelper.findChild(arg_7_0._gocarditem, "go_itempos"), "root")

	transformhelper.setLocalScale(var_7_1.transform, 0.65, 0.65, 0.65)

	arg_7_0._scroll_view = arg_7_0:com_registSimpleScrollView(arg_7_0._scrollcardget.gameObject, ScrollEnum.ScrollDirV, 4)

	arg_7_0._scroll_view:setClass(SeasonCelebrityCardGetScrollItem)
	arg_7_0._scroll_view:setObjItem(var_7_1)

	local var_7_2 = arg_7_0.viewParam.data

	if #var_7_2 > 4 then
		recthelper.setAnchor(arg_7_0._scrollcardget.transform, 0, -473)

		arg_7_0._contentGrid.enabled = false
		arg_7_0._contentSizeFitter.enabled = false
	else
		recthelper.setAnchor(arg_7_0._scrollcardget.transform, 0, -618)

		arg_7_0._contentGrid.enabled = true
		arg_7_0._contentSizeFitter.enabled = true
	end

	arg_7_0._scroll_view:setData(var_7_2)
end

function var_0_0.isItemID(arg_8_0)
	return arg_8_0.viewParam.is_item_id
end

function var_0_0.onClose(arg_9_0)
	arg_9_0._simagebg1:UnLoadImage()
	arg_9_0._simagebg3:UnLoadImage()
	arg_9_0._simagebg4:UnLoadImage()
	arg_9_0._simagebg5:UnLoadImage()
end

return var_0_0
