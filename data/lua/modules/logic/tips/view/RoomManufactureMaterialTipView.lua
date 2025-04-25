module("modules.logic.tips.view.RoomManufactureMaterialTipView", package.seeall)

slot0 = class("RoomManufactureMaterialTipView", BaseView)

function slot0.onInitView(slot0)
	if GMController.instance:getGMNode("materialtipview", slot0.viewGO) then
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

	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._imagequality = gohelper.findChildImage(slot0.viewGO, "iconbg/#image_quality")
	slot0._simagepropicon = gohelper.findChildSingleImage(slot0.viewGO, "iconbg/#simage_propicon")
	slot0._gohadnumber = gohelper.findChild(slot0.viewGO, "iconbg/#go_hadnumber")
	slot0._txthadnumber = gohelper.findChildText(slot0.viewGO, "iconbg/#go_hadnumber/#txt_hadnumber")
	slot0._txtpropname = gohelper.findChildText(slot0.viewGO, "#txt_propname")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._jumpItemParent = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content/jumpItemLayout")
	slot0._gojumpItem = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content/jumpItemLayout/#go_jumpItem")
	slot0._txtdec1 = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#txt_dec1")
	slot0._txtdec2 = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#txt_dec2")
	slot0._gosource = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content/#go_source")
	slot0._txtsource = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#go_source/#txt_source")
	slot0._txtWrongTip = gohelper.findChildText(slot0.viewGO, "#txt_wrongJump")
	slot0._btnWrongJump = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#txt_wrongJump/#btn_wrongJump")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	if slot0._gogm then
		slot0._btnone:AddClickListener(slot0._btnGMClick, slot0, 1)
		slot0._btnten:AddClickListener(slot0._btnGMClick, slot0, 10)
		slot0._btnhundred:AddClickListener(slot0._btnGMClick, slot0, 100)
		slot0._btnthousand:AddClickListener(slot0._btnGMClick, slot0, 1000)
		slot0._btntenthousand:AddClickListener(slot0._btnGMClick, slot0, 10000)
		slot0._btntenmillion:AddClickListener(slot0._btnGMClick, slot0, 10000000)
		slot0._btninput:AddClickListener(slot0._btninputOnClick, slot0)
	end

	slot0._btnWrongJump:AddClickListener(slot0._btnwrongjumpOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChange, slot0)
end

function slot0.removeEvents(slot0)
	if slot0._gogm then
		slot0._btnone:RemoveClickListener()
		slot0._btnten:RemoveClickListener()
		slot0._btnhundred:RemoveClickListener()
		slot0._btnthousand:RemoveClickListener()
		slot0._btntenthousand:RemoveClickListener()
		slot0._btntenmillion:RemoveClickListener()
		slot0._btninput:RemoveClickListener()
	end

	slot0._btnWrongJump:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChange, slot0)
end

function slot0._btnGMClick(slot0, slot1)
	slot0:sendGMRequest(slot1)
end

function slot0._btninputOnClick(slot0)
	slot1 = CommonInputMO.New()
	slot1.title = "请输入增加道具数量！"
	slot1.defaultInput = "Enter Item Num"

	function slot1.sureCallback(slot0)
		GameFacade.closeInputBox()

		if tonumber(slot0) and slot1 > 0 then
			uv0:sendGMRequest(slot1)
		end
	end

	GameFacade.openInputBox(slot1)
end

function slot0.sendGMRequest(slot0, slot1)
	GameFacade.showToast(ToastEnum.GMTool5, slot0.viewParam.id)

	if slot0.viewParam.type == MaterialEnum.MaterialType.Item and slot0.viewParam.id == 510001 then
		GMRpc.instance:sendGMRequest(string.format("add heroStoryTicket %d", slot1))
	else
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", slot0.viewParam.type, slot0.viewParam.id, slot1))
	end
end

