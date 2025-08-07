module("modules.logic.sp01.odyssey.view.OdysseyEquipView", package.seeall)

local var_0_0 = class("OdysseyEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/BG/#simage_fullbg")
	arg_1_0._scrollLeftTab = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_LeftTab")
	arg_1_0._goTabItem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_LeftTab/Viewport/Content/#go_TabItem")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#scroll_LeftTab/Viewport/Content/#go_TabItem/#image_icon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_LeftTab/Viewport/Content/#go_TabItem/#go_select")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#scroll_LeftTab/Viewport/Content/#go_TabItem/#btn_click")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_container")
	arg_1_0._scrollEquip = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_container/#scroll_Equip")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "root/#go_container/#go_empty")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/hero/#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/hero/#btn_right")
	arg_1_0._scrollSuit = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_Suit")
	arg_1_0._goOdysseyEquipParent = gohelper.findChild(arg_1_0.viewGO, "root/hero/go_Equip")
	arg_1_0._simageHero = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/hero/Hero/#simage_hero")
	arg_1_0._goTipsItem = gohelper.findChild(arg_1_0.viewGO, "root/hero/#go_tipsitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnEquipItemSelect, arg_2_0.onItemSelect, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnEquipSuitSelect, arg_2_0.OnEquipSuitSelect, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnEquipPosSelect, arg_2_0.onEquipPosSelect, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnTipSubViewClose, arg_2_0.onTipSubViewClose, arg_2_0)
	arg_2_0:addEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_2_0.onHeroGroupUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnEquipItemSelect, arg_3_0.onItemSelect, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnEquipSuitSelect, arg_3_0.OnEquipSuitSelect, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnEquipPosSelect, arg_3_0.onEquipPosSelect, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnTipSubViewClose, arg_3_0.onTipSubViewClose, arg_3_0)
	arg_3_0:removeEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_3_0.onHeroGroupUpdate, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	return
end

function var_0_0._btnleftOnClick(arg_5_0)
	local var_5_0 = arg_5_0._heroPosIndex - 1

	if var_5_0 <= 0 then
		return
	end

	arg_5_0._heroPosIndex = var_5_0

	arg_5_0._animHero:Play("left", 0, 0)
end

function var_0_0._btnrightOnClick(arg_6_0)
	local var_6_0 = arg_6_0._heroPosIndex + 1

	if var_6_0 > arg_6_0._heroPosMax then
		return
	end

	arg_6_0._heroPosIndex = var_6_0

	arg_6_0._animHero:Play("right", 0, 0)
end

