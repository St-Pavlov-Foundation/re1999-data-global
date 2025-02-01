module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleView", package.seeall)

slot0 = class("V2a1_BossRush_OfferRoleView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollChar = gohelper.findChildScrollRect(slot0.viewGO, "root/Left/#scroll_Char")
	slot0._scrollEffect = gohelper.findChildScrollRect(slot0.viewGO, "root/Right/#scroll_Effect")
	slot0._txtCharEffect = gohelper.findChildText(slot0.viewGO, "root/Right/#scroll_Effect/Viewport/Content/Title/#txt_CharEffect")
	slot0._txtEffect = gohelper.findChildText(slot0.viewGO, "root/Right/#scroll_Effect/Viewport/Content/#txt_Effect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(BossRushController.instance, BossRushEvent.OnSelectEnhanceRole, slot0._OnSelectEnhanceRole, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(BossRushController.instance, BossRushEvent.OnSelectEnhanceRole, slot0._OnSelectEnhanceRole, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._txtEffect.gameObject, false)
	BossRushEnhanceRoleViewListModel.instance:setListData()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._OnSelectEnhanceRole(slot0, slot1)
	slot0:refreshEnhanceEffect(slot1)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.refreshEnhanceEffect(slot0, slot1)
	slot0._txtCharEffect.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bossrush_enhance_role_title"), HeroConfig.instance:getHeroCO(slot1).name)

	if not string.nilorempty(BossRushConfig.instance:getActRoleEnhanceCoById(slot1).desc) then
		for slot10 = 1, #string.split(slot5, "|") do
			slot0:_getEffectItem(slot10):updateInfo(slot0, slot6[slot10], slot1)
			gohelper.setActive(slot0._effectList[slot10].viewGO, true)
			slot11:activeLine(slot10 < #slot6)
		end

		for slot10 = #slot6 + 1, #slot0._effectList do
			gohelper.setActive(slot0._effectList[slot10].viewGO, false)
		end
	end
end

function slot0._getEffectItem(slot0, slot1)
	slot0._effectList = slot0._effectList or slot0:getUserDataTb_()

	if not slot0._effectList[slot1] then
		slot2 = V2a1_BossRush_OfferRoleEffectItem.New()

		slot2:initView(gohelper.cloneInPlace(slot0._txtEffect.gameObject))

		slot0._effectList[slot1] = slot2
	end

	return slot2
end

return slot0
