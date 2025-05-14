module("modules.logic.resonance.view.CharacterTalentUseLayoutView", package.seeall)

local var_0_0 = class("CharacterTalentUseLayoutView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "#txt_tip")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._gocubelayout = gohelper.findChild(arg_1_0.viewGO, "#go_cubelayout")
	arg_1_0._gocurlayout = gohelper.findChild(arg_1_0.viewGO, "#go_cubelayout/#go_curlayout")
	arg_1_0._gosharelayout = gohelper.findChild(arg_1_0.viewGO, "#go_cubelayout/#go_sharelayout")
	arg_1_0._gomeshItem = gohelper.findChild(arg_1_0.viewGO, "#go_cubelayout/#go_meshItem")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "#go_cubelayout/#go_chessitem")
	arg_1_0._goattr = gohelper.findChild(arg_1_0.viewGO, "#go_attr")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_attr/panel/attributeItem/#go_bg")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_attr/panel/attributeItem/#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_attr/panel/attributeItem/#txt_name")
	arg_1_0._txtcur = gohelper.findChildText(arg_1_0.viewGO, "#go_attr/panel/attributeItem/#txt_cur")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_attr/panel/attributeItem/#txt_num")
	arg_1_0._imagechange = gohelper.findChildImage(arg_1_0.viewGO, "#go_attr/panel/attributeItem/#txt_num/#image_change")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_yes")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_no")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_check")
	arg_1_0._txtcube = gohelper.findChildText(arg_1_0.viewGO, "#btn_check/#txt_cube")
	arg_1_0._txtattr = gohelper.findChildText(arg_1_0.viewGO, "#btn_check/#txt_attr")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0._btncheck:RemoveClickListener()
end

function var_0_0._btnyesOnClick(arg_4_0)
	if string.nilorempty(arg_4_0._code) then
		return
	end

	local var_4_0 = arg_4_0._heroMo.useTalentTemplateId
	local var_4_1 = HeroResonaceModel.instance:_isUnlockTalentStyle(arg_4_0._heroMo.heroId, arg_4_0._shareStyle) and arg_4_0._shareStyle or 0

	HeroRpc.instance:setPutTalentCubeBatchRequest(arg_4_0._heroMo.heroId, arg_4_0._shareDataList, var_4_0, var_4_1)
end

function var_0_0._btnnoOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btncheckOnClick(arg_6_0)
	arg_6_0:_activeAttrPanel(not arg_6_0._isShowAttrPanel)
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._addEvents(arg_10_0)
	arg_10_0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_10_0._onUseShareCode, arg_10_0)
end

function var_0_0._removeEvents(arg_11_0)
	arg_11_0:removeEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_11_0._onUseShareCode, arg_11_0)
end

function var_0_0._onUseShareCode(arg_12_0)
	local var_12_0 = HeroResonaceModel.instance:getSpecialCn(arg_12_0._heroMo)

	ToastController.instance:showToast(ToastEnum.CharacterTalentShareCodeSuccessPastedUse, var_12_0)
	arg_12_0:closeThis()
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:_addEvents()
	gohelper.setActive(arg_13_0._txtdesc.gameObject, false)

	arg_13_0._code = arg_13_0.viewParam.code
	arg_13_0._heroMo = arg_13_0.viewParam.heroMo
	arg_13_0._defaultWidth = 56.2
	arg_13_0._defaultSize = 6

	recthelper.setWidth(arg_13_0._gomeshItem.transform, arg_13_0._defaultWidth)
	recthelper.setHeight(arg_13_0._gomeshItem.transform, arg_13_0._defaultWidth)

	if not string.nilorempty(arg_13_0._code) then
		arg_13_0:_showShareLayout()
		arg_13_0:_showUseLayout()
	end

	arg_13_0._attrItems = arg_13_0:getUserDataTb_()
	arg_13_0._attrItemPrefab = gohelper.findChild(arg_13_0.viewGO, "#go_attr/panel/attributeItem")

	arg_13_0:_initAttr()

	local var_13_0 = HeroResonaceModel.instance:getSpecialCn(arg_13_0._heroMo)
	local var_13_1 = luaLang("p_charactertalentuselayoutview_txt_title")

	arg_13_0._txttip.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_13_1, var_13_0)
