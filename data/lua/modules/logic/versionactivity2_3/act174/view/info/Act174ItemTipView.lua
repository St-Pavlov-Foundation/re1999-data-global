module("modules.logic.versionactivity2_3.act174.view.info.Act174ItemTipView", package.seeall)

local var_0_0 = class("Act174ItemTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gobuff = gohelper.findChild(arg_1_0.viewGO, "#go_buff")
	arg_1_0._gocollection = gohelper.findChild(arg_1_0.viewGO, "#go_collection")
	arg_1_0._gobuynode1 = gohelper.findChild(arg_1_0.viewGO, "#go_collection/#go_buynode")
	arg_1_0._btnunequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_collection/#btn_unequip")
	arg_1_0._gocharacterinfo = gohelper.findChild(arg_1_0.viewGO, "#go_characterinfo")
	arg_1_0._gocharacterinfo2 = gohelper.findChild(arg_1_0.viewGO, "#go_characterinfo2")
	arg_1_0._gobuynode2 = gohelper.findChild(arg_1_0.viewGO, "#go_characterinfo2/#go_buynode")
	arg_1_0._btnBuy = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "btn_buy")
	arg_1_0.txtCost = gohelper.findChildText(arg_1_0.viewGO, "btn_buy/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0.clickBuy, arg_2_0)
	arg_2_0._btnunequip:AddClickListener(arg_2_0.clickUnEquip, arg_2_0)
	arg_2_0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, arg_2_0.refreshCost, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnBuy:RemoveClickListener()
	arg_3_0._btnunequip:RemoveClickListener()
	arg_3_0:removeEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, arg_3_0.refreshCost, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.clickBuy(arg_5_0)
	local var_5_0 = arg_5_0.viewParam and arg_5_0.viewParam.goodInfo

	if not var_5_0 then
		return
	end

	if var_5_0.finish then
		return
	end

	local var_5_1 = Activity174Model.instance:getActInfo():getGameInfo()

	if var_5_0.buyCost > var_5_1.coin then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act174ItemTipViewBuy")

	arg_5_0.expectCoin = var_5_1.coin - var_5_0.buyCost

	local var_5_2 = Activity174Model.instance:getCurActId()

	Activity174Rpc.instance:sendBuyIn174ShopRequest(var_5_2, var_5_0.index, arg_5_0.buyReply, arg_5_0)
end

function var_0_0.buyReply(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	UIBlockMgr.instance:endBlock("Act174ItemTipViewBuy")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if arg_6_2 == 0 then
		local var_6_0 = Activity174Model.instance:getActInfo():getGameInfo()

		if arg_6_0.expectCoin and arg_6_0.expectCoin ~= var_6_0.coin then
			GameFacade.showToast(ToastEnum.Act174BuyReturnCoin)
		end

		arg_6_0:closeThis()
	end
end

function var_0_0.clickUnEquip(arg_7_0)
	Activity174Controller.instance:dispatchEvent(Activity174Event.UnEquipCollection, arg_7_0.viewParam.index)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.cIcon = gohelper.findChildSingleImage(arg_8_0._gocollection, "simage_collection")
	arg_8_0.cName = gohelper.findChildText(arg_8_0._gocollection, "txt_name")
	arg_8_0.cDesc = gohelper.findChildText(arg_8_0._gocollection, "scroll_desc/Viewport/go_desccontent/txt_desc")
	arg_8_0.bIcon = gohelper.findChildSingleImage(arg_8_0._gobuff, "simage_bufficon")
	arg_8_0.bName = gohelper.findChildText(arg_8_0._gobuff, "txt_name")
	arg_8_0.bDesc = gohelper.findChildText(arg_8_0._gobuff, "scroll_desc/Viewport/go_desccontent/txt_desc")
	arg_8_0._animBuff = arg_8_0._gobuff:GetComponent(gohelper.Type_Animator)
	arg_8_0._animCollection = arg_8_0._gocollection:GetComponent(gohelper.Type_Animator)
	arg_8_0._animCharacter = arg_8_0._gocharacterinfo:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshUI()
end

function var_0_0.onOpen(arg_10_0)
	local var_10_0 = arg_10_0.viewParam and arg_10_0.viewParam.showMask

	gohelper.setActive(arg_10_0._btnclose, var_10_0)

	local var_10_1 = var_10_0 and arg_10_0.viewGO.transform or arg_10_0._goleft.transform

	arg_10_0._gobuff.transform:SetParent(var_10_1)
	arg_10_0._gocollection.transform:SetParent(var_10_1)
	arg_10_0._gocharacterinfo.transform:SetParent(var_10_1)
	arg_10_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_mln_page_turn)
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0.type = arg_11_0.viewParam.type

	local var_11_0 = arg_11_0.viewParam.pos or Vector2.New(0, 0)

	gohelper.setActive(arg_11_0._gobuff, arg_11_0.type == Activity174Enum.ItemTipType.Buff)
	gohelper.setActive(arg_11_0._gocollection, arg_11_0.type == Activity174Enum.ItemTipType.Collection or arg_11_0.type == Activity174Enum.ItemTipType.Character2)
	gohelper.setActive(arg_11_0._gocharacterinfo, arg_11_0.type == Activity174Enum.ItemTipType.Character)
	gohelper.setActive(arg_11_0._gocharacterinfo2, arg_11_0.type == Activity174Enum.ItemTipType.Character1 or arg_11_0.type == Activity174Enum.ItemTipType.Character3)

	if arg_11_0.type == Activity174Enum.ItemTipType.Character then
		recthelper.setAnchor(arg_11_0._gocharacterinfo.transform, var_11_0.x, var_11_0.y)

		if not arg_11_0.characterItem then
			arg_11_0.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._gocharacterinfo, Act174CharacterInfo)
		end

		arg_11_0.characterItem:setData(arg_11_0.viewParam.co)
	elseif arg_11_0.type == Activity174Enum.ItemTipType.Collection or arg_11_0.type == Activity174Enum.ItemTipType.Character2 then
		recthelper.setAnchor(arg_11_0._gocollection.transform, var_11_0.x, var_11_0.y)
		arg_11_0:refreshSimpleInfo(arg_11_0.viewParam.co)
	elseif arg_11_0.type == Activity174Enum.ItemTipType.Buff then
		recthelper.setAnchor(arg_11_0._gobuff.transform, var_11_0.x, var_11_0.y)
		arg_11_0:refreshBuffInfo(arg_11_0.viewParam.co)
	else
		recthelper.setAnchor(arg_11_0._gocharacterinfo2.transform, var_11_0.x, var_11_0.y)

		if not arg_11_0.characterItem then
			arg_11_0.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._gocharacterinfo2, Act174CharacterInfo)
		end

		arg_11_0:refreshCharacterInfo2(arg_11_0.viewParam.co)
	end

	arg_11_0:refreshBuy()
	gohelper.setActive(arg_11_0._btnunequip, arg_11_0.viewParam.index)
