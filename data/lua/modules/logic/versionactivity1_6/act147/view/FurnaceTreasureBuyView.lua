module("modules.logic.versionactivity1_6.act147.view.FurnaceTreasureBuyView", package.seeall)

local var_0_0 = class("FurnaceTreasureBuyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_spine")
	arg_1_0._txtcontentcn = gohelper.findChildText(arg_1_0.viewGO, "#go_contents/txt_contentcn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._uiSpine = GuiSpine.Create(arg_2_0._gospine, true)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0._storeId = arg_3_0.viewParam and arg_3_0.viewParam.storeId
	arg_3_0._goodsId = arg_3_0.viewParam and arg_3_0.viewParam.goodsId

	local var_3_0 = FurnaceTreasureModel.instance:getActId()
	local var_3_1 = FurnaceTreasureConfig.instance:getDialogList(var_3_0)

	if #var_3_1 > 0 and arg_3_0._txtcontentcn then
		local var_3_2 = math.random(1, #var_3_1)

		arg_3_0._txtcontentcn.text = var_3_1[var_3_2]
	end

	local var_3_3 = FurnaceTreasureConfig.instance:getSpineRes(var_3_0)

	if not arg_3_0._uiSpine or string.nilorempty(var_3_3) then
		return
	end

	arg_3_0._uiSpine:setResPath(var_3_3, arg_3_0._onSpineLoaded, arg_3_0)
end

function var_0_0._onSpineLoaded(arg_4_0)
	if not arg_4_0._uiSpine then
		return
	end

	arg_4_0._uiSpine:changeLookDir(SpineLookDir.Left)

	local var_4_0 = FurnaceTreasureModel.instance:getGoodsPoolId(arg_4_0._storeId, arg_4_0._goodsId)
	local var_4_1 = FurnaceTreasureModel.instance:getSpinePlayData(var_4_0)

	arg_4_0._uiSpine:playVoice(var_4_1)

	local var_4_2 = var_4_0 == FurnaceTreasureEnum.ActGoodsPool.Great
	local var_4_3 = AudioEnum.UI.FurnaceTreasureBuyViewNormalSpine

	if var_4_2 then
		var_4_3 = AudioEnum.UI.FurnaceTreasureBuyViewGreatSpine
	end

	AudioMgr.instance:trigger(var_4_3)
end

function var_0_0.onClickModalMask(arg_5_0)
	FurnaceTreasureController.instance:BuyFurnaceTreasureGoods(arg_5_0._storeId, arg_5_0._goodsId, arg_5_0.closeThis, arg_5_0)
end

function var_0_0.onDestroyView(arg_6_0)
	if arg_6_0._uiSpine then
		arg_6_0._uiSpine:doClear()
	end

	arg_6_0._uiSpine = false

	AudioMgr.instance:trigger(AudioEnum.UI.FurnaceTreasureBuyViewFinish)
end

return var_0_0
