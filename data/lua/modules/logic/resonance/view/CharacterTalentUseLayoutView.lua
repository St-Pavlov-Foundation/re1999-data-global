module("modules.logic.resonance.view.CharacterTalentUseLayoutView", package.seeall)

slot0 = class("CharacterTalentUseLayoutView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "#txt_tip")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._gocubelayout = gohelper.findChild(slot0.viewGO, "#go_cubelayout")
	slot0._gocurlayout = gohelper.findChild(slot0.viewGO, "#go_cubelayout/#go_curlayout")
	slot0._gosharelayout = gohelper.findChild(slot0.viewGO, "#go_cubelayout/#go_sharelayout")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "#go_cubelayout/#go_meshItem")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "#go_cubelayout/#go_chessitem")
	slot0._goattr = gohelper.findChild(slot0.viewGO, "#go_attr")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_attr/panel/attributeItem/#go_bg")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_attr/panel/attributeItem/#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_attr/panel/attributeItem/#txt_name")
	slot0._txtcur = gohelper.findChildText(slot0.viewGO, "#go_attr/panel/attributeItem/#txt_cur")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_attr/panel/attributeItem/#txt_num")
	slot0._imagechange = gohelper.findChildImage(slot0.viewGO, "#go_attr/panel/attributeItem/#txt_num/#image_change")
	slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_yes")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_no")
	slot0._btncheck = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_check")
	slot0._txtcube = gohelper.findChildText(slot0.viewGO, "#btn_check/#txt_cube")
	slot0._txtattr = gohelper.findChildText(slot0.viewGO, "#btn_check/#txt_attr")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
	slot0._btncheck:AddClickListener(slot0._btncheckOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
	slot0._btncheck:RemoveClickListener()
end

function slot0._btnyesOnClick(slot0)
	if string.nilorempty(slot0._code) then
		return
	end

	HeroRpc.instance:setPutTalentCubeBatchRequest(slot0._heroMo.heroId, slot0._shareDataList, slot0._heroMo.useTalentTemplateId, HeroResonaceModel.instance:_isUnlockTalentStyle(slot0._heroMo.heroId, slot0._shareStyle) and slot0._shareStyle or 0)
end

function slot0._btnnoOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncheckOnClick(slot0)
	slot0:_activeAttrPanel(not slot0._isShowAttrPanel)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, slot0._onUseShareCode, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, slot0._onUseShareCode, slot0)
end

function slot0._onUseShareCode(slot0)
	ToastController.instance:showToast(ToastEnum.CharacterTalentShareCodeSuccessPastedUse, HeroResonaceModel.instance:getSpecialCn(slot0._heroMo))
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0:_addEvents()
	gohelper.setActive(slot0._txtdesc.gameObject, false)

	slot0._code = slot0.viewParam.code
	slot0._heroMo = slot0.viewParam.heroMo
	slot0._defaultWidth = 56.2
	slot0._defaultSize = 6

	recthelper.setWidth(slot0._gomeshItem.transform, slot0._defaultWidth)
	recthelper.setHeight(slot0._gomeshItem.transform, slot0._defaultWidth)

	if not string.nilorempty(slot0._code) then
		slot0:_showShareLayout()
		slot0:_showUseLayout()
	end

	slot0._attrItems = slot0:getUserDataTb_()
	slot0._attrItemPrefab = gohelper.findChild(slot0.viewGO, "#go_attr/panel/attributeItem")

	slot0:_initAttr()

	slot0._txttip.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("p_charactertalentuselayoutview_txt_title"), HeroResonaceModel.instance:getSpecialCn(slot0._heroMo))
end

