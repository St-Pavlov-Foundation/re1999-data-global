module("modules.logic.season.view1_2.Season1_2EquipBookView", package.seeall)

slot0 = class("Season1_2EquipBookView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "left/#go_target")
	slot0._gotargetcardpos = gohelper.findChild(slot0.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos")
	slot0._gotouch = gohelper.findChild(slot0.viewGO, "left/#go_target/#go_touch")
	slot0._txtcardname = gohelper.findChildText(slot0.viewGO, "left/#go_target/#txt_cardname")
	slot0._txteffectdesc = gohelper.findChildText(slot0.viewGO, "left/#go_target/Scroll View/Viewport/Content/#txt_effectdesc")
	slot0._scrollcardlist = gohelper.findChildScrollRect(slot0.viewGO, "right/mask/#scroll_cardlist")
	slot0._btnexchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_exchange")
	slot0._goattributeitem = gohelper.findChild(slot0.viewGO, "left/#go_target/Scroll View/Viewport/Content/attrlist/#go_attributeitem")
	slot0._goskilldescitem = gohelper.findChild(slot0.viewGO, "left/#go_target/Scroll View/Viewport/Content/skilldesc/#go_skilldescitem")
	slot0._gocarditem = gohelper.findChild(slot0.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos/#go_carditem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnexchange:AddClickListener(slot0._btnexchangeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnexchange:RemoveClickListener()
end

function slot0._btnexchangeOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Season1_2EquipComposeView, {
		actId = Activity104Model.instance:getCurSeasonId()
	})
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	slot0._goDesc = gohelper.findChild(slot0.viewGO, "left/#go_target/Scroll View")
	slot0._goAttrParent = gohelper.findChild(slot0.viewGO, "left/#go_target/Scroll View/Viewport/Content/attrlist")
	slot0._animatorCard = slot0._gotargetcardpos:GetComponent(typeof(UnityEngine.Animator))
	slot0._animCardEventWrap = slot0._animatorCard:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animCardEventWrap:AddEventListener("switch", slot0.onSwitchCardAnim, slot0)

	slot0._propItems = {}
	slot0._skillItems = {}
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()

	if slot0._animCardEventWrap then
		slot0._animCardEventWrap:RemoveAllEventListener()

		slot0._animCardEventWrap = nil
	end

	if slot0._icon ~= nil then
		slot0._icon:disposeUI()

		slot0._icon = nil
	end

	Activity104EquipBookController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity104EquipBookController.instance, Activity104Event.OnBookUpdateNotify, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity104EquipBookController.instance, Activity104Event.OnBookChangeSelectNotify, slot0.onChangeSelectCard, slot0)
	Activity104EquipBookController.instance:onOpenView(Activity104Model.instance:getCurSeasonId())
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshDesc()
	slot0:refreshIcon()
end

function slot0.refreshDesc(slot0)
	if not Activity104EquipItemBookModel.instance.curSelectItemId then
		slot0._txtcardname.text = ""

		gohelper.setActive(slot0._goDesc, false)
	else
		if not SeasonConfig.instance:getSeasonEquipCo(slot1) then
			slot0._txtcardname.text = ""

			gohelper.setActive(slot0._goDesc, false)
		else
			gohelper.setActive(slot0._goDesc, true)
		end

		slot0._txtcardname.text = string.format("[%s]", slot2.name)

		slot0:refreshProps(slot2)
		slot0:refreshSkills(slot2)
	end
end

function slot0.refreshIcon(slot0)
	slot0:checkCreateIcon()

	if slot0._icon then
		slot0._icon:updateData(Activity104EquipItemBookModel.instance.curSelectItemId)
	end
end

function slot0.refreshProps(slot0, slot1)
	slot2 = {}
	slot3 = false

	if slot1 and slot1.attrId ~= 0 then
		for slot9, slot10 in ipairs(SeasonEquipMetaUtils.getEquipPropsStrList(slot1.attrId)) do
			slot11 = slot0:getOrCreatePropText(slot9)

			gohelper.setActive(slot11.go, true)

			slot11.txtDesc.text = slot10

			SLFramework.UGUI.GuiHelper.SetColor(slot11.txtDesc, SeasonEquipMetaUtils.getCareerColorDarkBg(slot1.equipId))

			slot2[slot11] = true
			slot3 = true
		end
	end

	for slot7, slot8 in pairs(slot0._propItems) do
		if not slot2[slot8] then
			gohelper.setActive(slot8.go, false)
		end
	end

	gohelper.setActive(slot0._goAttrParent, slot3)
end

function slot0.refreshSkills(slot0, slot1)
	slot4 = {
		[slot10] = true
	}

	for slot8, slot9 in ipairs(SeasonEquipMetaUtils.getSkillEffectStrList(slot1)) do
		slot10 = slot0:getOrCreateSkillText(slot8)

		gohelper.setActive(slot10.go, true)

		slot10.txtDesc.text = slot9

		SLFramework.UGUI.GuiHelper.SetColor(slot10.txtDesc, SeasonEquipMetaUtils.getCareerColorDarkBg(slot1.equipId))
	end

	for slot8, slot9 in pairs(slot0._skillItems) do
		if not slot4[slot9] then
			gohelper.setActive(slot9.go, false)
		end
	end
end

function slot0.getOrCreatePropText(slot0, slot1)
	if not slot0._propItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goattributeitem, "propname_" .. tostring(slot1))
		slot2.txtDesc = gohelper.findChildText(slot2.go, "txt_attributedesc")
		slot0._propItems[slot1] = slot2
	end

	return slot2
end

function slot0.getOrCreateSkillText(slot0, slot1)
	if not slot0._skillItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goskilldescitem, "skill_" .. tostring(slot1))
		slot2.txtDesc = gohelper.findChildText(slot2.go, "txt_skilldesc")
		slot0._skillItems[slot1] = slot2
	end

	return slot2
end

function slot0.checkCreateIcon(slot0)
	if not slot0._icon then
		slot0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gocarditem, Season1_2CelebrityCardEquip)
	end
end

function slot0.onChangeSelectCard(slot0)
	slot0._animatorCard:Play("switch", 0, 0)
end

function slot0.onSwitchCardAnim(slot0)
	slot0:refreshUI()
end

return slot0