end

function var_0_0._showShareLayout(arg_14_0)
	arg_14_0._shareDataList, arg_14_0._shareStyle = HeroResonaceModel.instance:decodeLayoutShareCode(arg_14_0._code)

	if not arg_14_0._shareDataList then
		return
	end

	if not arg_14_0._shareCubeItems then
		arg_14_0._shareCubeItems = arg_14_0:getUserDataTb_()
	end

	if not arg_14_0._shareMeshItems then
		arg_14_0._shareMeshItems = arg_14_0:getUserDataTb_()
	end

	arg_14_0._sharemeshObj = gohelper.findChild(arg_14_0._gosharelayout, "mesh")
	arg_14_0._sharecubeObj = gohelper.findChild(arg_14_0._gosharelayout, "cube")

	arg_14_0:_setMesh(1)
	gohelper.CreateObjList(arg_14_0, arg_14_0._onShareCubeItemShow, arg_14_0._shareDataList, arg_14_0._sharecubeObj, arg_14_0._gochessitem)
	arg_14_0:_refreshMeshLine(arg_14_0._shareMeshItems)
end

function var_0_0._showUseLayout(arg_15_0)
	local var_15_0 = arg_15_0._heroMo.talentCubeInfos.data_list

	if not var_15_0 or not arg_15_0._heroMo then
		return
	end

	arg_15_0._usemeshObj = gohelper.findChild(arg_15_0._gocurlayout, "mesh")
	arg_15_0._usecubeObj = gohelper.findChild(arg_15_0._gocurlayout, "cube")

	if not arg_15_0._useCubeItems then
		arg_15_0._useCubeItems = arg_15_0:getUserDataTb_()
	end

	if not arg_15_0._useMeshItems then
		arg_15_0._useMeshItems = arg_15_0:getUserDataTb_()
	end

	arg_15_0:_setMesh(2)
	gohelper.CreateObjList(arg_15_0, arg_15_0._onUseCubeItemShow, var_15_0, arg_15_0._usecubeObj, arg_15_0._gochessitem)
	arg_15_0:_refreshMeshLine(arg_15_0._useMeshItems)
end

function var_0_0._setMesh(arg_16_0, arg_16_1)
	local var_16_0 = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(arg_16_0._heroMo.heroId, arg_16_0._heroMo.talent), ",")
	local var_16_1 = var_16_0[1]
	local var_16_2 = var_16_0[2]
	local var_16_3 = arg_16_1 == 1 and arg_16_0._shareMeshItems or arg_16_0._useMeshItems
	local var_16_4 = arg_16_1 == 1 and arg_16_0._sharemeshObj or arg_16_0._usemeshObj

	if arg_16_1 ~= 1 or not arg_16_0._gosharelayout then
		local var_16_5 = arg_16_0._gocurlayout
	end

	for iter_16_0 = 0, var_16_2 - 1 do
		var_16_3[iter_16_0] = arg_16_0:getUserDataTb_()

		local var_16_6 = var_16_3[iter_16_0]

		if not var_16_6 then
			var_16_6 = arg_16_0:getUserDataTb_()
			var_16_3[iter_16_0] = var_16_6
		end

		for iter_16_1 = 0, var_16_1 - 1 do
			local var_16_7 = var_16_6[iter_16_1]

			if not var_16_7 then
				var_16_7 = arg_16_0:getUserDataTb_()

				local var_16_8 = string.format("mesh_%s_%s", iter_16_1, iter_16_0)
				local var_16_9 = gohelper.clone(arg_16_0._gomeshItem, var_16_4, var_16_8)

				var_16_7.go = var_16_9
				var_16_7.top = gohelper.findChild(var_16_9, "top")
				var_16_7.bottom = gohelper.findChild(var_16_9, "bottom")
				var_16_7.left = gohelper.findChild(var_16_9, "left")
				var_16_7.right = gohelper.findChild(var_16_9, "right")
				var_16_6[iter_16_1] = var_16_7
			end

			local var_16_10 = iter_16_1 - (var_16_1 - 1) / 2
			local var_16_11 = (var_16_2 - 1) / 2 - iter_16_0

			recthelper.setAnchor(var_16_7.go.transform, var_16_10 * arg_16_0._defaultWidth, var_16_11 * arg_16_0._defaultWidth)
			gohelper.setActive(var_16_7.go, true)
		end
	end