function slot0._showShareLayout(slot0)
	slot0._shareDataList, slot0._shareStyle = HeroResonaceModel.instance:decodeLayoutShareCode(slot0._code)

	if not slot0._shareDataList then
		return
	end

	if not slot0._shareCubeItems then
		slot0._shareCubeItems = slot0:getUserDataTb_()
	end

	if not slot0._shareMeshItems then
		slot0._shareMeshItems = slot0:getUserDataTb_()
	end

	slot0._sharemeshObj = gohelper.findChild(slot0._gosharelayout, "mesh")
	slot0._sharecubeObj = gohelper.findChild(slot0._gosharelayout, "cube")

	slot0:_setMesh(1)
	gohelper.CreateObjList(slot0, slot0._onShareCubeItemShow, slot0._shareDataList, slot0._sharecubeObj, slot0._gochessitem)
	slot0:_refreshMeshLine(slot0._shareMeshItems)
end

function slot0._showUseLayout(slot0)
	if not slot0._heroMo.talentCubeInfos.data_list or not slot0._heroMo then
		return
	end

	slot0._usemeshObj = gohelper.findChild(slot0._gocurlayout, "mesh")
	slot0._usecubeObj = gohelper.findChild(slot0._gocurlayout, "cube")

	if not slot0._useCubeItems then
		slot0._useCubeItems = slot0:getUserDataTb_()
	end

	if not slot0._useMeshItems then
		slot0._useMeshItems = slot0:getUserDataTb_()
	end

	slot0:_setMesh(2)
	gohelper.CreateObjList(slot0, slot0._onUseCubeItemShow, slot1, slot0._usecubeObj, slot0._gochessitem)
	slot0:_refreshMeshLine(slot0._useMeshItems)
end

function slot0._setMesh(slot0, slot1)
	slot2 = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(slot0._heroMo.heroId, slot0._heroMo.talent), ",")
	slot3 = slot2[1]
	slot5 = slot1 == 1 and slot0._shareMeshItems or slot0._useMeshItems
	slot6 = slot1 == 1 and slot0._sharemeshObj or slot0._usemeshObj
	slot7 = slot1 == 1 and slot0._gosharelayout or slot0._gocurlayout

	for slot11 = 0, slot2[2] - 1 do
		slot5[slot11] = slot0:getUserDataTb_()

		if not slot5[slot11] then
			slot5[slot11] = slot0:getUserDataTb_()
		end

		for slot16 = 0, slot3 - 1 do
			if not slot12[slot16] then
				slot17 = slot0:getUserDataTb_()
				slot19 = gohelper.clone(slot0._gomeshItem, slot6, string.format("mesh_%s_%s", slot16, slot11))
				slot17.go = slot19
				slot17.top = gohelper.findChild(slot19, "top")
				slot17.bottom = gohelper.findChild(slot19, "bottom")
				slot17.left = gohelper.findChild(slot19, "left")
				slot17.right = gohelper.findChild(slot19, "right")
				slot12[slot16] = slot17
			end

			recthelper.setAnchor(slot17.go.transform, (slot16 - (slot3 - 1) / 2) * slot0._defaultWidth, ((slot4 - 1) / 2 - slot11) * slot0._defaultWidth)
			gohelper.setActive(slot17.go, true)
		end
	end
end

function slot0._onShareCubeItemShow(slot0, slot1, slot2, slot3)
	slot0:_onCubeItemShow(slot1, slot2, slot3, 1)

	if slot0._heroMo.talentCubeInfos.own_main_cube_id == slot2.cubeId and slot0._shareStyle and slot0._shareStyle > 0 then
		slot5, slot6 = HeroResonaceModel.instance:_isUnlockTalentStyle(slot0._heroMo.heroId, slot0._shareStyle)

		if not slot5 then
			slot7 = TalentStyleModel.instance:getCubeMoByStyle(slot0._heroMo.heroId, 0)
			slot0._txtdesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("character_copy_talentLayout_use_tip"), slot6 and slot6:getStyleTag(), slot7 and slot7:getStyleTag())
		else
			slot0:_showMainStyleCube(tonumber(slot2.cubeId .. slot0._shareStyle), slot2.cubeId, slot0._shareCubeItems[slot3])
		end

		gohelper.setActive(slot0._txtdesc.gameObject, not slot5)
	end
end

