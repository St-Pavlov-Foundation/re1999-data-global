module("modules.logic.gm.view.GMFastAddHeroHadHeroItem", package.seeall)

slot0 = class("GMFastAddHeroHadHeroItem", ListScrollCell)
slot0.SelectBgColor = GameUtil.parseColor("#EA4F4F")
slot0.NotSelectBgColor = GameUtil.parseColor("#B0B0B0")

function slot0.init(slot0, slot1)
	slot0.goClick = gohelper.getClick(slot1)

	slot0.goClick:AddClickListener(slot0.onClickItem, slot0)

	slot0.bgImg = slot1:GetComponent(gohelper.Type_Image)
	slot0._txtName = gohelper.findChildText(slot1, "#txt_heroname")
	slot0._txtherolv = gohelper.findChildText(slot1, "#txt_herolv")
	slot0._txtherolabel = gohelper.findChildText(slot1, "#txt_herolv/label")
	slot0._txtranklv = gohelper.findChildText(slot1, "#txt_ranklv")
	slot0._txtranklabel = gohelper.findChildText(slot1, "#txt_ranklv/label")
	slot0._txttalentlv = gohelper.findChildText(slot1, "#txt_talentlv")
	slot0._txttalentlabel = gohelper.findChildText(slot1, "#txt_talentlv/label")
	slot0._txtexskilllv = gohelper.findChildText(slot1, "#txt_exskilllv")
	slot0._txtexskilllabel = gohelper.findChildText(slot1, "#txt_exskilllv/label")
	slot0.isSelect = false

	GMController.instance:registerCallback(GMController.Event.ChangeSelectHeroItem, slot0.refreshSelect, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1

	if GMFastAddHeroHadHeroItemModel.instance:getShowType() == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		slot3 = slot1
		slot0._txtName.text = slot3.config.name .. "#" .. tostring(slot3.config.id)
		slot0._txtherolv.text = slot3.level
		slot0._txtranklabel.text = "洞悉:"
		slot0._txtranklv.text = slot3.rank - 1
		slot0._txttalentlabel.text = "共鸣:"
		slot0._txttalentlv.text = slot3.talent
		slot0._txtexskilllabel.text = "塑造:"
		slot0._txtexskilllv.text = slot3.exSkillLevel
	else
		slot3 = slot1
		slot0._txtName.text = slot3.config.name .. "#" .. tostring(slot3.config.id)
		slot0._txtherolv.text = slot3.level
		slot0._txtranklabel.text = "精炼:"
		slot0._txtranklv.text = slot3.refineLv
		slot0._txttalentlabel.text = "突破:"
		slot0._txttalentlv.text = slot3.breakLv
		slot0._txtexskilllabel.text = "uid:"
		slot0._txtexskilllv.text = slot3.uid
	end

	slot0:refreshSelect()
end

function slot0.onClickItem(slot0)
	slot0.isSelect = not slot0.isSelect

	if slot0.isSelect then
		GMFastAddHeroHadHeroItemModel.instance:changeSelectHeroItem(slot0.mo)
		GMFastAddHeroHadHeroItemModel.instance:setSelectMo(slot0.mo)
	else
		GMFastAddHeroHadHeroItemModel.instance:changeSelectHeroItem(nil)
		GMFastAddHeroHadHeroItemModel.instance:setSelectMo(nil)
	end
end

function slot0.refreshSelect(slot0)
	if GMFastAddHeroHadHeroItemModel.instance:getSelectMo() then
		slot0.isSelect = slot0.mo.uid == slot1.uid
	else
		slot0.isSelect = false
	end

	if slot0.isSelect then
		slot0.bgImg.color = uv0.SelectBgColor
	else
		slot0.bgImg.color = uv0.NotSelectBgColor
	end
end

function slot0.onDestroy(slot0)
	slot0.goClick:RemoveClickListener()
	GMController.instance:unregisterCallback(GMController.Event.ChangeSelectHeroItem, slot0.refreshSelect, slot0)
end

return slot0
