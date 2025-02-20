module("modules.logic.versionactivity2_3.act174.view.info.Act174ItemTipView", package.seeall)

slot0 = class("Act174ItemTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gobuff = gohelper.findChild(slot0.viewGO, "#go_buff")
	slot0._gocollection = gohelper.findChild(slot0.viewGO, "#go_collection")
	slot0._gobuynode1 = gohelper.findChild(slot0.viewGO, "#go_collection/#go_buynode")
	slot0._btnunequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_collection/#btn_unequip")
	slot0._gocharacterinfo = gohelper.findChild(slot0.viewGO, "#go_characterinfo")
	slot0._gocharacterinfo2 = gohelper.findChild(slot0.viewGO, "#go_characterinfo2")
	slot0._gobuynode2 = gohelper.findChild(slot0.viewGO, "#go_characterinfo2/#go_buynode")
	slot0._btnBuy = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "btn_buy")
	slot0.txtCost = gohelper.findChildText(slot0.viewGO, "btn_buy/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnBuy:AddClickListener(slot0.clickBuy, slot0)
	slot0._btnunequip:AddClickListener(slot0.clickUnEquip, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, slot0.refreshCost, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnBuy:RemoveClickListener()
	slot0._btnunequip:RemoveClickListener()
	slot0:removeEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, slot0.refreshCost, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.clickBuy(slot0)
	if not (slot0.viewParam and slot0.viewParam.goodInfo) then
		return
	end

	if slot1.finish then
		return
	end

	if Activity174Model.instance:getActInfo():getGameInfo().coin < slot1.buyCost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act174ItemTipViewBuy")

	slot0.expectCoin = slot2.coin - slot1.buyCost

	Activity174Rpc.instance:sendBuyIn174ShopRequest(Activity174Model.instance:getCurActId(), slot1.index, slot0.buyReply, slot0)
end

function slot0.buyReply(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:endBlock("Act174ItemTipViewBuy")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if slot2 == 0 then
		if slot0.expectCoin and slot0.expectCoin ~= Activity174Model.instance:getActInfo():getGameInfo().coin then
			GameFacade.showToast(ToastEnum.Act174BuyReturnCoin)
		end

		slot0:closeThis()
	end
end

function slot0.clickUnEquip(slot0)
	Activity174Controller.instance:dispatchEvent(Activity174Event.UnEquipCollection, slot0.viewParam.index)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.cIcon = gohelper.findChildSingleImage(slot0._gocollection, "simage_collection")
	slot0.cName = gohelper.findChildText(slot0._gocollection, "txt_name")
	slot0.cDesc = gohelper.findChildText(slot0._gocollection, "scroll_desc/Viewport/go_desccontent/txt_desc")
	slot0.bIcon = gohelper.findChildSingleImage(slot0._gobuff, "simage_bufficon")
	slot0.bName = gohelper.findChildText(slot0._gobuff, "txt_name")
	slot0.bDesc = gohelper.findChildText(slot0._gobuff, "scroll_desc/Viewport/go_desccontent/txt_desc")
	slot0._animBuff = slot0._gobuff:GetComponent(gohelper.Type_Animator)
	slot0._animCollection = slot0._gocollection:GetComponent(gohelper.Type_Animator)
	slot0._animCharacter = slot0._gocharacterinfo:GetComponent(gohelper.Type_Animator)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.showMask

	gohelper.setActive(slot0._btnclose, slot1)

	slot2 = slot1 and slot0.viewGO.transform or slot0._goleft.transform

	slot0._gobuff.transform:SetParent(slot2)
	slot0._gocollection.transform:SetParent(slot2)
	slot0._gocharacterinfo.transform:SetParent(slot2)
	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_mln_page_turn)
end

function slot0.refreshUI(slot0)
	slot0.type = slot0.viewParam.type
	slot1 = slot0.viewParam.pos or Vector2.New(0, 0)

	gohelper.setActive(slot0._gobuff, slot0.type == Activity174Enum.ItemTipType.Buff)
	gohelper.setActive(slot0._gocollection, slot0.type == Activity174Enum.ItemTipType.Collection or slot0.type == Activity174Enum.ItemTipType.Character2)
	gohelper.setActive(slot0._gocharacterinfo, slot0.type == Activity174Enum.ItemTipType.Character)
	gohelper.setActive(slot0._gocharacterinfo2, slot0.type == Activity174Enum.ItemTipType.Character1 or slot0.type == Activity174Enum.ItemTipType.Character3)

	if slot0.type == Activity174Enum.ItemTipType.Character then
		recthelper.setAnchor(slot0._gocharacterinfo.transform, slot1.x, slot1.y)

		if not slot0.characterItem then
			slot0.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gocharacterinfo, Act174CharacterInfo)
		end

		slot0.characterItem:setData(slot0.viewParam.co)
	elseif slot0.type == Activity174Enum.ItemTipType.Collection or slot0.type == Activity174Enum.ItemTipType.Character2 then
		recthelper.setAnchor(slot0._gocollection.transform, slot1.x, slot1.y)
		slot0:refreshSimpleInfo(slot0.viewParam.co)
	elseif slot0.type == Activity174Enum.ItemTipType.Buff then
		recthelper.setAnchor(slot0._gobuff.transform, slot1.x, slot1.y)
		slot0:refreshBuffInfo(slot0.viewParam.co)
	else
		recthelper.setAnchor(slot0._gocharacterinfo2.transform, slot1.x, slot1.y)

		if not slot0.characterItem then
			slot0.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gocharacterinfo2, Act174CharacterInfo)
		end

		slot0:refreshCharacterInfo2(slot0.viewParam.co)
	end

	slot0:refreshBuy()
	gohelper.setActive(slot0._btnunequip, slot0.viewParam.index)
