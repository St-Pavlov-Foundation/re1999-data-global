module("modules.logic.equip.view.EquipInfoView", package.seeall)

local var_0_0 = class("EquipInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._txtcurlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_progress/#txt_curlevel")
	arg_1_0._txttotallevel = gohelper.findChildText(arg_1_0.viewGO, "#go_progress/#txt_curlevel/#txt_totallevel")
	arg_1_0._goinsigt = gohelper.findChild(arg_1_0.viewGO, "#go_progress/#txt_curlevel/go_insigt")
	arg_1_0._image1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_1")
	arg_1_0._image2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_2")
	arg_1_0._image3 = gohelper.findChildImage(arg_1_0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_3")
	arg_1_0._image4 = gohelper.findChildImage(arg_1_0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_4")
	arg_1_0._image5 = gohelper.findChildImage(arg_1_0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_5")
	arg_1_0._imagelock = gohelper.findChildImage(arg_1_0.viewGO, "#go_progress/#image_lock")
	arg_1_0._goType = gohelper.findChild(arg_1_0.viewGO, "layout/type")
	arg_1_0._goTypeItem = gohelper.findChild(arg_1_0.viewGO, "layout/type/#go_typeItem")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "layout/attribute")
	arg_1_0._gostrengthenattr = gohelper.findChild(arg_1_0.viewGO, "layout/attribute/container/#go_strengthenattr")
	arg_1_0._gobreakeffect = gohelper.findChild(arg_1_0.viewGO, "layout/attribute/container/#go_breakeffect")
	arg_1_0._goSkill = gohelper.findChild(arg_1_0.viewGO, "layout/#go_skill")
	arg_1_0._txtattributelv = gohelper.findChildText(arg_1_0.viewGO, "layout/#go_skill/attributename/#txt_attributelv")
	arg_1_0._goSkillContainer = gohelper.findChild(arg_1_0.viewGO, "layout/#go_skill")
	arg_1_0._goSkillItem = gohelper.findChild(arg_1_0.viewGO, "layout/#go_skill/#scroll_desccontainer/Viewport/#go_skillContainer/#go_SkillItem")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._btnmaxlevel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_maxlevel")
	arg_1_0._imagemaxleveltip = gohelper.findChildImage(arg_1_0.viewGO, "#btn_maxlevel")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmaxlevel:AddClickListener(arg_2_0._onClickMaxLevelBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmaxlevel:RemoveClickListener()
end

function var_0_0._onClickMaxLevelBtn(arg_4_0)
	arg_4_0._showMax = not arg_4_0._showMax

	arg_4_0._animator:Play("switch", 0, 0)
	arg_4_0:refreshMaxLevelImage(0)

	if arg_4_0._hadEquip then
		if arg_4_0._showMax then
			arg_4_0._equipMO = EquipHelper.createMaxLevelEquipMo(arg_4_0._equipId, arg_4_0._equipMO.id)
		else
			arg_4_0._equipMO = arg_4_0.viewContainer.viewParam.equipMO
		end
	elseif arg_4_0._showMax then
		arg_4_0._equipMO = EquipHelper.createMaxLevelEquipMo(arg_4_0._equipId)
	else
		arg_4_0._equipMO = EquipHelper.createMinLevelEquipMo(arg_4_0._equipId)
	end

	arg_4_0:refreshUI()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.strengthenAttrItemList = {}
	arg_5_0.tagItemList = {}
	arg_5_0.skillItemList = {}

	gohelper.setActive(arg_5_0._gostrengthenattr, false)
	gohelper.setActive(arg_5_0._goSkillItem, false)
	gohelper.setActive(arg_5_0._goTypeItem, false)

	arg_5_0._click = gohelper.getClickWithAudio(arg_5_0._imagelock.gameObject)

	arg_5_0._click:AddClickListener(arg_5_0._onClick, arg_5_0)
	gohelper.addUIClickAudio(arg_5_0._btnmaxlevel.gameObject, AudioEnum.UI.play_ui_admission_open)

	arg_5_0.imageBreakIcon = gohelper.findChildImage(arg_5_0._gobreakeffect, "image_icon")
	arg_5_0.txtBreakAttrName = gohelper.findChildText(arg_5_0._gobreakeffect, "txt_name")
	arg_5_0.txtBreakValue = gohelper.findChildText(arg_5_0._gobreakeffect, "txt_value")
	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0.viewGO, typeof(UnityEngine.Animator))
	arg_5_0.txtTitle = gohelper.findChildText(arg_5_0.viewGO, "layout/#go_skill/attributename/txttitle")
	arg_5_0._btnMaxLevelAnim = gohelper.onceAddComponent(arg_5_0._btnmaxlevel.gameObject, typeof(UnityEngine.Animator))
end

function var_0_0._onHyperLinkClick(arg_6_0)
	EquipController.instance:openEquipSkillTipView({
		arg_6_0._equipMO,
		arg_6_0._equipId,
		true
	})
end

function var_0_0._onClick(arg_7_0)
	arg_7_0._lock = not arg_7_0._lock

	UISpriteSetMgr.instance:setEquipSprite(arg_7_0._imagelock, arg_7_0._lock and "xinxiang_suo" or "xinxiang_jiesuo", false)
	EquipRpc.instance:sendEquipLockRequest(arg_7_0._equipMO.id, arg_7_0._lock)

	if arg_7_0._lock then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Lock)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Unlock)
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._equipMO = arg_9_0.viewContainer.viewParam.equipMO
	arg_9_0._equipId = arg_9_0._equipMO and arg_9_0._equipMO.config.id or arg_9_0.viewContainer.viewParam.equipId
	arg_9_0._hadEquip = true

	if not arg_9_0._equipMO and arg_9_0._equipId then
		arg_9_0._hadEquip = false
		arg_9_0._equipMO = EquipHelper.createMinLevelEquipMo(arg_9_0._equipId)
	end

	arg_9_0._config = arg_9_0._equipMO.config

	local var_9_0 = EquipTeamListModel.instance:getHero()

	arg_9_0._heroId = var_9_0 and var_9_0.heroId
	arg_9_0._isNormalEquip = EquipHelper.isNormalEquip(arg_9_0._config)

	gohelper.setActive(arg_9_0._btnmaxlevel.gameObject, arg_9_0._isNormalEquip)

	arg_9_0._showMax = false
	arg_9_0._lock = arg_9_0._equipMO.isLock

	gohelper.setActive(arg_9_0._imagelock.gameObject, arg_9_0._hadEquip and arg_9_0._isNormalEquip)

	if arg_9_0._hadEquip and arg_9_0._isNormalEquip then
		UISpriteSetMgr.instance:setEquipSprite(arg_9_0._imagelock, arg_9_0._lock and "xinxiang_suo" or "xinxiang_jiesuo", false)
	end

	gohelper.setActive(arg_9_0._goprogress, arg_9_0._isNormalEquip)
	gohelper.setActive(arg_9_0._goattribute, arg_9_0._isNormalEquip)
	gohelper.setActive(arg_9_0._txtattributelv.gameObject, arg_9_0._isNormalEquip)
	arg_9_0:refreshMaxLevelImage(1)
	arg_9_0:refreshTxtTitle()
	arg_9_0:refreshUI()

	if arg_9_0.viewContainer:getIsOpenLeftBackpack() then
		arg_9_0.viewContainer.equipView:showTitleAndCenter()
	end

	arg_9_0._animator:Play(UIAnimationName.Open)
