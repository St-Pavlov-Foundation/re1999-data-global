module("modules.logic.tower.view.fight.TowerBossHeroGroupAttributeTipsView", package.seeall)

slot0 = class("TowerBossHeroGroupAttributeTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0.gotipitem = gohelper.findChild(slot0.viewGO, "mask/root/scrollview/viewport/content/tipitem")

	gohelper.setActive(slot0.gotipitem, false)

	slot0.items = {}
	slot0.txtTeamLev = gohelper.findChildTextMesh(slot0.viewGO, "title/txt_Lv/num")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "title/Click")
	slot0.goSmallTips = gohelper.findChild(slot0.viewGO, "#go_SmallTips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnClick, slot0.onBtnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0._btnClick)
end

function slot0._editableInitView(slot0)
end

function slot0.onBtnClick(slot0)
	slot0._isSmallTipsShow = not slot0._isSmallTipsShow

	gohelper.setActive(slot0.goSmallTips, slot0._isSmallTipsShow)
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
	slot0.bossMo = TowerAssistBossModel.instance:getById(slot0.bossId)
	slot0.config = TowerConfig.instance:getAssistBossConfig(slot0.bossId)
end

function slot0.refreshView(slot0)
	slot0:refreshAttr()
end

function slot0.refreshAttr(slot0)
	slot0.txtTeamLev.text = HeroConfig.instance:getCommonLevelDisplay(HeroSingleGroupModel.instance:getTeamLevel())

	for slot8 = 1, math.max(#TowerConfig.instance:getHeroGroupAddAttr(slot0.bossId, slot1, slot0.bossMo and slot0.bossMo.level or 1), #slot0.items) do
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

	if slot2.upAttr then
		slot1.txtNum.text = string.format("%s%%", (slot2.val or 0) * 0.1)
	else
		slot1.txtNum.text = string.format("%s", slot4)
	end

	slot1.txtAdd.text = string.format("+%s%%", slot2.add * 0.1)

	UISpriteSetMgr.instance:setCommonSprite(slot1.imgIcon, string.format("icon_att_%s", slot2.key))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
