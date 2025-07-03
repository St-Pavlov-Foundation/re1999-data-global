module("modules.logic.tips.view.RoomManufactureMaterialTipView", package.seeall)

local var_0_0 = class("RoomManufactureMaterialTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = GMController.instance:getGMNode("materialtipview", arg_1_0.viewGO)

	if var_1_0 then
		arg_1_0._gogm = gohelper.findChild(var_1_0, "#go_gm")
		arg_1_0._txtmattip = gohelper.findChildText(var_1_0, "#go_gm/bg/#txt_mattip")
		arg_1_0._btnone = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_one")
		arg_1_0._btnten = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_ten")
		arg_1_0._btnhundred = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_hundred")
		arg_1_0._btnthousand = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_thousand")
		arg_1_0._btntenthousand = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_tenthousand")
		arg_1_0._btntenmillion = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_tenmillion")
		arg_1_0._btninput = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_input")
	end

	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._imagequality = gohelper.findChildImage(arg_1_0.viewGO, "iconbg/#image_quality")
	arg_1_0._simagepropicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "iconbg/#simage_propicon")
	arg_1_0._gohadnumber = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_hadnumber")
	arg_1_0._txthadnumber = gohelper.findChildText(arg_1_0.viewGO, "iconbg/#go_hadnumber/#txt_hadnumber")
	arg_1_0._txtpropname = gohelper.findChildText(arg_1_0.viewGO, "#txt_propname")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._jumpItemParent = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/viewport/content/jumpItemLayout")
	arg_1_0._gojumpItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/viewport/content/jumpItemLayout/#go_jumpItem")
	arg_1_0._txtdec1 = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/viewport/content/#txt_dec1")
	arg_1_0._txtdec2 = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/viewport/content/#txt_dec2")
	arg_1_0._gosource = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_source")
	arg_1_0._txtsource = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_source/#txt_source")
	arg_1_0._txtWrongTip = gohelper.findChildText(arg_1_0.viewGO, "#txt_wrongJump")
	arg_1_0._btnWrongJump = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#txt_wrongJump/#btn_wrongJump")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if arg_2_0._gogm then
		arg_2_0._btnone:AddClickListener(arg_2_0._btnGMClick, arg_2_0, 1)
		arg_2_0._btnten:AddClickListener(arg_2_0._btnGMClick, arg_2_0, 10)
		arg_2_0._btnhundred:AddClickListener(arg_2_0._btnGMClick, arg_2_0, 100)
		arg_2_0._btnthousand:AddClickListener(arg_2_0._btnGMClick, arg_2_0, 1000)
		arg_2_0._btntenthousand:AddClickListener(arg_2_0._btnGMClick, arg_2_0, 10000)
		arg_2_0._btntenmillion:AddClickListener(arg_2_0._btnGMClick, arg_2_0, 10000000)
		arg_2_0._btninput:AddClickListener(arg_2_0._btninputOnClick, arg_2_0)
	end

	arg_2_0._btnWrongJump:AddClickListener(arg_2_0._btnwrongjumpOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._gogm then
		arg_3_0._btnone:RemoveClickListener()
		arg_3_0._btnten:RemoveClickListener()
		arg_3_0._btnhundred:RemoveClickListener()
		arg_3_0._btnthousand:RemoveClickListener()
		arg_3_0._btntenthousand:RemoveClickListener()
		arg_3_0._btntenmillion:RemoveClickListener()
		arg_3_0._btninput:RemoveClickListener()
	end

	arg_3_0._btnWrongJump:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChange, arg_3_0)
end

function var_0_0._btnGMClick(arg_4_0, arg_4_1)
	arg_4_0:sendGMRequest(arg_4_1)
end

function var_0_0._btninputOnClick(arg_5_0)
	local var_5_0 = CommonInputMO.New()

	var_5_0.title = "请输入增加道具数量！"
	var_5_0.defaultInput = "Enter Item Num"

	function var_5_0.sureCallback(arg_6_0)
		GameFacade.closeInputBox()

		local var_6_0 = tonumber(arg_6_0)

		if var_6_0 and var_6_0 > 0 then
			arg_5_0:sendGMRequest(var_6_0)
		end
	end

	GameFacade.openInputBox(var_5_0)
end

function var_0_0.sendGMRequest(arg_7_0, arg_7_1)
	GameFacade.showToast(ToastEnum.GMTool5, arg_7_0.viewParam.id)

	if arg_7_0.viewParam.type == MaterialEnum.MaterialType.Item and arg_7_0.viewParam.id == 510001 then
		GMRpc.instance:sendGMRequest(string.format("add heroStoryTicket %d", arg_7_1))
	else
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", arg_7_0.viewParam.type, arg_7_0.viewParam.id, arg_7_1))
	end
end

