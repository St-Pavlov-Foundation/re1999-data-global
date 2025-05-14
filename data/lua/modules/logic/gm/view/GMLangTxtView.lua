module("modules.logic.gm.view.GMLangTxtView", package.seeall)

local var_0_0 = class("GMLangTxtView", BaseView)
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btnClose")
	arg_1_0._btnShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btnShow")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btnHide")
	arg_1_0._btnDelete = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/title/btnDelete")
	arg_1_0._rect = gohelper.findChild(arg_1_0.viewGO, "view").transform
	arg_1_0._inputSearch = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "view/title/InputField")
	arg_1_0._dropLangChange = gohelper.findChildDropdown(arg_1_0.viewGO, "view/title/dropdown_lang")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "view/right/scroll/Viewport/content/item")

	arg_1_0._goLangItemList = {}

	local var_1_1 = GameConfig:GetSupportedLangs()
	local var_1_2 = var_1_1.Length

	arg_1_0.supportLangs = {}

	for iter_1_0 = 0, var_1_2 - 1 do
		table.insert(arg_1_0.supportLangs, LangSettings.shortcutTab[var_1_1[iter_1_0]])

		local var_1_3 = GMLangTxtLangItem.New()

		var_1_3:init(gohelper.cloneInPlace(var_1_0, "item"), LangSettings.shortcutTab[var_1_1[iter_1_0]])
		table.insert(arg_1_0._goLangItemList, var_1_3)
	end

	arg_1_0._dropLangChange:ClearOptions()
	arg_1_0._dropLangChange:AddOptions(arg_1_0.supportLangs)

	local var_1_4 = LangSettings.instance:getCurLangShortcut()

	for iter_1_1 = 1, #arg_1_0.supportLangs do
		if arg_1_0.supportLangs[iter_1_1] == var_1_4 then
			arg_1_0._dropLangChange:SetValue(iter_1_1 - 1)

			break
		end
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnShow:AddClickListener(arg_2_0._onClickShow, arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._onClickHide, arg_2_0)
	arg_2_0._btnDelete:AddClickListener(arg_2_0._onClickDelete, arg_2_0)
	arg_2_0._inputSearch:AddOnValueChanged(arg_2_0._onSearchValueChanged, arg_2_0)
	arg_2_0._inputSearch:AddOnEndEdit(arg_2_0._onSearchEndEdit, arg_2_0)
	arg_2_0._dropLangChange:AddOnValueChanged(arg_2_0._onLangChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnShow:RemoveClickListener()
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0._btnDelete:RemoveClickListener()

	if arg_3_0._inputSearch then
		arg_3_0._inputSearch:RemoveOnValueChanged()
		arg_3_0._inputSearch:RemoveOnEndEdit()
	end

	arg_3_0._dropLangChange:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._state = var_0_1

	arg_4_0:_updateBtns()
end

function var_0_0.onClose(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._goLangItemList) do
		iter_5_1:onClose()
	end

	if arg_5_0._tweenId then
		ZProj.TweenHelper.KillById(arg_5_0._tweenId)

		arg_5_0._tweenId = nil
	end
end

function var_0_0._onClickShow(arg_6_0)
	if arg_6_0._state == var_0_2 then
		arg_6_0._state = var_0_3
		arg_6_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_6_0._rect, 0, 0.2, arg_6_0._onShow, arg_6_0)
	end
end

function var_0_0._onShow(arg_7_0)
	arg_7_0._tweenId = nil
	arg_7_0._state = var_0_1

	arg_7_0:_updateBtns()
end

function var_0_0._onClickHide(arg_8_0)
	if arg_8_0._state == var_0_1 then
		arg_8_0._state = var_0_3
		arg_8_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_8_0._rect, -1740, 0.2, arg_8_0._onHide, arg_8_0)
	end
end

function var_0_0._onClickDelete(arg_9_0)
	GMLangController.instance:clearInUse()
end

function var_0_0._onSearchValueChanged(arg_10_0, arg_10_1)
	GMLangTxtModel.instance:setSearch(arg_10_1)
end

function GMLangTxtModel._onSearchEndEdit(arg_11_0, arg_11_1)
	return
end

function var_0_0._onHide(arg_12_0)
	arg_12_0._tweenId = nil
	arg_12_0._state = var_0_2

	arg_12_0:_updateBtns()
end

function var_0_0._updateBtns(arg_13_0)
	gohelper.setActive(arg_13_0._btnShow.gameObject, arg_13_0._state == var_0_2)
	gohelper.setActive(arg_13_0._btnHide.gameObject, arg_13_0._state == var_0_1)
end

function var_0_0._onLangChange(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.supportLangs[arg_14_1 + 1]
	local var_14_1 = ViewMgr.instance:getUIRoot()
	local var_14_2 = GMLangController.instance:getInUseDic()
	local var_14_3 = var_14_1:GetComponentsInChildren(gohelper.Type_TextMesh, true)

	for iter_14_0 = 0, var_14_3.Length - 1 do
		local var_14_4 = var_14_3[iter_14_0]
		local var_14_5 = var_14_2[var_14_4.text]

		if var_14_5 then
			var_14_4.text = var_14_5[var_14_0]
		end
	end

	GMLangController.instance:changeLang(var_14_0)

	local var_14_6 = {}
	local var_14_7 = var_14_1:GetComponentsInChildren(typeof(SLFramework.UGUI.SingleImage), true)

	for iter_14_1 = 0, var_14_7.Length - 1 do
		local var_14_8 = var_14_7[iter_14_1]

		var_14_6[var_14_8] = var_14_8.curImageUrl

		var_14_8:UnLoadImage()
	end

	SLFramework.UnityHelper.ResGC()

	for iter_14_2, iter_14_3 in pairs(var_14_6) do
		if not string.nilorempty(iter_14_3) then
			iter_14_2:LoadImage(iter_14_3)
		end
	end
end

function var_0_0.onLangTxtClick(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._goLangItemList) do
		iter_15_1:updateStr(arg_15_1)
	end
end

return var_0_0