function slot0._btnwrongjumpOnClick(slot0)
	if not slot0.isWrong then
		return
	end

	if slot0.wrongBuildingUid then
		ManufactureController.instance:jumpToManufactureBuildingLevelUpView(slot0.wrongBuildingUid)
	else
		ManufactureController.instance:jump2PlaceManufactureBuildingView()
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._onItemChange(slot0)
	slot0:refreshItemQuantity()
end

function slot0.jumpBtnOnClick(slot0, slot1)
	if not slot0.jumpItemList[slot1] then
		return
	end

	if slot2.cantJumpTips then
		GameFacade.showToastWithTableParam(slot2.cantJumpTips, slot2.cantJumpParam)

		return
	end

	if not slot0.canJump then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
		NavigateButtonsView.homeClick()

		return
	end

	JumpController.instance:dispatchEvent(JumpEvent.JumpBtnClick, slot2.jumpId)
	GameFacade.jump(slot2.jumpId, slot0._onJumpFinish, slot0, slot0.viewParam.recordFarmItem)
end

function slot0._onJumpFinish(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	if slot0._gogm then
		gohelper.setActive(slot0._gogm, GMController.instance:isOpenGM())
	end

	slot0._txtsource.text = luaLang("materialview_source")
	slot0.jumpItemList = {}
end

function slot0.onUpdateParam(slot0)
	slot0.type = nil
	slot0.id = nil

	if slot0.viewParam then
		slot0.type = slot0.viewParam.type
		slot0.id = slot0.viewParam.id
		slot0.canJump = slot0.viewParam.canJump
	end

	slot0:setItem()
	slot0:setJumpItems()

	slot0._scrolldesc.verticalNormalizedPosition = 1
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
end

function slot0.setItem(slot0)
	slot0.config, slot0.icon = ItemModel.instance:getItemConfigAndIcon(slot0.type, slot0.id)
	slot0._txtpropname.text = slot0.config.name
	slot0._txtdec1.text = slot0.config.useDesc
	slot0._txtdec2.text = slot0.config.desc

	slot0._simagepropicon:LoadImage(slot0.icon)
	UISpriteSetMgr.instance:setCritterSprite(slot0._imagequality, "critter_manufacture_itemquality" .. slot0.config.rare)

	if slot0._txtmattip then
		slot0._txtmattip.text = tostring(slot0.type) .. "#" .. tostring(slot0.id)
	end

	slot0:refreshItemQuantity()
	slot0:checkWrong()
end

function slot0.checkWrong(slot0)
	slot0.isWrong = false
	slot0.wrongBuildingUid = nil

	if ManufactureConfig.instance:getManufactureItemListByItemId(slot0.id)[1] then
		if ManufactureController.instance:checkPlaceProduceBuilding(slot2) then
			slot4, slot5, slot6 = ManufactureController.instance:checkProduceBuildingLevel(slot2)

			if slot4 then
				slot7 = ""

				if RoomMapBuildingModel.instance:getBuildingMOById(slot5) then
					slot7 = slot8.config.useDesc
				end

				slot0._txtWrongTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_upgrade_building_unlock"), slot7, slot6)
				slot0.wrongBuildingUid = slot5
				slot0.isWrong = true
			end
		else
			slot4 = ""

			if RoomConfig.instance:getBuildingConfig(ManufactureConfig.instance:getManufactureItemBelongBuildingList(slot2)[1]) then
				slot4 = slot6.useDesc
			end

			slot0._txtWrongTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_place_building_to_unlock"), slot4)
			slot0.isWrong = true
		end
	end

	gohelper.setActive(slot0._txtWrongTip, slot0.isWrong)
end

function slot0.refreshItemQuantity(slot0)
	slot1 = ItemModel.instance:getItemQuantity(slot0.type, slot0.id) or 0

	if ManufactureConfig.instance:getManufactureItemListByItemId(slot0.id)[1] then
		slot1 = ManufactureModel.instance:getManufactureItemCount(slot3)
	end

	slot0._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", tostring(GameUtil.numberDisplay(slot1)))
end

function slot0.setJumpItems(slot0)
	slot1 = {}

	if not string.nilorempty(slot0.config.sources) then
		for slot7, slot8 in ipairs(string.split(slot2, "|")) do
			slot9 = string.splitToNumber(slot8, "#")
			slot10 = {
				sourceId = slot9[1],
				probability = slot9[2]
			}
			slot10.episodeId = JumpConfig.instance:getJumpEpisodeId(slot10.sourceId)

			if JumpConfig.instance:isOpenJumpId(slot10.sourceId) and (slot10.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(slot10.episodeId)) then
				table.insert(slot1, slot10)
			end
		end
	end

	gohelper.CreateObjList(slot0, slot0._onSetJumpItem, slot1, slot0._jumpItemParent, slot0._gojumpItem)
	gohelper.setActive(slot0._gosource, #slot1 > 0)
end

function slot0._onSetJumpItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.indexText = gohelper.findChildText(slot1, "indexText")
	slot4.originText = gohelper.findChildText(slot1, "layout/originText")
	slot4.jumpHardTagGO = gohelper.findChild(slot1, "layout/hardtag")
	slot4.probabilityBg = gohelper.findChild(slot1, "layout/bg")
	slot4.txtProbability = gohelper.findChildText(slot1, "layout/bg/probality")
	slot4.hasJump = gohelper.findChild(slot1, "jump")
	slot4.jumpBgGO = gohelper.findChild(slot1, "jump/bg")
	slot4.jumpBtn = gohelper.findChildButtonWithAudio(slot1, "jump/jumpBtn")
	slot4.jumpText = gohelper.findChildText(slot1, "jump/jumpBtn/jumpText")
	slot4.jumpText.text = luaLang("p_materialtip_jump")

	slot4.jumpBtn:AddClickListener(slot0.jumpBtnOnClick, slot0, slot3)

	slot4.data = slot2
	slot4.jumpId = slot2.sourceId

	if JumpConfig.instance:getJumpConfig(slot4.jumpId) then
		slot6, slot7 = nil

		if string.nilorempty(slot5.param) then
			slot6 = slot5.name
		else
			slot6, slot7 = JumpConfig.instance:getJumpName(slot4.jumpId, "#D0AB74")
		end

		slot4.originText.text = slot6 or ""
		slot4.indexText.text = slot7 or ""
		slot8 = slot4.data.episodeId

		gohelper.setActive(slot4.jumpHardTagGO, JumpConfig.instance:isJumpHardDungeon(slot8))

		slot9 = slot4.data.probability
		slot10 = slot8 and slot9 and MaterialEnum.JumpProbabilityDisplay[slot9]
		slot4.txtProbability.text = slot10 and string.format("%s", luaLang(MaterialEnum.JumpProbabilityDisplay[slot9])) or ""

		gohelper.setActive(slot4.probabilityBg, slot10 and true or false)
		gohelper.setActive(slot4.hasJump, not JumpController.instance:isOnlyShowJump(slot4.jumpId))

		if JumpController.instance:isJumpOpen(slot4.jumpId) then
			slot4.cantJumpTips, slot4.cantJumpParam = JumpController.instance:cantJump(slot5.param)
		else
			slot4.cantJumpTips, slot4.cantJumpParam = OpenHelper.getToastIdAndParam(slot5.openId)
		end

		ZProj.UGUIHelper.SetGrayscale(slot4.jumpText.gameObject, slot4.cantJumpTips)
		ZProj.UGUIHelper.SetGrayscale(slot4.jumpBgGO, slot4.cantJumpTips)
	else
		gohelper.setActive(slot4.go, false)
	end

	slot0.jumpItemList[slot3] = slot4
end

function slot0.onClose(slot0)
	slot0._simagepropicon:UnLoadImage()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.jumpItemList) do
		slot5.jumpBtn:RemoveClickListener()
	end
end

return slot0
