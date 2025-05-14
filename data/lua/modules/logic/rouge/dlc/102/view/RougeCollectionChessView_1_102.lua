module("modules.logic.rouge.dlc.102.view.RougeCollectionChessView_1_102", package.seeall)

local var_0_0 = class("RougeCollectionChessView_1_102", BaseViewExtended)

var_0_0.AssetUrl = "ui/viewres/rouge/dlc/102/rougecollectiontrammelview.prefab"
var_0_0.ParentObjPath = "#go_left"

local var_0_1 = "#A08156"
local var_0_2 = "#616161"
local var_0_3 = 1
local var_0_4 = 0.6
local var_0_5 = "#A08156"
local var_0_6 = "#616161"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntrammel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_trammel")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#btn_trammel/#image_icon")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tips/#btn_close")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_tips/go_content")
	arg_1_0._godecitem = gohelper.findChild(arg_1_0.viewGO, "#go_tips/#go_content/#txt_decitem")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#txt_title")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntrammel:AddClickListener(arg_2_0._btntrammelOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.AdjustBackPack, arg_2_0._adjustBackPack, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntrammel:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btntrammelOnClick(arg_4_0)
	arg_4_0._waitShowTips = true

	arg_4_0:_tryGetTrammelInfoAndRefreshUI()
end

function var_0_0._tryGetTrammelInfoAndRefreshUI(arg_5_0)
	local var_5_0 = RougeModel.instance:getSeason()

	RougeRpc.instance:sendRougeItemTrammelsRequest(var_5_0, arg_5_0._sendRougeItemTrammelsRequestCallBack, arg_5_0)
end

function var_0_0._sendRougeItemTrammelsRequestCallBack(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		return
	end

	arg_6_0._activeIds = arg_6_3.ids
	arg_6_0._activeIdMap = {}
	arg_6_0._activeIdCount = arg_6_0._activeIds and #arg_6_0._activeIds or 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_3.ids) do
		arg_6_0._activeIdMap[iter_6_1] = true
	end

	gohelper.setActive(arg_6_0._gotips, arg_6_0._waitShowTips)
	arg_6_0:_refreshUI()
end

function var_0_0._adjustBackPack(arg_7_0)
	arg_7_0:_tryGetTrammelInfoAndRefreshUI()
end

function var_0_0._btncloseOnClick(arg_8_0)
	gohelper.setActive(arg_8_0._gotips, false)

	arg_8_0._waitShowTips = false
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:_tryGetTrammelInfoAndRefreshUI()
end

function var_0_0._refreshUI(arg_10_0)
	local var_10_0 = string.format("rouge_dlc2_icon" .. arg_10_0._activeIdCount)

	UISpriteSetMgr.instance:setRouge4Sprite(arg_10_0._imageicon, var_10_0)

	local var_10_1 = RougeDLCConfig102.instance:getAllCollectionTrammelCo()
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_3 = arg_10_0._activeIdMap and arg_10_0._activeIdMap[iter_10_1.id]
		local var_10_4 = iter_10_1.num
		local var_10_5 = var_10_3 and var_0_5 or var_0_6
		local var_10_6 = string.format("<%s>%s</color>", var_10_5, var_10_4)

		table.insert(var_10_2, var_10_6)
	end

	local var_10_7 = table.concat(var_10_2, "/")

	arg_10_0._txttitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_trammels_title"), var_10_7)

	gohelper.CreateObjList(arg_10_0, arg_10_0.refreshTip, var_10_1, arg_10_0._gocontent, arg_10_0._godecitem)
end

function var_0_0.refreshTip(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1:GetComponent(gohelper.Type_TextMesh)

	var_11_0.text = arg_11_2.desc

	local var_11_1 = arg_11_0._activeIdMap and arg_11_0._activeIdMap[arg_11_2.id]

	SLFramework.UGUI.GuiHelper.SetColor(var_11_0, var_11_1 and var_0_1 or var_0_2)
	ZProj.UGUIHelper.SetColorAlpha(var_11_0, var_11_1 and var_0_3 or var_0_4)
end

return var_0_0
