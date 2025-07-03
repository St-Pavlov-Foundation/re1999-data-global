module("modules.logic.versionactivity2_7.act191.view.Act191CollectionTipView", package.seeall)

local var_0_0 = class("Act191CollectionTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._goRoot = gohelper.findChild(arg_1_0.viewGO, "#go_Root")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Root/#simage_Icon")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/#txt_Name")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/scroll_desc/Viewport/go_desccontent/#txt_Desc")
	arg_1_0._btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Root/#btn_Buy")
	arg_1_0._txtBuyCost = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/#btn_Buy/#txt_BuyCost")
	arg_1_0._goTag1 = gohelper.findChild(arg_1_0.viewGO, "#go_Root/tag/#go_Tag1")
	arg_1_0._txtTag1 = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/tag/#go_Tag1/#txt_Tag1")
	arg_1_0._goTag2 = gohelper.findChild(arg_1_0.viewGO, "#go_Root/tag/#go_Tag2")
	arg_1_0._txtTag2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/tag/#go_Tag2/#txt_Tag2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0._btnBuyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnBuy:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnBuyOnClick(arg_5_0)
	if Activity191Model.instance:getActInfo():getGameInfo().coin < arg_5_0.viewParam.cost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	Activity191Rpc.instance:sendBuyIn191ShopRequest(arg_5_0.actId, arg_5_0.viewParam.index, arg_5_0._buyReply, arg_5_0)
end

function var_0_0._buyReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == 0 then
		GameFacade.showToast(ToastEnum.Act191BuyTip)
		arg_6_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.actId = Activity191Model.instance:getCurActId()

	SkillHelper.addHyperLinkClick(arg_7_0._txtDesc)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.onOpen(arg_9_0)
	Act191StatController.instance:onViewOpen(arg_9_0.viewName)

	if arg_9_0.viewParam.pos then
		local var_9_0 = recthelper.rectToRelativeAnchorPos(arg_9_0.viewParam.pos, arg_9_0.viewGO.transform)

		recthelper.setAnchor(arg_9_0._goRoot.transform, var_9_0.x + 85, 8)
	end

	arg_9_0:refreshUI()
end

function var_0_0.onClose(arg_10_0)
	local var_10_0 = arg_10_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_10_0.viewName, var_10_0, arg_10_0.config.title)
end

function var_0_0.refreshUI(arg_11_0)
	gohelper.setActive(arg_11_0._btnClose, not arg_11_0.viewParam.notShowBg)

	if arg_11_0.viewParam.showBuy then
		arg_11_0:refreshCost()
		gohelper.setActive(arg_11_0._btnBuy, true)
	else
		gohelper.setActive(arg_11_0._btnBuy, false)
	end

	arg_11_0.config = Activity191Config.instance:getCollectionCo(arg_11_0.viewParam.itemId)

	if arg_11_0.config then
		arg_11_0._simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(arg_11_0.config.icon))

		local var_11_0 = Activity191Enum.CollectionColor[arg_11_0.config.rare]

		arg_11_0._txtName.text = string.format("<#%s>%s</color>", var_11_0, arg_11_0.config.title)

		if arg_11_0.viewParam.enhance then
			arg_11_0._txtDesc.text = SkillHelper.buildDesc(arg_11_0.config.replaceDesc)
		else
			arg_11_0._txtDesc.text = SkillHelper.buildDesc(arg_11_0.config.desc)
		end

		if string.nilorempty(arg_11_0.config.label) then
			gohelper.setActive(arg_11_0._goTag1, false)
			gohelper.setActive(arg_11_0._goTag2, false)
		else
			local var_11_1 = string.split(arg_11_0.config.label, "#")

			for iter_11_0 = 1, 2 do
				local var_11_2 = var_11_1[iter_11_0]

				arg_11_0["_txtTag" .. iter_11_0].text = var_11_2

				gohelper.setActive(arg_11_0["_goTag" .. iter_11_0], var_11_2)
			end
		end
	end
end

function var_0_0.refreshCost(arg_12_0)
	local var_12_0 = arg_12_0.viewParam.cost

	if var_12_0 > Activity191Model.instance:getActInfo():getGameInfo().coin then
		SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._txtBuyCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._txtBuyCost, "#211f1f")
	end

	arg_12_0._txtBuyCost.text = var_12_0
end

return var_0_0