function slot0._onUseCubeItemShow(slot0, slot1, slot2, slot3)
	slot0:_onCubeItemShow(slot1, slot2, slot3, 2)

	slot5 = slot0._heroMo:getHeroUseStyleCubeId()

	if slot2.cubeId == slot0._heroMo.talentCubeInfos.own_main_cube_id and slot5 ~= slot4 then
		slot0:_showMainStyleCube(slot5, slot4, slot0._useCubeItems[slot3])
	end
end

function slot0._showMainStyleCube(slot0, slot1, slot2, slot3)
	if not HeroResonanceConfig.instance:getCubeConfig(slot1) then
		return
	end

	if not string.nilorempty(slot4.icon) then
		slot9 = HeroResonanceConfig.instance:getCubeConfig(slot2)

		if slot3 then
			UISpriteSetMgr.instance:setCharacterTalentSprite(slot3.image, "ky_" .. slot5, true)
			UISpriteSetMgr.instance:setCharacterTalentSprite(slot3.icon, slot7, true)
			UISpriteSetMgr.instance:setCharacterTalentSprite(slot3.glow_icon, "mk_" .. slot5, true)

			if slot9 and string.split(slot9.icon, "_") then
				UISpriteSetMgr.instance:setCharacterTalentSprite(slot3.cell_icon, "gz_" .. slot10[#slot10], true)
				gohelper.setActive(slot3.cell_icon.gameObject, true)
			end
		end
	end
end

function slot0._onCubeItemShow(slot0, slot1, slot2, slot3, slot4)
	slot11 = slot4 == 1 and slot0._shareMeshItems or slot0._useMeshItems
	slot12 = slot2.cubeId
	slot13 = HeroResonanceConfig.instance:getCubeMatrix(slot12)
	slot14 = HeroResonanceConfig.instance:getCubeConfig(slot12).icon

	UISpriteSetMgr.instance:setCharacterTalentSprite(slot1.transform:GetComponent(gohelper.Type_Image), "ky_" .. slot14, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(gohelper.findChildImage(slot1, "icon"), slot14, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(gohelper.findChildImage(slot1, "glow"), "glow_" .. slot14, true)
	gohelper.setActive(gohelper.findChildImage(slot1, "cell").gameObject, false)

	if not (slot4 == 1 and slot0._shareCubeItems or slot0._useCubeItems)[slot3] then
		slot10[slot3] = slot0:getUserDataTb_()
	end

	slot15 = slot0:getUserDataTb_()
	slot15.go = slot1
	slot15.image = slot6
	slot15.icon = slot7
	slot15.glow_icon = slot8
	slot15.cell_icon = slot9
	slot10[slot3] = slot15

	if slot11[slot2.posY][slot2.posX] then
		transformhelper.setLocalRotation(slot5, 0, 0, -slot2.direction * 90)

		slot19 = slot0._defaultWidth * GameUtil.getTabLen(slot13[0])
		slot20 = slot0._defaultWidth * GameUtil.getTabLen(slot13)
		slot21 = slot2.direction % 2 == 0

		recthelper.setAnchor(slot5, slot16.go.transform.anchoredPosition.x + (slot21 and slot19 or slot20) / 2 - slot0._defaultWidth / 2, slot16.go.transform.anchoredPosition.y + -(slot21 and slot20 or slot19) / 2 + slot0._defaultWidth / 2)
	end

	for slot21, slot22 in pairs(HeroResonaceModel.instance:rotationMatrix(slot13, slot2.direction)) do
		for slot26, slot27 in pairs(slot22) do
			if slot27 == 1 and slot11[slot2.posY + slot21] and slot11[slot2.posY + slot21][slot2.posX + slot26] then
				slot28.data = slot2
			end
		end
	end
end

function slot0._refreshMeshLine(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in pairs(slot1) do
		for slot10, slot11 in pairs(slot6) do
			if not slot11 then
				return
			end

			if slot1[slot5][slot10 - 1] and slot11.data and slot11.data == slot12.data then
				gohelper.setActive(slot11.left, false)
				gohelper.setActive(slot12.right, false)
			end

			if slot1[slot5 - 1] and slot1[slot5 - 1][slot10] and slot11.data and slot11.data == slot13.data then
				gohelper.setActive(slot11.top, false)
				gohelper.setActive(slot13.bottom, false)
			end

			if slot1[slot5][slot10 + 1] and slot11.data and slot11.data == slot14.data then
				gohelper.setActive(slot11.right, false)
				gohelper.setActive(slot14.left, false)
			end

			if slot1[slot5 + 1] and slot1[slot5 + 1][slot10] and slot11.data and slot11.data == slot15.data then
				gohelper.setActive(slot11.bottom, false)
				gohelper.setActive(slot15.top, false)
			end
		end
	end
end

function slot0._activeAttrPanel(slot0, slot1)
	slot0._isShowAttrPanel = slot1

	gohelper.setActive(slot0._gocubelayout, not slot1)
	gohelper.setActive(slot0._goattr, slot1)
	gohelper.setActive(slot0._txtcube.gameObject, not slot1)
	gohelper.setActive(slot0._txtattr.gameObject, slot1)
end

function slot0._initAttr(slot0)
	slot3 = math.min(math.ceil(#HeroResonaceModel.instance:getShareTalentAttrInfos(slot0._heroMo, slot0._shareDataList, slot0._shareStyle) * 0.5) > 5 and 120 + 20 * (slot2 - 5) or 120, 240)

	for slot7, slot8 in ipairs(slot1) do
		slot9 = slot0:_getAttrItem(slot7)

		if HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot8.key)).type ~= 1 then
			slot11 = tonumber(string.format("%.3f", (slot8.value or 0) / 10)) .. "%"
			slot12 = tonumber(string.format("%.3f", (slot8.shareValue or 0) / 10)) .. "%"
		else
			slot11 = math.floor(slot11)
			slot12 = math.floor(slot12)
		end

		slot9.txtname.text = slot10.name
		slot9.txtcur.text = slot11
		slot9.txtnum.text = slot12
		slot13 = 0

		if math.floor(slot8.shareValue) < math.floor(slot8.value) then
			slot13 = 2
		elseif slot14 < slot15 then
			slot13 = 1
		end

		slot16 = HeroResonanceEnum.AttrChange[slot13]
		slot9.txtnum.color = GameUtil.parseColor(slot16.NumColor)

		if not string.nilorempty(slot16.ChangeImage) then
			UISpriteSetMgr.instance:setUiCharacterSprite(slot9.imagechange, slot16.ChangeImage, true)
		end

		gohelper.setActive(slot9.imagechange.gameObject, slot17)
		UISpriteSetMgr.instance:setCommonSprite(slot9.imageicon, "icon_att_" .. slot10.id, true)
		gohelper.setActive(slot9.goBg, (slot7 - 1) % slot2 % 2 == 1)
		recthelper.setAnchor(slot9.go.transform, slot7 <= slot2 and -360 or 360, slot3 - slot18 * 60)
	end

	for slot7 = 1, #slot0._attrItems do
		gohelper.setActive(slot0._attrItems[slot7].go, slot7 <= #slot1)
	end

	gohelper.setActive(slot0._attrItemPrefab, false)
	slot0:_activeAttrPanel(false)
end

function slot0._getAttrItem(slot0, slot1)
	if not slot0._attrItems[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._attrItemPrefab, "item_" .. slot1)
		slot2 = slot0:getUserDataTb_()
		slot2.go = slot3
		slot2.goBg = gohelper.findChild(slot3, "#go_bg")
		slot2.imageicon = gohelper.findChildImage(slot3, "#image_icon")
		slot2.txtname = gohelper.findChildText(slot3, "#txt_name")
		slot2.txtcur = gohelper.findChildText(slot3, "#txt_cur")
		slot2.txtnum = gohelper.findChildText(slot3, "#txt_num")
		slot2.imagechange = gohelper.findChildImage(slot3, "#txt_num/#image_change")
		slot0._attrItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
end

return slot0
