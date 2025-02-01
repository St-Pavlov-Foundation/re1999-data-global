module("modules.logic.season.view1_5.Season1_5CelebrityCardTipView", package.seeall)

slot0 = class("Season1_5CelebrityCardTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if GMController.instance:getGMNode("seasoncelebritycardtipview", slot0.viewGO) then
		slot0._gogm = gohelper.findChild(slot1, "#go_gm")
		slot0._txtmattip = gohelper.findChildText(slot1, "#go_gm/bg/#txt_mattip")
		slot0._btnone = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_one")
		slot0._btnten = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_ten")
		slot0._btnhundred = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_hundred")
		slot0._btnthousand = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_thousand")
		slot0._btntenthousand = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_tenthousand")
		slot0._btntenmillion = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_tenmillion")
		slot0._btninput = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_input")
	end

	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg2")
	slot0._txtpropname = gohelper.findChildText(slot0.viewGO, "#txt_propname")
	slot0._txtpropnameen = gohelper.findChildText(slot0.viewGO, "#txt_propname/#txt_propnameen")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content/#go_effect")
	slot0._goeffectitem = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content/#go_effect/#go_effectitem")
	slot0._goeffectdesc = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content/#go_effectdesc")
	slot0._goeffectdescitem = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content/#go_effectdesc/#go_effectdescitem")
	slot0._txthadnumber = gohelper.findChildText(slot0.viewGO, "#go_quantity/#txt_hadnumber")
	slot0._goquantity = gohelper.findChild(slot0.viewGO, "#go_quantity")
	slot0._gocard = gohelper.findChild(slot0.viewGO, "#go_card")
	slot0._gocarditem = gohelper.findChild(slot0.viewGO, "#go_ctrl/#go_targetcardpos/#go_carditem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)

	if slot0._gogm then
		slot0._btnone:AddClickListener(slot0.onClickGMAdd, slot0, 1)
		slot0._btnten:AddClickListener(slot0.onClickGMAdd, slot0, 10)
		slot0._btnhundred:AddClickListener(slot0.onClickGMAdd, slot0, 100)
		slot0._btnthousand:AddClickListener(slot0.onClickGMAdd, slot0, 1000)
		slot0._btntenthousand:AddClickListener(slot0.onClickGMAdd, slot0, 10000)
		slot0._btntenmillion:AddClickListener(slot0.onClickGMAdd, slot0, 10000000)
		slot0._btninput:AddClickListener(slot0._btninputOnClick, slot0)
	end
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()

	if slot0._gogm then
		slot0._btnone:RemoveClickListener()
		slot0._btnten:RemoveClickListener()
		slot0._btnhundred:RemoveClickListener()
		slot0._btnthousand:RemoveClickListener()
		slot0._btntenthousand:RemoveClickListener()
		slot0._btntenmillion:RemoveClickListener()
		slot0._btninput:RemoveClickListener()
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickGMAdd(slot0, slot1)
	GameFacade.showToast(ToastEnum.GMTool5, slot0.viewParam.id)
	GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", slot0.viewParam.type, slot0.viewParam.id, 10))
end

function slot0._btninputOnClick(slot0)
	slot1 = CommonInputMO.New()
	slot1.title = "请输入增加道具数量！"
	slot1.defaultInput = "Enter Item Num"

	function slot1.sureCallback(slot0)
		GameFacade.closeInputBox()

		if tonumber(slot0) and slot1 > 0 then
			GameFacade.showToast(ToastEnum.GMTool5, uv0.viewParam.id)
			GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", uv0.viewParam.type, uv0.viewParam.id, slot1))
		end
	end

	GameFacade.openInputBox(slot1)
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._goSkillTitle = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content/#go_effectdesc/title")
	slot0._propItems = {}
	slot0._skillItems = {}

	if slot0._gogm then
		gohelper.setActive(slot0._gogm, GMController.instance:isOpenGM())
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()

	if slot0._icon then
		slot0._icon:disposeUI()

		slot0._icon = nil
	end
end

function slot0.onOpen(slot0)
	slot0._itemId = slot0.viewParam.id
	slot0._itemCfg = ItemModel.instance:getItemConfigAndIcon(slot0.viewParam.type, slot0._itemId)
	slot0._activityId = slot0.viewParam.actId or Activity104Model.instance:getCurSeasonId()

	if not slot0._itemCfg then
		logError("can't find card cfg : " .. tostring(slot0._itemId))

		return
	end

	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0._txtpropname.text = slot0._itemCfg.name

	if slot0._txtmattip then
		slot0._txtmattip.text = tostring(slot0.viewParam.type) .. "#" .. tostring(slot0.viewParam.id)
	end

	slot0:checkCreateIcon()
	slot0._icon:updateData(slot0._itemId)
	slot0:refreshQuantity()

	if not slot0:refreshProps() or not slot0:refreshSkills() then
		gohelper.setActive(slot0._goSkillTitle, false)
	end
end

function slot0.refreshQuantity(slot0)
	if slot0.viewParam.needQuantity then
		gohelper.setActive(slot0._goquantity, true)

		slot1 = nil
		slot0._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", (not slot0.viewParam.fakeQuantity or tostring(slot0.viewParam.fakeQuantity)) and (not slot0._activityId or tostring(GameUtil.numberDisplay(SeasonEquipMetaUtils.getEquipCount(slot0._activityId, slot0._itemId)))) and tostring(SeasonEquipMetaUtils.getCurSeasonEquipCount(slot0._itemId)))
	else
		gohelper.setActive(slot0._goquantity, false)
	end
end

function slot0.refreshProps(slot0)
	slot1 = false
	slot3 = SeasonEquipMetaUtils.getCareerColorBrightBg(slot0._itemId)
	slot4 = {
		[slot10] = true
	}

	for slot8, slot9 in ipairs(SeasonEquipMetaUtils.getEquipPropsStrList(slot0._itemCfg.attrId, true)) do
		slot10 = slot0:getOrCreatePropText(slot8)

		gohelper.setActive(slot10.go, true)

		slot10.txtDesc.text = slot9

		SLFramework.UGUI.GuiHelper.SetColor(slot10.txtDesc, slot3)
		SLFramework.UGUI.GuiHelper.SetColor(slot10.imagePoint, slot3)

		slot1 = true
	end

	for slot8, slot9 in pairs(slot0._propItems) do
		if not slot4[slot9] then
			gohelper.setActive(slot9.go, false)
		end
	end

	gohelper.setActive(slot0._goeffect, slot1)

	return slot1
end

function slot0.refreshSkills(slot0)
	slot2 = SeasonEquipMetaUtils.getCareerColorBrightBg(slot0._itemId)
	slot3 = false
	slot4 = {
		[slot10] = true
	}

	for slot8, slot9 in ipairs(SeasonEquipMetaUtils.getSkillEffectStrList(slot0._itemCfg)) do
		slot10 = slot0:getOrCreateSkillText(slot8)

		gohelper.setActive(slot10.go, true)

		slot10.txtDesc.text = slot9

		SLFramework.UGUI.GuiHelper.SetColor(slot10.txtDesc, slot2)
		SLFramework.UGUI.GuiHelper.SetColor(slot10.imagePoint, slot2)

		slot3 = true
	end

	for slot8, slot9 in pairs(slot0._skillItems) do
		if not slot4[slot9] then
			gohelper.setActive(slot9.go, false)
		end
	end

	return slot3
end

function slot0.checkCreateIcon(slot0)
	if not slot0._icon then
		slot0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocard, "icon"), Season1_5CelebrityCardEquip)
	end
end

function slot0.getOrCreatePropText(slot0, slot1)
	if not slot0._propItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goeffectitem, "propname_" .. tostring(slot1))
		slot2.txtDesc = gohelper.findChildText(slot2.go, "txt_desc")
		slot2.imagePoint = gohelper.findChildImage(slot2.go, "point")
		slot0._propItems[slot1] = slot2
	end

	return slot2
end

function slot0.getOrCreateSkillText(slot0, slot1)
	if not slot0._skillItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goeffectdescitem, "skill_" .. tostring(slot1))
		slot2.txtDesc = gohelper.findChildText(slot2.go, "txt_desc")
		slot2.imagePoint = gohelper.findChildImage(slot2.go, "point")
		slot0._skillItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