end

function var_0_0.refreshBuy(arg_12_0)
	local var_12_0 = arg_12_0.viewParam and arg_12_0.viewParam.goodInfo

	if var_12_0 then
		local var_12_1

		if arg_12_0.type == Activity174Enum.ItemTipType.Collection or arg_12_0.type == Activity174Enum.ItemTipType.Character2 then
			var_12_1 = arg_12_0._gobuynode1.transform
		elseif arg_12_0.type == Activity174Enum.ItemTipType.Character1 then
			var_12_1 = arg_12_0._gobuynode2.transform
		end

		if var_12_1 then
			arg_12_0._btnBuy.transform:SetParent(var_12_1, false)
		end
	end

	arg_12_0:refreshCost()
	gohelper.setActive(arg_12_0._btnBuy, var_12_0)
end

function var_0_0.refreshCost(arg_13_0)
	local var_13_0 = ""
	local var_13_1 = "#211F1F"
	local var_13_2 = arg_13_0.viewParam and arg_13_0.viewParam.goodInfo
	local var_13_3 = Activity174Model.instance:getActInfo():getGameInfo()

	if var_13_2 and var_13_3 then
		var_13_0 = var_13_2.buyCost

		if var_13_0 > var_13_3.coin then
			var_13_1 = "#be4343"
		end
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_13_0.txtCost, var_13_1)

	arg_13_0.txtCost.text = var_13_0
end