end

function var_0_0.refreshMaxLevelImage(arg_10_0, arg_10_1)
	arg_10_0._btnMaxLevelAnim:Play(arg_10_0._showMax and "open" or "close", 0, arg_10_1)
end

function var_0_0.refreshTxtTitle(arg_11_0)
	if EquipHelper.isExpEquip(arg_11_0._config) then
		arg_11_0.txtTitle.text = luaLang("p_equipinfo_exp_title")
	elseif EquipHelper.isRefineUniversalMaterials(arg_11_0._config.id) or EquipHelper.isSpRefineEquip(arg_11_0._config) then
		arg_11_0.txtTitle.text = luaLang("p_equipinfo_refine_title")
	else
		arg_11_0.txtTitle.text = luaLang("p_equipinfo_normal_title")
	end
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:refreshTag()
	arg_12_0:refreshBaseAttr()

	if not arg_12_0._isNormalEquip or arg_12_0._isNormalEquip and arg_12_0._equipMO.config.rare > EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(arg_12_0._goSkillContainer, true)

		arg_12_0._txtattributelv.text = arg_12_0._equipMO.refineLv

		arg_12_0:refreshSkillDesc()
	else
		gohelper.setActive(arg_12_0._goSkillContainer, false)
	end

	arg_12_0:showProgress()