function var_0_0._btnwrongjumpOnClick(arg_8_0)
	if not arg_8_0.isWrong then
		return
	end

	if arg_8_0.wrongBuildingUid then
		ManufactureController.instance:jumpToManufactureBuildingLevelUpView(arg_8_0.wrongBuildingUid)
	else
		ManufactureController.instance:jump2PlaceManufactureBuildingView()
	end
end

function var_0_0._btncloseOnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._onItemChange(arg_10_0)
	arg_10_0:refreshItemQuantity()
end

function var_0_0.jumpBtnOnClick(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.jumpItemList[arg_11_1]

	if not var_11_0 then
		return
	end

	if var_11_0.cantJumpTips then
		GameFacade.showToastWithTableParam(var_11_0.cantJumpTips, var_11_0.cantJumpParam)

		return
	end

	if not arg_11_0.canJump then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
		NavigateButtonsView.homeClick()

		return
	end

	JumpController.instance:dispatchEvent(JumpEvent.JumpBtnClick, var_11_0.jumpId)
	GameFacade.jump(var_11_0.jumpId, arg_11_0._onJumpFinish, arg_11_0, arg_11_0.viewParam.recordFarmItem)
end

function var_0_0._onJumpFinish(arg_12_0)
	arg_12_0:closeThis()
end

function var_0_0._editableInitView(arg_13_0)
	if arg_13_0._gogm then
		gohelper.setActive(arg_13_0._gogm, GMController.instance:isOpenGM())
	end

	arg_13_0._txtsource.text = luaLang("materialview_source")
	arg_13_0.jumpItemList = {}
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0.type = nil
	arg_14_0.id = nil

	if arg_14_0.viewParam then
		arg_14_0.type = arg_14_0.viewParam.type
		arg_14_0.id = arg_14_0.viewParam.id
		arg_14_0.canJump = arg_14_0.viewParam.canJump
	end

	arg_14_0:setItem()
	arg_14_0:setJumpItems()

	arg_14_0._scrolldesc.verticalNormalizedPosition = 1
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:onUpdateParam()
end

function var_0_0.setItem(arg_16_0)
	arg_16_0.config, arg_16_0.icon = ItemModel.instance:getItemConfigAndIcon(arg_16_0.type, arg_16_0.id)
	arg_16_0._txtpropname.text = arg_16_0.config.name
	arg_16_0._txtdec1.text = arg_16_0.config.useDesc
	arg_16_0._txtdec2.text = arg_16_0.config.desc

	arg_16_0._simagepropicon:LoadImage(arg_16_0.icon)

	local var_16_0 = arg_16_0.config.rare

	UISpriteSetMgr.instance:setCritterSprite(arg_16_0._imagequality, "critter_manufacture_itemquality" .. var_16_0)

	if arg_16_0._txtmattip then
		arg_16_0._txtmattip.text = tostring(arg_16_0.type) .. "#" .. tostring(arg_16_0.id)
	end

	arg_16_0:refreshItemQuantity()
	arg_16_0:checkWrong()
end

function var_0_0.checkWrong(arg_17_0)
	arg_17_0.isWrong = false
	arg_17_0.wrongBuildingUid = nil

	local var_17_0 = ManufactureConfig.instance:getManufactureItemListByItemId(arg_17_0.id)[1]

	if var_17_0 then
		if ManufactureController.instance:checkPlaceProduceBuilding(var_17_0) then
			local var_17_1, var_17_2, var_17_3 = ManufactureController.instance:checkProduceBuildingLevel(var_17_0)

			if var_17_1 then
				local var_17_4 = ""
				local var_17_5 = RoomMapBuildingModel.instance:getBuildingMOById(var_17_2)

				if var_17_5 then
					var_17_4 = var_17_5.config.useDesc
				end

				local var_17_6 = luaLang("room_upgrade_building_unlock")

				arg_17_0._txtWrongTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_17_6, var_17_4, var_17_3)
				arg_17_0.wrongBuildingUid = var_17_2
				arg_17_0.isWrong = true
			end
		else
			local var_17_7 = ""
			local var_17_8 = ManufactureConfig.instance:getManufactureItemBelongBuildingList(var_17_0)
			local var_17_9 = RoomConfig.instance:getBuildingConfig(var_17_8[1])

			if var_17_9 then
				var_17_7 = var_17_9.useDesc
			end

			local var_17_10 = luaLang("room_place_building_to_unlock")

			arg_17_0._txtWrongTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_17_10, var_17_7)
			arg_17_0.isWrong = true
		end
	end

	gohelper.setActive(arg_17_0._txtWrongTip, arg_17_0.isWrong)
end

function var_0_0.refreshItemQuantity(arg_18_0)
	local var_18_0 = ItemModel.instance:getItemQuantity(arg_18_0.type, arg_18_0.id) or 0
	local var_18_1 = ManufactureConfig.instance:getManufactureItemListByItemId(arg_18_0.id)[1]

	if var_18_1 then
		var_18_0 = ManufactureModel.instance:getManufactureItemCount(var_18_1)
	end

	local var_18_2 = tostring(GameUtil.numberDisplay(var_18_0))

	arg_18_0._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", var_18_2)
