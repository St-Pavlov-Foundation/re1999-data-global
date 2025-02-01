module("modules.logic.versionactivity1_6.act147.view.FurnaceTreasureBuyView", package.seeall)

slot0 = class("FurnaceTreasureBuyView", BaseView)

function slot0.onInitView(slot0)
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_spine")
	slot0._txtcontentcn = gohelper.findChildText(slot0.viewGO, "#go_contents/txt_contentcn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._uiSpine = GuiSpine.Create(slot0._gospine, true)
end

function slot0.onOpen(slot0)
	slot0._storeId = slot0.viewParam and slot0.viewParam.storeId
	slot0._goodsId = slot0.viewParam and slot0.viewParam.goodsId

	if #FurnaceTreasureConfig.instance:getDialogList(FurnaceTreasureModel.instance:getActId()) > 0 and slot0._txtcontentcn then
		slot0._txtcontentcn.text = slot2[math.random(1, #slot2)]
	end

	slot4 = FurnaceTreasureConfig.instance:getSpineRes(slot1)

	if not slot0._uiSpine or string.nilorempty(slot4) then
		return
	end

	slot0._uiSpine:setResPath(slot4, slot0._onSpineLoaded, slot0)
end

function slot0._onSpineLoaded(slot0)
	if not slot0._uiSpine then
		return
	end

	slot0._uiSpine:changeLookDir(SpineLookDir.Left)

	slot1 = FurnaceTreasureModel.instance:getGoodsPoolId(slot0._storeId, slot0._goodsId)

	slot0._uiSpine:playVoice(FurnaceTreasureModel.instance:getSpinePlayData(slot1))

	slot4 = AudioEnum.UI.FurnaceTreasureBuyViewNormalSpine

	if slot1 == FurnaceTreasureEnum.ActGoodsPool.Great then
		slot4 = AudioEnum.UI.FurnaceTreasureBuyViewGreatSpine
	end

	AudioMgr.instance:trigger(slot4)
end

function slot0.onClickModalMask(slot0)
	FurnaceTreasureController.instance:BuyFurnaceTreasureGoods(slot0._storeId, slot0._goodsId, slot0.closeThis, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:doClear()
	end

	slot0._uiSpine = false

	AudioMgr.instance:trigger(AudioEnum.UI.FurnaceTreasureBuyViewFinish)
end

return slot0