function var_0_0._editableInitView(arg_7_0)
	OdysseyEquipSuitTabListModel.instance:initList()

	arg_7_0._equipFilterType = nil
	arg_7_0._odysseyItemList = {}

	local var_7_0 = arg_7_0._goOdysseyEquipParent.transform
	local var_7_1 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MainHeroEquipCount)
	local var_7_2 = tonumber(var_7_1.value)

	for iter_7_0 = 1, var_7_2 do
		local var_7_3 = arg_7_0:getResInst(arg_7_0.viewContainer:getSetting().otherRes[2], var_7_0.gameObject)
		local var_7_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_3.gameObject, OdysseyHeroGroupEquipItem)

		table.insert(arg_7_0._odysseyItemList, var_7_4)
	end

	arg_7_0.equipTipItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._goTipsItem, OdysseyEquipTipItem)

	arg_7_0.equipTipItem:setActive(false)

	arg_7_0._gohero = gohelper.findChild(arg_7_0.viewGO, "root/hero")
	arg_7_0._goEmptyHero = gohelper.findChild(arg_7_0.viewGO, "root/hero/Hero/empty")
	arg_7_0._animHero = arg_7_0._gohero:GetComponent(gohelper.Type_Animator)
	arg_7_0._animEventWrap = arg_7_0._gohero:GetComponent(gohelper.Type_AnimationEventWrap)

	arg_7_0._animEventWrap:AddEventListener("switch", arg_7_0.onSelectHeroAnimEvent, arg_7_0)

	arg_7_0._animScroll = gohelper.findChildComponent(arg_7_0.viewGO, "root/#go_container", gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam
	local var_9_1 = var_9_0.index
	local var_9_2 = var_9_0.heroPos

	arg_9_0:refreshList(false, true)
	arg_9_0:initSwitchList(var_9_2, var_9_1)
end

function var_0_0.onSelectHeroAnimEvent(arg_10_0)
	arg_10_0:onSelectHero(arg_10_0._heroPosIndex)
end

function var_0_0.onSelectHero(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._heroPosIndex = arg_11_1
	arg_11_2 = arg_11_2 or OdysseyEnum.EquipDefaultIndex
	arg_11_0._equipIndex = arg_11_2
	arg_11_0._heroPos = arg_11_0._heroPosList[arg_11_1]

	arg_11_0:refreshHero()
	arg_11_0:refreshItem()
	arg_11_0:selectEquipPos(arg_11_2, arg_11_3)
	arg_11_0:refreshSwitchState()
end

function var_0_0.refreshHero(arg_12_0)
	local var_12_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_12_1 = arg_12_0._heroPos
	local var_12_2 = var_12_0.heroIdPosDic[arg_12_0._heroPos]
	local var_12_3 = false

	if var_12_2 ~= nil and var_12_2 ~= 0 then
		local var_12_4

		if var_12_2 < 0 then
			local var_12_5 = lua_hero_trial.configDict[-var_12_2][0]

			var_12_4 = SkinConfig.instance:getSkinCo(var_12_5.skin)
		else
			local var_12_6 = HeroModel.instance:getByHeroId(var_12_2)

			var_12_4 = SkinConfig.instance:getSkinCo(var_12_6.skin)
		end

		if var_12_4 == nil then
			logError("奥德赛角色活动 角色皮肤表id为空：装备uid：" .. tostring(arg_12_0.mo.uid))
		else
			if var_12_4.gainApproach ~= CharacterEnum.SkinGainApproach.Init then
				local var_12_7 = var_12_4.characterId
				local var_12_8
				local var_12_9 = SkinConfig.instance:getCharacterSkinCoList(var_12_7)

				if var_12_9 ~= nil and next(var_12_9) then
					for iter_12_0, iter_12_1 in ipairs(var_12_9) do
						if iter_12_1.gainApproach == CharacterEnum.SkinGainApproach.Init then
							var_12_8 = iter_12_1

							break
						end
					end

					if var_12_8 == nil then
						logError("奥德赛角色活动 角色默认皮肤表id为空：角色：" .. tostring(var_12_7))
					else
						var_12_3 = true
						var_12_4 = var_12_8
					end
				else
					logError("奥德赛角色活动 角色皮肤列表为空：角色：" .. tostring(var_12_7))
				end
			else
				var_12_3 = true
			end

			local var_12_10 = ResUrl.getHeadIconImg(var_12_4.id)

			arg_12_0.skinCo = var_12_4

			arg_12_0._simageHero:LoadImage(var_12_10, arg_12_0.onLoadHeadIcon, arg_12_0)
		end
	end

	gohelper.setActive(arg_12_0._simageHero, var_12_3)
	gohelper.setActive(arg_12_0._goEmptyHero, not var_12_3)
	logNormal(string.format("索引:%s Id:%s", var_12_1, var_12_2))
end

function var_0_0.onLoadHeadIcon(arg_13_0)
	ZProj.UGUIHelper.SetImageSize(arg_13_0._simageHero.gameObject)

	local var_13_0 = arg_13_0.skinCo.playercardViewImgOffset

	if string.nilorempty(var_13_0) then
		var_13_0 = arg_13_0.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(var_13_0) then
		local var_13_1 = string.splitToNumber(var_13_0, "#")

		recthelper.setAnchor(arg_13_0._simageHero.transform, tonumber(var_13_1[1]), tonumber(var_13_1[2]))
		transformhelper.setLocalScale(arg_13_0._simageHero.transform, tonumber(var_13_1[3]), tonumber(var_13_1[3]), tonumber(var_13_1[3]))
	end
end

function var_0_0.initSwitchList(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = 1
	local var_14_1 = HeroGroupModel.instance:getCurGroupMO()
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_1.heroList) do
		table.insert(var_14_2, iter_14_0)
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_2) do
		if iter_14_3 == arg_14_1 then
			var_14_0 = iter_14_2

			break
		end
	end

	arg_14_0._heroPosMax = #var_14_2
	arg_14_0._heroPosList = var_14_2

	arg_14_0:onSelectHero(var_14_0, arg_14_2, true)
end

function var_0_0.onHeroGroupUpdate(arg_15_0)
	arg_15_0:refreshList(true, false)
	arg_15_0:refreshItem()

	local var_15_0 = OdysseyHeroGroupModel.instance:getSaveType()

	OdysseyHeroGroupModel.instance:setSaveType(nil)

	if var_15_0 and var_15_0 == OdysseyEnum.HeroGroupSaveType.ItemEquip or var_15_0 == OdysseyEnum.HeroGroupSaveType.ItemReplace then
		arg_15_0:checkChangeEquipPos()
	else
		arg_15_0:selectCurItemAndPos()
	end
end

function var_0_0.selectCurItemAndPos(arg_16_0)
	arg_16_0:selectEquipPos(arg_16_0._equipIndex)
	OdysseyEquipListModel.instance:setSelect(nil)
end

function var_0_0.checkChangeEquipPos(arg_17_0)
	if arg_17_0.equipCount <= 1 then
		arg_17_0:selectCurItemAndPos()

		return
	end

	local var_17_0 = arg_17_0._equipIndex
	local var_17_1 = arg_17_0._heroPos
	local var_17_2 = HeroGroupModel.instance:getCurGroupMO():getOdysseyEquips(var_17_1 - 1)

	for iter_17_0, iter_17_1 in ipairs(var_17_2.equipUid) do
		local var_17_3 = tonumber(iter_17_1)

		if iter_17_0 ~= var_17_0 and var_17_3 ~= nil and var_17_3 == 0 then
			var_17_0 = iter_17_0

			arg_17_0:onEquipPosSelect(var_17_0)

			return
		end
	end

	arg_17_0:selectCurItemAndPos()
end

function var_0_0.onTipSubViewClose(arg_18_0)
	arg_18_0:onItemSelect(nil)
end

function var_0_0.refreshSwitchState(arg_19_0)
	local var_19_0 = arg_19_0._heroPosIndex

	gohelper.setActive(arg_19_0._btnleft, var_19_0 > 1)
	gohelper.setActive(arg_19_0._btnright, var_19_0 < arg_19_0._heroPosMax)
end

function var_0_0.refreshItem(arg_20_0)
	local var_20_0 = arg_20_0._heroPos
	local var_20_1 = HeroGroupModel.instance:getCurGroupMO():getOdysseyEquips(var_20_0 - 1)

	for iter_20_0, iter_20_1 in ipairs(var_20_1.equipUid) do
		local var_20_2 = arg_20_0._odysseyItemList[iter_20_0]

		if not var_20_2 then
			logError("奥德赛编队界面 装备索引超过上限 index: " .. tostring(iter_20_0))
		else
			local var_20_3 = tonumber(iter_20_1)

			var_20_2:setActive(true)
			var_20_2:setInfo(var_20_0, iter_20_0, var_20_3, OdysseyEnum.BagType.Bag)
			var_20_2:refreshUI()
		end
	end

	local var_20_4 = #arg_20_0._odysseyItemList
	local var_20_5 = #var_20_1.equipUid

	arg_20_0.equipCount = var_20_5

	if var_20_5 < var_20_4 then
		for iter_20_2 = var_20_5 + 1, var_20_4 do
			local var_20_6 = arg_20_0._odysseyItemList[iter_20_2]

			var_20_6:clear()
			var_20_6:setActive(false)
		end
	end
end

function var_0_0.refreshList(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0._equipFilterType == nil then
		OdysseyEquipSuitTabListModel.instance:selectAllTag()
	end

	OdysseyEquipListModel.instance:copyListFromEquipModel(OdysseyEnum.ItemType.Equip, arg_21_0._equipFilterType, OdysseyEnum.BagType.FightPrepare, arg_21_1)

	if arg_21_2 then
		arg_21_0._animScroll:Play("flash", 0, 0)
	end
end

function var_0_0.onItemSelect(arg_22_0, arg_22_1)
	arg_22_0._equipMo = arg_22_1

	if arg_22_1 ~= nil then
		if arg_22_1.uid == 0 then
			logError("奥德赛 下半活动 背包道具uid 为0")

			return
		else
			local var_22_0 = OdysseyHeroGroupModel.instance:getCurHeroGroup():getEquipByUid(arg_22_1.uid)

			if var_22_0 ~= nil and var_22_0.heroPos == arg_22_0._heroPos and var_22_0.slotId ~= arg_22_0._equipIndex then
				arg_22_0:onEquipPosSelect(var_22_0.slotId)
				arg_22_0:onItemSelect(arg_22_1)
			else
				local var_22_1 = {
					itemId = arg_22_1.itemId,
					equipUid = arg_22_1.uid,
					equipIndex = arg_22_0._equipIndex,
					heroPos = arg_22_0._heroPos
				}

				arg_22_0.equipTipItem:setActive(true)
				arg_22_0.equipTipItem:setData(var_22_1)
			end
		end
	else
		OdysseyEquipListModel.instance:clearSelect()
		arg_22_0.equipTipItem:setActive(false)
	end
end

function var_0_0.onEquipPosSelect(arg_23_0, arg_23_1)
	arg_23_0:selectEquipPos(arg_23_1, true)
end

function var_0_0.selectEquipPos(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._equipIndex = arg_24_1

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._odysseyItemList) do
		iter_24_1:setSelect(arg_24_1)
	end

	OdysseyEquipListModel.instance:clearSelect()

	if arg_24_0._equipIndex ~= nil and arg_24_2 then
		local var_24_0 = arg_24_0._heroPos
		local var_24_1 = HeroGroupModel.instance:getCurGroupMO():getOdysseyEquips(var_24_0 - 1):getEquipUID(arg_24_1)

		if var_24_1 and var_24_1 ~= 0 then
			local var_24_2 = OdysseyItemModel.instance:getItemMoByUid(var_24_1)

			if var_24_2 then
				local var_24_3 = OdysseyEquipSuitTabListModel.instance:getSelect()

				if var_24_3 and var_24_3.type ~= OdysseyEnum.EquipSuitType.All and var_24_2.config.suitId ~= var_24_3.suitId then
					OdysseyEquipSuitTabListModel.instance:selectAllTag(true)
					logNormal("选中全部类型装备标签")
				end
			end

			OdysseyEquipListModel.instance:setSelect(var_24_1)
		else
			arg_24_0:onItemSelect(nil)
		end
	else
		arg_24_0:onItemSelect(nil)
	end
end

function var_0_0.OnEquipSuitSelect(arg_25_0, arg_25_1)
	local var_25_0

	if arg_25_1.type == OdysseyEnum.EquipSuitType.All then
		-- block empty
	else
		var_25_0 = arg_25_1 and arg_25_1.suitId

		if arg_25_0._equipFilterType == var_25_0 then
			return
		end
	end

	arg_25_0._equipFilterType = var_25_0

	OdysseyEquipListModel.instance:clearSelect()
	arg_25_0:onItemSelect(nil)
	arg_25_0:refreshList(false, true)
end

function var_0_0.onClose(arg_26_0)
	arg_26_0._animEventWrap:RemoveAllEventListener()
end

function var_0_0.onDestroyView(arg_27_0)
	return
end

return var_0_0