end

function var_0_0.refreshTag(arg_13_0)
	local var_13_0 = arg_13_0._config.tag

	if string.nilorempty(var_13_0) then
		gohelper.setActive(arg_13_0._goType, false)

		return
	end

	gohelper.setActive(arg_13_0._goType, true)

	local var_13_1 = EquipConfig.instance:getTagList(arg_13_0._config)
	local var_13_2

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_3 = arg_13_0.tagItemList[iter_13_0]

		if not var_13_3 then
			var_13_3 = arg_13_0:getUserDataTb_()
			var_13_3.go = gohelper.cloneInPlace(arg_13_0._goTypeItem)
			var_13_3.txt = var_13_3.go:GetComponent(gohelper.Type_TextMesh)

			table.insert(arg_13_0.tagItemList, var_13_3)
		end

		gohelper.setActive(var_13_3.go, true)

		var_13_3.txt.text = EquipConfig.instance:getTagName(iter_13_1)
	end

	for iter_13_2 = #var_13_1 + 1, #arg_13_0.tagItemList do
		gohelper.setActive(arg_13_0.tagItemList[iter_13_2].go, false)
	end
end

function var_0_0.refreshBaseAttr(arg_14_0)
	local var_14_0
	local var_14_1

	if arg_14_0._equipMO then
		local var_14_2

		var_14_2, var_14_1 = EquipConfig.instance:getEquipNormalAttr(arg_14_0._equipId, arg_14_0._equipMO.level, HeroConfig.sortAttrForEquipView)
	else
		local var_14_3

		var_14_3, var_14_1 = EquipConfig.instance:getMaxEquipNormalAttr(arg_14_0._equipId, HeroConfig.sortAttrForEquipView)
	end

	local var_14_4

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_5 = arg_14_0.strengthenAttrItemList[iter_14_0]

		if not var_14_5 then
			var_14_5 = arg_14_0:getUserDataTb_()
			var_14_5.go = gohelper.cloneInPlace(arg_14_0._gostrengthenattr)
			var_14_5.icon = gohelper.findChildImage(var_14_5.go, "image_icon")
			var_14_5.name = gohelper.findChildText(var_14_5.go, "txt_name")
			var_14_5.value = gohelper.findChildText(var_14_5.go, "txt_value")
			var_14_5.goBg = gohelper.findChild(var_14_5.go, "go_bg")

			table.insert(arg_14_0.strengthenAttrItemList, var_14_5)
		end

		gohelper.setActive(var_14_5.go, true)
		gohelper.setActive(var_14_5.goBg, iter_14_0 % 2 == 0)

		local var_14_6 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_14_1.attrType))

		UISpriteSetMgr.instance:setCommonSprite(var_14_5.icon, "icon_att_" .. var_14_6.id)

		var_14_5.name.text = var_14_6.name
		var_14_5.value.text = iter_14_1.value
	end

	for iter_14_2 = #var_14_1 + 1, #arg_14_0.strengthenAttrItemList do
		gohelper.setActive(arg_14_0.strengthenAttrItemList[iter_14_2].go, false)
	end

	local var_14_7, var_14_8 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(arg_14_0._config, arg_14_0._equipMO.breakLv)

	if var_14_7 then
		gohelper.setActive(arg_14_0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_14_0.imageBreakIcon, "icon_att_" .. var_14_7)

		arg_14_0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_14_7)
		arg_14_0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_14_8)

		gohelper.setAsLastSibling(arg_14_0._gobreakeffect)
	else
		gohelper.setActive(arg_14_0._gobreakeffect, false)
	end