end

function slot0.refreshBuy(slot0)
	if slot0.viewParam and slot0.viewParam.goodInfo then
		slot2 = nil

		if slot0.type == Activity174Enum.ItemTipType.Collection or slot0.type == Activity174Enum.ItemTipType.Character2 then
			slot2 = slot0._gobuynode1.transform
		elseif slot0.type == Activity174Enum.ItemTipType.Character1 then
			slot2 = slot0._gobuynode2.transform
		end

		if slot2 then
			slot0._btnBuy.transform:SetParent(slot2, false)
		end
	end

	slot0:refreshCost()
	gohelper.setActive(slot0._btnBuy, slot1)
end

function slot0.refreshCost(slot0)
	slot1 = ""
	slot2 = "#211F1F"
	slot4 = Activity174Model.instance:getActInfo():getGameInfo()

	if slot0.viewParam and slot0.viewParam.goodInfo and slot4 and slot4.coin < slot3.buyCost then
		slot2 = "#be4343"
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0.txtCost, slot2)

	slot0.txtCost.text = slot1
end

function slot0.refreshSimpleInfo(slot0, slot1)
	slot2, slot3, slot4 = nil

	if slot0.type == Activity174Enum.ItemTipType.Collection then
		slot2 = slot1.icon
		slot3 = string.format("<#%s>%s</color>", Activity174Enum.CollectionColor[slot1.rare], slot1.title)
		slot4 = SkillHelper.buildDesc(slot1.desc)
	elseif slot0.type == Activity174Enum.ItemTipType.Character2 then
		if slot0.viewParam and slot0.viewParam.goodInfo then
			slot2 = Activity174Enum.heroBagIcon[#slot5.bagInfo.heroId]
		end

		slot3 = slot1.bagTitle
		slot4 = slot1.bagDesc
	end

	if slot2 then
		slot0.cIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot2))
	end

	slot0.cName.text = slot3 or ""
	slot0.cDesc.text = slot4 or ""

	SkillHelper.addHyperLinkClick(slot0.cDesc)
end

function slot0.refreshBuffInfo(slot0, slot1)
	slot0.bIcon:LoadImage(ResUrl.getAct174BuffIcon(slot1.icon))

	slot0.bName.text = slot1.title
	slot0.bDesc.text = slot1.desc
end

function slot0.refreshCharacterInfo2(slot0, slot1)
	slot0.roleIdList = slot1
	slot0.characterItemList = {}

	for slot5 = 1, 3 do
		slot6 = slot0:getUserDataTb_()
		slot6.frame = gohelper.findChild(slot0._gocharacterinfo2, "selectframe/selectframe" .. slot5)
		slot6.go = gohelper.findChild(slot0._gocharacterinfo2, "character" .. slot5)

		if slot0.roleIdList[slot5] and Activity174Config.instance:getRoleCo(slot7) then
			slot6.rare = gohelper.findChildImage(slot6.go, "rare")
			slot6.heroIcon = gohelper.findChildSingleImage(slot6.go, "heroicon")
			slot6.career = gohelper.findChildImage(slot6.go, "career")

			slot0:addClickCb(gohelper.findButtonWithAudio(slot6.go), slot0.clickRole, slot0, slot5)
			UISpriteSetMgr.instance:setCommonSprite(slot6.rare, "bgequip" .. tostring(CharacterEnum.Color[slot8.rare]))
			UISpriteSetMgr.instance:setCommonSprite(slot6.career, "lssx_" .. slot8.career)

			if slot8.type == Activity174Enum.CharacterType.Hero then
				slot6.heroIcon:LoadImage(ResUrl.getHeadIconSmall(slot8.skinId))
			else
				slot6.heroIcon:LoadImage(ResUrl.monsterHeadIcon(slot8.skinId))
			end
		else
			gohelper.setActive(slot6.go, false)
		end

		table.insert(slot0.characterItemList, slot6)
	end

	slot0:clickRole(1)
end

function slot0.clickRole(slot0, slot1)
	if slot1 == slot0.selectedIndex then
		return
	end

	if not gohelper.isNil(slot0.characterItemList[slot1] and slot2.frame) then
		gohelper.setAsLastSibling(slot3)
	end

	slot0.selectedIndex = slot1

	slot0.characterItem:setData(Activity174Config.instance:getRoleCo(slot0.roleIdList[slot1]))
end

function slot0.onClose(slot0)
end

function slot0.playCloseAnim(slot0)
	if slot0._gocharacterinfo.activeInHierarchy then
		slot0._animCharacter:Play(UIAnimationName.Close)
	end

	if slot0._gocollection.activeInHierarchy then
		slot0._animCollection:Play(UIAnimationName.Close)
	end

	if slot0._gobuff.activeInHierarchy then
		slot0._animBuff:Play(UIAnimationName.Close)
	end
end

function slot0.onDestroyView(slot0)
	slot0.cIcon:UnLoadImage()
	slot0.bIcon:UnLoadImage()
end

return slot0
