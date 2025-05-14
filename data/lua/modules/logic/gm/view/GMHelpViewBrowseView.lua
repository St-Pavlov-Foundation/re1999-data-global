module("modules.logic.gm.view.GMHelpViewBrowseView", package.seeall)

local var_0_0 = class("GMHelpViewBrowseView", BaseView)
local var_0_1 = {
	hide = 3,
	tweening = 2,
	show = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._rect = gohelper.findChild(arg_1_0.viewGO, "view").transform
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btnClose")
	arg_1_0._btnShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btnShow")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btnHide")
	arg_1_0._inputSearch = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "view/title/InputField")
	arg_1_0._tabBtnList = arg_1_0:getUserDataTb_()

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "view/tab").transform
	local var_1_1 = var_1_0.childCount

	for iter_1_0 = 1, var_1_1 do
		local var_1_2 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_3 = gohelper.findButtonWithAudio(var_1_2.gameObject)

		table.insert(arg_1_0._tabBtnList, var_1_3)
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnShow:AddClickListener(arg_2_0._onClickShow, arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._onClickHide, arg_2_0)
	arg_2_0._inputSearch:AddOnValueChanged(arg_2_0._onSearchValueChanged, arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._tabBtnList) do
		iter_2_1:AddClickListener(arg_2_0._onClickTab, arg_2_0, iter_2_0)
	end
end

function var_0_0._onClickShow(arg_3_0)
	if arg_3_0._state == var_0_1.hide then
		arg_3_0._state = var_0_1.tweening
		arg_3_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_3_0._rect, 0, 0.2, arg_3_0._onShow, arg_3_0)
	end
end

function var_0_0._onShow(arg_4_0)
	arg_4_0._tweenId = nil
	arg_4_0._state = var_0_1.show

	arg_4_0:_updateBtns()
end

function var_0_0._onClickHide(arg_5_0)
	if arg_5_0._state == var_0_1.show then
		arg_5_0._state = var_0_1.tweening
		arg_5_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_5_0._rect, -800, 0.2, arg_5_0._onHide, arg_5_0)
	end
end

function var_0_0._onHide(arg_6_0)
	arg_6_0._tweenId = nil
	arg_6_0._state = var_0_1.hide

	arg_6_0:_updateBtns()
end

function var_0_0._updateBtns(arg_7_0)
	gohelper.setActive(arg_7_0._btnShow.gameObject, arg_7_0._state == var_0_1.hide)
	gohelper.setActive(arg_7_0._btnHide.gameObject, arg_7_0._state == var_0_1.show)
end

function var_0_0._onSearchValueChanged(arg_8_0, arg_8_1)
	GMHelpViewBrowseModel.instance:setSearch(arg_8_1)
end

function var_0_0._onClickTab(arg_9_0, arg_9_1)
	GMHelpViewBrowseModel.instance:setListByTabMode(arg_9_1)
end

function var_0_0.removeEvents(arg_10_0)
	arg_10_0._btnClose:RemoveClickListener()
	arg_10_0._btnShow:RemoveClickListener()
	arg_10_0._btnHide:RemoveClickListener()
	arg_10_0._inputSearch:RemoveOnValueChanged()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._tabBtnList) do
		iter_10_1:RemoveClickListener()
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._state = var_0_1.show

	arg_12_0:_updateBtns()
	arg_12_0:_onClickTab(GMHelpViewBrowseModel.tabModeEnum.helpView)
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0._tweenId then
		ZProj.TweenHelper.KillById(arg_13_0._tweenId)

		arg_13_0._tweenId = nil
	end
end

return var_0_0