end

function var_0_0.setJumpItems(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = arg_19_0.config.sources

	if not string.nilorempty(var_19_1) then
		local var_19_2 = string.split(var_19_1, "|")

		for iter_19_0, iter_19_1 in ipairs(var_19_2) do
			local var_19_3 = string.splitToNumber(iter_19_1, "#")
			local var_19_4 = {
				sourceId = var_19_3[1],
				probability = var_19_3[2]
			}

			var_19_4.episodeId = JumpConfig.instance:getJumpEpisodeId(var_19_4.sourceId)

			local var_19_5 = JumpConfig.instance:isOpenJumpId(var_19_4.sourceId)
			local var_19_6 = var_19_4.probability ~= MaterialEnum.JumpProbability.Normal
			local var_19_7 = DungeonModel.instance:hasPassLevel(var_19_4.episodeId)

			if var_19_5 and (var_19_6 or not var_19_7) then
				table.insert(var_19_0, var_19_4)
			end
		end
	end

	gohelper.CreateObjList(arg_19_0, arg_19_0._onSetJumpItem, var_19_0, arg_19_0._jumpItemParent, arg_19_0._gojumpItem)
	gohelper.setActive(arg_19_0._gosource, #var_19_0 > 0)
end

function var_0_0._onSetJumpItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0:getUserDataTb_()

	var_20_0.go = arg_20_1
	var_20_0.indexText = gohelper.findChildText(arg_20_1, "indexText")
	var_20_0.originText = gohelper.findChildText(arg_20_1, "layout/originText")
	var_20_0.jumpHardTagGO = gohelper.findChild(arg_20_1, "layout/hardtag")
	var_20_0.probabilityBg = gohelper.findChild(arg_20_1, "layout/bg")
	var_20_0.txtProbability = gohelper.findChildText(arg_20_1, "layout/bg/probality")
	var_20_0.hasJump = gohelper.findChild(arg_20_1, "jump")
	var_20_0.jumpBgGO = gohelper.findChild(arg_20_1, "jump/bg")
	var_20_0.jumpBtn = gohelper.findChildButtonWithAudio(arg_20_1, "jump/jumpBtn")
	var_20_0.jumpText = gohelper.findChildText(arg_20_1, "jump/jumpBtn/jumpText")
	var_20_0.jumpText.text = luaLang("p_materialtip_jump")

	var_20_0.jumpBtn:AddClickListener(arg_20_0.jumpBtnOnClick, arg_20_0, arg_20_3)

	var_20_0.data = arg_20_2
	var_20_0.jumpId = arg_20_2.sourceId

	local var_20_1 = JumpConfig.instance:getJumpConfig(var_20_0.jumpId)

	if var_20_1 then
		local var_20_2
		local var_20_3

		if string.nilorempty(var_20_1.param) then
			var_20_2 = var_20_1.name
		else
			var_20_2, var_20_3 = JumpConfig.instance:getJumpName(var_20_0.jumpId, "#D0AB74")
		end

		var_20_0.originText.text = var_20_2 or ""
		var_20_0.indexText.text = var_20_3 or ""

		local var_20_4 = var_20_0.data.episodeId

		gohelper.setActive(var_20_0.jumpHardTagGO, JumpConfig.instance:isJumpHardDungeon(var_20_4))

		local var_20_5 = var_20_0.data.probability
		local var_20_6 = var_20_4 and var_20_5 and MaterialEnum.JumpProbabilityDisplay[var_20_5]
		local var_20_7 = ""

		if var_20_6 then
			local var_20_8 = luaLang(MaterialEnum.JumpProbabilityDisplay[var_20_5])
		end

		var_20_0.txtProbability.text = var_20_5

		gohelper.setActive(var_20_0.probabilityBg, var_20_6 and true or false)

		local var_20_9 = JumpController.instance:isOnlyShowJump(var_20_0.jumpId)

		gohelper.setActive(var_20_0.hasJump, not var_20_9)

		if JumpController.instance:isJumpOpen(var_20_0.jumpId) then
			var_20_0.cantJumpTips, var_20_0.cantJumpParam = JumpController.instance:cantJump(var_20_1.param)
		else
			var_20_0.cantJumpTips, var_20_0.cantJumpParam = OpenHelper.getToastIdAndParam(var_20_1.openId)
		end

		ZProj.UGUIHelper.SetGrayscale(var_20_0.jumpText.gameObject, var_20_0.cantJumpTips)
		ZProj.UGUIHelper.SetGrayscale(var_20_0.jumpBgGO, var_20_0.cantJumpTips)
	else
		gohelper.setActive(var_20_0.go, false)
	end

	arg_20_0.jumpItemList[arg_20_3] = var_20_0
end

function var_0_0.onClose(arg_21_0)
	arg_21_0._simagepropicon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.jumpItemList) do
		iter_22_1.jumpBtn:RemoveClickListener()
	end
end

return var_0_0