end

function var_0_0.refreshSkillDesc(arg_15_0)
	local var_15_0 = EquipHelper.getEquipSkillDescList(arg_15_0._config.id, arg_15_0._equipMO.refineLv, "#D9A06F")

	if not next(var_15_0) then
		gohelper.setActive(arg_15_0._goSkill, false)
	else
		gohelper.setActive(arg_15_0._goSkill, true)

		local var_15_1

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_2 = arg_15_0.skillItemList[iter_15_0]

			if not var_15_2 then
				var_15_2 = arg_15_0:getUserDataTb_()
				var_15_2.itemGo = gohelper.cloneInPlace(arg_15_0._goSkillItem)
				var_15_2.txt = gohelper.findChildText(var_15_2.itemGo, "skill_desc")

				SkillHelper.addHyperLinkClick(var_15_2.txt)

				var_15_2.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_2.txt.gameObject, FixTmpBreakLine)

				table.insert(arg_15_0.skillItemList, var_15_2)
			end

			var_15_2.txt.text = EquipHelper.getEquipSkillDesc(iter_15_1)

			var_15_2.fixTmpBreakLine:refreshTmpContent(var_15_2.txt)
			gohelper.setActive(var_15_2.itemGo, true)
		end

		for iter_15_2 = #var_15_0 + 1, #arg_15_0.skillItemList do
			gohelper.setActive(arg_15_0.skillItemList[iter_15_2].itemGo, false)
		end
	end
end

function var_0_0.showProgress(arg_16_0)
	if arg_16_0._showMax then
		for iter_16_0 = 1, 5 do
			UISpriteSetMgr.instance:setEquipSprite(arg_16_0["_image" .. iter_16_0], "bg_xinxiang_dengji")
		end

		gohelper.setActive(arg_16_0._txttotallevel.gameObject, false)
	elseif arg_16_0._isNormalEquip then
		arg_16_0._txttotallevel.text = string.format("/%s", EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_16_0._equipMO))

		gohelper.setActive(arg_16_0._txttotallevel.gameObject, true)

		for iter_16_1 = 1, 5 do
			UISpriteSetMgr.instance:setEquipSprite(arg_16_0["_image" .. iter_16_1], iter_16_1 <= arg_16_0._equipMO.refineLv and "bg_xinxiang_dengji" or "bg_xinxiang_dengji_dis")
		end
	else
		gohelper.setActive(arg_16_0._txttotallevel.gameObject, false)
	end

	arg_16_0._txtcurlevel.text = arg_16_0._equipMO.level

	gohelper.setActive(arg_16_0._gotip, arg_16_0._showMax and not EquipHelper.isConsumableEquip(arg_16_0._equipMO.equipId))
end

function var_0_0.onOpenFinish(arg_17_0)
	return
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:playCloseAnimation()
end

function var_0_0.playCloseAnimation(arg_19_0)
	arg_19_0._animator:Play(UIAnimationName.Close)
end

function var_0_0.onDestroyView(arg_20_0)
	if arg_20_0._itemList then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._itemList) do
			iter_20_1:destroyView()
		end
	end

	arg_20_0._click:RemoveClickListener()

	arg_20_0.strengthenAttrItemList = nil
	arg_20_0.tagItemList = nil
	arg_20_0.skillItemList = nil
end

return var_0_0
