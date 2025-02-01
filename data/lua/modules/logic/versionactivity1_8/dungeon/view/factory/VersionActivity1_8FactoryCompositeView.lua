module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryCompositeView", package.seeall)

slot0 = class("VersionActivity1_8FactoryCompositeView", BaseView)
slot1 = 1

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._translayout1 = gohelper.findChild(slot0.viewGO, "left/layout").gameObject
	slot0._txtitemname1 = gohelper.findChildText(slot0.viewGO, "left/layout/#txt_leftproductname")
	slot0._txtitemnum1 = gohelper.findChildText(slot0.viewGO, "left/layout/#txt_leftproductnum")
	slot0._simageitemicon1 = gohelper.findChildSingleImage(slot0.viewGO, "left/leftproduct_icon")
	slot0._translayout2 = gohelper.findChild(slot0.viewGO, "right/layout").gameObject
	slot0._txtitemname2 = gohelper.findChildText(slot0.viewGO, "right/layout/#txt_rightproductname")
	slot0._txtitemnum2 = gohelper.findChildText(slot0.viewGO, "right/layout/#txt_rightproductnum")
	slot0._simageitemicon2 = gohelper.findChildSingleImage(slot0.viewGO, "right/rightproduct_icon")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_composite/valuebg/#input_value")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_composite/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_composite/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_composite/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_composite/#btn_max")
	slot0._btncomposite = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_composite/#btn_composite")
	slot0._simagecosticon1 = gohelper.findChildImage(slot0.viewGO, "#go_composite/cost/#simage_costicon")
	slot0._txtoriginalCost = gohelper.findChildText(slot0.viewGO, "#go_composite/cost/#txt_originalCost")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseClick, slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0._btncomposite:AddClickListener(slot0._btncompositeOnClick, slot0)
	slot0._inputvalue:AddOnValueChanged(slot0.onCompositeCountValueChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0._btncomposite:RemoveClickListener()
	slot0._inputvalue:RemoveOnValueChanged()
end

function slot0._btncloseClick(slot0)
	slot0:closeThis()
end

function slot0._btnminOnClick(slot0)
	slot0:changeCompositeCount(uv0)
end

function slot0._btnsubOnClick(slot0)
	slot0:changeCompositeCount(slot0.compositeCount - 1)
end

function slot0._btnaddOnClick(slot0)
	slot0:changeCompositeCount(slot0.compositeCount + 1)
end

function slot0._btnmaxOnClick(slot0)
	slot0:changeCompositeCount(slot0:getMaxCompositeCount())
end

function slot0._btncompositeOnClick(slot0)
	Activity157Controller.instance:factoryComposite(slot0.compositeCount, slot0.compositeCount * slot0.costPerComposite, slot0.closeThis, slot0)
end

function slot0.onCompositeCountValueChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0:changeCompositeCount(slot2, true)
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity157Model.instance:getActId()

	for slot6, slot7 in ipairs(Activity157Config.instance:getAct157CompositeFormula(slot0.actId)) do
		if true then
			slot0.costItemType = slot7.materilType
			slot0.costItemId = slot7.materilId
			slot0.costPerComposite = slot7.quantity or 0
			slot2 = false
		else
			slot0.targetPerComposite = slot7.quantity or 0
		end

		slot8, slot9 = ItemModel.instance:getItemConfigAndIcon(slot7.materilType, slot7.materilId)

		if slot0["_txtitemname" .. slot6] then
			slot0[slot10].text = slot8.name
		end

		if slot0["_simageitemicon" .. slot6] then
			slot0[slot11]:LoadImage(slot9)
		end

		if slot0["_simagecosticon" .. slot6] then
			UISpriteSetMgr.instance:setCurrencyItemSprite(slot0[slot12], slot8.icon .. "_1")
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = uv0

	if Activity157Model.instance:getLastWillBeRepairedComponent() then
		slot3, slot4, slot5 = Activity157Config.instance:getComponentUnlockCondition(slot0.actId, slot2)

		if slot5 - ItemModel.instance:getItemQuantity(slot3, slot4) > 0 then
			slot1 = slot0:getMaxCompositeCount() < slot7 and slot8 or slot7
		end
	end

	slot0:changeCompositeCount(slot1)
end

function slot0.getMaxCompositeCount(slot0)
	slot1 = uv0

	if ItemModel.instance:getItemQuantity(slot0.costItemType, slot0.costItemId) then
		slot1 = math.floor(slot2 / slot0.costPerComposite)
	end

	return slot1
end

function slot0.changeCompositeCount(slot0, slot1, slot2)
	if slot0:getMaxCompositeCount() < slot1 then
		slot1 = slot3
	end

	if slot1 < uv0 then
		slot1 = uv0
	end

	slot0.compositeCount = slot1

	if slot2 then
		slot0._inputvalue:SetTextWithoutNotify(tostring(slot1))
	else
		slot0._inputvalue:SetText(slot1)
	end

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot1 = slot0.compositeCount * slot0.costPerComposite
	slot0._txtitemnum1.text = luaLang("multiple") .. slot1
	slot0._txtitemnum2.text = luaLang("multiple") .. slot0.compositeCount * slot0.targetPerComposite

	ZProj.UGUIHelper.RebuildLayout(slot0._translayout1.transform)
	ZProj.UGUIHelper.RebuildLayout(slot0._translayout2.transform)
	slot0:showOriginalCostTxt(slot1, ItemModel.instance:getItemQuantity(slot0.costItemType, slot0.costItemId))
end

function slot0.showOriginalCostTxt(slot0, slot1, slot2)
	slot0._txtoriginalCost.text = string.format("<color=#E07E25>%s</color>/%s", slot1, slot2)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageitemicon1:UnLoadImage()
	slot0._simageitemicon2:UnLoadImage()
end

return slot0
