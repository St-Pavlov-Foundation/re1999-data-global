module("modules.logic.tower.view.assistboss.TowerBossAttributeTipsView", package.seeall)

slot0 = class("TowerBossAttributeTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0.gotipitem = gohelper.findChild(slot0.viewGO, "mask/root/scrollview/viewport/content/tipitem")

	gohelper.setActive(slot0.gotipitem, false)

	slot0.items = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.bossId = slot0.viewParam.bossId
	slot0.isFromHeroGroup = slot0.viewParam.isFromHeroGroup
	slot0.bossMo = TowerAssistBossModel.instance:getById(slot0.bossId)
	slot0.config = TowerConfig.instance:getAssistBossConfig(slot0.bossId)
end

function slot0.refreshView(slot0)
	slot0:refreshAttr()
end

function slot0.refreshAttr(slot0)
	slot8 = slot0.bossMo and slot0.bossMo.level or 1

	for slot8 = 1, math.max(#TowerConfig.instance:getHeroGroupAddAttr(slot0.bossId, 0, slot8), #slot0.items) do
		slot0:updateAttrItem(slot0:getAttrItem(slot8), slot3[slot8])
	end
end

function slot0.getAttrItem(slot0, slot1)
	if not slot0.items[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0.gotipitem)
		slot2.imgIcon = gohelper.findChildImage(slot2.go, "icon")
		slot2.txtName = gohelper.findChildTextMesh(slot2.go, "name")
		slot2.txtNum = gohelper.findChildTextMesh(slot2.go, "num")
		slot2.txtAdd = gohelper.findChildTextMesh(slot2.go, "add")
		slot0.items[slot1] = slot2
	end

	return slot0.items[slot1]
end

function slot0.updateAttrItem(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	slot1.txtName.text = HeroConfig.instance:getHeroAttributeCO(slot2.key).name

	if slot2.val then
		if slot2.upAttr then
			slot1.txtNum.text = string.format("%s%%", slot2.val * 0.1)
		else
			slot1.txtNum.text = string.format("%s", slot2.val)
		end
	else
		slot1.txtNum.text = ""
	end

	slot1.txtAdd.text = string.format("+%s%%", slot2.add * 0.1)

	UISpriteSetMgr.instance:setCommonSprite(slot1.imgIcon, string.format("icon_att_%s", slot2.key))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