function var_0_0.refreshSimpleInfo(arg_14_0, arg_14_1)
	local var_14_0
	local var_14_1
	local var_14_2

	if arg_14_0.type == Activity174Enum.ItemTipType.Collection then
		var_14_0 = arg_14_1.icon

		local var_14_3 = Activity174Enum.CollectionColor[arg_14_1.rare]

		var_14_1 = string.format("<#%s>%s</color>", var_14_3, arg_14_1.title)
		var_14_2 = SkillHelper.buildDesc(arg_14_1.desc)
	elseif arg_14_0.type == Activity174Enum.ItemTipType.Character2 then
		local var_14_4 = arg_14_0.viewParam and arg_14_0.viewParam.goodInfo

		if var_14_4 then
			local var_14_5 = var_14_4.bagInfo

			var_14_0 = Activity174Enum.heroBagIcon[#var_14_5.heroId]
		end

		var_14_1 = arg_14_1.bagTitle
		var_14_2 = arg_14_1.bagDesc
	end

	if var_14_0 then
		arg_14_0.cIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_14_0))
	end

	arg_14_0.cName.text = var_14_1 or ""
	arg_14_0.cDesc.text = var_14_2 or ""

	SkillHelper.addHyperLinkClick(arg_14_0.cDesc)
end

function var_0_0.refreshBuffInfo(arg_15_0, arg_15_1)
	arg_15_0.bIcon:LoadImage(ResUrl.getAct174BuffIcon(arg_15_1.icon))

	arg_15_0.bName.text = arg_15_1.title
	arg_15_0.bDesc.text = arg_15_1.desc
end

function var_0_0.refreshCharacterInfo2(arg_16_0, arg_16_1)
	arg_16_0.roleIdList = arg_16_1
	arg_16_0.characterItemList = {}

	for iter_16_0 = 1, 3 do
		local var_16_0 = arg_16_0:getUserDataTb_()

		var_16_0.frame = gohelper.findChild(arg_16_0._gocharacterinfo2, "selectframe/selectframe" .. iter_16_0)
		var_16_0.go = gohelper.findChild(arg_16_0._gocharacterinfo2, "character" .. iter_16_0)

		local var_16_1 = arg_16_0.roleIdList[iter_16_0]
		local var_16_2 = var_16_1 and Activity174Config.instance:getRoleCo(var_16_1)

		if var_16_2 then
			var_16_0.rare = gohelper.findChildImage(var_16_0.go, "rare")
			var_16_0.heroIcon = gohelper.findChildSingleImage(var_16_0.go, "heroicon")
			var_16_0.career = gohelper.findChildImage(var_16_0.go, "career")

			local var_16_3 = gohelper.findButtonWithAudio(var_16_0.go)

			arg_16_0:addClickCb(var_16_3, arg_16_0.clickRole, arg_16_0, iter_16_0)
			UISpriteSetMgr.instance:setCommonSprite(var_16_0.rare, "bgequip" .. tostring(CharacterEnum.Color[var_16_2.rare]))
			UISpriteSetMgr.instance:setCommonSprite(var_16_0.career, "lssx_" .. var_16_2.career)

			if var_16_2.type == Activity174Enum.CharacterType.Hero then
				local var_16_4 = ResUrl.getHeadIconSmall(var_16_2.skinId)

				var_16_0.heroIcon:LoadImage(var_16_4)
			else
				local var_16_5 = ResUrl.monsterHeadIcon(var_16_2.skinId)

				var_16_0.heroIcon:LoadImage(var_16_5)
			end
		else
			gohelper.setActive(var_16_0.go, false)
		end

		table.insert(arg_16_0.characterItemList, var_16_0)
	end

	arg_16_0:clickRole(1)
end

function var_0_0.clickRole(arg_17_0, arg_17_1)
	if arg_17_1 == arg_17_0.selectedIndex then
		return
	end

	local var_17_0 = arg_17_0.characterItemList[arg_17_1]
	local var_17_1 = var_17_0 and var_17_0.frame

	if not gohelper.isNil(var_17_1) then
		gohelper.setAsLastSibling(var_17_1)
	end

	arg_17_0.selectedIndex = arg_17_1

	local var_17_2 = arg_17_0.roleIdList[arg_17_1]
	local var_17_3 = Activity174Config.instance:getRoleCo(var_17_2)

	arg_17_0.characterItem:setData(var_17_3)
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.playCloseAnim(arg_19_0)
	if arg_19_0._gocharacterinfo.activeInHierarchy then
		arg_19_0._animCharacter:Play(UIAnimationName.Close)
	end

	if arg_19_0._gocollection.activeInHierarchy then
		arg_19_0._animCollection:Play(UIAnimationName.Close)
	end

	if arg_19_0._gobuff.activeInHierarchy then
		arg_19_0._animBuff:Play(UIAnimationName.Close)
	end
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0.cIcon:UnLoadImage()
	arg_20_0.bIcon:UnLoadImage()
end

return var_0_0