end

function var_0_0._onShareCubeItemShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0:_onCubeItemShow(arg_17_1, arg_17_2, arg_17_3, 1)

	if arg_17_0._heroMo.talentCubeInfos.own_main_cube_id == arg_17_2.cubeId and arg_17_0._shareStyle and arg_17_0._shareStyle > 0 then
		local var_17_0, var_17_1 = HeroResonaceModel.instance:_isUnlockTalentStyle(arg_17_0._heroMo.heroId, arg_17_0._shareStyle)

		if not var_17_0 then
			local var_17_2 = TalentStyleModel.instance:getCubeMoByStyle(arg_17_0._heroMo.heroId, 0)
			local var_17_3 = var_17_1 and var_17_1:getStyleTag()
			local var_17_4 = var_17_2 and var_17_2:getStyleTag()
			local var_17_5 = luaLang("character_copy_talentLayout_use_tip")

			arg_17_0._txtdesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_17_5, var_17_3, var_17_4)
		else
			local var_17_6 = tonumber(arg_17_2.cubeId .. arg_17_0._shareStyle)
			local var_17_7 = arg_17_0._shareCubeItems[arg_17_3]

			arg_17_0:_showMainStyleCube(var_17_6, arg_17_2.cubeId, var_17_7)
		end

		gohelper.setActive(arg_17_0._txtdesc.gameObject, not var_17_0)
	end
end

function var_0_0._onUseCubeItemShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0:_onCubeItemShow(arg_18_1, arg_18_2, arg_18_3, 2)

	local var_18_0 = arg_18_0._heroMo.talentCubeInfos.own_main_cube_id
	local var_18_1 = arg_18_0._heroMo:getHeroUseStyleCubeId()

	if arg_18_2.cubeId == var_18_0 and var_18_1 ~= var_18_0 then
		local var_18_2 = arg_18_0._useCubeItems[arg_18_3]

		arg_18_0:_showMainStyleCube(var_18_1, var_18_0, var_18_2)
	end
end

function var_0_0._showMainStyleCube(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = HeroResonanceConfig.instance:getCubeConfig(arg_19_1)

	if not var_19_0 then
		return
	end

	local var_19_1 = var_19_0.icon

	if not string.nilorempty(var_19_1) then
		local var_19_2 = "ky_" .. var_19_1
		local var_19_3 = "mk_" .. var_19_1
		local var_19_4 = var_19_3
		local var_19_5 = HeroResonanceConfig.instance:getCubeConfig(arg_19_2)

		if arg_19_3 then
			UISpriteSetMgr.instance:setCharacterTalentSprite(arg_19_3.image, var_19_2, true)
			UISpriteSetMgr.instance:setCharacterTalentSprite(arg_19_3.icon, var_19_3, true)
			UISpriteSetMgr.instance:setCharacterTalentSprite(arg_19_3.glow_icon, var_19_4, true)

			local var_19_6 = var_19_5 and string.split(var_19_5.icon, "_")

			if var_19_6 then
				local var_19_7 = "gz_" .. var_19_6[#var_19_6]

				UISpriteSetMgr.instance:setCharacterTalentSprite(arg_19_3.cell_icon, var_19_7, true)
				gohelper.setActive(arg_19_3.cell_icon.gameObject, true)
			end
		end
	end
end

function var_0_0._onCubeItemShow(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = arg_20_1.transform
	local var_20_1 = var_20_0:GetComponent(gohelper.Type_Image)
	local var_20_2 = gohelper.findChildImage(arg_20_1, "icon")
	local var_20_3 = gohelper.findChildImage(arg_20_1, "glow")
	local var_20_4 = gohelper.findChildImage(arg_20_1, "cell")
	local var_20_5 = arg_20_4 == 1 and arg_20_0._shareCubeItems or arg_20_0._useCubeItems
	local var_20_6 = arg_20_4 == 1 and arg_20_0._shareMeshItems or arg_20_0._useMeshItems
	local var_20_7 = arg_20_2.cubeId
	local var_20_8 = HeroResonanceConfig.instance:getCubeMatrix(var_20_7)
	local var_20_9 = HeroResonanceConfig.instance:getCubeConfig(var_20_7).icon

	UISpriteSetMgr.instance:setCharacterTalentSprite(var_20_1, "ky_" .. var_20_9, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(var_20_2, var_20_9, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(var_20_3, "glow_" .. var_20_9, true)
	gohelper.setActive(var_20_4.gameObject, false)

	if not var_20_5[arg_20_3] then
		var_20_5[arg_20_3] = arg_20_0:getUserDataTb_()
	end

	local var_20_10 = arg_20_0:getUserDataTb_()

	var_20_10.go = arg_20_1
	var_20_10.image = var_20_1
	var_20_10.icon = var_20_2
	var_20_10.glow_icon = var_20_3
	var_20_10.cell_icon = var_20_4
	var_20_5[arg_20_3] = var_20_10

	local var_20_11 = var_20_6[arg_20_2.posY][arg_20_2.posX]

	if var_20_11 then
		local var_20_12 = var_20_11.go.transform.anchoredPosition.x
		local var_20_13 = var_20_11.go.transform.anchoredPosition.y

		transformhelper.setLocalRotation(var_20_0, 0, 0, -arg_20_2.direction * 90)

		local var_20_14 = arg_20_0._defaultWidth * GameUtil.getTabLen(var_20_8[0])
		local var_20_15 = arg_20_0._defaultWidth * GameUtil.getTabLen(var_20_8)
		local var_20_16 = arg_20_2.direction % 2 == 0
		local var_20_17 = var_20_12 + (var_20_16 and var_20_14 or var_20_15) / 2
		local var_20_18 = var_20_13 + -(var_20_16 and var_20_15 or var_20_14) / 2
		local var_20_19 = var_20_17 - arg_20_0._defaultWidth / 2
		local var_20_20 = var_20_18 + arg_20_0._defaultWidth / 2

		recthelper.setAnchor(var_20_0, var_20_19, var_20_20)
	end

	local var_20_21 = HeroResonaceModel.instance:rotationMatrix(var_20_8, arg_20_2.direction)

	for iter_20_0, iter_20_1 in pairs(var_20_21) do
		for iter_20_2, iter_20_3 in pairs(iter_20_1) do
			if iter_20_3 == 1 and var_20_6[arg_20_2.posY + iter_20_0] then
				local var_20_22 = var_20_6[arg_20_2.posY + iter_20_0][arg_20_2.posX + iter_20_2]

				if var_20_22 then
					var_20_22.data = arg_20_2
				end
			end
		end
	end
end

function var_0_0._refreshMeshLine(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		for iter_21_2, iter_21_3 in pairs(iter_21_1) do
			if not iter_21_3 then
				return
			end

			local var_21_0 = arg_21_1[iter_21_0][iter_21_2 - 1]

			if var_21_0 and iter_21_3.data and iter_21_3.data == var_21_0.data then
				gohelper.setActive(iter_21_3.left, false)
				gohelper.setActive(var_21_0.right, false)
			end

			local var_21_1 = arg_21_1[iter_21_0 - 1] and arg_21_1[iter_21_0 - 1][iter_21_2]

			if var_21_1 and iter_21_3.data and iter_21_3.data == var_21_1.data then
				gohelper.setActive(iter_21_3.top, false)
				gohelper.setActive(var_21_1.bottom, false)
			end

			local var_21_2 = arg_21_1[iter_21_0][iter_21_2 + 1]

			if var_21_2 and iter_21_3.data and iter_21_3.data == var_21_2.data then
				gohelper.setActive(iter_21_3.right, false)
				gohelper.setActive(var_21_2.left, false)
			end

			local var_21_3 = arg_21_1[iter_21_0 + 1] and arg_21_1[iter_21_0 + 1][iter_21_2]

			if var_21_3 and iter_21_3.data and iter_21_3.data == var_21_3.data then
				gohelper.setActive(iter_21_3.bottom, false)
				gohelper.setActive(var_21_3.top, false)
			end
		end
	end
end

function var_0_0._activeAttrPanel(arg_22_0, arg_22_1)
	arg_22_0._isShowAttrPanel = arg_22_1

	gohelper.setActive(arg_22_0._gocubelayout, not arg_22_1)
	gohelper.setActive(arg_22_0._goattr, arg_22_1)
	gohelper.setActive(arg_22_0._txtcube.gameObject, not arg_22_1)
	gohelper.setActive(arg_22_0._txtattr.gameObject, arg_22_1)
end

function var_0_0._initAttr(arg_23_0)
	local var_23_0 = HeroResonaceModel.instance:getShareTalentAttrInfos(arg_23_0._heroMo, arg_23_0._shareDataList, arg_23_0._shareStyle)
	local var_23_1 = math.ceil(#var_23_0 * 0.5)
	local var_23_2 = var_23_1 > 5 and 120 + 20 * (var_23_1 - 5) or 120
	local var_23_3 = math.min(var_23_2, 240)

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		local var_23_4 = arg_23_0:_getAttrItem(iter_23_0)
		local var_23_5 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_23_1.key))
		local var_23_6 = iter_23_1.value or 0
		local var_23_7 = iter_23_1.shareValue or 0

		if var_23_5.type ~= 1 then
			var_23_6 = tonumber(string.format("%.3f", var_23_6 / 10)) .. "%"
			var_23_7 = tonumber(string.format("%.3f", var_23_7 / 10)) .. "%"
		else
			var_23_6 = math.floor(var_23_6)
			var_23_7 = math.floor(var_23_7)
		end

		var_23_4.txtname.text = var_23_5.name
		var_23_4.txtcur.text = var_23_6
		var_23_4.txtnum.text = var_23_7

		local var_23_8 = 0
		local var_23_9 = math.floor(iter_23_1.value)
		local var_23_10 = math.floor(iter_23_1.shareValue)

		if var_23_10 < var_23_9 then
			var_23_8 = 2
		elseif var_23_9 < var_23_10 then
			var_23_8 = 1
		end

		local var_23_11 = HeroResonanceEnum.AttrChange[var_23_8]

		var_23_4.txtnum.color = GameUtil.parseColor(var_23_11.NumColor)

		local var_23_12 = not string.nilorempty(var_23_11.ChangeImage)

		if var_23_12 then
			UISpriteSetMgr.instance:setUiCharacterSprite(var_23_4.imagechange, var_23_11.ChangeImage, true)
		end

		gohelper.setActive(var_23_4.imagechange.gameObject, var_23_12)
		UISpriteSetMgr.instance:setCommonSprite(var_23_4.imageicon, "icon_att_" .. var_23_5.id, true)

		local var_23_13 = (iter_23_0 - 1) % var_23_1

		gohelper.setActive(var_23_4.goBg, var_23_13 % 2 == 1)

		local var_23_14 = iter_23_0 <= var_23_1 and -360 or 360
		local var_23_15 = var_23_3 - var_23_13 * 60

		recthelper.setAnchor(var_23_4.go.transform, var_23_14, var_23_15)
	end

	for iter_23_2 = 1, #arg_23_0._attrItems do
		gohelper.setActive(arg_23_0._attrItems[iter_23_2].go, iter_23_2 <= #var_23_0)
	end

	gohelper.setActive(arg_23_0._attrItemPrefab, false)
	arg_23_0:_activeAttrPanel(false)
end

function var_0_0._getAttrItem(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._attrItems[arg_24_1]

	if not var_24_0 then
		local var_24_1 = gohelper.cloneInPlace(arg_24_0._attrItemPrefab, "item_" .. arg_24_1)

		var_24_0 = arg_24_0:getUserDataTb_()
		var_24_0.go = var_24_1
		var_24_0.goBg = gohelper.findChild(var_24_1, "#go_bg")
		var_24_0.imageicon = gohelper.findChildImage(var_24_1, "#image_icon")
		var_24_0.txtname = gohelper.findChildText(var_24_1, "#txt_name")
		var_24_0.txtcur = gohelper.findChildText(var_24_1, "#txt_cur")
		var_24_0.txtnum = gohelper.findChildText(var_24_1, "#txt_num")
		var_24_0.imagechange = gohelper.findChildImage(var_24_1, "#txt_num/#image_change")
		arg_24_0._attrItems[arg_24_1] = var_24_0
	end

	return var_24_0
end

function var_0_0.onClose(arg_25_0)
	return
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0:_removeEvents()
end

return var_0_0
